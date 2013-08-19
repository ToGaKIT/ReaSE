#include "TopologyNode.h"

namespace tgm
{
/**
 * @brief This class is the basic node class.
 *   
 * It provides methods for connecting and comparing nodes as well as getting node degree and node type.
 *
 * @version 1.0-developer version
 * @author Michael Scharf, Thomas Gamer
 *
 * @class TopologyNode
 */

/**
 * Constructor
 *
 * @param nodeID unique ID for this node
 */
TopologyNode::TopologyNode(int nodeId)
{
	myId = nodeId;
	coordX = coordY = -1;
	edgeDegree = 0;
	nodeType = 0;
}

/**
 * Destructor
 */
TopologyNode::~TopologyNode()
{
}

/**
 * Compares the node degree of two given nodes
 *
 * @param n1 First topology node to compare with
 * @param n2 Second topology node
 * @return True if node degree of n1 is greater than node degree of n2
 */
bool TopologyNode::compareNodes(TopologyNode *n1, TopologyNode *n2)
{
	return n1->edgeDegree > n2->edgeDegree;
}

/**
 * Get method for protected variable nodeType
 *
 * @return Node type of this node
 */
int TopologyNode::getNodeType()
{
	return nodeType;
}

/**
 * Set method for protected variable nodeType
 *
 * @param type Node type the node should represent
 */
void TopologyNode::setNodeType(int type)
{
	nodeType = type;
}

/**
 * Get method for protected variable edgeDegree
 *
 * @return Number of outgoing connections
 */
int TopologyNode::getNodeDegree()
{
	return edgeDegree;
}

/**
 * Get method for protected variable myID
 *
 * @return Unique ID of node
 */
int TopologyNode::getId()
{
	return myId;
}

/**
 * Get method for protected variable peers
 *
 * @return Vector of neighbor nodes
 */
TopologyVector &TopologyNode::getPeers()
{
	return peers;
}

/**
 * Establishes a bi-directional connection between two nodes
 *
 * @param peer Neighbor node a bi-directional connection is established with
 */
void TopologyNode::connectTo(TopologyNode *peer)
{
	if(!isConnected(peer))
	{
		peer->connectBackTo(this);
		connectBackTo(peer);
	}
}

/**
 * Method for requesting the peering status with a certain node
 *
 * @param peer Node for which the neighbor status is requested
 * @return True if peer is a neighbor node, i.e. a connection exists with this node
 */
bool TopologyNode::isConnected(TopologyNode *peer)
{
	for(int i = 0; i < peers.size(); i++)
		if(peers[i] == peer) return true;

	return false;
}

/**
 * Establishes a uni-directional connection between two nodes
 *
 * @param peer Neighbor node an uni-directional connection is established with
 */
void TopologyNode::connectBackTo(TopologyNode *peer)
{
	edgeDegree++;
	peers.push_back(peer);
}


}//end namespace
