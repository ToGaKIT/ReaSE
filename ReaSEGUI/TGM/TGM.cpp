#include "TGM.h"

using namespace std;

namespace tgm
{
/**
 * @brief This is the main class of TGM - a topology generator for realistic OMNeT++ simulation environments
 *
 * A topology created by TGM can be hierarchically constructed:
 *   Multiple interconnected Autonomous Systems (AS) form the top level.
 *   Each AS in turn consists of a hierarchical router level topology: core, gateway, and edge routers.
 *   The actual hosts are connected to edge routers only.
 *
 *   AS-level topology is built based on the positive-feedback preference model (PFP)
 *   Router-level topology is built based on the heuristically optimal topology model (HOT).
 *     Nodes with powerlaw-distributed edge degrees are created by PFP, then all connections are deleted and
 *     HOT is applied on the nodes previously created.
 *
 * If STATISTICS is defined during compilation, the three powerlaw values of the AS topology and the router
 *   topology of the first AS are calculated and written to a file.
 *
 * @version 1.0-developer version
 * @author Michael Scharf, Thomas Gamer
 *
 * @class TGM
 */

// default values
const double CORE_RATIO = 0.05;
const double CORE_CROSS_LINK = 0.03;
const double PFP_PAR_P = 0.4;
const double PFP_PAR_DELTA = 0.048;

inline char* GET_OFFSET(char *buf)
{
    char *c1 = strrchr(buf, '<')+1;
    char *c2 = strrchr(buf, '>');
    *c2 = '\0';
    return c1;
}

/**
 * Constructor
 */
TGM::TGM()
{
	initialize();
	srand(time(NULL));
}

/**
 * Constructor
 */
TGM::TGM(int runNumber)
{
	initialize();
	srand(time(NULL) / runNumber);
}

/**
 * Destructor
 */
TGM::~TGM()
{
}

/**
 * Initialize all the member variables.
 */
void TGM::initialize()
{

	parasRead = false;

	asLevel = false;
	asNodes = transitThresh = 0;
	paramP = PFP_PAR_P;
	paramDelta = PFP_PAR_DELTA;

	rLevel = false;
	rNodeMin = rNodeMax = hostsPerEdgeMin = hostsPerEdgeMax= 0;
	coreRatio = CORE_RATIO;
	coreCrossLinkRatio = CORE_CROSS_LINK;

	topFile = "";
	statPref = "";
	OverSim = 0;

	nodesProbability = NULL;
	probabilityIsDirty = true;
	asIdCount = 0;
	rlIdCount = 0;
	vTopology.clear();
}

/**
 * This method reads all necessary parameter of the user-given parameter file.
 * The file must have a predefined format.
 * There is no check if all parameters are present or if the parameters contain reasonable values!
 *
 * @param File name of the user-given parameter file
 * @return status code: 0 on success, 1 on error
 */
int TGM::readParameter(char *filename)
{
	if(parasRead)
	{
		if(DEBUG)
			cerr<<"WARNING: Parameters already read!\n";
		return 0;
	}

	ifstream in(filename);

	if(!in)
	{
		cerr<<"ERROR: Couldn't open file "<<filename<<endl;
		return 1;
	}

	char buf[255];
	int status;

	while(in)
	{
		in.getline(buf, 255);

		// ignore empty lines and comments starting with #
		if(strlen(buf) == 0)
			continue;
		if(strstr(buf, "#"))
			continue;

		// main tag AS-Level read: start reading according parameters
		if(strstr(buf, "<AS-Level>"))
		{
			asLevel = true;
			status = 1;
			continue;
		}

		// main tag Router-Level read: start reading according parameters
		else if(strstr(buf, "<Router-Level>"))
		{
			rLevel = true;
			status = 2;
			continue;
		}

		// main tag Misc read: start reading according parameters
		else if(strstr(buf, "<Misc>"))
		{
			status = 3;
			continue;
		}

		// read parameters according to AS-Level
		if(status == 1)
		{
			if(strstr(buf, "<AS-Nodes>"))
				asNodes = atoi(GET_OFFSET(buf));
			else if(strstr(buf, "<Transit-Node-Thresh>"))
				transitThresh = atoi(GET_OFFSET(buf));
			else if(strstr(buf, "<Parameter-P>"))
				paramP = atof(GET_OFFSET(buf));
			else if(strstr(buf, "<Parameter-Delta>"))
				paramDelta = atof(GET_OFFSET(buf));
			else
			{
				if(DEBUG)
					cerr<<"WARNING: Parameter not known!"<<endl;
				puts(buf);
			}
		}
		// read parameters according to Router-Level
		else if (status == 2)
		{
			if(strstr(buf, "<R-Node-Max>"))
				rNodeMax = atoi(GET_OFFSET(buf));
			else if(strstr(buf, "<R-Node-Min>"))
				rNodeMin = atoi(GET_OFFSET(buf));
			else if(strstr(buf, "<Hosts-Per-Edge-Max>")) {
				hostsPerEdgeMax = atoi(GET_OFFSET(buf));
				if(hostsPerEdgeMax < 0)
					hostsPerEdgeMax = 0;
			} else if(strstr(buf, "<Hosts-Per-Edge-Min>")) {
				hostsPerEdgeMin = atoi(GET_OFFSET(buf));
				if(hostsPerEdgeMin < 0)
					hostsPerEdgeMin = 0;
			} else if(strstr(buf, "<Core-Ratio>"))
				coreRatio = (double) atoi(GET_OFFSET(buf)) / 100.;
			else if(strstr(buf, "<Core-Cross-Link-Ratio>"))
				coreCrossLinkRatio = (double) atoi(GET_OFFSET(buf)) / 100.;
			else
			{
				if(DEBUG)
					cerr<<"WARNING: Parameter not known!"<<endl;
				puts(buf);
			}
		}
		// read parameters according to Misc
		else if(status == 3)
		{
			if(strstr(buf, "<Topology-File>"))
				topFile += GET_OFFSET(buf);
			else if(strstr(buf, "Stats-Prefix>"))
				statPref += GET_OFFSET(buf);
			else if(strstr(buf, "<OverSim>"))
				OverSim = atoi(GET_OFFSET(buf));
			else
			{
				if(DEBUG)
					cerr<<"WARNING: Parameter not known!"<<endl;
				puts(buf);
			}
		}
	} // end while

	// check plausibility of router-level parameters (status = 2)
	if(rLevel) {
		if(hostsPerEdgeMin > hostsPerEdgeMax) {
			cerr <<"Parameters don't make sense. Hosts-Per-Edge-Min greater than Hosts-Per-Edge-Max!"<<endl;
			return 1;
		}
		if(rNodeMin > rNodeMax) {
			cerr <<"Parameters don't make sense. R-Node-Min greater than R-Node-Max!"<<endl;
			return 1;
		}
	}

	parasRead = true;

	return 0;
}

/**
 * Method in order to roughly estimate the size of the topology to be generated
 *
 * @return: estimated topology size on success, 1 on error
 */
int TGM::estimateTopologySize()
{
	int estimatedSize = 1;

	if(parasRead)
		estimatedSize = max(1,asNodes) * max(1, (rNodeMin + rNodeMax) / 2) * max(1, (hostsPerEdgeMin + hostsPerEdgeMax) / 2);

	if(DEBUG)
		cout<<"INFO: estimated size of topology to be generated: "<<estimatedSize<<endl; 

	return estimatedSize;
}

/**
 * Main method for creation of topology.
 * AS-level topology, router-level topology or a combination of both can be created.
 * In the latter case a router-level topology is created for each AS-level node.
 *
 * @return status code: 0 on success, 1 on program error, 2 on generation failure
 */
int TGM::buildTopology()
{
	if(!parasRead)
	{
		cerr<<"ERROR: no parameter read\n. Use readParameter(fileName) first\n";
		return 1;
	}

	// create AS-level topology
	if(asLevel)
	{
		if(buildASLevelTopology(vTopology))
		{
			if(DEBUG)
				cout<<"Generation failure: Error while building AS-Level-Topology\n";
			return 2;
		}
	}

	// create router-level topology...
	if(rLevel)
	{
		// ... only
		if(vTopology.empty())
		{
			int noNodes = rNodeMin;
			if((rNodeMax - rNodeMin) > 0)
				noNodes += rand() % (rNodeMax - rNodeMin + 1);

			if(buildRouterLevelTopology(vTopology, noNodes))
			{
				if(DEBUG)
					cout<<"Generation failure: Error while building Router-Level-Topology\n";
				return 2;
			}
		}
		// ... within each AS node
		else
		{
			for(int i = 0; i < vTopology.size(); i++)
			{
				TopologyVector *rTopo = new TopologyVector();

				int noNodes = rNodeMin;
				if((rNodeMax - rNodeMin) > 0)
					noNodes += rand() % (rNodeMax - rNodeMin + 1);

				if(DEBUG)
				{
					cout<<"INFO: build Router-Level for ";
					if(vTopology[i]->getNodeType() == TRANSIT_AS)
						cout<<"Transit-AS "<<vTopology[i]->getId()<<endl;
					else
						cout<<"Stub-AS "<<vTopology[i]->getId()<<endl;
				}

				if(buildRouterLevelTopology(*rTopo, noNodes))
				{
					if(DEBUG)
						cout<<"Generation failure: Error while building Router-Level-Topology\n";
					return 2;
				}

				ASNode * curAS = dynamic_cast<ASNode*>(vTopology[i]);
				curAS->setRouterLevelTopology(rTopo);
			}
		}
	}

	return 0;
}

/**
 * This method creates an AS-level topology based on the Positive-Feedback Preference Model (PFP).
 * Topology is generated based on an initialization step creating three interconnected nodes. Then, new nodes
 * are iteratively created and connected to the existing topology, i.e. a certain growth model is applied.
 *
 * Subsequent to topology creation the available nodes are classified into stub and transit AS nodes in a way
 * that all stub AS are reached by crossing transit AS only.
 *
 * @param tv reference on topology vector for the AS-level topology
 * @return status code: 0 on success, 1 on error
 */
int TGM::buildASLevelTopology(TopologyVector &tv)
{
	asIdCount = 0;
	if(DEBUG)
		cout<<"INFO: building AS-Level Topology with "<<asNodes<<" Nodes and Transit-Thresh of "<<transitThresh<<endl;

	// create the three initial nodes
	if(createStartNodes(tv, &TGM::allocateNewASNode) == 1)
		return 1;

	// use the pfpGrow Model:
		//Towards a Precise and Complete Internet Topology Generator
		//Shi Zhou   Guoqiang Zhang   Guoqing Zhang   Zhenrong Zhuge
		//Univ. Coll. London;
		//
		//This paper appears in: Communications, Circuits and Systems Proceedings, 2006 International Conference on
		//Publication Date: 25-28 June 2006
		//Volume: 3,  On page(s): 1830-1834
		//Location: Guilin,
		//ISBN: 0-7803-9585-9
		//INSPEC Accession Number: 9342012
		//Digital Object Identifier: 10.1109/ICCCAS.2006.285029
		//Posted online: 2007-01-15 13:07:37.0

	while(tv.size() < asNodes)
		pfpGrow(tv, &TGM::allocateNewASNode);

	// classify all topology nodes into Transit or Stub AS
	setASTypes(tv, transitThresh);

	return 0;
}

/**
 * This method performs a classification of AS-level nodes into stub and transit AS nodes.
 * This is done in a way that all stub AS nodes can be reached by crossing transit AS nodes only.
 * Nodes with degree of thresh or higher implicitly are classified as transit AS nodes.
 *
 * @param topology reference on topology vector for the AS-level topology
 * @param thresh threshold for transit AS: nodes of this degree or higher are implicitly classified as transit AS nodes
 */
void TGM::setASTypes(TopologyVector &topology, int thresh)
{
	TopologyList tl;
	// insert processed nodes into map and vector
	TopologyMap tm;
	TopologyVector tv;
	TopologyNode *startNode = topology[0];
	bool connectedNewNode;
	int startNodeIndex;

	if(DEBUG)
		cout<<"INFO: determine Transit-AS (thresh: "<<thresh<<" ) and Stub-AS"<<endl;

	// initialize node map and determine node with highest edge degree
	for(int i = 0; i < topology.size(); i++)
	{
		tm.insert(pair<int, TopologyNode*>(i, NULL));
		if(startNode->getNodeDegree() < (topology[i]->getNodeDegree()))
			startNode = topology[i];
	}

	startNode->setNodeType(TRANSIT_AS);
	tm[startNode->getId()] = startNode;
	tv.reserve(topology.size());
	tv.push_back(startNode);

	int connectedNodes = 1;

	// iterate until all nodes of topology are connected by transit nodes
	while(connectedNodes < topology.size())
	{
		connectedNewNode = false;
		// determine next node that was not processed but is connected
		for(int i = 0; i < tv.size(); i++)
		{
			if(tv[i] != NULL)
			{
				startNode = tv[i];
				startNodeIndex = i;
				break;
			}
		}

		// determine node, that was not processed but is connected, with highest edge degree
		for(int i = 0; i < tv.size(); i++)
		{
			if(tv[i] == NULL)
				continue;
			else if(startNode->getNodeDegree() < tv[i]->getNodeDegree())
			{
				startNode = tv[i];
				startNodeIndex = i;
			}
		}

		for(int i = 0; i < startNode->getPeers().size(); i++)
		{
			// check if current startNode is connected to other still unconnected nodes
			if(tm[startNode->getPeers()[i]->getId()] == NULL)
			{
				connectedNewNode = true;
				break;
			}
		}

		// current startNode is connected to new nodes -> add them to topologyMap and topologyVector
		if(connectedNewNode)
		{
			for(int i = 0; i < startNode->getPeers().size(); i++)
				if(tm[startNode->getPeers()[i]->getId()] == NULL)
				{
					tm[startNode->getPeers()[i]->getId()] = startNode->getPeers()[i];
					tv.push_back(startNode->getPeers()[i]);
					connectedNodes++;
				}
			startNode->setNodeType(TRANSIT_AS);
		}

		// delete node from topologyVector so that it won't select as startNode in future
		// COMMENT: last processed element could be erased instead of set to NULL. This however is not
		//          efficient in vectors due to the copying of all subsequent elements
		tv[startNodeIndex] = NULL;
	} // end while(connectedNodes < topology.size())

	// now classify all nodes with node degree greater than thresh as transit nodes
	// nodes not classified until now are assigned the type STUB_AS
	for(int i = 0; i < topology.size(); i++)
	{
		if(topology[i]->getNodeDegree() >= thresh)
			topology[i]->setNodeType(TRANSIT_AS);
		else if(topology[i]->getNodeType() != TRANSIT_AS)
			topology[i]->setNodeType(STUB_AS);
	}
}

/**
 * This method performs the initialization step of the PFP growth algorithm: 3 nodes are created
 * and randomly connected by one of two possible connection patterns.
 *
 * @param tv reference to topology vector containing the current topology
 * @param TGM::newNode() reference to method that is able to create a new TopologyNode
 * @return status code: 0 on success, 1 on error
 */
int TGM::createStartNodes(TopologyVector &tv, TopologyNode *(TGM::*newNode)() )
{
	tv.push_back((this->*newNode)());
	tv.push_back((this->*newNode)());
	tv.push_back((this->*newNode)());

	// randomly choose one of two connection possibilities according to PFP algorithm
	switch(rand() %2)
	{
		case 0:
			tv[0]->connectTo(tv[1]);
			tv[0]->connectTo(tv[2]);
			break;
		case 1:
			tv[0]->connectTo(tv[1]);
			tv[1]->connectTo(tv[2]);
			tv[2]->connectTo(tv[0]);
			break;
	}

	return 0;
}

/**
 * This method performs the iteration step of the PFP growth algorithm: new nodes are iteratively
 * created and connected to the existing topology. How the new connection are arranged depends
 * on the parameter P.
 *
 * @param tv reference to topology vector containing the current topology
 * @param TGM::getnewNode() reference to method that is able to create a new TopologyNode
 */
void TGM::pfpGrow(TopologyVector &tv, TopologyNode *(TGM::*getNewNode)())
{
	double r = rand()/((double)RAND_MAX);
	if(r < paramP)
	{
		// a new node is attached to a host node and two new links appear,
		// connecting the host node with two peer nodes
		// host and peer nodes are randomly selected nodes of the current topology
		TopologyNode *host = getHostNode(tv);
		TopologyNode *peer1 = getPeerNode(host, tv);
		TopologyNode *peer2 = getPeerNode(host, peer1, tv);

		TopologyNode *newNode = (this->*getNewNode)();
		tv.push_back(newNode);

		host->connectTo(newNode);
		host->connectTo(peer1);
		host->connectTo(peer2);
	}
	else
	{
		// a new node is attached to two host nodes and a new link appears,
		// connecting one of the host nodes with a peer node
		// host and peer nodes are randomly selected nodes of the current topology
		TopologyNode *host1 = getHostNode(tv);
		TopologyNode *host2 = getHostNode(host1,tv);
		TopologyNode *tmp = (rand()%2 == 0) ? host1 : host2;
		TopologyNode *peer = getPeerNode(host1, host2, tv);

		TopologyNode *newNode = (this->*getNewNode)();
		tv.push_back(newNode);

		host1->connectTo(newNode);
		host2->connectTo(newNode);
		tmp->connectTo(peer);
	}

	// a new node is added - node probabilities must be re-calculated
	probabilityIsDirty = true;
}

/**
 * This method randomly selects a node of the currently existing topology and
 * returns a reference to this node.
 * The selected node is taken as host node by the PFP growth algorithm.
 *
 * @param tv reference to topology vector containing the current topology
 * @return randomly selected topology node
 */
TopologyNode *TGM::getHostNode(TopologyVector &tv)
{
	return tv[getNodeIndex(rand()/((double)RAND_MAX), tv)];
}

/**
 * This method randomly selects a node of the currently existing topology with
 * a single exception: the node additionally given is certainly not selected.
 * A reference to the selected node is returned.
 * The selected node is taken as host node by the PFP growth algorithm.
 *
 * @param except reference to topology node that must not be selected
 * @param tv reference to topology vector containing the current topology
 * @return randomly selected topology node (except the given node)
 */
TopologyNode *TGM::getHostNode(TopologyNode *except, TopologyVector &tv)
{
	TopologyNode *newHost;

	do
	{
		newHost = tv[getNodeIndex((rand()/((double)RAND_MAX)), tv)];
	} while(newHost == except);

	return newHost;
}

/**
 * This method randomly selects a node of the currently existing topology and
 * returns a reference to this node.
 * The selected node is taken as peer node by the PFP growth algorithm.
 *
 * @param tv reference to topology vector containing the current topology
 * @return randomly selected topology node
 */
TopologyNode *TGM::getPeerNode(TopologyVector &tv)
{
	return getHostNode(tv);
}

/**
 * This method randomly selects a node of the currently existing topology with
 * a single exception: the node additionally given is certainly not selected.
 * A reference to the selected node is returned.
 * The selected node is taken as peer node by the PFP growth algorithm.
 *
 * @param except reference to topology node that must not be selected
 * @param tv reference to topology vector containing the current topology
 * @return randomly selected topology node (except the given node)
 */
TopologyNode *TGM::getPeerNode(TopologyNode *except, TopologyVector &tv)
{
	return getHostNode(except, tv);
}

/**
 * This method randomly selects a node of the currently existing topology with
 * two exceptions: the nodes additionally given are certainly not selected.
 * A reference to the selected node is returned.
 * The selected node is taken as peer node by the PFP growth algorithm.
 *
 * @param except reference to topology node that must not be selected
 * @param tv reference to topology vector containing the current topology
 * @return randomly selected topology node (except given nodes)
 */
TopologyNode *TGM::getPeerNode(TopologyNode *except1, TopologyNode *except2, TopologyVector &tv)
{
	TopologyNode *newPeer;

	do
	{
		newPeer = getHostNode(except1, tv);
	} while(newPeer == except2);

	return newPeer;
}

/**
 * This method returns the index of a topology node randomly selected. The selection process
 * is based on the iteratively increasing sum of the single node probabililites. Node probabilities
 * are refreshed after a new node is added to the currently existing topology by the PFP growth algorithm.
 *
 * @param random random value between 0 and 1 (each included)
 * @param tv reference to topology vector containing the current topology
 * @return index of randomly selected node
 */
int TGM::getNodeIndex(double random, TopologyVector &tv)
{
	double probabilitySum = 0.;
	int index = 0;

	if(probabilityIsDirty)
	{
		refreshNodesProbability(tv);
	}

	do
	{
		probabilitySum += nodesProbability[index++];
	} while(random > probabilitySum);

	index--;

	return index;
}

/**
 * Calculate new probability for each node and save it in nodesProbability. The
 * node probability depends on the node's degree and the parameter Delta.
 * Probabilites finally are normalized in a way that the sum of all probabilities
 * becomes 1.
 *
 * @param tv reference to topology vector containing the current topology
 */
void TGM::refreshNodesProbability(TopologyVector &tv)
{
	double denominator = 0.;

	if(nodesProbability != NULL)
	{
		delete [] nodesProbability;
		nodesProbability = NULL;
	}

	nodesProbability = new double[tv.size()];

	if(nodesProbability == NULL)
	{
		cerr<<"ERROR: Error during memory allocation for nodesProbability: "<<tv.size()<<" * (double)\n";
		exit(1);
	}

	// calculate sum of probabilities
	for(int i = 0; i < tv.size(); i++)
	{
		nodesProbability[i] = pow(tv[i]->getNodeDegree(), \
			(1 + paramDelta * log10((double)tv[i]->getNodeDegree())));
		denominator += nodesProbability[i];
	}

	// normalize probabilities to sum of 1
	for(int i=0; i<tv.size(); i++)
	{
		nodesProbability[i] /= denominator;
	}

	probabilityIsDirty = false;
}

/**
 * This method creates a router-level topology.
 * In a first step, router-level nodes with powerlaw distributed node degree are created by the
 * PFP growth algorithm. The connections resulting from this algorithm then are deleted in order
 * to enable the application of the HOT model for the router-level topology.
 *
 * @param tv reference on topology vector for the router-level topology
 * @param noNodes number of nodes the router-level topology should consist of
 * @return status code: 0 on success, 1 on error
 */
int TGM::buildRouterLevelTopology(TopologyVector &tv, int noNodes)
{
	TopologyList tl;
	TopologyVector tmpTv;
	rlIdCount = 0;
	bool redo = true;

	// apply PFP growth model... alternatively, the BA growth model can be applied
	if(createStartNodes(tv, &TGM::allocateNewRNode) == 1)
		return 1;

	while(tv.size() < noNodes)
		pfpGrow(tv, &TGM::allocateNewRNode);

	if(DEBUG)
		cout << "INFO: Creation of network ("<<noNodes<<" nodes) finished"<<endl;

	// delete all connections but keep the node degrees
	RNode::resetConnections(tv);

	// insert all nodes into a list and delete vector...
	for(int i = 0; i < tv.size(); i++)
		tl.push_back(tv[i]);
	tv.clear();

	// then, sort list with decreasing nodes degree...
	tl.sort(TopologyNode::compareNodes);

	// and finally, insert into vector again
	TopologyList::iterator lIt = tl.begin();
	while(lIt != tl.end())
	{
		tmpTv.push_back(*lIt);
		lIt++;
	}
	tl.clear();

	// number of core nodes is calculated by the parameter coreRatio
	int noCoreNodes = (int) ceil(coreRatio * (double) noNodes);
	int noGatewayNodes = 0;
	int noEdgeNodes = 0;
	int noCrossCoreLinks = 0;

	if(noCoreNodes <= 0)
	{
		if(DEBUG)
			cout<<"Generation failure: number of core nodes is zero"<<endl;
		return 1;
	}

	// determine the core nodes:
	//   nodes with highest node degree are made to gateway nodes.
	//   core nodes are chosen in a way that unused edges after forming a ring
	//   and addition of cross links are enough to attach gateway nodes.
	//   edge nodes then are connected to the gateways.
	if(DEBUG)
		cout<<"INFO: determine "<<noCoreNodes<<" core nodes...\n";
	int sumOfLinks = 0;
	int coreOffset = 0;

	// Router-level topology now is created according to the HOT model
		//A first-principles approach to understanding the internet's router-level topology
		//Lun Li   David Alderson   Walter Willinger   John Doyle
	        //California Institute of Technology
		//
		//This paper appears in: ACM SIGCOMM Computer Communication Review
		//Publication Date: October 2004
		//Volume: 34, Issue: 4,  On page(s): 3-14
		//Location: New York, NY, USA
		//ISSN: 0146-4833
		//Digital Object Identifier: http://doi.acm.org/10.1145/1030194.1015470
	for(int i = 0; i < tmpTv.size(); i++)
	{
		sumOfLinks = 0;

		// get summed up number of core node degrees
		for(int j = i; ((j < noCoreNodes + i) && (j < tmpTv.size())); j++)
			sumOfLinks += tmpTv[j]->getNodeDegree();

		// subtract those edges that are necessary to form a ring
		sumOfLinks -= 2 * noCoreNodes;
		if(sumOfLinks <= 0)
			continue;
		// calculate edges necessary to fulfill cross connection ratio
		noCrossCoreLinks = (int) (coreCrossLinkRatio * sumOfLinks/2);
		// remaining unused connections (greater than 0 if coreCrossLinkRatio is between 0 and 1)
		sumOfLinks -= 2 * noCrossCoreLinks;

		// core nodes found is remaining links less than number of gateways
		if(i > sumOfLinks)
		{
			coreOffset = i;
			redo = false;
			break;
		}
	}
	noGatewayNodes = sumOfLinks;

	// no core nodes found -> rebuild new topology
	if(redo)
	{
		if(DEBUG)
			cout<<"Generation failure: couldn't determine core nodes in current Topology\n";
		return 1;
	}

	// add the core nodes to topology (into tv)
	if(DEBUG)
		cout<<"INFO: ... core nodes found - adding to current topology\n";

	for(int i = 0; i < noCoreNodes; i++)
	{
		// add connect between core nodes that form a ring
		tmpTv[coreOffset + i]->connectTo(tmpTv[coreOffset + ((i + 1) % noCoreNodes)]);
		tmpTv[coreOffset + i]->setNodeType(CORE_ROUTER);

		tv.push_back(tmpTv[coreOffset + i]);
	}

	// create cross core connections
	if(DEBUG)
		cout<<"INFO: create "<<noCrossCoreLinks<<" cross-links between cores\n";

	// cross links are added between unused edges of random core nodes
	vector<RNode*> rNodeVec;
	for(int i = 0; i < noCrossCoreLinks; i++)
	{
		// find all core nodes with unused edges
		rNodeVec.clear();
		for(int j = 0; j < noCoreNodes; j++)
		{
			RNode *core = dynamic_cast<RNode*> (tv[j]);
			if(core->unusedEdges() > 0)
				rNodeVec.push_back(core);
		}

		// randomly connect two of them
		int nodeA = 0, nodeB = 0;
		do
		{
			nodeA = rand() % rNodeVec.size();
			nodeB = rand() % rNodeVec.size();
		} while(nodeA == nodeB);

		rNodeVec[nodeA]->connectTo(rNodeVec[nodeB]);
	}


	// get the gateways (nodes with degree greater than the cores) and connect them to the cores.
	// a core node for connection to the next gateway is selected by iterativly stepping through
	// the list of core nodes (forward, then backward and forward again...)
	bool walkForward = true;
	if(DEBUG)
		cout<<"INFO: determine "<<noGatewayNodes<<" gateways and connect them to cores\n";
	int j = 0;

	for(int i = 0; ((i < noGatewayNodes) && (i < tmpTv.size())); i++)
	{
		// add gateways and connect to cores
		// select only those cores that still have unused edges
		RNode *curCore = dynamic_cast<RNode*> (tv[j]);
		if(curCore->unusedEdges() > 0)
		{
			tv[j]->connectTo(tmpTv[i]);
			tmpTv[i]->setNodeType(GW_ROUTER);
			tv.push_back(tmpTv[i]);
		}
		else
			// deadlock possible here if number of unused core edges less than number of gateway nodes
			// in our case this impossible due to the calculationn of gateway nodes above
			i--;

		if(walkForward)
		{
			if(j == noCoreNodes-1)
				walkForward = false;
			else
				j++;
		}
		else
		{
			if(j == 0)
				walkForward = true;
			else
				j--;
		}
	}

	// renumber the cores and gateways
	map<int, int> reMap;
	TopologyVector oTv;
	// copy tv into oTv and insert curID and newID into map
	for(int i = 0; i < tv.size(); i++)
	{
		reMap.insert(pair<int,int>(tv[i]->getId(), i));
		oTv.push_back(tv[i]);
	}
	tv.clear();

	// create new nodes with newID i but values (type and connections) of nodes that were on spot i
	for(int i = 0; i < oTv.size(); i++)
	{
		RNode *newNode = new RNode(i);
		tv.push_back(newNode);
		newNode->setNodeType(oTv[i]->getNodeType());
	}

	for(int i = 0; i < oTv.size(); i++)
	{
		for(int j = 0; j < oTv[i]->getPeers().size(); j++)
			tv[i]->connectTo(tv[reMap[oTv[i]->getPeers()[j]->getId()]]);
	}

	// now create edges (with degree 1) and connect them to gateways
	int currentIndex = tv.size();
	for(int i = noCoreNodes; i < (noCoreNodes + noGatewayNodes); i++)
	{
		RNode *curNode = dynamic_cast<RNode*> (oTv[i]);
		for(int j = 0; j < curNode->unusedEdges(); j++)
		{
			RNode *newEdge = new RNode(currentIndex++);
			tv[i]->connectTo(newEdge);
			newEdge->setNodeType(EDGE_ROUTER);
			tv.push_back(newEdge);
		}
	}
	noEdgeNodes = currentIndex - noCoreNodes - noGatewayNodes;

	// free temporary data structures
	for(int i = 0; i < tmpTv.size(); i++)
		delete tmpTv[i];
	tmpTv.clear();
	reMap.clear();
	oTv.clear();

	if(DEBUG)
	{
		cout<<"INFO: Overview:\n";
		cout<<"  "<<noCoreNodes <<" core nodes - all edges are connected\n";
	}
	int sumEdges = 0;
	int unusedEdges = 0;
	for(int i = noCoreNodes; i < (noCoreNodes + noGatewayNodes); i++)
	{
		RNode *curGW = dynamic_cast<RNode*> (tv[i]);
		sumEdges += curGW->getNodeDegree();
		unusedEdges += curGW->unusedEdges();
	}
	if(DEBUG)
		cout<<"  "<<noGatewayNodes<<" gateway nodes - "<<unusedEdges<<" edges of "<<sumEdges<<" aren't connected\n";
	sumEdges = unusedEdges = 0;
	for(int i = (noCoreNodes + noGatewayNodes); i < tv.size(); i++)
	{
		RNode *curGW = dynamic_cast<RNode*> (tv[i]);
		sumEdges += curGW->getNodeDegree();
		unusedEdges += curGW->unusedEdges();
	}
	if(DEBUG)
		cout<<"  "<<noEdgeNodes<<" edge nodes - "<<unusedEdges<<" edges of "<<sumEdges<<" aren't connected\n";

	return 0;
}

/**
 * This method conducts the BA growth algorithm.
 * First, a ring of three nodes is created. Then, nodes are added iteratively and connected
 * to a random existing node until the given number of nodes is reached. Finally, some additional
 * connections between existing nodes are added randomly.
 *
 * @param tv reference to topology vector containing the current topology
 * @param noNodes number of nodes the created topology should consist of
 * @param TGM::getnewNode() reference to method that is able to create a new TopologyNode
 */
void TGM::baGrow(TopologyVector &tv, int noNodes, TopologyNode *(TGM::*getNewNode)())
{
	// create initial ring of three nodes
	tv.push_back((this->*getNewNode)());
	tv.push_back((this->*getNewNode)());
	tv.push_back((this->*getNewNode)());
	tv[0]->connectTo(tv[1]);
	tv[1]->connectTo(tv[2]);
	tv[2]->connectTo(tv[0]);

	// start random PA growing
	while(noNodes >= tv.size())
	{
		TopologyNode *host = getHostNode(tv);
		TopologyNode *newNode = (this->*getNewNode)();
		tv.push_back(newNode);
		host->connectTo(newNode);
		probabilityIsDirty = true;
	}

	// get current number of edges and augment topology with additional edges
	int noEdges = 0;
	for(int i = 0; i < tv.size(); i++)
		noEdges += tv[i]->getNodeDegree();
	noEdges = noEdges / 2;

	while(noEdges < noNodes)
	{
		TopologyNode *host1 = getHostNode(tv);
		TopologyNode *host2 = getHostNode(host1, tv);
		host1->connectTo(host2);
		noEdges++;
		probabilityIsDirty = true;
	}
}

/**
 * Opens the file with given file name and associates it with the class' generic output stream
 *
 * @param fileName File name of output file
 * @return output file stream belonging to given file name
 */
ofstream &TGM::openFile(const char *fileName)
{
	if(output.is_open())
		output.close();

	output.open(fileName);

	if(output.is_open())
		return output;
}


/**
 * This method writes the complete topology created by TGM in the output NED file
 * specified in the parameters file. There are three kinds of topologies that can
 * be differentiated: AS-level topology only, router-level topology only, and a
 * combination of both, i.e. an AS-level topology where each AS also contains a
 * router-level topology.
 *
 * The output NED file starts with the definition of channels and the global network
 * module. Then the definition of AS-level or router-level nodes is written in the
 * first two cases. In case of a complex scenario each AS module contains the definition
 * of its router-level nodes. At the end of each modules the connections between nodes
 * are specified and in case of router-level topology hosts are created and attached
 * to edge routers.
 *
 * @return status code: 0 on success, 1 on error
 */
int TGM::printTopology()
{

	if(vTopology.empty())
		return 1;

	ofstream &stream = openFile( topFile.data() );
	bool isComplexTopology = false;

	// write package declaration for Oversim topologies only
	if(OverSim == 1) {
		stream<<"package oversim.underlay.reaseunderlay.topologies."<< topFile.substr(topFile.find_last_of("/")+1, topFile.find_last_of('.')-topFile.find_last_of("/")-1) <<";"<<endl;
		stream<<endl;
	}

	stream<<"import inet.nodes.inet.Router;"<<endl;
	if (hostsPerEdgeMax > 0) {
		stream<<"import inet.nodes.inet.StandardHost;"<<endl;
	}

	// write AS-level topology into output NED file
	if(dynamic_cast<ASNode*>(vTopology[0]))
	{
		ASNode *node = dynamic_cast<ASNode*> (vTopology[0]);

		if(node->getRouterLevelTopology() != NULL)
		{
			if(DEBUG)
				cout<<"INFO: create OMNeT++ NED file for complex topology (AS-level and router-level within each AS)"<<endl;
			isComplexTopology = true;

			// write channel definitions into output NED file
			stream<<endl;
			stream<<"channel host2edge extends ned.DatarateChannel\n{\n\tparameters:\n\t\tdelay = 1us;\n\t\tdatarate = 1Mbps;\n}"<<endl;
			stream<<"channel edge2host extends ned.DatarateChannel\n{\n\tparameters:\n\t\tdelay = 1us;\n\t\tdatarate = 1Mbps;\n}"<<endl;
			stream<<"channel edge2gateway extends ned.DatarateChannel\n{\n\tparameters:\n\t\tdelay = 1us;\n\t\tdatarate = 155Mbps;\n}"<<endl;
			stream<<"channel gateway2core extends ned.DatarateChannel\n{\n\tparameters:\n\t\tdelay = 1us;\n\t\tdatarate = 622Mbps;\n}"<<endl;
			stream<<"channel core2core extends ned.DatarateChannel\n{\n\tparameters:\n\t\tdelay = 1us;\n\t\tdatarate = 1000Mbps;\n}"<<endl;
			stream<<"channel stub2stub extends ned.DatarateChannel\n{\n\tparameters:\n\t\tdelay = 1us;\n\t\tdatarate = 1000Mbps;\n}"<<endl;
			stream<<"channel stub2transit extends ned.DatarateChannel\n{\n\tparameters:\n\t\tdelay = 1us;\n\t\tdatarate = 5000Mbps;\n}"<<endl;
			stream<<"channel transit2transit extends ned.DatarateChannel\n{\n\tparameters:\n\t\tdelay = 1us;\n\t\tdatarate = 10000Mbps;\n}"<<endl<<endl;;
		}
		else
		{
			if(DEBUG)
				cout<<"INFO: create OMNeT++ NED file for AS-level topology only"<<endl;
			stream<<endl<<"channel stub2stub extends ned.DatarateChannel\n{\n\tparameters:\n\t\tdelay = 1us;\n\t\tdatarate = 1000Mbps;\n}"<<endl<<endl;
			stream<<"channel transit2transit extends ned.DatarateChannel\n{\n\tparameters:\n\t\tdelay = 1us;\n\t\tdatarate = 10000Mbps;\n}"<<endl<<endl;
			stream<<"channel stub2transit extends ned.DatarateChannel\n{\n\tparameters:\n\t\tdelay = 1us;\n\t\tdatarate = 5000Mbps;\n}"<<endl<<endl;

			// in case of AS-level only, stub and transit AS modules and their gates are defined
			// in case of router-level topology, each AS gets its own module definition (see later)
			stream<<"module SASNode\n{"<<endl;
			stream<<"\tparameters:"<<endl;
			stream<<"\tgates:"<<endl;
			stream<<"\t\tinout pppg[];"<<endl;
			stream<<"}"<<endl<<endl;
			stream<<"module TASNode"<<endl;
			stream<<"\tparameters:"<<endl;
			stream<<"\tgates:"<<endl;
			stream<<"\t\tinout pppg[];"<<endl;
			stream<<"}"<<endl<<endl;
		}

		if (OverSim == 1) {
			stream<<"module Internet extends oversim.underlay.reaseunderlay.ReaSEUnderlayNetworkBase\n{"<<endl;
		} else {
			stream<<"module Internet\n{"<<endl;
		}
		stream<<"\tparameters:"<<endl;
		stream<<"\t\t@Internet();"<<endl;
		stream<<"\tsubmodules:"<<endl;

		// AS-Level Topology
		for(int i = 0; i < vTopology.size(); i++)
		{
			node = dynamic_cast<ASNode*> (vTopology[i]);
			if(!node)
			{
				if(DEBUG)
					cout<<"Generation failure: dynamic_cast<ASNode*> (vTopology[i]) in printTopology failed"<<endl;
				stream.close();
				return 1;
			}

			if(node->getRouterLevelTopology()!=NULL)
			{
				// in case that each AS node contains a router-level topology,
				// we define each node as its own module
				if(node->getNodeType() == TRANSIT_AS)
				{
					stream << "\t\ttas" << node->getId() << ": TAS" << node->getId() << " {" << endl;
					stream << "\t\t\tparameters:" << endl;
					stream << "\t\t\t\t@AS();" << endl;
					stream << "\t\t\t\t@display(\"i=misc/globe_s\");" << endl;
					stream << "\t\t}" << endl;
				}
				else
				{
					stream << "\t\tsas" << node->getId() << ": SAS" << node->getId() << " {" << endl;
					stream << "\t\t\tparameters:" << endl;
					stream << "\t\t\t\t@AS();" << endl;
					stream << "\t\t\t\t@display(\"i=misc/cloud_s\");" << endl;
					stream << "\t\t}" << endl;
				}
			}
			else
			{
				// in the other case, each module is defined the same simple module
				if(node->getNodeType() == TRANSIT_AS)
				{
					stream << "\t\ttas" << node->getId() << ": TASNode" << node->getId() << " {" << endl;
					stream << "\t\t\tparameters:" << endl;
					stream << "\t\t\t\t@AS();" << endl;
					stream << "\t\t\t\t@display(\"i=misc/globe_s\");" << endl;
					stream << "\t\t}" << endl;
				}
				else
				{
					stream << "\t\tsas" << node->getId() << ": SASNode" << node->getId() << " {" << endl;
					stream << "\t\t\tparameters:" << endl;
					stream << "\t\t\t\t@AS();" << endl;
					stream << "\t\t\t\t@display(\"i=misc/cloud_s\");" << endl;
					stream << "\t\t}" << endl;
				}
			}
		} //end for

		// now write connections between the AS nodes into output NED file
		stream<<endl<<"\tconnections:"<<endl;
		for(int i = 0; i < vTopology.size(); i++)
		{
			ASNode *srcNode = dynamic_cast<ASNode*> (vTopology[i]);
			for(int j = 0; j < srcNode->getPeers().size(); j++)
			{
				ASNode *dstNode = dynamic_cast<ASNode*> (srcNode->getPeers()[j]);
				// check if ids are equal, don't add a reflexive connection
				if (dstNode->getId() <= srcNode->getId())
					continue;
				if(srcNode->getNodeType() == TRANSIT_AS)
				{
					if(dstNode->getNodeType() == STUB_AS)
						stream << "\t\ttas"<<srcNode->getId()<<".pppg++ <--> stub2transit <--> sas"<<\
							dstNode->getId()<<".pppg++;"<<endl;
					else
						stream << "\t\ttas"<<srcNode->getId()<<".pppg++ <--> transit2transit <--> tas"<<\
							dstNode->getId()<<".pppg++;"<<endl;
				}
				else
				{
					if(dstNode->getNodeType() == STUB_AS)
						stream<<"\t\tsas"<<srcNode->getId()<<".pppg++ <--> stub2stub <--> sas"<<\
							dstNode->getId()<<".pppg++;"<<endl;
					else
						stream<<"\t\tsas"<<srcNode->getId()<<".pppg++ <--> stub2transit <--> tas"<<\
							dstNode->getId()<<".pppg++;"<<endl;
				}

			}
		}

		// print trailer of network module
		stream<<endl<<"}"<<endl<<endl;
		if(OverSim == 1)
			stream<<"network ReaSEUnderlayNetwork extends Internet\n{\n\tparameters:\n}"<<endl<<endl;
		else
			stream<<"network Inet extends Internet\n{\n\tparameters:\n}"<<endl<<endl;

		if(isComplexTopology)
		{
			// write module and gate definitions of AS nodes as well as router-level topology
			for(int i = 0; i < vTopology.size(); i++)
			{
				map<int,int> hostsAtEdge;
				if(DEBUG)
				{
					cout<<"INFO: print Router-Level for ";
					if(vTopology[i]->getNodeType() == TRANSIT_AS)
						cout<<"Transit-AS"<<vTopology[i]->getId()<<endl;
					else
						cout<<"Stub-AS"<<vTopology[i]->getId()<<endl;
				}

				node = dynamic_cast<ASNode*>(vTopology[i]);

				if(node->getNodeType() == TRANSIT_AS)
					stream<<"module TAS"<<node->getId()<<endl;
				else
					stream<<"module SAS"<<node->getId()<<endl;
				stream<<"{"<<endl;
				stream<<"\tgates:"<<endl;
				stream<<"\t\tinout pppg[];"<<endl;
				stream<<"\tsubmodules:"<<endl;

				TopologyVector *rtv = node->getRouterLevelTopology();
				if(rtv == NULL) {
					if(DEBUG)
						cout<<"Generation failure: could not get router level topology"<<endl;
					stream.close();
					return 1;
				}

				// write router node definitions
				for(int j = 0; j < rtv->size(); j++)
				{
					if((*rtv)[j]->getNodeType() == CORE_ROUTER)
					{
						stream<<"\t\tcore"<<(*rtv)[j]->getId()<<": Router {"<<endl;
						stream<<"\t\t\tparameters:"<<endl;
						stream << "\t\t\t\t@RL();" << endl;
						stream << "\t\t\t\t@CoreRouter();" << endl;
						stream<<"\t\t\t\t@display(\"i=abstract/switch\");"<<endl;
						stream<<"\t\t}"<<endl;
					}
					else if((*rtv)[j]->getNodeType() == GW_ROUTER)
					{
						stream<<"\t\tgw"<<(*rtv)[j]->getId()<<": Router {"<<endl;
						stream<<"\t\t\tparameters:"<<endl;
						stream << "\t\t\t\t@RL();" << endl;
						if(OverSim == 1)
							stream << "\t\t\t\t@GatewayRouter();" << endl;
						stream<<"\t\t\t\t@display(\"i=abstract/router2\");"<<endl;
						stream<<"\t\t}"<<endl;
					}
					else if((*rtv)[j]->getNodeType() == EDGE_ROUTER)
					{
						stream<<"\t\tedge"<<(*rtv)[j]->getId()<<": Router {"<<endl;
						stream<<"\t\t\tparameters:"<<endl;
						stream << "\t\t\t\t@RL();" << endl;
						if(OverSim == 1)
							stream << "\t\t\t\t@EdgeRouter();" << endl;
						stream<<"\t\t\t\t@display(\"i=abstract/router\");"<<endl;
						stream<<"\t\t}"<<endl;

						// create random number of host systems per edge node
						int hostsystems = hostsPerEdgeMin;
						if((hostsPerEdgeMax-hostsPerEdgeMin) > 0)
							hostsystems += rand()%(hostsPerEdgeMax-hostsPerEdgeMin + 1);
						hostsAtEdge.insert(pair<int, int>((*rtv)[j]->getId(), hostsystems));
					}
				}

				// write host system into output NED file
				int index = rtv->size();
				map<int, int>::iterator it = hostsAtEdge.begin();
				while(it != hostsAtEdge.end())
				{
					for(int j = 0; j < it->second; j++)
					{
						stream<<"\t\thost"<<index++<<": StandardHost {"<<endl;
						stream<<"\t\t\tparameters:"<<endl;
						stream << "\t\t\t\t@RL();" << endl;
						if(OverSim == 1)
							stream << "\t\t\t\t@Host();" << endl;
						stream<<"\t\t\t\t@display(\"i=device/laptop\");"<<endl;
						stream<<"\t\t}"<<endl;
					}
					it++;
				}

				// write connections between nodes into output NED file
				stream<<endl<<"\tconnections:"<<endl;

				// connections from core routers to AS border
				int noCoreNodes = 0;
				for(int j = 0; j < rtv->size(); j++)
				{
					if((*rtv)[j]->getNodeType() == CORE_ROUTER)
						noCoreNodes++;
					else
						break;
				}

				for(int j = 0; j < vTopology[i]->getNodeDegree(); j++)
				{
					stream<<"\t\tpppg++ <--> core"<<(j % noCoreNodes)<<".pppg++;"<<endl;
				}
				stream<<endl;

				// connections between router-level nodes
				for(int j = 0; j < rtv->size();j++)
				{
					RNode *srcNode = dynamic_cast<RNode*> ((*rtv)[j]);
					for(int k = 0; k<srcNode->getPeers().size(); k++)
					{
						RNode *dstNode = dynamic_cast<RNode*> (srcNode->getPeers()[k]);
						// check if ids are equal, don't add a reflexive connection
						if (dstNode->getId() <= srcNode->getId())
							continue;
						if(srcNode->getNodeType() == CORE_ROUTER)
							if(dstNode->getNodeType() == CORE_ROUTER)
								stream<<"\t\tcore"<<srcNode->getId()<<".pppg++ <--> core2core <--> core"<<dstNode->getId()<<".pppg++;"<<endl;
							else if(dstNode->getNodeType() == GW_ROUTER)
								stream<<"\t\tcore"<<srcNode->getId()<<".pppg++ <--> gateway2core <--> gw"<<dstNode->getId()<<".pppg++;"<<endl;
							else
								cerr<<"ERROR: invalid connection of core router"<<endl;
						else if(srcNode->getNodeType() == GW_ROUTER)
							if(dstNode->getNodeType() == CORE_ROUTER)
								stream<<"\t\tgw"<<srcNode->getId()<<".pppg++ <--> gateway2core <--> core"<<dstNode->getId()<<".pppg++;"<<endl;
							else if(dstNode->getNodeType() == EDGE_ROUTER)
								stream<<"\t\tgw"<<srcNode->getId()<<".pppg++ <--> edge2gateway <--> edge"<<dstNode->getId()<<".pppg++;"<<endl;
							else
								cerr<<"ERROR: invalid connection of gateway router"<<endl;
						else if(srcNode->getNodeType() == EDGE_ROUTER)
							if(dstNode->getNodeType() == GW_ROUTER)
								stream<<"\t\tedge"<<srcNode->getId()<<".pppg++ <--> edge2gateway <--> gw"<<dstNode->getId()<<".pppg++;"<<endl;
							else
								cerr<<"ERROR: invalid connection of edge router"<<endl;
					}
				}

				// connections of hosts to edges
				it = hostsAtEdge.begin();
				index = rtv->size();
				while(it != hostsAtEdge.end())
				{
					for(int j = 0; j < it->second; j++)
					{
						stream<<"\t\thost"<<index<<".pppg$o++ --> host2edge --> edge"<<it->first<<".pppg$i++;"<<endl;
						stream<<"\t\tedge"<<it->first<<".pppg$o++ --> edge2host --> host"<<index++<<".pppg$i++;"<<endl;
					}
					it++;
				}
				stream<<"}"<<endl<<endl;
			}
		}//endif (complex)
	}
	else
	{
		// Router-level topology only
		if(DEBUG)
			cout<<"INFO: print router-level topology"<<endl;


		// write channel definitions into output NED file
		stream<<endl;
		stream<<"channel host2edge extends ned.DatarateChannel\n{\n\tparameters:\n\t\tdelay = 1us;\n\t\tdatarate = 1Mbps;\n}"<<endl;
		stream<<"channel edge2host extends ned.DatarateChannel\n{\n\tparameters:\n\t\tdelay = 1us;\n\t\tdatarate = 1Mbps;\n}"<<endl;
		stream<<"channel edge2gateway extends ned.DatarateChannel\n{\n\tparameters:\n\t\tdelay = 1us;\n\t\tdatarate = 155Mbps;\n}"<<endl;
		stream<<"channel gateway2core extends ned.DatarateChannel\n{\n\tparameters:\n\t\tdelay = 1us;\n\t\tdatarate = 622Mbps;\n}"<<endl;
		stream<<"channel core2core extends ned.DatarateChannel\n{\n\tparameters:\n\t\tdelay = 1us;\n\t\tdatarate = 1000Mbps;\n}"<<endl<<endl;

		if (OverSim == 1) {
			stream<<"module Internet extends oversim.underlay.reaseunderlay.ReaSEUnderlayNetworkBase\n{"<<endl;
		} else {
			stream<<"module Internet\n{"<<endl;
		}
		stream<<"\tparameters:"<<endl;
		stream<<"\t\t@Internet();"<<endl;
		stream<<"\tsubmodules:"<<endl;

		// write router node definitions
		map<int,int> hostsAtEdge;
		for(int i = 0; i < vTopology.size(); i++)
		{
			if(vTopology[i]->getNodeType() == CORE_ROUTER)
			{
				stream<<"\t\tcore"<<vTopology[i]->getId()<<": Router {"<<endl;
				stream<<"\t\t\tparameters:"<<endl;
				stream << "\t\t\t\t@RL();" << endl;
				stream << "\t\t\t\t@CoreRouter();" << endl;
				stream<<"\t\t\t\t@display(\"i=abstract/switch\");"<<endl;
				stream<<"\t\t}"<<endl;
			}
			else if(vTopology[i]->getNodeType() == GW_ROUTER)
			{
				stream<<"\t\tgw"<<vTopology[i]->getId()<<": Router {"<<endl;
				stream<<"\t\t\tparameters:"<<endl;
				stream << "\t\t\t\t@RL();" << endl;
				if(OverSim == 1)
					stream << "\t\t\t\t@GatewayRouter();" << endl;
				stream<<"\t\t\t\t@display(\"i=abstract/router2\");"<<endl;
				stream<<"\t\t}"<<endl;
			}
			else if(vTopology[i]->getNodeType() == EDGE_ROUTER)
			{
				stream<<"\t\tedge"<<vTopology[i]->getId()<<": Router {"<<endl;
				stream<<"\t\t\tparameters:"<<endl;
				stream << "\t\t\t\t@RL();" << endl;
				if(OverSim == 1)
					stream << "\t\t\t\t@EdgeRouter();" << endl;
				stream<<"\t\t\t\t@display(\"i=abstract/router\");"<<endl;
				stream<<"\t\t}"<<endl;

				// create random number of host systems
				int hostsystems = hostsPerEdgeMin;
				if((hostsPerEdgeMax-hostsPerEdgeMin) > 0)
					hostsPerEdgeMin += rand() % (hostsPerEdgeMax - hostsPerEdgeMin + 1);
				hostsAtEdge.insert(pair<int, int>(vTopology[i]->getId(), hostsystems));
			}
		}

		// write host system into output NED file
		map<int, int>::iterator it = hostsAtEdge.begin();
		int index = vTopology.size();
		while(it != hostsAtEdge.end())
		{
			for(int j = 0; j < it->second; j++)
			{
				stream<<"\t\thost"<<index++<<": StandardHost {"<<endl;
				stream<<"\t\t\tparameters:"<<endl;
				stream << "\t\t\t\t@RL();" << endl;
				if(OverSim == 1)
					stream << "\t\t\t\t@Host();" << endl;
				stream<<"\t\t\t\t@display(\"i=device/laptop\");"<<endl;
				stream<<"\t\t}"<<endl;
			}
			it++;
		}

		// write connections between nodes into output NED file
		stream<<endl<<"\tconnections:"<<endl;

		// connections between router-level nodes
		for(int i = 0; i < vTopology.size();i++)
		{
			RNode *srcNode = dynamic_cast<RNode*> (vTopology[i]);
			for(int j = 0; j < srcNode->getPeers().size(); j++)
			{
				RNode *dstNode = dynamic_cast<RNode*> (srcNode->getPeers()[j]);
				// check if ids are equal, don't add a reflexive connection
				if (dstNode->getId() <= srcNode->getId())
					continue;
				if(srcNode->getNodeType() == CORE_ROUTER)
					if(dstNode->getNodeType() == CORE_ROUTER)
						stream<<"\t\tcore"<<srcNode->getId()<<".pppg++ <--> core2core <--> core"<<dstNode->getId()<<".pppg++;"<<endl;
					else if(dstNode->getNodeType() == GW_ROUTER)
						stream<<"\t\tcore"<<srcNode->getId()<<".pppg++ <--> gateway2core <--> gw"<<dstNode->getId()<<".pppg++;"<<endl;
					else
						cerr<<"ERROR: invalid connection of core router"<<endl;
				else if(srcNode->getNodeType() == GW_ROUTER)
					if(dstNode->getNodeType() == CORE_ROUTER)
						stream<<"\t\tgw"<<srcNode->getId()<<".pppg++ <--> gateway2core <--> core"<<dstNode->getId()<<".pppg++;"<<endl;
					else if(dstNode->getNodeType() == EDGE_ROUTER)
						stream<<"\t\tgw"<<srcNode->getId()<<".pppg++ <--> edge2gateway <--> edge"<<dstNode->getId()<<".pppg++;"<<endl;
					else
						cerr<<"ERROR: invalid connection of gateway router"<<endl;
				else if(srcNode->getNodeType() == EDGE_ROUTER)
					if(dstNode->getNodeType() == GW_ROUTER)
						stream<<"\t\tedge"<<srcNode->getId()<<".pppg++ <--> edge2gateway <--> gw"<<dstNode->getId()<<".pppg++;"<<endl;
					else
						cerr<<"ERROR: invalid connection of edge router"<<endl;
			}

		}

		// connections of hosts to edge routers
		it = hostsAtEdge.begin();
		index = vTopology.size();
		while(it != hostsAtEdge.end())
		{
			for(int j=0; j<it->second; j++)
			{
				stream<<"\t\thost"<<index<<".pppg$o++ --> host2edge --> edge"<<it->first<<".pppg$i++;"<<endl;
				stream<<"\t\tedge"<<it->first<<".pppg$o++ --> edge2host --> host"<<index++<<".pppg$i++;"<<endl;
			}
			it++;
		}

		// write trailer of network module
		stream<<endl<<"}"<<endl<<endl;
		if(OverSim == 1)
			stream<<"network ReaSEUnderlayNetwork extends Internet\n{\n\tparameters:\n}"<<endl<<endl;
		else
			stream<<"network Inet extends Internet\n{\n\tparameters:\n}"<<endl<<endl;

	}
	stream.close();

	return 0;
}

/**
 * Write all three powerlaw values of AS-level topology as well as of router-level topology
 * of the first AS node into the according output files.
 * STATISTICS must be specified during make process and output file prefix must be given in parameter file.
 *
 * @return status code
 */
int TGM::printPowerlawStats()
{
	if(statPref != "")
	{
#ifdef STATISTICS
		string outFile;
		if(dynamic_cast<ASNode*>(vTopology[0]))
		{
			if(DEBUG)
				cout<<"INFO: Calculate Powerlaw Values of AS-level Topology"<<endl;
			outFile = statPref + "AS_1";
			calcPL1(vTopology, outFile);
			outFile = statPref + "AS_2";
			calcPL2(vTopology, outFile);
			outFile = statPref + "AS_3";
			calcPL3(vTopology, outFile);

			ASNode *as = dynamic_cast<ASNode*>(vTopology[0]);
			if(as->getRouterLevelTopology())
			{
				TopologyVector *rTv = as->getRouterLevelTopology();
				if(DEBUG)
					cout<<endl<<"INFO: Calculate Powerlaw Values of Router-level Topology (AS0)"<<endl;
				outFile = statPref + "R_1";
				calcPL1(*rTv, outFile);
				outFile = statPref + "R_2";
				calcPL2(*rTv, outFile);
				outFile = statPref + "R_3";
				calcPL3(*rTv, outFile);
			}
		}
		else
		{
			if(DEBUG)
				cout<<"INFO: Calculate Powerlaw values of Router-level Topology"<<endl;
			outFile = statPref + "R_1";
			calcPL1(vTopology, outFile);
			outFile = statPref + "R_2";
			calcPL2(vTopology, outFile);
			outFile = statPref + "R_3";
			calcPL3(vTopology, outFile);
		}
#else
		cerr<<"ERROR: Could not calculate PowerLaw Statistics:"<<endl;
		cerr<<"set gnu-scientific-library Path (softlink to gsl)"<<endl<<"and compile with POWERLAWS = TRUE"<<endl;
#endif
	}
	else
	{
		if(DEBUG)
			cout<<"INFO: No value for Stats-Prefix given in configuration file: PowerLaw Statistics are not calculated."<<endl;
	}
}

#ifdef STATISTICS
/**
 * Powerlaw values of the generated topology can be compared with values of real topologies to show
 * the quality of the generated topology. There are three powerlaw values to be calculated.
 * This method calculates the first of these powerlaw values:
 * draw node degree of all nodes in descending order within log-log-scale and approximate
 *
 * @param tv Topology vector that contains all nodes and node degrees necessary for calculation of powerlaw value
 * @param filename Name of output file the calculated values are written to
 *                 (x and y value (non-logarithmic) as well as approximated y value)
 */
void TGM::calcPL1(TopologyVector &tv, string filename)
{
	ofstream &stream = openFile(filename.data());
	double xVal[tv.size()], yVal[tv.size()];
	int index = 1;
	TopologyList tlist;


	// append all topology nodes of the given vector to a node list and sort this list by descending node degree
	for(int i = 0; i < tv.size(); i++)
	{
		tlist.push_back(tv[i]);
	}
	tlist.sort(TopologyNode::compareNodes);

	// write index and node degree of a node into a log-log-scale
	TopologyList::iterator it = tlist.begin();
	while(it != tlist.end())
	{
		xVal[index-1] = log10(index);
		yVal[index-1] = log10((*it)->getNodeDegree());
		it++;
		index++;
	}
	tlist.clear();

	// calculate linear square approximation for these values
	double a = 0.4, b = 0.4;
	double 	cov00, cov01, cov11, sumsq;
	gsl_fit_linear (xVal, 1, yVal,1, tv.size(), &b, &a, &cov00, &cov01, &cov11, &sumsq);
	// a is the first powerlaw value
	if(DEBUG)
		cout<<"INFO: LinearSquareApproximation for PowerLaw1: < "<<a<<" * x + "<<b<<" >"<<endl;

	// write x and y value (non-logarithmic) as well as approximated y value into output file
	stream << "# Approximation for PowerLaw2: "<<a<<" * x + "<<b<<endl<<endl;
	for(int i = 0; i < tv.size(); i++)
	{
		stream << pow(10,xVal[i]) <<"   "<< pow(10,yVal[i]) <<"   "<<pow(10,(a*xVal[i]+b))<<endl;
	}
	stream.close();
}

/**
 * Powerlaw values of the generated topology can be compared with values of real topologies to show
 * the quality of the generated topology. There are three powerlaw values to be calculated.
 * This method calculates the second of these powerlaw values:
 * draw complementary distribution function of node degrees within log-log-scale and approximate
 *
 * @param tv Topology vector that contains all nodes and node degrees necessary for calculation of powerlaw value
 * @param filename Name of output file the calculated values are written to
 *                 (x and y value (non-logarithmic) as well as approximated y value)
 */
void TGM::calcPL2(TopologyVector &tv, string filename)
{
	ofstream &stream = openFile(filename.data());
	int noDifferentDegrees;
	int preNodeDegree;
	int index = 1;
	int nodeCount = 0;
	TopologyList tlist;

	// append all topology nodes of the given vector to a node list and sort this list by descending node degree
	for(int i = 0; i < tv.size(); i++)
	{
		tlist.push_back(tv[i]);
	}
	tlist.sort(TopologyNode::compareNodes);

	// find out number of different node degrees for the array subsequently used
	TopologyList::iterator it = tlist.begin();
	// initialization
	if(tv.size() > 0)
	{
		preNodeDegree = (*it)->getNodeDegree();
		noDifferentDegrees = 1;
	}
	// iteration
	while(it != tlist.end())
	{
		if(preNodeDegree > (*it)->getNodeDegree())
		{
			noDifferentDegrees++;
			preNodeDegree = (*it)->getNodeDegree();
		}
		it++;
	}

	// create complementary distribution function of node degrees within a log-log-scale
	// (x-axis: node degree, y-axis: cumulative probability)
	double xVal[noDifferentDegrees], yVal[noDifferentDegrees];
	preNodeDegree = 2*tv.size();

	it = tlist.begin();
	// initialization
	if(tv.size() > 0)
	{
		preNodeDegree = (*it)->getNodeDegree();
		it++;
		nodeCount++;
	}
	// iteration
	while(it != tlist.end())
	{
		nodeCount++;
		if(preNodeDegree > (*it)->getNodeDegree())
		{
			xVal[index-1] = log10(preNodeDegree); //(*it)->getNodeDegree());
			yVal[index-1] = log10(((double)(nodeCount - 1) / (double)tv.size()));
			preNodeDegree = (*it)->getNodeDegree();
			index++;
		}
		it++;
	}
	tlist.clear();
	// last step
	xVal[noDifferentDegrees-1] = log10(preNodeDegree);
	yVal[noDifferentDegrees-1] = log10(1);

	// calculate linear square approximation for these values
	double a = 0.4, b = 0.4;
	double 	cov00, cov01, cov11, sumsq;
	gsl_fit_linear (xVal, 1, yVal,1, noDifferentDegrees, &b, &a, &cov00, &cov01, &cov11, &sumsq);
	// a is the second powerlaw value
	if(DEBUG)
		cout<<"INFO: LinearSquareApproximation for PowerLaw2: < "<<a<<" * x + "<<b<<" >"<<endl;

	// write x and y value (non-logarithmic) as well as approximated y value into output file
	stream << "# Approximation for PowerLaw2: "<<a<<" * x + "<<b<<endl<<endl;
	for(int i = 0; i < noDifferentDegrees; i++)
	{
		stream << pow(10,xVal[i]) <<"   "<< pow(10,yVal[i]) <<"   "<<pow(10,(a*xVal[i]+b))<<endl;
	}
	stream.close();
}

/**
 * Powerlaw values of the generated topology can be compared with values of real topologies to show
 * the quality of the generated topology. There are three powerlaw values to be calculated.
 * This method calculates the third of these powerlaw values:
 * draw eigen-values of adjacency matrix and approximate
 *
 * @param tv Topology vector that contains all nodes and node degrees necessary for calculation of powerlaw value
 * @param filename Name of output file the calculated values are written to
 *                 (x and y value (non-logarithmic) as well as approximated y value)
 */
void TGM::calcPL3(TopologyVector &tv, string filename)
{
	ofstream &stream = openFile(filename.data());
	gsl_matrix *adjacencyMatrix = gsl_matrix_alloc(tv.size(), tv.size());
	gsl_matrix_set_zero(adjacencyMatrix);

	int eigenvaluesRegarded = 100;
  	double xVal[eigenvaluesRegarded], yVal[eigenvaluesRegarded];

	// fill adjacencyMatrix: node a connected to node b --> 1.0 at crosspoint
	for(int i = 0; i < tv.size(); i++)
	{
		for(int j=0; j<tv[i]->getPeers().size(); j++)
		{
			gsl_matrix_set(adjacencyMatrix, i, tv[i]->getPeers()[j]->getId(), 1.0);
		}
	}

	// calculate eigenvalues of the adjacency matrix
	gsl_vector *eigenvalues = gsl_vector_alloc(tv.size());
	gsl_vector_set_zero(eigenvalues);
	gsl_eigen_symm_workspace *w = gsl_eigen_symm_alloc(tv.size());

	if(DEBUG)
		cout<<"INFO: calculating eigenvalues ... this could take a time"<<endl;
 	gsl_eigen_symm(adjacencyMatrix, eigenvalues, w);

	// write all positive eigenvalues (--> this is for simplicity) into a list
  	list<double> eigenvalueList;
  	for(int i = 0; i < tv.size(); i++)
  	{
		if(gsl_vector_get(eigenvalues, i) < 0.)
			continue;
		eigenvalueList.push_back(gsl_vector_get(eigenvalues, i));
  	}

  	// like in the paper - sort the values ascending and look at the largest eigenvaluesRegarded of them
  	// (M. Faloutsos, P. Faloutsos, C. Faloutsos - On power-law relationship of
	// the Internet topology. CC Review 29(4), 1999)
  	eigenvalueList.sort();
  	list<double>::iterator lit = eigenvalueList.end();
  	lit--;
	for(int i = 0; i < eigenvaluesRegarded; i++)
  	{
	    xVal[i] = log10(i+1);
	    yVal[i] = log10(*lit);
	    lit--;
  	}

  	// free workspace
	gsl_vector_free (eigenvalues);
	gsl_matrix_free (adjacencyMatrix);
	gsl_eigen_symm_free(w);

	// calculate linear square approximation for these values
	double a = 0.4, b = 0.4;
	double 	cov00, cov01, cov11, sumsq;
	gsl_fit_linear (xVal, 1, yVal,1, eigenvaluesRegarded, &b, &a, &cov00, &cov01, &cov11, &sumsq);
	// a is the third powerlaw value
	if(DEBUG)
		cout<<"INFO: LinearSquareApproximation for PowerLaw3: < "<<a<<" * x + "<<b<<" >"<<endl;

	// write x and y value (non-logarithmic) as well as approximated y value into output file
	stream << "# Approximation for PowerLaw2: "<<a<<" * x + "<<b<<endl<<endl;
	for(int i = 0; i < eigenvaluesRegarded; i++)
	{
		stream << pow(10,xVal[i]) <<"   "<< pow(10,yVal[i]) <<"   "<<pow(10,(a*xVal[i]+b))<<endl;
	}
	stream.close();
}
#endif

} //endNamespace

