#ifndef TOPOLOGYNODE_H_
#define TOPOLOGYNODE_H_

#include <vector>
#include <fstream>
#include <list>
#include <map>
#include <iostream>
#include <cstdlib>

using namespace std;

namespace tgm
{
	
/// unique hex values indicating type of a node
/// {@
const int STUB_AS = 1;
const int TRANSIT_AS = 2;
const int CORE_ROUTER = 4;
const int GW_ROUTER = 8;
const int EDGE_ROUTER = 16;
const int HOST_NODE = 32;
/// @}

class TopologyNode;

// type definitions
typedef vector<TopologyNode*> TopologyVector;
typedef list<TopologyNode*> TopologyList;
typedef map<int, TopologyNode*> TopologyMap;

/**
 * @brief This class is the basic node class
 *   
 * It provides methods for connecting and comparing nodes as well as getting node degree and node type.
 *
 * @version 1.0-developer version
 * @author Michael Scharf, Thomas Gamer
 *
 * @class TopologyNode
 */
class TopologyNode
{
private:
	// static ofstream output;
	
protected:
	/** vector of neighbor nodes, i.e. a connection exists to these nodes */
	TopologyVector peers;
	
	/** unique node ID */
	int myId;
	/** x-coordinate in two-dimensional space (currently not used) */
	int coordX;
	/** y-coordinate in two-dimensional space (currently not used) */
	int coordY;
	/** node degree, i.e. number of outgoing connections */
	int edgeDegree;
	/** node type (constants for available nodes types are defined above) */
	int nodeType;
		
	
public:
	/// @brief Constructor - assigns given node ID to topology node
	TopologyNode(int nodeId);
	virtual ~TopologyNode();

	/// @brief Returns type of topology node - must be implemented by subclasses
	virtual int getNodeType();
	/// @brief Returns number of a node's outgoing connections
	int getNodeDegree();
	/// @brief Returns unique node ID
	int getId();
	/// @brief Returns vector of neighbor nodes connected to this node
	TopologyVector &getPeers();

	/// @brief Sets node type to given type
	virtual void setNodeType(int type);

	/// @brief Compares node degree of given nodes
	static bool compareNodes(TopologyNode *n1, TopologyNode *n2);
	/// @brief Establishes a bi-directional connection
	virtual void connectTo(TopologyNode *peer);
	

protected:
	/// @brief Returns neighbor status of peer
	bool isConnected(TopologyNode *peer);
	/// @brief Establishes a uni-directional connection
	void connectBackTo(TopologyNode *peer);
};
}

#endif /*TOPOLOGYNODE_H_*/
