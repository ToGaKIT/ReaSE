#include "RNode.h"


namespace tgm
{
/**
 * @brief This class is derived from TopologyNode and specifies the behaviour of nodes on router-level.
 *
 * The Topology created by TGM is built hierarchically. On the top level the AS nodes form a topology
 * between different administrative domains. AS nodes in the core are transit AS nodes, else they are stub AS nodes.
 * On the second level, each AS contains a router-level topology. This router-level topology, in turn, 
 * is built hierarchically and consists of core, gateway, and edge nodes. 
 * The actual hosts are connected to edge nodes only.
 * 
 * RNodes are of type CORE_ROUTER, GW_ROUTER, or EDGE_ROUTER.
 *
 * @version 1.0-developer version
 * @author Michael Scharf, Thomas Gamer
 *
 * @class RNode
 */

/**
 * Constructor (calls constructor of super class)
 *
 * @param Unique node ID
 */
RNode::RNode(int id):TopologyNode(id)
{
	resetConn = false;
	noConnections = 0;	
}

/**
 * Destructor
 */
RNode::~RNode()
{
}

/**
 * This method turns an unused edge into a connection to the given nodes.
 * In addition, an unused edge of the given node is connected to this node, 
 * i.e. a bidirection connection is established.
 *
 * Router-level topology is established in two separate loops: first, nodes 
 * with powerlaw distributed node degree are created by PFP. The connections
 * then are deleted and re-created based on HOT model. In case of re-creation
 * a new connection does not increase nodeDegree, in the first loop, however,
 * it does. Thus, the connectTo method of the super class has to be overwritten.
 *
 * @param Router-level node this node should be connected to
 */
void RNode::connectTo(TopologyNode *node)
{
	RNode *rnode = dynamic_cast<RNode*> (node);
	if(!rnode)
	{
		cerr<<"dynamic_cast<RNode*> (TopologyNode*) failed"<<endl;
		exit(1);
	}

	// in the second loop (resetConn == true) creation of a new connection does not increase edgeDegree
	if(resetConn)
	{
		if(!isConnected(node))
		{
			peers.push_back(rnode);
			rnode->peers.push_back(this);
			noConnections++;
			rnode->noConnections++;
		}
	}
	// in the first loop (resetConn == false) topology is created normally according to the PFP growth model
	else
	{
		if(!isConnected(node))
		{
			TopologyNode::connectTo(node);
			noConnections++;
			rnode->noConnections++;
		}
	}
}

/**
 * Resets all connections of each node contained in the given vector. 
 * Then, the parameter resetConn is set for each node indicating that
 * the second loop of router-level topology creation can be started.
 *
 * This method is declared static (and thus, reset ALL connections).
 *
 * @param Vector of topology nodes
 */
void RNode::resetConnections(TopologyVector &tv)
{
	for(int i = 0; i < tv.size(); i++)
	{
		RNode *rnode = dynamic_cast<RNode*> (tv[i]);

		if(rnode == NULL)
		{
			cerr<<"ERROR: dynamic_cast<RNode*> (TopologyNode*) failed"<<endl;
			exit(1);
		}

		rnode->peers.clear();
		rnode->noConnections = 0;
		rnode->resetConn = true;
	}
}

/**
 * A node is assigned a certain number of edges according to the powerlaw distribution during the 
 * creation algorithm. This method returns the number of edges that, at the current stage of the algorithm,
 * are not connected to other nodes yet.
 *
 * @return Number of a node's edges that currently are not connected to other nodes
 */
int RNode::unusedEdges()
{
	return (edgeDegree - noConnections);
}


}
