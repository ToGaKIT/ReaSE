/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package rease;

import java.beans.PropertyChangeListener;
import java.beans.PropertyChangeSupport;

/**
 * Container for storage of a traffic profile
 * Traffic profiles are necessary within OMNeT++ to create realistic background traffic
 * 
 * @author  Pascal Zschumme, Thomas Gamer
 * @version 1.0-developer version
 */

public class TrafficProfile
{

	/**
	 * Constructor
	 */
	public TrafficProfile()
    {
        portEnabled = false;
        hoplimitEnabled = false;
    }
    
	/**
	 * length values serve as location parameter of a pareto distribution with shape parameter 1
	 * time values serve as location parameter of a pareto distribution with shape parameter 3
	 */

	// state variables for parameters of traffic profile
	// unique ID
    private int id;
    
    private String label = new String();
    
    // parameters for client systems
    private int requestLength;
    private int requestsPerSession;
    private float timeBetweenRequests;
    private float timeBetweenSessions;
    private int hoplimit;
    private boolean hoplimitEnabled;
    private int port;
    private boolean portEnabled;

    // parameters for server systems
    private int replyLength;
    private int repliesPerRequest;
    private float timeToRespond;

    // general parameters
    private float ratio;
    private float wanRatio;
    
    
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
     * Get method for id
     * 
     * @return Returns unique ID
     */
    public int getId()
    {
        return id;
    }

    /**
     * Set method for id
     * 
     * @param id Unique ID
     */
    public void setId(int id)
    {
        int oldId = this.id;
        this.id = id;
        changeSupport.firePropertyChange("id", oldId, id);
    }

    /**
     * Get method for label
     * 
     * @return Returns label for traffic profile
     */
    public String getLabel()
    {
        return label;
    }

    /**
     * Set method for label
     * 
     * @param label Label for traffic profile
     */
    public void setLabel(String label)
    {
        String oldLabel = this.label;
        this.label = label;
        changeSupport.firePropertyChange("label", oldLabel, label);
    }

    /**
     * Get method for replyLength
     * 
     * @return Returns length of server reply messages
     */
    public int getReplyLength()
    {
        return replyLength;
    }

    /**
     * Set method for replyLength
     * 
     * @param replyLength Length of server reply messages
     */
    public void setReplyLength(int replyLength)
    {
        int oldReplyLength = this.replyLength;
        this.replyLength = replyLength;
        changeSupport.firePropertyChange("replyLength", oldReplyLength, replyLength);
    }

    /**
     * Get method for repliesPerRequest
     * 
     * @return Returns number of replies sent by server on each request
     */
    public int getRepliesPerRequest()
    {
        return repliesPerRequest;
    }

    /**
     * Set method for repliesPerRequest
     * 
     * @param repliesPerRequest Number of replies sent by server on each request
     */
    public void setRepliesPerRequest(int repliesPerRequest)
    {
        int oldRepliesPerRequest = this.repliesPerRequest;
        this.repliesPerRequest = repliesPerRequest;
        changeSupport.firePropertyChange("repliesPerRequest", oldRepliesPerRequest, repliesPerRequest);
    }   

    /**
     * Get method for requestLength
     * 
     * @return Returns length of client request messages
     */
    public int getRequestLength()
    {
        return requestLength;
    }

    /**
     * Set method for requestLength
     * 
     * @param requestLength Length of client request messages
     */
    public void setRequestLength(int requestLength)
    {
        int oldRequestLength = this.replyLength;
        this.requestLength = requestLength;
        changeSupport.firePropertyChange("requestLength", oldRequestLength, requestLength);
    }

    /**
     * Get method for requestsPerSession
     * 
     * @return Returns number of client request messages sent in a single session
     */
   public int getRequestsPerSession()
    {
        return requestsPerSession;
    }

   /**
    * Set method for requestsPerSession
    * 
    * @param requestsPerSession Number of client request messages sent in a single session
    */
   public void setRequestsPerSession(int requestsPerSession)
    {
        int oldRequestsPerSession = this.requestsPerSession;
        this.requestsPerSession = requestsPerSession;
        changeSupport.firePropertyChange("requestsPerSession", oldRequestsPerSession, requestsPerSession);
    }
    
   /**
    * Get method for ratio
    * 
    * @return Returns probability that this traffic profile is selected for the next session
    */
    public float getRatio()
    {
        return ratio;
    }

    /**
     * Set method for ratio
     * 
     * @param ratio Probability that this traffic profile is selected for the next session
     */
    public void setRatio(float ratio)
    {
        float oldRatio = this.ratio;
        this.ratio = ratio;
        changeSupport.firePropertyChange("ratio", oldRatio, ratio);
    }

