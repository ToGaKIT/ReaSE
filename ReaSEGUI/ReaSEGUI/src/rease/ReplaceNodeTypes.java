/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package rease;

import java.beans.PropertyChangeListener;
import java.beans.PropertyChangeSupport;

/**
 * This class manages the parameters for replacement of single node types within
 * a NED topology file by another node type
 *
 * @author  Pascal Zschumme, Thomas Gamer
 */

public class ReplaceNodeTypes {

	
    /**
     * Constructor 
     */
    public ReplaceNodeTypes()
    {
        DDoSZombieEnabled = false;
        InetUserHost2DDoSZombie = 0;
        
        WormHostEnabled = false;
        InetUserHost2WormHost = 0;
        
        DistackIDSEnabled = false;
        Router2DistackIDS = 0;
        
        UserConfReplacementEnabled = false;
        UserConf2UserConf = 0;
        UserConfFrom = "Insert node type here";
        UserConfTo = "Insert node type here";
    }
    
    // state variables for possible replacements
    // InetUserHost replaced by DDoSZombie
    private boolean DDoSZombieEnabled;
    private int InetUserHost2DDoSZombie;
    
    // InetUserHost replaced by WormHost
    private boolean WormHostEnabled;
    private int InetUserHost2WormHost;

    // Router replaced by distackIDS
    private boolean DistackIDSEnabled;
    private int Router2DistackIDS;
    
    // User-configured replacement
    private boolean UserConfReplacementEnabled;
    private int UserConf2UserConf;
    private String UserConfFrom;
    private String UserConfTo;

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
     * Get method for DDoSZombieEnabled
     * 
     * @return Returns true if replacement by DDoSZombies will be done
     */
    public boolean isDDoSZombieEnabled() {
        return DDoSZombieEnabled;
    }

    /**
     * Set method for DDoSZombieEnabled
     * 
     * @param DDoSZombieEnabled Set to true if replacement by DDoSZombies should be done
     */
    public void setDDoSZombieEnabled(boolean DDoSZombieEnabled) {
        if(DDoSZombieEnabled != this.DDoSZombieEnabled) {
            boolean old = this.DDoSZombieEnabled;
            this.DDoSZombieEnabled = DDoSZombieEnabled;
            changeSupport.firePropertyChange("DDoSZombieEnabled", old, DDoSZombieEnabled);
        }
    }

    /**
     * Get method for InetUserHost2DDoSZombie
     * 
     * @return Returns fraction of InetUserHosts to be replaced by DDoSZombies
     */
    public int getInetUserHost2DDoSZombie() {
        return InetUserHost2DDoSZombie;
    }

    /**
     * Set method for InetUserHost2DDoSZombie
     * 
     * @param InetUserHost2DDoSZombie Fraction of InetUserHosts to be replaced by DDoSZombies
     */
    public void setInetUserHost2DDoSZombie(int InetUserHost2DDoSZombie) {
        int old = this.InetUserHost2DDoSZombie;
        this.InetUserHost2DDoSZombie = InetUserHost2DDoSZombie;
        changeSupport.firePropertyChange("InetUserHost2DDoSZombie", old, InetUserHost2DDoSZombie);
    }

    /**
     * Get method for WormHostEnabled
     * 
     * @return Returns true if replacement by WormHosts will be done
     */
    public boolean isWormHostEnabled() {
        return WormHostEnabled;
    }

    /**
     * Set method for WormHostEnabled
     * 
     * @param WormHostEnabled Set to true if replacement by WormHosts will be done
     */
    public void setWormHostEnabled(boolean WormHostEnabled) {
        if(WormHostEnabled != this.WormHostEnabled) {
            boolean old = this.WormHostEnabled;
            this.WormHostEnabled = WormHostEnabled;
            changeSupport.firePropertyChange("WormHostEnabled", old, WormHostEnabled);
        }
    }

    /**
     * Get method for InetUserHost2WormHost
     * 
     * @return Returns fraction of InetUserHosts to be replaced by WormHosts
     */
    public int getInetUserHost2WormHost() {
        return InetUserHost2WormHost;
    }

