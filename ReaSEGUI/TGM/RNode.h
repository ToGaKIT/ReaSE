#ifndef RNODE_H_
#define RNODE_H_

#include "TopologyNode.h"

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
class RNode : public TopologyNode
{
private: 
	/** Number of a node's edges that are already connected to other nodes */
	int noConnections;
	/** Indicates if generation currently is in first (PFP, false) or second (HOT, true) loop */
	bool resetConn;
	
public:
	/// @brief Constructor - assigns given node ID to topology node
	RNode(int id);
	virtual ~RNode();

	/// @brief Establishes a bi-directional connection
	void connectTo(TopologyNode *node);
	/// @brief Deletes all connections between nodes of the given topology
	static void resetConnections(TopologyVector &tv);
	/// @brief Returns unused edges of a router-level node
	int unusedEdges();
	
	
};

}

#endif /*RNODE_H_*/
