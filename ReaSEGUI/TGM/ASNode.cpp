#include "ASNode.h"

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

/**
 * Constructor (calls constructor of super class)
 *
 * @param Unique node ID
 */
ASNode::ASNode(int nodeId):TopologyNode(nodeId)
{
	routerLevelTopology = NULL;
}

/**
 * Destructor
 */
ASNode::~ASNode()
{
}

/**
 * Set method for routerLevelTopology
 * If already present, the current router-level topology is completely deleted. Then it is set to the given topology.
 * (There is no check, if the given topology really is a correct router-level topology.)
 * 
 * @param New router-level topology.
 */
void ASNode::setRouterLevelTopology(TopologyVector *tv)
{
	if(routerLevelTopology != NULL)
	{
		cout<<"delete existing router-level topology\n";
		for(int i = 0; i < routerLevelTopology->size(); i++)
		{
			delete (*routerLevelTopology)[i];
		}
		delete routerLevelTopology;
		routerLevelTopology = NULL;
	}
	routerLevelTopology = tv;
}

/**
 * Get method for routerLevelTopology
 *
 * @return Router-level topology of this AS. Each AS can have such a router-level topology.
           If the router-level topology is created is configured by the user in the parameter file.
 */
TopologyVector *ASNode::getRouterLevelTopology()
{
	return routerLevelTopology;
}

}