    /**
     * Set method for InetUserHost2WormHost
     * 
     * @param InetUserHost2WormHost Fraction of InetUserHosts to be replaced by WormHosts
     */
    public void setInetUserHost2WormHost(int InetUserHost2WormHost) {
        int old = this.InetUserHost2WormHost;
        this.InetUserHost2WormHost = InetUserHost2WormHost;
        changeSupport.firePropertyChange("InetUserHost2WormHost", old, InetUserHost2WormHost);
    }

    /**
     * Get method for DistackIDSEnabled
     * 
     * @return Returns true if replacement by distackIDS will be done
     */
    public boolean isDistackIDSEnabled() {
        return DistackIDSEnabled;
    }

    /**
     * Set method for DistackIDSEnabled
     * 
     * @param DistackIDSEnabled Set to true if replacement by distackIDS will be done
     */
    public void setDistackIDSEnabled(boolean DistackIDSEnabled) {
        if(DistackIDSEnabled != this.DistackIDSEnabled) {
            boolean old = this.DistackIDSEnabled;
            this.DistackIDSEnabled = DistackIDSEnabled;
            changeSupport.firePropertyChange("DistackIDSEnabled", old, DistackIDSEnabled);
        }
    }

    /**
     * Get method for Router2DistackIDS
     * 
     * @return Returns fraction of Routers to be replaced by distackIDS
     */
    public int getRouter2DistackIDS() {
        return Router2DistackIDS;
    }

    /**
     * Set method for Router2DistackIDS
     * 
     * @param Router2DistackIDS Fraction of Routers to be replaced by distackIDS
     */
    public void setRouter2DistackIDS(int Router2DistackIDS) {
        int old = this.Router2DistackIDS;
        this.Router2DistackIDS = Router2DistackIDS;
        changeSupport.firePropertyChange("Router2DistackIDS", old, Router2DistackIDS);        
    }
    
    /**
     * Get method for UserConfReplacementEnabled
     * 
     * @return Returns true if replacement by user-given node types will be done
     */
    public boolean isUserConfEnabled() {
        return UserConfReplacementEnabled;
    }

    /**
     * Set method for UserConfReplacementEnabled
     * 
     * @param UserConfReplacementEnabled Set to true if replacement by user-given node types will be done
     */
    public void setUserConfEnabled(boolean UserConfReplacementEnabled) {
        if(UserConfReplacementEnabled != this.UserConfReplacementEnabled) {
            boolean old = this.UserConfReplacementEnabled;
            this.UserConfReplacementEnabled = UserConfReplacementEnabled;
            changeSupport.firePropertyChange("UserConfReplacementEnabled", old, UserConfReplacementEnabled);
        }
    }

    /**
     * Get method for UserConf2UserConf
     * 
     * @return Returns fraction of user-given node type to be replaced by user-given node type
     */
    public int getUserConf2UserConf() {
        return UserConf2UserConf;
    }

    /**
     * Set method for UserConf2UserConf
     * 
     * @param UserConf2UserConf Fraction of user-given node type to be replaced by user-given node type
     */
    public void setUserConf2UserConf(int UserConf2UserConf) {
        int old = this.UserConf2UserConf;
        this.UserConf2UserConf = UserConf2UserConf;
        changeSupport.firePropertyChange("UserConf2UserConf", old, UserConf2UserConf);        
    }

    /**
     * Get method for UserConfFrom
     * 
     * @return Returns user-given node type that should be replaced
     */
    public String getUserConfFrom() {
        return UserConfFrom;
    }

    /**
     * Set method for UserConfFrom
     * 
     * @param UserConfFrom User-given node type that should be replaced
     */
    public void setUserConfFrom(String UserConfFrom) {
        String old = this.UserConfFrom;
        this.UserConfFrom = UserConfFrom;
        changeSupport.firePropertyChange("UserConfFrom", old, UserConfFrom);        
    }
    
    /**
     * Get method for UserConfTo
     * 
     * @return Returns user-given node type that should be additionally included
     */
    public String getUserConfTo() {
        return UserConfTo;
    }

    /**
     * Set method for UserConfTo
     * 
     * @param UserConfTo User-given node type that should be additionally included
     */
    public void setUserConfTo(String UserConfTo) {
        String old = this.UserConfTo;
        this.UserConfTo = UserConfTo;
        changeSupport.firePropertyChange("UserConfTo", old, UserConfTo);        
    }
}
