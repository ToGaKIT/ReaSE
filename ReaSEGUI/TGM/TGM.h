/**
 * @brief The namespace tgm contains all classes and members that are necessary for TGM - a topology generator for realistic OMNeT++ simulation environments.
 *
 * The namespace tgm consists of the class TGM, TopologyNode, ASNode, and RNode.
 * TGM creates topologies for usage with the discrete event simulator OMNeT++.
 *
 * @namespace tgm
 */

#ifndef TGM_H_
#define TGM_H_

#include "TopologyNode.h"
#include "ASNode.h"
#include "RNode.h"
#include <cmath>

#include <vector>
#include <cstring>
#include <list>
#include <fstream>
#include <climits>
#include <cstdlib>

#ifdef STATISTICS
#include <gsl/gsl_fit.h>
#include <gsl/gsl_matrix.h>
#include <gsl/gsl_blas.h>
#include <gsl/gsl_eigen.h>
#endif


class TopologyNode;
class RNode;
class ASNode;

namespace tgm
{

//
// set this value to 1 in order to get debug output
//
#define DEBUG 0

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
class TGM
{

private:
	/** Vector of AS-level topology nodes */
	TopologyVector vTopology;
	/** indicates if user parameter have already been read */
	bool parasRead;

	/** indicates if AS-level topology should be created */
	bool asLevel;
	// state variables for AS-level
	/** number of AS nodes */
	int asNodes;
	/** AS nodes of this degree or higher are implicitly transit AS nodes */
	int transitThresh;
	/** parameter for PFP algorithm */
	double paramP;
	/** parameter for PFP algorithm */
	double paramDelta;

	/** indicates if router-level topology should be created */
	bool rLevel;
	// state variables for router-level
	/** minimal number of router-level nodes */
	int rNodeMin;
	/** maximal number of router-level nodes */
	int rNodeMax;
	/** minimal number of hosts attached to edge nodes of router level */
	int hostsPerEdgeMin;
	/** maximal number of hosts attached to edge nodes of router level */
	int hostsPerEdgeMax;
	/** percentage of nodes that must be core nodes */
	double coreRatio;
	/** percentage of core node connections that must be connection to other core nodes */
	double coreCrossLinkRatio;
	/** OverSim topology indicator*/
	int OverSim;

	// general parameters
	/** File name of output NED file */
	string topFile;
	/** File name prefix for powerlaw values of generated topology */
	string statPref;

	/** Global counter for unique node IDs on AS-level*/
	int asIdCount;
	/** Global counter for unique node IDs on router-level*/
	int rlIdCount;

	/** @brief Contains for each node its probability based on node degree and parameter Delta
	 *  Probabilities are normalized in a way that the sum of all probabilities becomes 1.
	 */
	double *nodesProbability;
	/** Indicates that probabilities must be renew after addition of a new node during the PFP growth algorithm */
	bool probabilityIsDirty;

	/** generic file output stream used by this class */
	ofstream output;

public:
	TGM();
	TGM(int runNumber);
	virtual ~TGM();
	/// @brief Reads parameters for topology creation from user-given parameter file
	int readParameter(char *fileName);
	/// @brief Creates topology for OMNeT++
	int buildTopology();
	/// @brief Writes created topology to output NED file
	int printTopology();
	/// @brief Perform calculation of powerlaw values and write them to output files
	int printPowerlawStats();
	/// @brief Estimate total size of resulting topology roughly
	int estimateTopologySize();


private:
	/// @initialize member variables
	void initialize();
	/// @brief Creates AS-level topology
	int buildASLevelTopology(TopologyVector &tv);
	/// @brief Creates router-level topology
	int buildRouterLevelTopology(TopologyVector &tv, int noNodes);

	 /// @brief This method creates a new AS-level node with a unique ID.
	 /// @return newly instanciated AS-level node
	TopologyNode *allocateNewASNode() { return new ASNode(asIdCount++); }
	 /// @brief This method creates a new router-level node with a unique ID.
	 /// @return newly instanciated router-level node
	TopologyNode *allocateNewRNode() { return new RNode(rlIdCount++); }

	/// @brief Perform initialization step of PFP growth algorithm: three interconnected nodes
	int createStartNodes(TopologyVector &tv, TopologyNode *(TGM::*newNodeFunc)());

	/// @brief Perform iteration step of PFP growth algorithm: add and connect new nodes to existing topology
	void pfpGrow(TopologyVector &tv, TopologyNode *(TGM::*NewNodeFunc)());
	/// @brief ...
	void baGrow(TopologyVector &tv, int noNodes, TopologyNode *(TGM::*NewNodeFunc)());

	/// @brief Randomly select a node of the current topology
	TopologyNode *getHostNode(TopologyVector &tv);
	/// @brief Randomly select a node of the current topology -- exception: the additionally given node must not be selected
	TopologyNode *getHostNode(TopologyNode *except, TopologyVector &tv);
	/// @brief Randomly select a node of the current topology
	TopologyNode *getPeerNode(TopologyVector &tv);
	/// @brief Randomly select a node of the current topology -- exception: the additionally given node must not be selected
	TopologyNode *getPeerNode(TopologyNode *except, TopologyVector &tv);
	/// @brief Randomly select a node of the current topology -- exceptions: the two additionally given nodes must not be selected
	TopologyNode *getPeerNode(TopologyNode *except1, TopologyNode *except2, TopologyVector &tv);

	/// @brief Renews node probabilities necessary for randomly selecting a node index
	void refreshNodesProbability(TopologyVector &tv);

	/// @brief Randomly select a node index of the existing nodes
	int getNodeIndex(double random, TopologyVector &tv);

	/// @brief Classify AS nodes into stub and transit AS nodes in a way that all stub nodes are reachable via transit nodes
	void setASTypes(TopologyVector &tv, int transitEdgeThresh);

	/// @brief Opens the file with given file name and associates it with the class' generic output stream
	ofstream &openFile(const char* fileName);
#ifdef STATISTICS
	// calcuation of the three powerlaw values for comparison with real topologies
	/// @brief Calculates first power law value and writes according values to output file
	void calcPL1(TopologyVector &tv, string filename);
	/// @brief Calculates second power law value and writes according values to output file
	void calcPL2(TopologyVector &tv, string filename);
	/// @brief Calculates third power law value and writes according values to output file
	void calcPL3(TopologyVector &tv, string filename);
#endif
};

}//End Namespace

#endif /*TGM_H_*/