    /**
     * Get method for timeBetweenRequests
     * 
     * @return Returns time a client waits between two requests
     */
    public float getTimeBetweenRequests()
    {
        return timeBetweenRequests;
    }

    /**
     * Set method for timeBetweenRequests
     * 
     * @param timeBetweenRequests Time a client waits between two requests
     */
    public void setTimeBetweenRequests(float timeBetweenRequests)
    {
        float oldTimeBetweenRequests = this.timeBetweenRequests;
        this.timeBetweenRequests = timeBetweenRequests;
        changeSupport.firePropertyChange("timeBetweenRequests", oldTimeBetweenRequests, timeBetweenRequests);
    }

    /**
     * Get method for timeBetweenSessions
     * 
     * @return Returns time a client waits between two sessions
     */
    public float getTimeBetweenSessions()
    {
        return timeBetweenSessions;
    }

    /**
     * Set method for timeBetweenSessions
     * 
     * @param timeBetweenSessions Time a client waits between two sessions
     */
    public void setTimeBetweenSessions(float timeBetweenSessions)
    {
        float oldTimeBetweenSessions = this.timeBetweenSessions;
        this.timeBetweenSessions = timeBetweenSessions;
        changeSupport.firePropertyChange("timeBetweenSessions", oldTimeBetweenSessions, timeBetweenSessions);
    }

    /**
     * Get method for timeToRespond
     * 
     * @return Returns time between reception of client request and sending of server reply
     */
    public float getTimeToRespond()
    {
        return timeToRespond;
    }

    /**
     * Set method for timeToRespond
     * 
     * @param timeToRespond Time between reception of client request and sending of server reply
     */
    public void setTimeToRespond(float timeToRespond)
    {
        float oldTimeToRespond = this.timeToRespond;
        this.timeToRespond = timeToRespond;
        changeSupport.firePropertyChange("timeToRespond", oldTimeToRespond, timeToRespond);
    }

    /**
     * Get method for wanRatio
     * 
     * @return Returns probability that communication takes place between different Autonomous Systems
     */
    public float getWanRatio()
    {
        return wanRatio;
    }

    /**
     * Set method for wanRatio
     * 
     * @param wanRatio Probability that communication takes place between different Autonomous Systems
     */
    public void setWanRatio(float wanRatio)
    {
        float oldWanRatio = this.wanRatio;
        this.wanRatio = wanRatio;
        changeSupport.firePropertyChange("wanRatio", oldWanRatio, wanRatio);
    }
    
    /**
     * Get method for hoplimit
     * 
     * @return Returns time-to-live (TTL) value for ICMP messages
     */
     public int getHoplimit()
    {
        return hoplimit;
    }

     /**
      * Set method for hoplimit
      * 
      * @param hoplimit Time-to-live (TTL) value for ICMP messages
      */
    public void setHoplimit(int hoplimit)
    {
        int oldHoplimit = this.hoplimit;
        this.hoplimit = hoplimit;
        changeSupport.firePropertyChange("hoplimit", oldHoplimit, hoplimit);
    }

    /**
     * Get method for hoplimitEnabled
     * 
     * @return Returns true if hoplimit for ICMP messages is applied
     */
    public boolean isHoplimitEnabled()
    {
        return hoplimitEnabled;
    }

    /**
     * Set method for hoplimitEnabled
     * 
     * @param hoplimitEnabled Set to true if hoplimit for ICMP messages should be applied
     */
    public void setHoplimitEnabled(boolean hoplimitEnabled)
    {
        boolean oldHoplimitEnabled = this.hoplimitEnabled;
        this.hoplimitEnabled = hoplimitEnabled;
        changeSupport.firePropertyChange("hoplimitEnabled", oldHoplimitEnabled, oldHoplimitEnabled);
     }

    /**
     * Get method for port
     * 
     * @return Returns port that is used for TCP and UDP messages
     */
    public int getPort()
    {
        return port;
    }

    /**
     * Set method for port
     * 
     * @param port Port that is used for TCP and UDP messages
     */
    public void setPort(int port)
    {
        int oldPort = this.port;
        this.port = port;
        changeSupport.firePropertyChange("port", oldPort, port);
    }

    /**
     * Get method for portEnabled
     * 
     * @return Returns true if a certain port is used for communication
     */
    public boolean isPortEnabled()
    {
        return portEnabled;
    }

    /**
     * Set method for portEnabled
     * 
     * @param portEnabled Set to true if a certain port should be used for communication
     */
    public void setPortEnabled(boolean portEnabled)
    {
        boolean oldPortEnabled = this.portEnabled;
        this.portEnabled = portEnabled;
        changeSupport.firePropertyChange("portEnabled", oldPortEnabled, portEnabled);
    }
}
