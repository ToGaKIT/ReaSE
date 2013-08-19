#ifndef ASNODE_H_
#define ASNODE_H_

#include "TopologyNode.h"

namespace tgm
{

/**
 * @brief This class is derived from TopologyNode and specifies the behaviour of nodes on the level of Autonomous Systems (AS).
 *
 * The Topology created by TGM is built hierarchically. On the top level the AS nodes form a topology
 * between different administrative domains. AS nodes in the core are transit AS nodes, else they are stub AS nodes.
 * On the second level, each AS contains a router-level topology. This router-level topology, in turn, 
 * is built hierarchically and consists of core, gateway, and edge nodes. 
 * The actual hosts are connected to edge nodes only.
 * 
 * ASNodes are of type STUB_AS or TRANSIT_AS.
 *
 * @version 1.0-developer version
 * @author Michael Scharf, Thomas Gamer
 *
 * @class ASNode
 */
class ASNode : public tgm::TopologyNode
{
public:
	/// @brief Constructor - assigns given node ID to topology node
	ASNode(int nodeId);
	virtual ~ASNode();

	/// @brief Sets router-level topology to given topology
	void setRouterLevelTopology(TopologyVector *tv);
	/// @brief Returns current router-level topology
	TopologyVector *getRouterLevelTopology();
	
protected:
	/** This vector contains the router-level topology of the AS (if required) */
	TopologyVector *routerLevelTopology;
};
}

#endif /*ASNODE_H_*/
