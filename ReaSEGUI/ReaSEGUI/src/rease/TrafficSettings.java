/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package rease;

import java.beans.*;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.PrintStream;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * This class manages the traffic profiles used within an OMNeT++ simulation
 * in order create realistic background traffic
 *
 * @author  Pascal Zschumme, Thomas Gamer
 * @version 1.0-developer version
 */

public class TrafficSettings
{
	
    /**
     * Constructor 
     */
    public TrafficSettings()
    {
        
    }

    /** state variable containing all available traffic profiles */
    private Vector<TrafficProfile> trafficProfiles = new Vector<TrafficProfile>();
    
    /**
     * Parameters configured by the GUI are written to parameter file.
     * Ratio of all profiles is normalized to 100% before being written to file.
     * 
     * @param target Output file for parameter file
     * @param settings Set of parameters to be written into parameter file
     * @throws Exception
     */
    public static void saveTrafficSettings(File target, TrafficSettings settings)
            throws Exception
    {
        FileOutputStream outputStream = new FileOutputStream(target);
        PrintStream stream = new PrintStream(outputStream);
        
        float ratioSum = 0;
        float ratio;

        for(TrafficProfile profile : settings.getProfiles())
        {
            ratioSum += profile.getRatio();
        }
            
        for(TrafficProfile profile : settings.getProfiles())
        {
            stream.println("<Profile>");
            stream.println("\t<Id><" + profile.getId() + ">");
            stream.println("\t<Label><" + profile.getLabel() + ">");
            stream.println("\t<RequestLength><" + profile.getRequestLength() + ">");
            stream.println("\t<RequestsPerSession><" + profile.getRequestsPerSession() + ">");
            stream.println("\t<ReplyLength><" + profile.getReplyLength() + ">");
            stream.println("\t<ReplyPerRequest><" + profile.getRepliesPerRequest() + ">");
            stream.println("\t<TimeBetweenRequests><" + profile.getTimeBetweenRequests() + ">");
            stream.println("\t<TimeToRespond><" + profile.getTimeToRespond() + ">");
            stream.println("\t<TimeBetweenSessions><" + profile.getTimeBetweenSessions() + ">");
            // shorten value to one digit after decimal point
            ratio = new Float(new Float(profile.getRatio() / ratioSum * 1000).intValue() / 10.0);
            stream.println("\t<Ratio><" + ratio + ">");
            stream.println("\t<WANRatio><" + profile.getWanRatio() + ">");
            if(profile.isPortEnabled())
                stream.println("\t<Port><" + profile.getPort() + ">");
            if(profile.isHoplimitEnabled())
                stream.println("\t<Hoplimit><" + profile.getHoplimit() + ">");
            stream.println("</Profile>\n\r");
        }

        stream.close();
    }
    
