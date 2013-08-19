/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package rease;

import java.beans.PropertyChangeListener;
import java.beans.PropertyChangeSupport;

/*
 * Format of parameter file: 
 * 
 * <AS-Level>
    <Transit-Node-Thresh><0>
	<AS-Nodes><0>
	<Parameter-P><0.00>
	<Parameter-Delta><0.00>
<Router-Level>
	<R-Node-Max><0>
	<R-Node-Min><0>
	<Core-Ratio><0>
	<Core-Cross-Link-Ratio><0>
	<Hosts-Per-Edge-Max><0>
	<Hosts-Per-Edge-Min><0>
<Misc>
	<Topology-File><topology.ned>
	<Stats-Prefix><powerlaws>
 * */
import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.PrintStream;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * This class manages the parameters for creation of a realistic topology
 * 
 * @author  Pascal Zschumme, Thomas Gamer
 * @version 1.0-developer version
 */

public class TopologyParameters
{
	
    /**
     * Constructor
     */
    public TopologyParameters()
    {
        asLevelEnabled = false;
        transitNodeThresh = 0;
        asNodes = 0;
        parameterP = 0.0f;
        parameterDelta = 0.0f;
        
        routerLevelEnabled = false;
        maxRouterNode = 0;
        minRouterNode = 0;
        coreRatio = 0.0f;
        coreCrossLinkRatio = 0.0f;
        maxHostsPerEdge = 0;
        minHostsPerEdge = 0;
        
        topologyFile = new String();
        statsPrefixEnabled = false;
        statsPrefix = new String();
        OverSim = false;
    }
    
    // state variables for possible parameters
    // AS-level generation
    private boolean asLevelEnabled;
    private int transitNodeThresh;
    private int asNodes;
    private float parameterP;
    private float parameterDelta;
    
    // router-level generation
    private boolean routerLevelEnabled;
    private int maxRouterNode;
    private int minRouterNode;
    private float coreRatio;
    private float coreCrossLinkRatio;
    private int maxHostsPerEdge;
    private int minHostsPerEdge;
    
    // general parameters
    private String topologyFile;
    private boolean statsPrefixEnabled;
    private String statsPrefix;
    private boolean OverSim;
    
    /**
     * Parameters configured by the GUI are written to parameter file
     * 
     * @param fileStream Output stream for parameter file
     * @param parameters Set of parameters to be written into parameter file
     * @throws Exception
     */
    public static void saveTopologyParameters(FileOutputStream fileStream, TopologyParameters parameters)
        throws Exception
    {
        	PrintStream stream = new PrintStream(fileStream);
        
            if (parameters.isAsLevelEnabled())
            {
                stream.println("<AS-Level>");
                stream.println("\t<Transit-Node-Thresh><" + parameters.getTransitNodeThresh() + ">");
                stream.println("\t<AS-Nodes><" + parameters.getAsNodes() + ">");
                stream.println("\t<Parameter-P><" + parameters.getParameterP() + ">");
                stream.println("\t<Parameter-Delta><" + parameters.getParameterDelta() + ">");
            }

            if (parameters.isRouterLevelEnabled())
            {
                stream.println("<Router-Level>");
                stream.println("\t<R-Node-Max><" + parameters.getMaxRouterNode() + ">");
                stream.println("\t<R-Node-Min><" + parameters.getMinRouterNode() + ">");
                stream.println("\t<Core-Ratio><" + parameters.getCoreRatio() + ">");
                stream.println("\t<Core-Cross-Link-Ratio><" + parameters.getCoreCrossLinkRatio() + ">");
                stream.println("\t<Hosts-Per-Edge-Max><" + parameters.getMaxHostsPerEdge() + ">");
                stream.println("\t<Hosts-Per-Edge-Min><" + parameters.getMinHostsPerEdge() + ">");
            }


            stream.println("<Misc>");
            stream.println("\t<Topology-File><" + parameters.getTopologyFile() + ">");
            if(parameters.isStatsPrefixEnabled())
                stream.println("\t<Stats-Prefix><" + parameters.getStatsPrefix() + ">");
            if(parameters.isOverSim())
                stream.println("\t<OverSim><1>");
            else
                stream.println("\t<OverSim><0>");
        
        stream.close();
    }
    