using namespace tgm;

/**
 * Main method:
 *   One parameter is expected: A parameter file containing all necessary configuration values
 *
 * @param argc number of command line parameters
 * @param argv command line parameters
 * @return status code
 */
int main(int argc, char **argv)
{
	if(argc != 2)
	{
		cerr<<"Usage: tgm <paraFile>\n";
		return 1;
	}

	int maxTries;
	int totalTries = 0;
	bool failed = true;
	TGM *tgmBuilder;
	int ret;
	int topoSize;

	if(DEBUG)
		maxTries = 3;
	else
		maxTries = 10000;

	while (failed && (maxTries > totalTries)){
		
		tgmBuilder = new TGM(totalTries+1);
		totalTries++;
		failed = false;

		// read parameters from parameter file
		if(tgmBuilder->readParameter(argv[1]))
		{
			cerr<<"ERROR: Error while reading ParaFile\n";
			delete tgmBuilder;
			break;
		}

		// set maxTries dependent on estimated topology size
		if(totalTries == 1 && !DEBUG) {
			topoSize = 10000000 / tgmBuilder->estimateTopologySize();
			maxTries = (topoSize > 1) ? topoSize : 1;
		}

		// build complete topology
		if((ret=tgmBuilder->buildTopology()) == 1)
		{
			delete tgmBuilder;
			// error: stop generation completely
			break;
		} else if(ret == 2) {
			failed = true;
			delete tgmBuilder;
			// generation failure: try another run
			continue;
		}

		// write created topology into output NED file
		if(tgmBuilder->printTopology())
		{
			failed = true;
			delete tgmBuilder;
			continue;
		}

		// calculate and write powerlaw values if required
		tgmBuilder->printPowerlawStats();

		delete tgmBuilder;
	}

	if(failed){
		cerr<<"ERROR: Error while building Topology\n";
		cerr<<"Gave up after "<< totalTries << " tries.\n";
		if(!DEBUG)
			cerr<<"Enable DebugMode for details on errors.\n";
		return 1;
	}


	return 0;
}