    /**
     * Available traffic profiles are read from user-given parameter file.
     * Ratio of all profiles is normalized to 100% after being read from file.
     * 
     * @param source Parameter file given by user
     * @return Set of parameters read from user-given file
     * @throws Exception Thrown if unknown tag or attribute is read
     */
    public static TrafficSettings loadTrafficSettings(File source)
            throws Exception
    {
            BufferedReader reader = new BufferedReader(new FileReader(source));
            
            TrafficSettings settings = new TrafficSettings();
            TrafficProfile profile = null;
            
            float ratioSum = 0;
            float ratio;
            
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

                Pattern tag = Pattern.compile("<[^<]*>");
                Matcher tagMatcher = tag.matcher(line);
                
                if (tagMatcher.find())
                {
                    String tag1 = tagMatcher.group(0);

                    // read values of current traffic profile
                    if (tagMatcher.find(tagMatcher.end()))
                    {

                        String tag2 = tagMatcher.group(0);
                        String value = tag2.substring(1, tag2.length() - 1);
                        
                        if (profile == null)
                            throw new Exception("Invalid syntax. Missing <Profile> tag before " + tag1 + " at line " + i + ".");

                        if (tag1.equals("<Id>"))
                            profile.setId(Integer.parseInt(value));
                        else if(tag1.equals("<Label>"))
                            profile.setLabel(value);
                        else if(tag1.equals("<RequestLength>"))
                            profile.setRequestLength(Integer.parseInt(value));
                        else if(tag1.equals("<RequestsPerSession>"))
                            profile.setRequestsPerSession(Integer.parseInt(value));
                        else if(tag1.equals("<ReplyLength>"))
                            profile.setReplyLength(Integer.parseInt(value));
                        else if(tag1.equals("<ReplyPerRequest>"))
                            profile.setRepliesPerRequest(Integer.parseInt(value));
                        else if(tag1.equals("<TimeBetweenRequests>"))
                            profile.setTimeBetweenRequests(Float.parseFloat(value));
                        else if(tag1.equals("<TimeToRespond>"))
                            profile.setTimeToRespond(Float.parseFloat(value));
                        else if(tag1.equals("<TimeBetweenSessions>"))
                            profile.setTimeBetweenSessions(Float.parseFloat(value));
                        else if(tag1.equals("<Ratio>")) {
                            profile.setRatio(Float.parseFloat(value));
                            ratioSum += profile.getRatio();
                        } else if(tag1.equals("<WANRatio>"))
                            profile.setWanRatio(Float.parseFloat(value));
                        else if(tag1.equals("<Port>"))
                        {
                            profile.setPortEnabled(true);
                            profile.setPort(Integer.parseInt(value));
                        }
                        else if(tag1.equals("<Hoplimit>"))
                        {
                            profile.setHoplimitEnabled(true);
                            profile.setHoplimit(Integer.parseInt(value));
                        }

                        else
                            throw new Exception("Invalid syntax. Unexpected attribute tag " + tag1 + " at line " + i + ".");
                        continue;
                    }
                    
                    // begin new profile or end current profile
                    if (tag1.equals("<Profile>"))
                    {
                        if(profile != null)
                            throw new Exception("Invalid syntax. Missing endtag before " + tag1 + " at line " + i + ".");
                        profile = new TrafficProfile();
                    }
                    else if(tag1.equals("</Profile>"))
                    {
                        if(profile == null)
                            throw new Exception("Invalid syntax. Unexpected endtag " + tag1 + " at line " + i + ".");
                        settings.addProfile(profile);
                        profile = null;
                    }
                    else
                        throw new Exception("Invalid syntax. Unexpected tag " + tag1 + " at line " + i + ".");
                }
                else
                    throw new Exception("Invalid syntax. No tags found at line " + i + ".");

            }        
            
            if(profile != null)
                    settings.addProfile(profile);
            
            // normalize ratio of all profiles to 100%
            for(TrafficProfile profiles : settings.getProfiles())
            {
                // shorten value to one digit after decimal point
                ratio = new Float(new Float(profiles.getRatio() / ratioSum * 1000).intValue() / 10.0);
                profiles.setRatio(ratio);
            }
            
                
            return settings;
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
     * Adds new traffic profile to current vector of available profiles
     * 
     * @param profile New traffic profile that should be added to the current profiles
     */
    public void addProfile(TrafficProfile profile)
    {
        Vector<TrafficProfile> oldProfiles = trafficProfiles;
        trafficProfiles.add(profile);
        changeSupport.firePropertyChange("profiles", oldProfiles, trafficProfiles);
    }
    
    /**
     * Deletes given traffic profile from current vector of available profiles
     * 
     * @param profile Traffic profile that should be deleted from current profiles
     */
    public void deleteProfile(TrafficProfile profile)
    {
        Vector<TrafficProfile> oldProfiles = trafficProfiles;
        trafficProfiles.remove(profile);
        changeSupport.firePropertyChange("profiles", oldProfiles, trafficProfiles);        
    }
    
    /**
     * Get method for trafficProfiles
     * 
     * @return Returns list of currently available traffic profiles
     */
    public List<TrafficProfile> getProfiles()
    {
        return trafficProfiles;
    }
}