    /**
     * Parameters for topology creation are read from user-given parameter file
     * 
     * @param source Parameter file given by user
     * @return Set of parameters read from user-given file
     * @throws Exception Thrown if unknown category or name/value pair is read
     */
    public static TopologyParameters loadTopologyParameters(FileReader source)
            throws Exception
    {
        BufferedReader reader = new BufferedReader(source);

        TopologyParameters parameters = new TopologyParameters();

        // save category: AS-Level, Router-Level, or Misc
        String category = null;
        String line = null;

        for (int i = 0; (line = reader.readLine()) != null; i++)
        {
            line = line.trim();

            if (line.length() == 0)
            {
                continue;
            }

            if (line.startsWith("#"))
            {
                continue;
            }

            // search for opening bracket of tag
            Pattern tag = Pattern.compile("<[^<]*>");
            Matcher tagMatcher = tag.matcher(line);


            if (tagMatcher.find())
            {
                String tag1 = tagMatcher.group(0);
                // if just one tag is found: category description
                // if two tags are found: name/value pair
                if (tagMatcher.find(tagMatcher.end()))
                {

                    String tag2 = tagMatcher.group(0);
                    // read tag name
                    String value = tag2.substring(1, tag2.length() - 1);
                    if (category.equals("<AS-Level>"))
                    {
                        if (tag1.equals("<AS-Nodes>"))
                        {
                            parameters.setAsNodes(Integer.parseInt(value));
                        } else if (tag1.equals("<Transit-Node-Thresh>"))
                        {
                            parameters.setTransitNodeThresh(Integer.parseInt(value));
                        } else if (tag1.equals("<Parameter-P>"))
                        {
                            parameters.setParameterP(Float.parseFloat(value));
                        } else if (tag1.equals("<Parameter-Delta>"))
                        {
                            parameters.setParameterDelta(Float.parseFloat(value));
                        }
                    } else if (category.equals("<Router-Level>"))
                    {
                        if (tag1.equals("<R-Node-Max>"))
                        {
                            parameters.setMaxRouterNode(Integer.parseInt(value));
                        } else if (tag1.equals("<R-Node-Min>"))
                        {
                            parameters.setMinRouterNode(Integer.parseInt(value));
                        } else if (tag1.equals("<Core-Ratio>"))
                        {
                            parameters.setCoreRatio(Float.parseFloat(value));
                        } else if (tag1.equals("<Core-Cross-Link-Ratio>"))
                        {
                            parameters.setCoreCrossLinkRatio(Float.parseFloat(value));
                        } else if (tag1.equals("<Hosts-Per-Edge-Max>"))
                        {
                            parameters.setMaxHostsPerEdge(Integer.parseInt(value));
                        } else if (tag1.equals("<Hosts-Per-Edge-Min>"))
                        {
                            parameters.setMinHostsPerEdge(Integer.parseInt(value));
                        }
                    } else if (category.equals("<Misc>"))
                    {
                        if (tag1.equals("<Topology-File>"))
                        {
                            parameters.setTopologyFile(value);
                        } else if (tag1.equals("<Stats-Prefix>"))
                        {
                            parameters.setStatsPrefixEnabled(true);
                            parameters.setStatsPrefix(value);
                        }else if (tag1.equals("<OverSim>"))
                        {
                            if(Integer.parseInt(value) == 1)
                                parameters.setOverSim(true);
                            else
                                parameters.setOverSim(false);
                        }
                    } else
                    {
                        throw new Exception("Invalid category " + category + " at line " + i);
                    }
                    continue;
                } else {
            		category = tag1;

            		if(tag1.equals("<AS-Level>"))
                	{
                		parameters.setAsLevelEnabled(true);
                	}
                	else if (tag1.equals("<Router-Level>"))
                	{
                		parameters.setRouterLevelEnabled(true);
                	}
                	else if (!tag1.equals("<Misc>"))
                	{
                		throw new Exception("Invalid category " + tag1 + " at line " + i);
                	}
                }                	
            } else
            {
                throw new Exception("Invalid syntax at line " + i);
            }
        }
        return parameters;
    }
    
    /**
     * Static method for creation of default parameter values for the GUI
     * 
     * @return Set of default parameters
     */
    public static TopologyParameters createDefaultTopologyParameters()
    {
        TopologyParameters parameters = new TopologyParameters();
        
        parameters.setAsLevelEnabled(true);
        parameters.setAsNodes(10);
        parameters.setTransitNodeThresh(20);
        parameters.setParameterP(0.4f);
        parameters.setParameterDelta(0.04f);

        parameters.setRouterLevelEnabled(true);
        parameters.setMinRouterNode(5);
        parameters.setMaxRouterNode(20);
        parameters.setCoreRatio(5);
        parameters.setCoreCrossLinkRatio(20);
        parameters.setMinHostsPerEdge(5);
        parameters.setMaxHostsPerEdge(10);
        parameters.setTopologyFile("topology.ned");
        
        parameters.setStatsPrefixEnabled(false);
        parameters.setStatsPrefix("powerlaws");
        parameters.setOverSim(false);
        
        return parameters;
    
    }
    
    private PropertyChangeSupport changeSupport = new PropertyChangeSupport(this);
    
