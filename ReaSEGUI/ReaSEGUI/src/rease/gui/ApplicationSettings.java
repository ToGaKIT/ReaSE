/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package rease.gui;

import java.beans.PropertyChangeSupport;
import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintStream;
import java.util.StringTokenizer;

/**
 * This class manages the GUI settings like library path and paths to executables.
 * These are necessary in order to actually generate the simulation environment.
 *
 * @author Pascal Zschumme, Thomas Gamer
 * @version 1.0-developer version
*/

public class ApplicationSettings
{
    /**
     * Constructor 
     */
    public ApplicationSettings()
    {
        this.libraryPathEnabled = false;
        
    }
        
    // state variables for GUI parameters
    /** path to TGM binary (topology creation) */
    //private String tgmDefaultPath =""
    private String tgmPath;
    private boolean libraryPathEnabled;
    /** user-specified path to GNU Scientific library */
    private String libraryPath;
    /** path to setServer script (introduction of servers and special router types) */
    private String serverScriptPath;
    /** path to ReplaceNodeTypes script (introduction of DDoSZombies, UDPWormVictims, and distackIDS) */
    private String rntScriptPath;
    /** path to the last working directory, we need to initialize it with "." to avoid
     * nullPointerException in Mainform.java when no applicatioSettings.ini is present */
    private String lastWorkingDir = ".";
    
    
    private PropertyChangeSupport changeSupport = new PropertyChangeSupport(this);
    

    /**
     * Settings of GUI are written to parameter file
     * 
     * @param fileStream Output stream for settings file
     * @param settings Set of GUI parameters to be written into parameter file
     */
    public static void saveApplicationSettings(FileOutputStream fileStream, ApplicationSettings settings)
    {
        PrintStream stream = new PrintStream(fileStream);
        
        if(settings.tgmPath != null)
            stream.println("tgmPath=" + settings.tgmPath);
        
        stream.println("libraryPathEnabled=" + settings.libraryPathEnabled);
        
        if(settings.libraryPath != null)
            stream.println("libraryPath=" + settings.libraryPath);
        
        if(settings.serverScriptPath != null)
            stream.println("serverScriptPath=" + settings.serverScriptPath);
        
        if(settings.rntScriptPath != null)
            stream.println("rntScriptPath=" + settings.rntScriptPath);
        
        if(settings.lastWorkingDir != null)
            stream.println("lastWorkingDir=" + settings.lastWorkingDir);
        
        stream.close();
    }
    
    /**
     * Settings of GUI are read from given settings file
     * 
     * @param source Settings file to be read from
     * @return Set of GUI settings read from given file
     */
    public static ApplicationSettings loadApplicationSettings(FileReader source)
    {
        BufferedReader reader = new BufferedReader(source);

        ApplicationSettings settings = new ApplicationSettings();
        String line;

        try
        {
            while ((line = reader.readLine()) != null)
            {
                StringTokenizer tokenizer = new StringTokenizer(line, "=");
                String name = tokenizer.nextToken();
                if (name.equals("tgmPath"))
                    settings.setTgmPath(tokenizer.nextToken());
                else if (name.equals("libraryPathEnabled"))
                    settings.setLibraryPathEnabled(Boolean.parseBoolean(tokenizer.nextToken()));
                else if (name.equals("libraryPath"))
                    settings.setLibraryPath(tokenizer.nextToken());
                else if (name.equals("serverScriptPath"))
                    settings.setServerScriptPath(tokenizer.nextToken());
                else if (name.equals("rntScriptPath"))
                    settings.setRntScriptPath(tokenizer.nextToken());
                else if (name.equals("lastWorkingDir"))
                    settings.setLastWorkingDir(tokenizer.nextToken());
                    
            }
        } catch (IOException e)
        {

        }
        return settings;
    }
    
    /**
     * Get method for libraryPath
     * 
     * @return Returns user path to GNU Scientific Library
     */
    public String getLibraryPath()
    {
        return libraryPath;
    }

    /**
     * Set method for libraryPath
     * 
     * @param libraryPath User-specified path to GNU Scientific library. 
     *                    Only necessary if not contained in default LD_LIBRARY_PATH
     */
    public void setLibraryPath(String libraryPath)
    {
        String oldLibraryPath = this.libraryPath;
        this.libraryPath = libraryPath;
        changeSupport.firePropertyChange("libraryPath", oldLibraryPath, libraryPath);
    }

    /**
     * Get method for libraryPathEnabled
     * 
     * @return Returns true if user specified libraryPath
     */
    public boolean isLibraryPathEnabled()
    {
        return libraryPathEnabled;
    }

    /**
     * Set method for libraryPathEnabled
     * 
     * @param libraryPathEnabled Set to true if user specified libraryPath
     */
    public void setLibraryPathEnabled(boolean libraryPathEnabled)
    {
        boolean oldLibraryPathEnabled = this.libraryPathEnabled;
        this.libraryPathEnabled = libraryPathEnabled;
        changeSupport.firePropertyChange("libraryPathEnabled", oldLibraryPathEnabled, libraryPathEnabled);
    }

    /**
     * Get method for tgmPath
     * 
     * @return Returns path to topology generator (TGM) binary
     */
    public String getTgmPath()
    {
        return tgmPath;
    }

    /**
     * Set method for tgmPath
     * 
     * @param tgmPath Path to topology generator (TGM) binary
     */
    public void setTgmPath(String tgmPath)
    {
        String oldTgmPath = this.tgmPath;
        this.tgmPath = tgmPath;
        changeSupport.firePropertyChange("tgmPath", oldTgmPath, tgmPath);
    }

    /**
     * Get method for serverScriptPath
     * 
     * @return Returns path to script for adding servers and special router types (setServer.pl)
     */
    public String getServerScriptPath()
    {
        return serverScriptPath;
    }

    /**
     * Set method for serverScriptPath
     * 
     * @param serverScriptPath Path to script for adding servers and special router types (setServer.pl)
     */
    public void setServerScriptPath(String serverScriptPath)
    {
        String old = this.serverScriptPath;
        this.serverScriptPath = serverScriptPath;
        changeSupport.firePropertyChange("serverScriptPath", old, serverScriptPath);
    }

    /**
     * Get method for rntScriptPath
     * 
     * @return Returns path to script for adding DDoSZombie, UDPVictim, and distackIDS (replaceNodeType.pl)
     */
   public String getRntScriptPath()
    {
        return rntScriptPath;
    }

    /**
     * Set method for rntScriptPath
     * 
     * @param rntScriptPath Path to script for adding DDoSZombie, UDPVictim, and distackIDS (replaceNodeType.pl)
     */
    public void setRntScriptPath(String rntScriptPath)
    {
        String old = this.rntScriptPath;
        this.rntScriptPath = rntScriptPath;
        changeSupport.firePropertyChange("rntScriptPath", old, rntScriptPath);
    }
    
    /**
     * Get methode for last working dir
     * 
     * @return lastWorkingDir Path to directory of the last session
     */
    public String getLastWorkingDir()
    {
        return lastWorkingDir;
    }
    
    /**
     * Set method for lastWorkingDir
     *  
     * @param lastWorkingDir Path to the current working directory 
     */
    public void setLastWorkingDir(String lastWorkingDir)
    {
        String old = this.lastWorkingDir;
        this.lastWorkingDir = lastWorkingDir;
        changeSupport.firePropertyChange("lastWorkingDir", old, lastWorkingDir);
    }
    
}