    /**
     * Add property change listener for this class
     * 
     * @param listener Property change listener
     */
    public void addPropertyChangeListener(PropertyChangeListener listener)
    {
        changeSupport.addPropertyChangeListener(listener);
    }
    
    /**
     * Remove property change listener for this class
     * 
     * @param listener Property change listener
     */
    public void removePropertyChangeListener(PropertyChangeListener listener)
    {
        changeSupport.removePropertyChangeListener(listener);
    }

    /**
     * Get method for asLevelEnabled
     * 
     * @return True if AS-Level topology should be created
     */
    public boolean isAsLevelEnabled()
    {
        return asLevelEnabled;
    }

    /**
     * Set method for asLevelEnabled
     * 
     * @param asLevelEnabled Set this value to true if AS-Level topology should be created
     */
    public void setAsLevelEnabled(boolean asLevelEnabled)
    {
        boolean old = this.asLevelEnabled;
        this.asLevelEnabled = asLevelEnabled;
        changeSupport.firePropertyChange("asLevelEnabled", old, asLevelEnabled);
    }

    /**
     * Get method for transitNodeThresh
     * 
     * @return Nodes with connection degree greater than returned value are 
     *         declared as core nodes independent of algorithm result
     */
    public int getTransitNodeThresh()
    {
        return transitNodeThresh;
    }

    /**
     * Set method for transitNodeThresh
     * 
     * @param transitNodeThresh Nodes with connection degree greater than returned value are 
     *                          declared as core nodes independent of algorithm result
     */
    public void setTransitNodeThresh(int transitNodeThresh)
    {
        int old = this.transitNodeThresh;
        this.transitNodeThresh = transitNodeThresh;
        changeSupport.firePropertyChange("transitNodeThresh", old, transitNodeThresh);
    }

    /**
     * Get method for asNodes
     * 
     * @return Returns number of nodes that should build the AS-Level topology
     */
    public int getAsNodes()
    {
        return asNodes;
    }

    /**
     * Set method for asNodes
     * 
     * @param asNodes Number of nodes that should build the AS-Level topology
     */
    public void setAsNodes(int asNodes)
    {
        int old = this.asNodes;
        this.asNodes = asNodes;
        changeSupport.firePropertyChange("asNodes", old, asNodes);
    }

    /**
     * Get method for coreCrossLinkRatio
     * 
     * @return Returns percentual fraction of outgoing core node connections that
     *         must be connected with another core node
     */
    public float getCoreCrossLinkRatio()
    {
        return coreCrossLinkRatio;
    }

    /**
     * Set method for coreCrossLinkRatio
     * 
     * @param coreCrossLinkRatio Percentual fraction of outgoing core node connections that
     *         must be connected with another core node
     */
    public void setCoreCrossLinkRatio(float coreCrossLinkRatio)
    {
        float old = this.coreCrossLinkRatio;
        this.coreCrossLinkRatio = coreCrossLinkRatio;
        changeSupport.firePropertyChange("coreCrossLinkRatio", old, coreCrossLinkRatio);
    }

    /**
     * Get method for coreRatio
     * 
     * @return Returns percentual fraction of core nodes in regard to total number of nodes
     */
    public float getCoreRatio()
    {
        return coreRatio;
    }

    /**
     * Set method for coreRatio
     * 
     * @param coreRatio Percentual fraction of core nodes in regard to total number of nodes
     */
    public void setCoreRatio(float coreRatio)
    {
        float old = this.coreRatio;
        this.coreRatio = coreRatio;
        changeSupport.firePropertyChange("coreRatio", old, coreRatio);
    }

    /**
     * Get method for maxRouterNode
     * 
     * @return Return maximum number of nodes for router topologies
     */
    public int getMaxRouterNode()
    {
        return maxRouterNode;
    }

    /**
     * Set method for maxRouterNode
     * 
     * @param maxRouterNode Maximum number of nodes for router topologies
     */
    public void setMaxRouterNode(int maxRouterNode)
    {
        int old = this.maxRouterNode;
        this.maxRouterNode = maxRouterNode;
        changeSupport.firePropertyChange("maxRouterNode", old, maxRouterNode);
    }

    /**
     * Get method for minRouterNode
     * 
     * @return Returns minimum number of nodes for router topologies
     */
    public int getMinRouterNode()
    {
        return minRouterNode;
    }

    /**
     * Set method for minRouterNode
     * 
     * @param minRouterNode Minimum number of nodes for router topologies
     */
    public void setMinRouterNode(int minRouterNode)
    {
        int old = this.minRouterNode;
        this.minRouterNode = minRouterNode;
        changeSupport.firePropertyChange("minRouterNode", old, minRouterNode);
    }

    /**
     * Get method for parameterDelta
     * 
     * @return Returns delta value of AS-Level creation algorithm
     */
    public float getParameterDelta()
    {
        return parameterDelta;
    }

    /**
     * Set method for parameterDelta
     * 
     * @param parameterDelta Delta value of AS-Level creation algorithm
     */
    public void setParameterDelta(float parameterDelta)
    {
        float old = this.parameterDelta;
        this.parameterDelta = parameterDelta;
        changeSupport.firePropertyChange("parameterDelta", old, parameterDelta);
    }

    /**
     * Get method for parameterP
     * 
     * @return Returns P value of AS-Level creation algorithm
     */
    public float getParameterP()
    {
        return parameterP;
    }

    /**
     * Set method for parameterP
     * 
     * @param parameterP P value of AS-Level creation algorithm
     */
    public void setParameterP(float parameterP)
    {
        float old = this.parameterP;
        this.parameterP = parameterP;
        changeSupport.firePropertyChange("parameterP", old, parameterP);
    }

    /**
     * Get method for routerLevelEnabled
     * 
     * @return Returns true if router-Level topology should be created
     */
    public boolean isRouterLevelEnabled()
    {
        return routerLevelEnabled;
    }

    /**
     * Set method for routerLevelEnabled
     * 
     * @param routerLevelEnabled Set this value to true if router-Level topology should be created
     */
    public void setRouterLevelEnabled(boolean routerLevelEnabled)
    {
        boolean old = this.routerLevelEnabled;
        this.routerLevelEnabled = routerLevelEnabled;
        changeSupport.firePropertyChange("routerLevelEnabled", old, routerLevelEnabled);
    }

    /**
     * Get method for maxHostsPerEdge
     * 
     * @return Returns maximum number of hosts that can be connected to edge nodes
     */
    public int getMaxHostsPerEdge()
    {
        return maxHostsPerEdge;
    }

    /**
     * Set method for maxHostsPerEdge
     * 
     * @param maxHostsPerEdge Maximum number of hosts that can be connected to edge nodes
     */
    public void setMaxHostsPerEdge(int maxHostsPerEdge)
    {
        int old = this.maxHostsPerEdge;
        this.maxHostsPerEdge = maxHostsPerEdge;
        changeSupport.firePropertyChange("maxHostsPerEdge", old, maxHostsPerEdge);
    }

    /**
     * Get method for minHostsPerEdge
     * 
     * @return Returns minimum number of hosts that can be connected to edge nodes
     */
    public int getMinHostsPerEdge()
    {
        return minHostsPerEdge;
    }

    /**
     * Set method for minHostsPerEdge
     * 
     * @param minHostsPerEdge Minimum number of hosts that can be connected to edge nodes
     */
    public void setMinHostsPerEdge(int minHostsPerEdge)
    {
        int old = this.minHostsPerEdge;
        this.minHostsPerEdge = minHostsPerEdge;
        changeSupport.firePropertyChange("minHostsPerEdge", old, minHostsPerEdge);
    }
    
    /**
     * Get method for statsPrefix
     * 
     * @return Returns prefix for file which contains calculated powerlaw values
     *         3 different powerlaw values exist and are stored in different files
     */
    public String getStatsPrefix()
    {
        return statsPrefix;
    }

    /**
     * Set method for statsPrefix
     * 
     * @param statsPrefix Prefix for file which contains calculated powerlaw values
     */
    public void setStatsPrefix(String statsPrefix)
    {
        String old = this.statsPrefix;
        this.statsPrefix = statsPrefix;
        changeSupport.firePropertyChange("statsPrefix", old, statsPrefix);
    }

    /**
     * Get method for statsPrefixEnabled
     * 
     * @return Returns true if powerlaw values should be calculated
     */
    public boolean isStatsPrefixEnabled()
    {
        return statsPrefixEnabled;
    }

    /**
     * Set method for statsPrefixEnabled
     * 
     * @param statsPrefixEnabled Set to true if powerlaw values should be calculated
     */
    public void setStatsPrefixEnabled(boolean statsPrefixEnabled)
    {
        boolean old = this.statsPrefixEnabled;
        this.statsPrefixEnabled = statsPrefixEnabled;
        changeSupport.firePropertyChange("statsPrefixEnabled", old, statsPrefixEnabled);
    }

        public boolean isOverSim() {
        return OverSim;
    }

    public void setOverSim(boolean OverSim) {
        this.OverSim = OverSim;
    }

    /**
     * Get method for topologyFile
     * 
     * @return Returns file name of NED topology file that is created based on current parameters
     */
    public String getTopologyFile()
    {
        return topologyFile;
    }

    /**
     * Set method for topologyFile
     * 
     * @param topologyFile File name of NED topology file that is created based on current parameters
     */
    public void setTopologyFile(String topologyFile)
    {
        String old = this.topologyFile;
        this.topologyFile = topologyFile;
        changeSupport.firePropertyChange("topologyFile", old, topologyFile);
    }
}
