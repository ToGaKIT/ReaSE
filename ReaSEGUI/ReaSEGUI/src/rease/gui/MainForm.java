/*
 * MainForm.java
 *
 * Created on 28. Januar 2008, 11:25
 */
package rease.gui;

import java.awt.Color;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.beans.PropertyChangeListener;
import java.beans.PropertyChangeSupport;
import javax.swing.JFileChooser;
import java.io.*;
import javax.swing.JOptionPane;
import javax.swing.filechooser.FileNameExtensionFilter;
import rease.ServerSettings;
import rease.TopologyParameters;
import rease.TrafficSettings;
import rease.ReplaceNodeTypes;

/**
 * This class actually generates the graphical user interface (GUI).
 * The GUI simplifies generation of realistic simulation environments for OMNeT++.
 * Such an environment includes hierarchical topologies, background traffic and special node types,
 * e.g. DDoSZombie that generates DDoS attacks.
 *
 * @author  Pascal Zschumme, Thomas Gamer, Bernhard Müller
 * @version 1.0-developer version
 */
public class MainForm extends javax.swing.JFrame
{

    /** Creates new form MainForm */
    public MainForm()
    {
        
        try
        {
            
            applicationSettings = ApplicationSettings.loadApplicationSettings(
                    new FileReader(getClassPath() + "applicationSettings.ini"));
        } catch (FileNotFoundException e)
        {
        }

        this.addWindowListener(new WindowAdapter()
        {

            @Override
            public void windowClosing(WindowEvent e)
            {
                try
                {
                    
                    ApplicationSettings.saveApplicationSettings(
                            new FileOutputStream(getClassPath() + "applicationSettings.ini", false), applicationSettings);
                } catch (FileNotFoundException e2)
                {
                }

                setVisible(false);
                dispose();
                System.exit(0);
            }
        });

        setTopologyParameters(TopologyParameters.createDefaultTopologyParameters());

        initComponents();
        
        //sets the script paht if they are known
        setTgmAndScriptPath();
        
        libraryPathChooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
        
        setNedFileFilters();
        
        updateFileChooserOpenDir(new File(applicationSettings.getLastWorkingDir()));
    }
    
    
    //! Application Settings
    private ApplicationSettings applicationSettings = new ApplicationSettings();
    //! Topology Parameters
    private TopologyParameters topologyParameters = new TopologyParameters();
    //! Traffic Settings
    private TrafficSettings trafficSettings = new TrafficSettings();
    //! Server Settings
    private ServerSettings serverSettings = new ServerSettings();
    //! Replace Node Type Settings
    private ReplaceNodeTypes replaceNodeTypes = new ReplaceNodeTypes();
    
    //! Monitors changes to topology parameters
    private boolean topologyHasChanged = true;
    
    //! Monitors changes to server settings
    private boolean serverSettingsChanged = true;
    //!Monitors changes to replace Node Types
    private boolean rntChanged = true;
        
    //! Path to currentl topology parameter file
    private String topologyParameterFilePath = null;
    //! Path to current traffic settings file
    private String trafficSettingsFilePath = null;
    //! Path to current server settings file
    private String serverSettingsFilePath = null;
    
    //! Path to server input topology file
    private String serverTopologyInputFilePath = null;
    //! Path to server output topology file
    private String serverTopologyOutputFilePath = null;
    
    //! Path to rnt input topology file
    private String rntTopologyInputFilePath = null;
    //! Path to rnt output topology file
    private String rntTopologyOutputFilePath = null;
    //! Path to the jar File
    private String classPath = null;
    
    
    //! Property change support object
    private PropertyChangeSupport changeSupport = new PropertyChangeSupport(this);
       
    /* File choosers */
    private JFileChooser fileChooser = new JFileChooser();
    private JFileChooser tgmPathChooser = new JFileChooser();
    private JFileChooser outputFileChooser = new JFileChooser();
    private JFileChooser libraryPathChooser = new JFileChooser();
    private JFileChooser trafficFileChooser = new JFileChooser();
    private JFileChooser serverSettingsChooser = new JFileChooser();
    private JFileChooser serverScriptChooser = new JFileChooser();
    private JFileChooser topologyInputOutputFileChooser = new JFileChooser();
    private JFileChooser rntScriptPathChooser = new JFileChooser();
    
    //! Extension filters for the fileChooser
    FileNameExtensionFilter nedFilter = new FileNameExtensionFilter("Omnet nedfile (.ned)", "ned");
   
    
    /**
     * If the TGM path and script paths are known this method sets the 
     * current directories of the corresponding filechooser to the this paths
     */
    public void setTgmAndScriptPath()
    {
        if (applicationSettings.getTgmPath() == null)
            tgmPathChooser.setCurrentDirectory(new File(applicationSettings.getLastWorkingDir()));
        else
            tgmPathChooser.setCurrentDirectory(new File(applicationSettings.getTgmPath()));
               
        if ( applicationSettings.getLibraryPath() == null )
            libraryPathChooser.setCurrentDirectory(new File(applicationSettings.getLastWorkingDir()));
        else
            libraryPathChooser.setCurrentDirectory(new File(applicationSettings.getLibraryPath()));
        
        if (applicationSettings.getRntScriptPath() == null)
            rntScriptPathChooser.setCurrentDirectory(new File(applicationSettings.getLastWorkingDir()));
        else
            rntScriptPathChooser.setCurrentDirectory(new File(applicationSettings.getRntScriptPath()));
           
        if (applicationSettings.getServerScriptPath() == null)
            serverScriptChooser.setCurrentDirectory(new File(applicationSettings.getLastWorkingDir()));
        else
            serverScriptChooser.setCurrentDirectory(new File(applicationSettings.getServerScriptPath()));
                
    }
    
    /**
     * Updates the path in which the filechooser are opened 
     * @param path the path to the current working directory
     */
    public void updateFileChooserOpenDir(File path)
    {
        fileChooser.setCurrentDirectory(path);
        outputFileChooser.setCurrentDirectory(path);
        trafficFileChooser.setCurrentDirectory(path);
        serverSettingsChooser.setCurrentDirectory(path);
        topologyInputOutputFileChooser.setCurrentDirectory(path);
        
        //and also update the lastWorkingDir in applicationSettings.ini
        try
        {   
            applicationSettings.setLastWorkingDir(path.getCanonicalPath());
        }
        catch(IOException e )
        {
        }
                
    }
    
    /*
     * Sets the nedfile Filters for the FileChooser, so that only nedfiles 
     * can be choosen aasInput and Output
     */
    public void setNedFileFilters()
    {
        outputFileChooser.setFileFilter(nedFilter);
        topologyInputOutputFileChooser.setFileFilter(nedFilter);
    }
    
     /**
     * Get the Classpath of the jar file
     * @return Path to the jar File
     */
    public String getClassPath()
    {
        
        String jarPath = System.getProperty("java.class.path");
        int j = jarPath.lastIndexOf(System.getProperty("file.separator"));
        classPath = jarPath.substring(0, j+1);
        return classPath;
    }
    
    /**
     * Generates a name for automatic name suggestion for the output files
     * when an input file is selected
     * 
     * @param path is the path containing the input file
     * @param suffix the string appended to the input file name 
     * @return  the generated name as suggestion 
     */
    public String generateNameSuggestion(String path, String suffix)
    {
        String nameSuggestion;
        int j = path.lastIndexOf(".");
        int i = path.lastIndexOf("_servers");
        if (j != -1)
        {
            if (suffix.compareTo("replaced") == 0 && i != -1)
            {
                nameSuggestion = path.substring(0,i) + "_" + suffix + ".ned";
            }
            else
            {
        	nameSuggestion = path.substring(0, j) + "_" + suffix + ".ned";
            }
        }
        else
        {
            nameSuggestion = path + "_" + suffix + ".ned";
        }   
        return nameSuggestion;
     }
    
    @Override
    public void addPropertyChangeListener(PropertyChangeListener listener)
    {
        super.addPropertyChangeListener(listener);
        changeSupport.addPropertyChangeListener(listener);
    }

    @Override
    public void removePropertyChangeListener(PropertyChangeListener listener)
    {
        super.removePropertyChangeListener(listener);
        changeSupport.removePropertyChangeListener(listener);
    }

    public ApplicationSettings getApplicationSettings()
    {
        return applicationSettings;
    }

    public void setApplicationSettings(ApplicationSettings applicationSettings)
    {
        ApplicationSettings oldApplicationSettings = this.applicationSettings;
        this.applicationSettings = applicationSettings;
        changeSupport.firePropertyChange("applicationSettings", oldApplicationSettings, applicationSettings);
    }

    public TrafficSettings getTrafficSettings()
    {
        return trafficSettings;
    }

    public void setTrafficSettings(TrafficSettings settings)
    {
        TrafficSettings oldSettings = this.trafficSettings;
        this.trafficSettings = settings;
        changeSupport.firePropertyChange("trafficSettings", oldSettings, settings);
    }

    public TopologyParameters getTopologyParameters()
    {
        return topologyParameters;
    }

    public void setTopologyParameters(TopologyParameters topologyParameters)
    {
        TopologyParameters old = this.topologyParameters;
        this.topologyParameters = topologyParameters;
        changeSupport.firePropertyChange("topologyParameters", old, topologyParameters);
    }

    public ServerSettings getServerSettings()
    {
        return serverSettings;
    }

    public void setServerSettings(ServerSettings serverSettings)
    {
        ServerSettings old = this.serverSettings;
        this.serverSettings = serverSettings;
        changeSupport.firePropertyChange("serverSettings", old, serverSettings);
    }
    
    public ReplaceNodeTypes getReplaceNodeTypes()
    {
        return replaceNodeTypes;
    }

    public void setReplaceNodeTypes(ReplaceNodeTypes replaceNodeTypes)
    {
        ReplaceNodeTypes old = this.replaceNodeTypes;
        this.replaceNodeTypes = replaceNodeTypes;
        changeSupport.firePropertyChange("replaceNodeTypes", old, replaceNodeTypes);
    }

    public String getTopologyParameterFilePath()
    {
        return topologyParameterFilePath;
    }

    public void setTopologyParameterFilePath(String topologyParameterFilePath)
    {
        String old = this.topologyParameterFilePath;
        this.topologyParameterFilePath = topologyParameterFilePath;
        changeSupport.firePropertyChange("topologyParameterFilePath", old, topologyParameterFilePath);
    }

    public String getTrafficSettingsFilePath()
    {
        return trafficSettingsFilePath;
    }

    public void setTrafficSettingsFilePath(String trafficSettingsFilePath)
    {
        String old = this.trafficSettingsFilePath;
        this.trafficSettingsFilePath = trafficSettingsFilePath;
        changeSupport.firePropertyChange("trafficSettingsFilePath", old, trafficSettingsFilePath);
    }

    public String getServerSettingsFilePath()
    {
        return serverSettingsFilePath;
    }

    public void setServerSettingsFilePath(String serverSettingsFilePath)
    {
        String old = this.serverSettingsFilePath;
        this.serverSettingsFilePath = serverSettingsFilePath;
        changeSupport.firePropertyChange("serverSettingsFilePath", old, serverSettingsFilePath);
    }

    public String getServerTopologyInputFilePath()
    {
        return serverTopologyInputFilePath;
    }

    public void setServerTopologyInputFilePath(String serverTopologyInputFilePath)
    {
        String old = this.serverTopologyInputFilePath;
        this.serverTopologyInputFilePath = serverTopologyInputFilePath;
        changeSupport.firePropertyChange("serverTopologyInputFilePath", old, serverTopologyInputFilePath);
        
        if (getServerTopologyOutputFilePath() == null ||
                generateNameSuggestion(old, "servers").compareTo(getServerTopologyOutputFilePath()) == 0)
        {
            setServerTopologyOutputFilePath(generateNameSuggestion(serverTopologyInputFilePath, "servers"));
        }
            
    }

    public String getServerTopologyOutputFilePath()
    {
        return serverTopologyOutputFilePath;
    }

    public void setServerTopologyOutputFilePath(String serverTopologyOutputFilePath)
    {
        String old = this.serverTopologyOutputFilePath;
        this.serverTopologyOutputFilePath = serverTopologyOutputFilePath;
        changeSupport.firePropertyChange("serverTopologyOutputFilePath", old, serverTopologyOutputFilePath);
        
        if (getRntTopologyInputFilePath() == null || 
                serverTopologyOutputFilePath.compareTo(getRntTopologyInputFilePath()) != 0)
        {
            setRntTopologyInputFilePath(serverTopologyOutputFilePath);
        }
    }

    public String getRntTopologyInputFilePath()
    {
        return rntTopologyInputFilePath;
    }

    public void setRntTopologyInputFilePath(String rntTopologyInputFilePath)
    {
        String old = this.rntTopologyInputFilePath;
        this.rntTopologyInputFilePath = rntTopologyInputFilePath;
        changeSupport.firePropertyChange("rntTopologyInputFilePath", old, rntTopologyInputFilePath);
        
        if (getRntTopologyOutputFilePath() == null || 
                generateNameSuggestion(old,"replaced").compareTo(getRntTopologyOutputFilePath()) == 0)
        {
            setRntTopologyOutputFilePath(generateNameSuggestion(rntTopologyInputFilePath, "replaced"));
        }
    }

    public String getRntTopologyOutputFilePath()
    {
        return rntTopologyOutputFilePath;
    }

    public void setRntTopologyOutputFilePath(String rntTopologyOutputFilePath)
    {
        String old = this.rntTopologyOutputFilePath;
        this.rntTopologyOutputFilePath = rntTopologyOutputFilePath;
        changeSupport.firePropertyChange("rntTopologyOutputFilePath", old, rntTopologyOutputFilePath);
    }

    // Tries to save current topology parameters to file
    /** \returns true if sucessfull, false if not. */
    public boolean saveTopologyParameterFile(File file)
    {
        try
        {
            TopologyParameters.saveTopologyParameters(
                    new FileOutputStream(file), topologyParameters);
        } catch (Exception e)
        {
            JOptionPane.showMessageDialog(null, "Failed to save topology parameter file:" + e.getMessage());
            return false;
        }

        setTopologyParameterFilePath(file.getPath());
        topologyHasChanged = false;
        return true;
    }

    //! Tries to load topology parameters from file
    /** @return true if sucessfull, false if not. */
    public boolean loadTopologyParameterFile(File file)
    {
        try
        {
            setTopologyParameters(
                    TopologyParameters.loadTopologyParameters(new FileReader(file)));
        } catch (Exception e)
        {
            JOptionPane.showMessageDialog(null, "Failed to load topology parameter file:" + e.getMessage());
            return false;
        }

        setTopologyParameterFilePath(file.getPath());
        topologyHasChanged = false;
        return true;
    }

    //! Tries to save current traffic settings to file
    /** \returns true if sucessfull, false if not. */
    public boolean saveTrafficSettingsFile(File file)
    {
        try
        {
            TrafficSettings.saveTrafficSettings(file, getTrafficSettings());
        } catch (Exception e)
        {
            JOptionPane.showMessageDialog(null, "Failed to save traffic settings: " + e.getMessage());
            return false;
        }

        setTrafficSettingsFilePath(file.getPath());
        return true;
    }

    //! Tries to save traffic settings from file
    /** \returns true if sucessfull, false if not. */
    public boolean loadTrafficSettingsFile(File file)
    {
        try
        {
            setTrafficSettings(TrafficSettings.loadTrafficSettings(file));
        } catch (Exception e)
        {
            JOptionPane.showMessageDialog(null, "Failed to load traffic settings: " + e.getMessage());
            return false;
        }

        setTrafficSettingsFilePath(file.getPath());
        return true;
    }

    //! Tries to save current server settings to file
    /** \returns true if sucessfull, false if not. */
    public boolean saveServerSettingsFile(File file)
    {
        try
        {
            ServerSettings.saveServerSettings(file, getServerSettings());
        } catch (Exception e)
        {
            JOptionPane.showMessageDialog(null, "Failed to save server settings: " + e.getMessage());
            return false;
        }

        setServerSettingsFilePath(file.getPath());
        serverSettingsChanged = false;
        return true;
    }

    //! Tries to save server settings from file
    /** \returns true if sucessfull, false if not. */
    public boolean loadServerSettingsFile(File file)
    {
        try
        {
            setServerSettings(ServerSettings.loadServerSettings(file));
        } catch (Exception e)
        {
            JOptionPane.showMessageDialog(null, "Failed to load server settings: " + e.getMessage());
            return false;
        }

        setServerSettingsFilePath(file.getPath());
        serverSettingsChanged = false;
        return true;
    }
    
    /** This method is called from within the constructor to
     * initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is
     * always regenerated by the Form Editor.
     */
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {
        bindingGroup = new org.jdesktop.beansbinding.BindingGroup();

        jScrollPane1 = new javax.swing.JScrollPane();
        replaceNodeTypesPane = new javax.swing.JTabbedPane();
        topologyPanel = new javax.swing.JPanel();
        asLevelPanel = new javax.swing.JPanel();
        asNodesLabel = new javax.swing.JLabel();
        asParameterPLabel = new javax.swing.JLabel();
        asParameterDeltaLabel = new javax.swing.JLabel();
        asNodes = new javax.swing.JSpinner();
        asParameterP = new javax.swing.JSpinner();
        asParameterDelta = new javax.swing.JSpinner();
        asTransitNodeThreshLabel = new javax.swing.JLabel();
        asTransitNodeThresh = new javax.swing.JSpinner();
        jLabel50 = new javax.swing.JLabel();
        jLabel60 = new javax.swing.JLabel();
        jLabel61 = new javax.swing.JLabel();
        asLevelCheckBox = new javax.swing.JCheckBox();
        routerLevelCheckBox = new javax.swing.JCheckBox();
        routerLevelPanel = new javax.swing.JPanel();
        routerNodesMaxLabel = new javax.swing.JLabel();
        routerNodesMinLabel = new javax.swing.JLabel();
        routerCoreRatioLabel = new javax.swing.JLabel();
        routerCoreCrossLinkRatioLabel = new javax.swing.JLabel();
        routerMaxHostsPerEdgeLabel = new javax.swing.JLabel();
        routerMinHostsPerEdgeLabel = new javax.swing.JLabel();
        routerMaxNodes = new javax.swing.JSpinner();
        routerCoreRatio = new javax.swing.JSpinner();
        routerCoreCrossLinkRatio = new javax.swing.JSpinner();
        routerMaxHostsPerEdge = new javax.swing.JSpinner();
        routerMinNodes = new javax.swing.JSpinner();
        routerMinHostsPerEdge = new javax.swing.JSpinner();
        jLabel48 = new javax.swing.JLabel();
        jLabel49 = new javax.swing.JLabel();
        topologyLoadButton = new javax.swing.JButton();
        topologySaveButton = new javax.swing.JButton();
        topologyRunButton = new javax.swing.JButton();
        miscPanel = new javax.swing.JPanel();
        miscOutputFileLabel = new javax.swing.JLabel();
        miscOutputFile = new javax.swing.JTextField();
        miscStatsPrefixTextField = new javax.swing.JTextField();
        miscOutputFileSelectButton = new javax.swing.JButton();
        miscStatsPrefixCheckBox = new javax.swing.JCheckBox();
        jCheckBox1 = new javax.swing.JCheckBox();
        miscLabel = new javax.swing.JLabel();
        topologySelectPathButton = new javax.swing.JButton();
        topologyDefaultButton = new javax.swing.JButton();
        topologyFileNameLabel = new javax.swing.JTextField();
        jLabel1 = new javax.swing.JLabel();
        libraryPathSelectButton = new javax.swing.JButton();
        libraryPath = new javax.swing.JTextField();
        libraryPathCheckBox = new javax.swing.JCheckBox();
        trafficProfilesPane = new javax.swing.JPanel();
        trafficProfileFileLabel = new javax.swing.JLabel();
        trafficProfileFile = new javax.swing.JTextField();
        trafficProfileLoadButton = new javax.swing.JButton();
        trafficProfileSaveButton = new javax.swing.JButton();
        trafficProfilesLabel = new javax.swing.JLabel();
        trafficProfilesScrollPane = new javax.swing.JScrollPane();
        trafficProfilesListControl = new javax.swing.JList();
        jPanel1 = new javax.swing.JPanel();
        profileIdLabel = new javax.swing.JLabel();
        profileId = new javax.swing.JSpinner();
        jLabel5 = new javax.swing.JLabel();
        ReplayLength = new javax.swing.JSpinner();
        jLabel38 = new javax.swing.JLabel();
        jLabel6 = new javax.swing.JLabel();
        RepliesPerRequest = new javax.swing.JSpinner();
        jLabel10 = new javax.swing.JLabel();
        SelectionProb = new javax.swing.JSpinner();
        jLabel11 = new javax.swing.JLabel();
        WANProb = new javax.swing.JSpinner();
        jLabel39 = new javax.swing.JLabel();
        portCheckBox = new javax.swing.JCheckBox();
        Port = new javax.swing.JSpinner();
        hoplimitCheckBox = new javax.swing.JCheckBox();
        HopLimit = new javax.swing.JSpinner();
        jLabel40 = new javax.swing.JLabel();
        jSeparator4 = new javax.swing.JSeparator();
        jLabel2 = new javax.swing.JLabel();
        Label = new javax.swing.JTextField();
        jLabel3 = new javax.swing.JLabel();
        RequestLength = new javax.swing.JSpinner();
        jLabel44 = new javax.swing.JLabel();
        jLabel4 = new javax.swing.JLabel();
        RequestsPerFlow = new javax.swing.JSpinner();
        jLabel7 = new javax.swing.JLabel();
        TimeBetweenRequests = new javax.swing.JSpinner();
        jLabel46 = new javax.swing.JLabel();
        jLabel9 = new javax.swing.JLabel();
        TimeBetweenFlows = new javax.swing.JSpinner();
        jLabel47 = new javax.swing.JLabel();
        jLabel8 = new javax.swing.JLabel();
        TimeToRespond = new javax.swing.JSpinner();
        jLabel45 = new javax.swing.JLabel();
        serverSettingsPane = new javax.swing.JPanel();
        serverSettingsLoadButton = new javax.swing.JButton();
        serverSettingsSaveButton = new javax.swing.JButton();
        jLabel12 = new javax.swing.JLabel();
        jTextField2 = new javax.swing.JTextField();
        jLabel13 = new javax.swing.JLabel();
        jPanel2 = new javax.swing.JPanel();
        jLabel14 = new javax.swing.JLabel();
        jLabel15 = new javax.swing.JLabel();
        jLabel16 = new javax.swing.JLabel();
        jLabel17 = new javax.swing.JLabel();
        jLabel18 = new javax.swing.JLabel();
        jLabel19 = new javax.swing.JLabel();
        jLabel20 = new javax.swing.JLabel();
        jLabel21 = new javax.swing.JLabel();
        jLabel22 = new javax.swing.JLabel();
        jSpinner12 = new javax.swing.JSpinner();
        jSpinner13 = new javax.swing.JSpinner();
        jSpinner14 = new javax.swing.JSpinner();
        jSpinner15 = new javax.swing.JSpinner();
        jSpinner16 = new javax.swing.JSpinner();
        jSpinner17 = new javax.swing.JSpinner();
        jSpinner18 = new javax.swing.JSpinner();
        jSpinner19 = new javax.swing.JSpinner();
        jSpinner20 = new javax.swing.JSpinner();
        jSpinner33 = new javax.swing.JSpinner();
        jSpinner34 = new javax.swing.JSpinner();
        jSpinner22 = new javax.swing.JSpinner();
        jSpinner35 = new javax.swing.JSpinner();
        jSpinner36 = new javax.swing.JSpinner();
        jSpinner37 = new javax.swing.JSpinner();
        jSpinner38 = new javax.swing.JSpinner();
        jSpinner39 = new javax.swing.JSpinner();
        jSpinner40 = new javax.swing.JSpinner();
        jLabel65 = new javax.swing.JLabel();
        jLabel66 = new javax.swing.JLabel();
        jLabel67 = new javax.swing.JLabel();
        jLabel68 = new javax.swing.JLabel();
        jLabel69 = new javax.swing.JLabel();
        jLabel70 = new javax.swing.JLabel();
        jLabel71 = new javax.swing.JLabel();
        jLabel72 = new javax.swing.JLabel();
        jLabel73 = new javax.swing.JLabel();
        jLabel74 = new javax.swing.JLabel();
        jLabel75 = new javax.swing.JLabel();
        jLabel76 = new javax.swing.JLabel();
        jLabel77 = new javax.swing.JLabel();
        jLabel78 = new javax.swing.JLabel();
        jLabel79 = new javax.swing.JLabel();
        jLabel80 = new javax.swing.JLabel();
        jLabel81 = new javax.swing.JLabel();
        jLabel82 = new javax.swing.JLabel();
        jLabel23 = new javax.swing.JLabel();
        jPanel3 = new javax.swing.JPanel();
        jLabel25 = new javax.swing.JLabel();
        jLabel26 = new javax.swing.JLabel();
        jLabel27 = new javax.swing.JLabel();
        jLabel28 = new javax.swing.JLabel();
        jLabel29 = new javax.swing.JLabel();
        jLabel30 = new javax.swing.JLabel();
        jSpinner23 = new javax.swing.JSpinner();
        jSpinner24 = new javax.swing.JSpinner();
        jSpinner25 = new javax.swing.JSpinner();
        jSpinner26 = new javax.swing.JSpinner();
        jSpinner27 = new javax.swing.JSpinner();
        jSpinner28 = new javax.swing.JSpinner();
        jLabel24 = new javax.swing.JLabel();
        jSeparator2 = new javax.swing.JSeparator();
        jTextField7 = new javax.swing.JTextField();
        jLabel51 = new javax.swing.JLabel();
        jLabel52 = new javax.swing.JLabel();
        jLabel53 = new javax.swing.JLabel();
        jLabel54 = new javax.swing.JLabel();
        jLabel55 = new javax.swing.JLabel();
        jLabel56 = new javax.swing.JLabel();
        jLabel31 = new javax.swing.JLabel();
        RouterFractionSpinner = new javax.swing.JSpinner();
        jPanel4 = new javax.swing.JPanel();
        jLabel33 = new javax.swing.JLabel();
        jSpinner29 = new javax.swing.JSpinner();
        jLabel32 = new javax.swing.JLabel();
        jSeparator3 = new javax.swing.JSeparator();
        jTextField8 = new javax.swing.JTextField();
        jLabel57 = new javax.swing.JLabel();
        serverSettingsDefaultButton = new javax.swing.JButton();
        serverSettingsRunButton = new javax.swing.JButton();
        serverSettingsSetScriptPathButton = new javax.swing.JButton();
        jLabel34 = new javax.swing.JLabel();
        jLabel35 = new javax.swing.JLabel();
        jTextField3 = new javax.swing.JTextField();
        jTextField4 = new javax.swing.JTextField();
        serverSettingsSelectTopologyInputFileButton = new javax.swing.JButton();
        serverSettingsSelectTopologyOutputFileButton = new javax.swing.JButton();
        jSeparator1 = new javax.swing.JSeparator();
        ServerFractionSpinner = new javax.swing.JSpinner();
        jLabel58 = new javax.swing.JLabel();
        jLabel59 = new javax.swing.JLabel();
        latencyCheckBox = new javax.swing.JCheckBox();
        ReplaceNodesPane = new javax.swing.JPanel();
        rntSetScriptPathButton = new javax.swing.JButton();
        rntRunButton = new javax.swing.JButton();
        jLabel36 = new javax.swing.JLabel();
        jLabel37 = new javax.swing.JLabel();
        jTextField5 = new javax.swing.JTextField();
        jTextField6 = new javax.swing.JTextField();
        rntTopologyInputFileSelectButton = new javax.swing.JButton();
        rntTopologyOutputFileSelectButton = new javax.swing.JButton();
        jPanel5 = new javax.swing.JPanel();
        rntDDoSZombieCheckBox = new javax.swing.JCheckBox();
        jSpinner30 = new javax.swing.JSpinner();
        jLabel41 = new javax.swing.JLabel();
        jPanel7 = new javax.swing.JPanel();
        rntWormHostCheckBox = new javax.swing.JCheckBox();
        jSpinner31 = new javax.swing.JSpinner();
        jLabel42 = new javax.swing.JLabel();
        jPanel8 = new javax.swing.JPanel();
        rntIDSCheckBox = new javax.swing.JCheckBox();
        jSpinner32 = new javax.swing.JSpinner();
        jLabel43 = new javax.swing.JLabel();
        jPanel6 = new javax.swing.JPanel();
        rntUserConfigCheckBox = new javax.swing.JCheckBox();
        jLabel62 = new javax.swing.JLabel();
        jSpinner21 = new javax.swing.JSpinner();
        jLabel63 = new javax.swing.JLabel();
        rntUserConfigFromTextField = new javax.swing.JTextField();
        jLabel64 = new javax.swing.JLabel();
        rntUserConfigToTextField = new javax.swing.JTextField();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        setTitle("ReaSEGUI - A frontend GUI for a generator of realistic simulation environments for OMNeT++");
        setMaximizedBounds(new java.awt.Rectangle(0, 0, 1000, 1100));

        jScrollPane1.setBorder(javax.swing.BorderFactory.createEmptyBorder(1, 1, 1, 1));
        jScrollPane1.setPreferredSize(new java.awt.Dimension(700, 800));

        replaceNodeTypesPane.setTabLayoutPolicy(javax.swing.JTabbedPane.SCROLL_TAB_LAYOUT);
        replaceNodeTypesPane.setFont(new java.awt.Font("Arial", 0, 11)); // NOI18N

        topologyPanel.setPreferredSize(new java.awt.Dimension(700, 800));

        asLevelPanel.setBorder(javax.swing.BorderFactory.createEtchedBorder());
        asLevelPanel.setPreferredSize(new java.awt.Dimension(500, 124));

        asNodesLabel.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        asNodesLabel.setText("Nodes"); // NOI18N

        org.jdesktop.beansbinding.Binding binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, asLevelCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), asNodesLabel, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        asParameterPLabel.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        asParameterPLabel.setText("Parameter P"); // NOI18N

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, asLevelCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), asParameterPLabel, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        asParameterDeltaLabel.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        asParameterDeltaLabel.setText("Parameter Delta"); // NOI18N

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, asLevelCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), asParameterDeltaLabel, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        asNodes.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        asNodes.setModel(new javax.swing.SpinnerNumberModel(Integer.valueOf(0), Integer.valueOf(0), null, Integer.valueOf(1)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${topologyParameters.asNodes}"), asNodes, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, asLevelCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), asNodes, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        asNodes.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                topologyChanged(evt);
            }
        });

        asParameterP.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        asParameterP.setModel(new javax.swing.SpinnerNumberModel(Float.valueOf(0.0f), Float.valueOf(0.0f), Float.valueOf(1.0f), Float.valueOf(0.1f)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${topologyParameters.parameterP}"), asParameterP, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, asLevelCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), asParameterP, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        asParameterP.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                topologyChanged(evt);
            }
        });

        asParameterDelta.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        asParameterDelta.setModel(new javax.swing.SpinnerNumberModel(Float.valueOf(0.0f), Float.valueOf(0.0f), Float.valueOf(1.0f), Float.valueOf(0.01f)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${topologyParameters.parameterDelta}"), asParameterDelta, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, asLevelCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), asParameterDelta, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        asParameterDelta.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                topologyChanged(evt);
            }
        });

        asTransitNodeThreshLabel.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        asTransitNodeThreshLabel.setText("Transit Node Thresh");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, asLevelCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), asTransitNodeThreshLabel, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        asTransitNodeThresh.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        asTransitNodeThresh.setModel(new javax.swing.SpinnerNumberModel(Integer.valueOf(0), Integer.valueOf(0), null, Integer.valueOf(1)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${topologyParameters.transitNodeThresh}"), asTransitNodeThresh, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, asLevelCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), asTransitNodeThresh, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        asTransitNodeThresh.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                topologyChanged(evt);
            }
        });

        jLabel50.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel50.setText("Node degree");

        jLabel60.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel60.setText("%");

        jLabel61.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel61.setText("%");

        org.jdesktop.layout.GroupLayout asLevelPanelLayout = new org.jdesktop.layout.GroupLayout(asLevelPanel);
        asLevelPanel.setLayout(asLevelPanelLayout);
        asLevelPanelLayout.setHorizontalGroup(
            asLevelPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(asLevelPanelLayout.createSequentialGroup()
                .addContainerGap()
                .add(asLevelPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(asNodesLabel)
                    .add(asTransitNodeThreshLabel)
                    .add(asParameterDeltaLabel)
                    .add(asParameterPLabel))
                .add(23, 23, 23)
                .add(asLevelPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING, false)
                    .add(asNodes, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 69, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(asTransitNodeThresh, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 69, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(asParameterP, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 69, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(asParameterDelta, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 69, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .add(3, 3, 3)
                .add(asLevelPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(jLabel50)
                    .add(asLevelPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.TRAILING, false)
                        .add(org.jdesktop.layout.GroupLayout.LEADING, jLabel60, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .add(org.jdesktop.layout.GroupLayout.LEADING, jLabel61, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                .addContainerGap(337, Short.MAX_VALUE))
        );

        asLevelPanelLayout.linkSize(new java.awt.Component[] {asNodes, asParameterDelta, asParameterP, asTransitNodeThresh}, org.jdesktop.layout.GroupLayout.HORIZONTAL);

        asLevelPanelLayout.setVerticalGroup(
            asLevelPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(asLevelPanelLayout.createSequentialGroup()
                .addContainerGap()
                .add(asLevelPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(asNodesLabel)
                    .add(asNodes, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(asLevelPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(asTransitNodeThreshLabel)
                    .add(asTransitNodeThresh, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel50))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(asLevelPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(asParameterPLabel)
                    .add(asParameterP, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel60))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                .add(asLevelPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(asParameterDeltaLabel)
                    .add(asParameterDelta, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel61))
                .addContainerGap())
        );

        asLevelPanelLayout.linkSize(new java.awt.Component[] {asNodes, asParameterDelta, asParameterP, asTransitNodeThresh}, org.jdesktop.layout.GroupLayout.VERTICAL);

        asLevelCheckBox.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        asLevelCheckBox.setText("AS-Level"); // NOI18N

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${topologyParameters.asLevelEnabled}"), asLevelCheckBox, org.jdesktop.beansbinding.BeanProperty.create("selected"));
        bindingGroup.addBinding(binding);

        asLevelCheckBox.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                topologyChanged(evt);
            }
        });

        routerLevelCheckBox.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        routerLevelCheckBox.setText("Router Level"); // NOI18N

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${topologyParameters.routerLevelEnabled}"), routerLevelCheckBox, org.jdesktop.beansbinding.BeanProperty.create("selected"));
        bindingGroup.addBinding(binding);

        routerLevelCheckBox.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                topologyChanged(evt);
            }
        });

        routerLevelPanel.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        routerNodesMaxLabel.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        routerNodesMaxLabel.setText("Max Nodes"); // NOI18N

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, routerLevelCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), routerNodesMaxLabel, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        routerNodesMinLabel.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        routerNodesMinLabel.setText("Min Nodes"); // NOI18N

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, routerLevelCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), routerNodesMinLabel, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        routerCoreRatioLabel.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        routerCoreRatioLabel.setText("Core Ratio"); // NOI18N

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, routerLevelCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), routerCoreRatioLabel, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        routerCoreCrossLinkRatioLabel.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        routerCoreCrossLinkRatioLabel.setText("Core Cross Link Ratio"); // NOI18N

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, routerLevelCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), routerCoreCrossLinkRatioLabel, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        routerMaxHostsPerEdgeLabel.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        routerMaxHostsPerEdgeLabel.setText("Max Hosts per Edge"); // NOI18N

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, routerLevelCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), routerMaxHostsPerEdgeLabel, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        routerMinHostsPerEdgeLabel.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        routerMinHostsPerEdgeLabel.setText("Min Hosts per Edge"); // NOI18N

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, routerLevelCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), routerMinHostsPerEdgeLabel, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        routerMaxNodes.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        routerMaxNodes.setModel(new javax.swing.SpinnerNumberModel(Integer.valueOf(0), Integer.valueOf(0), null, Integer.valueOf(1)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${topologyParameters.maxRouterNode}"), routerMaxNodes, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, routerLevelCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), routerMaxNodes, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        routerMaxNodes.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                topologyChanged(evt);
            }
        });

        routerCoreRatio.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        routerCoreRatio.setModel(new javax.swing.SpinnerNumberModel(Float.valueOf(0.0f), Float.valueOf(0.0f), Float.valueOf(100.0f), Float.valueOf(1.0f)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${topologyParameters.coreRatio}"), routerCoreRatio, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, routerLevelCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), routerCoreRatio, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        routerCoreRatio.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                topologyChanged(evt);
            }
        });

        routerCoreCrossLinkRatio.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        routerCoreCrossLinkRatio.setModel(new javax.swing.SpinnerNumberModel(Float.valueOf(0.0f), Float.valueOf(0.0f), Float.valueOf(100.0f), Float.valueOf(1.0f)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${topologyParameters.coreCrossLinkRatio}"), routerCoreCrossLinkRatio, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, routerLevelCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), routerCoreCrossLinkRatio, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        routerCoreCrossLinkRatio.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                topologyChanged(evt);
            }
        });

        routerMaxHostsPerEdge.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        routerMaxHostsPerEdge.setModel(new javax.swing.SpinnerNumberModel(Integer.valueOf(0), Integer.valueOf(0), null, Integer.valueOf(1)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${topologyParameters.maxHostsPerEdge}"), routerMaxHostsPerEdge, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, routerLevelCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), routerMaxHostsPerEdge, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        routerMaxHostsPerEdge.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                topologyChanged(evt);
            }
        });

        routerMinNodes.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        routerMinNodes.setModel(new javax.swing.SpinnerNumberModel(Integer.valueOf(0), Integer.valueOf(0), null, Integer.valueOf(1)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${topologyParameters.minRouterNode}"), routerMinNodes, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, routerLevelCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), routerMinNodes, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        routerMinNodes.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                topologyChanged(evt);
            }
        });

        routerMinHostsPerEdge.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        routerMinHostsPerEdge.setModel(new javax.swing.SpinnerNumberModel(Integer.valueOf(0), Integer.valueOf(0), null, Integer.valueOf(1)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${topologyParameters.minHostsPerEdge}"), routerMinHostsPerEdge, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, routerLevelCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), routerMinHostsPerEdge, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        routerMinHostsPerEdge.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                topologyChanged(evt);
            }
        });

        jLabel48.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel48.setText("%");

        jLabel49.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel49.setText("%");

        org.jdesktop.layout.GroupLayout routerLevelPanelLayout = new org.jdesktop.layout.GroupLayout(routerLevelPanel);
        routerLevelPanel.setLayout(routerLevelPanelLayout);
        routerLevelPanelLayout.setHorizontalGroup(
            routerLevelPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(routerLevelPanelLayout.createSequentialGroup()
                .addContainerGap()
                .add(routerLevelPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(routerNodesMinLabel)
                    .add(routerCoreRatioLabel)
                    .add(routerMinHostsPerEdgeLabel)
                    .add(routerCoreCrossLinkRatioLabel))
                .add(18, 18, 18)
                .add(routerLevelPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(routerMinNodes, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 71, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(routerCoreRatio, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 71, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(routerCoreCrossLinkRatio, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 71, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(routerMinHostsPerEdge, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 0, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .add(1, 1, 1)
                .add(routerLevelPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(routerLevelPanelLayout.createSequentialGroup()
                        .add(62, 62, 62)
                        .add(routerLevelPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(routerNodesMaxLabel)
                            .add(routerMaxHostsPerEdgeLabel))
                        .add(51, 51, 51)
                        .add(routerLevelPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(routerMaxNodes, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 65, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(routerMaxHostsPerEdge, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)))
                    .add(routerLevelPanelLayout.createSequentialGroup()
                        .add(3, 3, 3)
                        .add(routerLevelPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(jLabel49)
                            .add(jLabel48))))
                .addContainerGap(111, Short.MAX_VALUE))
        );

        routerLevelPanelLayout.linkSize(new java.awt.Component[] {routerCoreCrossLinkRatio, routerCoreRatio, routerMaxHostsPerEdge, routerMaxNodes, routerMinHostsPerEdge, routerMinNodes}, org.jdesktop.layout.GroupLayout.HORIZONTAL);

        routerLevelPanelLayout.setVerticalGroup(
            routerLevelPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(routerLevelPanelLayout.createSequentialGroup()
                .addContainerGap()
                .add(routerLevelPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(routerNodesMinLabel)
                    .add(routerNodesMaxLabel)
                    .add(routerMaxNodes, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(routerMinNodes, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(routerLevelPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(routerCoreRatioLabel)
                    .add(routerCoreRatio, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel48))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(routerLevelPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(routerCoreCrossLinkRatioLabel)
                    .add(routerCoreCrossLinkRatio, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel49))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(routerLevelPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(routerMinHostsPerEdgeLabel)
                    .add(routerMaxHostsPerEdgeLabel)
                    .add(routerMaxHostsPerEdge, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(routerMinHostsPerEdge, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        routerLevelPanelLayout.linkSize(new java.awt.Component[] {routerCoreCrossLinkRatio, routerCoreRatio, routerMaxHostsPerEdge, routerMaxNodes, routerMinHostsPerEdge, routerMinNodes}, org.jdesktop.layout.GroupLayout.VERTICAL);

        topologyLoadButton.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        topologyLoadButton.setText("Load"); // NOI18N
        topologyLoadButton.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                topologyChanged(evt);
            }
        });
        topologyLoadButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                topologyLoadButtonActionPerformed(evt);
            }
        });

        topologySaveButton.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        topologySaveButton.setText("Save"); // NOI18N
        topologySaveButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                topologySaveButtonActionPerformed(evt);
            }
        });

        topologyRunButton.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        topologyRunButton.setText("Run"); // NOI18N
        topologyRunButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                topologyRunButtonActionPerformed(evt);
            }
        });

        miscPanel.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        miscOutputFileLabel.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        miscOutputFileLabel.setText("Output NED File"); // NOI18N

        miscOutputFile.setFont(new java.awt.Font("Lucida Sans", 0, 11));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${topologyParameters.topologyFile}"), miscOutputFile, org.jdesktop.beansbinding.BeanProperty.create("text"));
        bindingGroup.addBinding(binding);

        miscStatsPrefixTextField.setFont(new java.awt.Font("Lucida Sans", 0, 11));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${topologyParameters.statsPrefix}"), miscStatsPrefixTextField, org.jdesktop.beansbinding.BeanProperty.create("text"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, miscStatsPrefixCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), miscStatsPrefixTextField, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        miscOutputFileSelectButton.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        miscOutputFileSelectButton.setText("Select"); // NOI18N
        miscOutputFileSelectButton.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                topologyChanged(evt);
            }
        });
        miscOutputFileSelectButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                miscOutputFileSelectButtonActionPerformed(evt);
            }
        });

        miscStatsPrefixCheckBox.setFont(new java.awt.Font("Lucida Sans", 0, 11)); // NOI18N
        miscStatsPrefixCheckBox.setText("Powerlaw File Prefix");
        miscStatsPrefixCheckBox.setToolTipText("Check this in order to let TGM calculate\nsome statistical values (Powerlaw values)\nof the generated topology. Therefore, TGM\nhas to be compiled with GNU Scientific\nLibrary (GSL) support in advance.");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${topologyParameters.statsPrefixEnabled}"), miscStatsPrefixCheckBox, org.jdesktop.beansbinding.BeanProperty.create("selected"));
        bindingGroup.addBinding(binding);

        miscStatsPrefixCheckBox.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                topologyChanged(evt);
            }
        });
        miscStatsPrefixCheckBox.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                miscStatsPrefixCheckBoxActionPerformed(evt);
            }
        });

        jCheckBox1.setFont(new java.awt.Font("Lucida Sans", 0, 11)); // NOI18N
        jCheckBox1.setText("Create topology for OverSim");
        jCheckBox1.setToolTipText("Check this in order to create a topology\nthat is usable with OMNeT++ and the \nOversim Framework.");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${topologyParameters.overSim}"), jCheckBox1, org.jdesktop.beansbinding.BeanProperty.create("selected"));
        bindingGroup.addBinding(binding);

        org.jdesktop.layout.GroupLayout miscPanelLayout = new org.jdesktop.layout.GroupLayout(miscPanel);
        miscPanel.setLayout(miscPanelLayout);
        miscPanelLayout.setHorizontalGroup(
            miscPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(miscPanelLayout.createSequentialGroup()
                .addContainerGap()
                .add(miscPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(miscPanelLayout.createSequentialGroup()
                        .add(jCheckBox1, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 315, Short.MAX_VALUE)
                        .add(84, 84, 84))
                    .add(miscPanelLayout.createSequentialGroup()
                        .add(miscPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(miscOutputFileLabel)
                            .add(miscStatsPrefixCheckBox))
                        .add(46, 46, 46)
                        .add(miscPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING, false)
                            .add(miscStatsPrefixTextField, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 130, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(miscPanelLayout.createSequentialGroup()
                                .add(miscOutputFile, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 130, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                                .add(miscOutputFileSelectButton, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 74, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)))))
                .add(223, 223, 223))
        );
        miscPanelLayout.setVerticalGroup(
            miscPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(miscPanelLayout.createSequentialGroup()
                .addContainerGap()
                .add(miscPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(miscOutputFileLabel)
                    .add(miscOutputFile, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(miscOutputFileSelectButton, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 16, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(miscPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(miscStatsPrefixTextField, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(miscStatsPrefixCheckBox))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                .add(jCheckBox1)
                .addContainerGap(16, Short.MAX_VALUE))
        );

        miscLabel.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        miscLabel.setText("Misc"); // NOI18N

        topologySelectPathButton.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        topologySelectPathButton.setText("Select TGM Path"); // NOI18N
        topologySelectPathButton.setPreferredSize(new java.awt.Dimension(160, 26));
        topologySelectPathButton.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                topologyChanged(evt);
            }
        });
        topologySelectPathButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                topologySelectPathButtonActionPerformed(evt);
            }
        });

        topologyDefaultButton.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        topologyDefaultButton.setText("Default"); // NOI18N
        topologyDefaultButton.setPreferredSize(new java.awt.Dimension(100, 26));
        topologyDefaultButton.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                topologyChanged(evt);
            }
        });
        topologyDefaultButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                topologyDefaultButtonActionPerformed(evt);
            }
        });

        topologyFileNameLabel.setEditable(false);
        topologyFileNameLabel.setFont(new java.awt.Font("Lucida Sans", 0, 11));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${topologyParameterFilePath}"), topologyFileNameLabel, org.jdesktop.beansbinding.BeanProperty.create("text"));
        bindingGroup.addBinding(binding);

        jLabel1.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel1.setText("Topology Parameter File"); // NOI18N

        libraryPathSelectButton.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        libraryPathSelectButton.setText("Select"); // NOI18N

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, libraryPathCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), libraryPathSelectButton, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        libraryPathSelectButton.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                topologyChanged(evt);
            }
        });
        libraryPathSelectButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                libraryPathSelectButtonActionPerformed(evt);
            }
        });

        libraryPath.setFont(new java.awt.Font("Lucida Sans", 0, 11));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${applicationSettings.libraryPath}"), libraryPath, org.jdesktop.beansbinding.BeanProperty.create("text"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, libraryPathCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), libraryPath, org.jdesktop.beansbinding.BeanProperty.create("editable"));
        bindingGroup.addBinding(binding);

        libraryPathCheckBox.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        libraryPathCheckBox.setText("use LD_LIBRARY_PATH"); // NOI18N

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${applicationSettings.libraryPathEnabled}"), libraryPathCheckBox, org.jdesktop.beansbinding.BeanProperty.create("selected"));
        bindingGroup.addBinding(binding);

        libraryPathCheckBox.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                topologyChanged(evt);
            }
        });

        org.jdesktop.layout.GroupLayout topologyPanelLayout = new org.jdesktop.layout.GroupLayout(topologyPanel);
        topologyPanel.setLayout(topologyPanelLayout);
        topologyPanelLayout.setHorizontalGroup(
            topologyPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(topologyPanelLayout.createSequentialGroup()
                .addContainerGap()
                .add(topologyPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(asLevelCheckBox)
                    .add(routerLevelCheckBox)
                    .add(miscLabel)
                    .add(topologyPanelLayout.createSequentialGroup()
                        .add(jLabel1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 142, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(topologyFileNameLabel, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 246, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, 58, Short.MAX_VALUE)
                        .add(topologySelectPathButton, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                        .add(topologyRunButton, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 94, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                    .add(topologyPanelLayout.createSequentialGroup()
                        .add(topologyLoadButton, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 69, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(topologySaveButton, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 69, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(topologyDefaultButton, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, 56, Short.MAX_VALUE)
                        .add(libraryPathCheckBox)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(libraryPath, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 158, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                        .add(libraryPathSelectButton, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 93, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                    .add(topologyPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.TRAILING, false)
                        .add(org.jdesktop.layout.GroupLayout.LEADING, miscPanel, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .add(org.jdesktop.layout.GroupLayout.LEADING, routerLevelPanel, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 638, Short.MAX_VALUE)
                        .add(org.jdesktop.layout.GroupLayout.LEADING, asLevelPanel, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 638, Short.MAX_VALUE)))
                .addContainerGap())
        );
        topologyPanelLayout.setVerticalGroup(
            topologyPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(topologyPanelLayout.createSequentialGroup()
                .addContainerGap()
                .add(topologyPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 16, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(topologyFileNameLabel, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(topologyRunButton)
                    .add(topologySelectPathButton, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                .add(topologyPanelLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(topologyLoadButton)
                    .add(topologySaveButton)
                    .add(topologyDefaultButton, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(libraryPathSelectButton, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 17, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(libraryPath, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(libraryPathCheckBox))
                .add(24, 24, 24)
                .add(asLevelCheckBox)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(asLevelPanel, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 140, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                .add(routerLevelCheckBox)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(routerLevelPanel, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                .add(miscLabel)
                .add(5, 5, 5)
                .add(miscPanel, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .add(291, 291, 291))
        );

        replaceNodeTypesPane.addTab("Topology", topologyPanel);

        trafficProfilesPane.setMinimumSize(new java.awt.Dimension(700, 650));
        trafficProfilesPane.setPreferredSize(new java.awt.Dimension(700, 800));

        trafficProfileFileLabel.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        trafficProfileFileLabel.setText("Traffic Profile File");

        trafficProfileFile.setEditable(false);
        trafficProfileFile.setFont(new java.awt.Font("Lucida Sans", 0, 11));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${trafficSettingsFilePath}"), trafficProfileFile, org.jdesktop.beansbinding.BeanProperty.create("text"));
        bindingGroup.addBinding(binding);

        trafficProfileLoadButton.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        trafficProfileLoadButton.setText("Load");
        trafficProfileLoadButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                trafficProfileLoadButtonActionPerformed(evt);
            }
        });

        trafficProfileSaveButton.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        trafficProfileSaveButton.setText("Save");
        trafficProfileSaveButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                trafficProfileSaveButtonActionPerformed(evt);
            }
        });

        trafficProfilesLabel.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        trafficProfilesLabel.setText("Profiles");

        trafficProfilesScrollPane.setFont(new java.awt.Font("Lucida Sans", 0, 13));

        trafficProfilesListControl.setFont(new java.awt.Font("Arial", 0, 11));
        trafficProfilesListControl.setSelectionMode(javax.swing.ListSelectionModel.SINGLE_SELECTION);

        org.jdesktop.beansbinding.ELProperty eLProperty = org.jdesktop.beansbinding.ELProperty.create("${trafficSettings.profiles}");
        org.jdesktop.swingbinding.JListBinding jListBinding = org.jdesktop.swingbinding.SwingBindings.createJListBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, eLProperty, trafficProfilesListControl);
        jListBinding.setDetailBinding(org.jdesktop.beansbinding.ELProperty.create("${label}"));
        bindingGroup.addBinding(jListBinding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${selectedProfile}"), trafficProfilesListControl, org.jdesktop.beansbinding.BeanProperty.create("selectedElement"));
        bindingGroup.addBinding(binding);

        trafficProfilesScrollPane.setViewportView(trafficProfilesListControl);

        jPanel1.setBorder(javax.swing.BorderFactory.createEtchedBorder());
        jPanel1.setMinimumSize(new java.awt.Dimension(559, 298));

        profileIdLabel.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        profileIdLabel.setText("ID");

        profileId.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        profileId.setModel(new javax.swing.SpinnerNumberModel(Integer.valueOf(0), Integer.valueOf(0), null, Integer.valueOf(1)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, trafficProfilesListControl, org.jdesktop.beansbinding.ELProperty.create("${selectedElement.id}"), profileId, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jLabel5.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel5.setText("Reply Length");

        ReplayLength.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        ReplayLength.setModel(new javax.swing.SpinnerNumberModel(Integer.valueOf(0), Integer.valueOf(0), null, Integer.valueOf(1)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, trafficProfilesListControl, org.jdesktop.beansbinding.ELProperty.create("${selectedElement.replyLength}"), ReplayLength, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jLabel38.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel38.setText("Byte");

        jLabel6.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel6.setText("Replies per Request");

        RepliesPerRequest.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        RepliesPerRequest.setModel(new javax.swing.SpinnerNumberModel(Integer.valueOf(0), Integer.valueOf(0), null, Integer.valueOf(1)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, trafficProfilesListControl, org.jdesktop.beansbinding.ELProperty.create("${selectedElement.repliesPerRequest}"), RepliesPerRequest, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jLabel10.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel10.setText("Selection Probability");

        SelectionProb.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        SelectionProb.setModel(new javax.swing.SpinnerNumberModel(Float.valueOf(0.0f), Float.valueOf(0.0f), Float.valueOf(100.0f), Float.valueOf(1.0f)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, trafficProfilesListControl, org.jdesktop.beansbinding.ELProperty.create("${selectedElement.ratio}"), SelectionProb, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jLabel11.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel11.setText("WAN Probability");

        WANProb.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        WANProb.setModel(new javax.swing.SpinnerNumberModel(Float.valueOf(0.0f), Float.valueOf(0.0f), Float.valueOf(100.0f), Float.valueOf(1.0f)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, trafficProfilesListControl, org.jdesktop.beansbinding.ELProperty.create("${selectedElement.wanRatio}"), WANProb, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jLabel39.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel39.setText("%");

        portCheckBox.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        portCheckBox.setText("Port");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, trafficProfilesListControl, org.jdesktop.beansbinding.ELProperty.create("${selectedElement.portEnabled}"), portCheckBox, org.jdesktop.beansbinding.BeanProperty.create("selected"));
        bindingGroup.addBinding(binding);

        Port.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        Port.setModel(new javax.swing.SpinnerNumberModel(0, 0, 65535, 1));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, trafficProfilesListControl, org.jdesktop.beansbinding.ELProperty.create("${selectedElement.port}"), Port, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, portCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), Port, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        hoplimitCheckBox.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        hoplimitCheckBox.setText("Hoplimit");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, trafficProfilesListControl, org.jdesktop.beansbinding.ELProperty.create("${selectedElement.hoplimitEnabled}"), hoplimitCheckBox, org.jdesktop.beansbinding.BeanProperty.create("selected"));
        bindingGroup.addBinding(binding);

        HopLimit.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        HopLimit.setModel(new javax.swing.SpinnerNumberModel(0, 0, 256, 1));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, trafficProfilesListControl, org.jdesktop.beansbinding.ELProperty.create("${selectedElement.hoplimit}"), HopLimit, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, hoplimitCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), HopLimit, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jLabel40.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel40.setText("%");

        jSeparator4.setOrientation(javax.swing.SwingConstants.VERTICAL);

        jLabel2.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel2.setText("Label");

        Label.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        Label.setHorizontalAlignment(javax.swing.JTextField.LEFT);

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, trafficProfilesListControl, org.jdesktop.beansbinding.ELProperty.create("${selectedElement.label}"), Label, org.jdesktop.beansbinding.BeanProperty.create("text"));
        bindingGroup.addBinding(binding);

        jLabel3.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel3.setText("Request Length");

        RequestLength.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        RequestLength.setModel(new javax.swing.SpinnerNumberModel(Integer.valueOf(0), Integer.valueOf(0), null, Integer.valueOf(1)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, trafficProfilesListControl, org.jdesktop.beansbinding.ELProperty.create("${selectedElement.requestLength}"), RequestLength, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jLabel44.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel44.setText("Byte");

        jLabel4.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel4.setText("Requests per Flow");

        RequestsPerFlow.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        RequestsPerFlow.setModel(new javax.swing.SpinnerNumberModel(Integer.valueOf(0), Integer.valueOf(0), null, Integer.valueOf(1)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, trafficProfilesListControl, org.jdesktop.beansbinding.ELProperty.create("${selectedElement.requestsPerSession}"), RequestsPerFlow, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jLabel7.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel7.setHorizontalAlignment(javax.swing.SwingConstants.LEFT);
        jLabel7.setText("Time between Requests");
        jLabel7.setHorizontalTextPosition(javax.swing.SwingConstants.LEFT);

        TimeBetweenRequests.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        TimeBetweenRequests.setModel(new javax.swing.SpinnerNumberModel(Float.valueOf(0.0f), Float.valueOf(0.0f), null, Float.valueOf(0.1f)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, trafficProfilesListControl, org.jdesktop.beansbinding.ELProperty.create("${selectedElement.timeBetweenRequests}"), TimeBetweenRequests, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jLabel46.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel46.setText(" sec");
        jLabel46.setHorizontalTextPosition(javax.swing.SwingConstants.LEADING);

        jLabel9.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel9.setText("Time between Flows");

        TimeBetweenFlows.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        TimeBetweenFlows.setModel(new javax.swing.SpinnerNumberModel(Float.valueOf(0.0f), Float.valueOf(0.0f), null, Float.valueOf(0.1f)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, trafficProfilesListControl, org.jdesktop.beansbinding.ELProperty.create("${selectedElement.timeBetweenSessions}"), TimeBetweenFlows, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jLabel47.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel47.setText(" sec");

        jLabel8.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel8.setText("Time to respond");

        TimeToRespond.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        TimeToRespond.setModel(new javax.swing.SpinnerNumberModel(Float.valueOf(0.0f), Float.valueOf(0.0f), null, Float.valueOf(0.1f)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, trafficProfilesListControl, org.jdesktop.beansbinding.ELProperty.create("${selectedElement.timeToRespond}"), TimeToRespond, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jLabel45.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel45.setText(" sec");

        org.jdesktop.layout.GroupLayout jPanel1Layout = new org.jdesktop.layout.GroupLayout(jPanel1);
        jPanel1.setLayout(jPanel1Layout);
        jPanel1Layout.setHorizontalGroup(
            jPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .add(jPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(org.jdesktop.layout.GroupLayout.TRAILING, jPanel1Layout.createSequentialGroup()
                        .add(jPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(jPanel1Layout.createSequentialGroup()
                                .add(portCheckBox, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 110, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                .add(Port, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 70, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                            .add(jPanel1Layout.createSequentialGroup()
                                .add(hoplimitCheckBox, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 110, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                .add(HopLimit, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 70, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)))
                        .add(52, 52, 52))
                    .add(jPanel1Layout.createSequentialGroup()
                        .add(jLabel6, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 110, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(RepliesPerRequest, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 70, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                    .add(jPanel1Layout.createSequentialGroup()
                        .add(jPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(jLabel5, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 110, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(profileIdLabel, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 117, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(jPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING, false)
                            .add(profileId)
                            .add(ReplayLength, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 70, Short.MAX_VALUE))
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(jLabel38, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 30, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                    .add(jPanel1Layout.createSequentialGroup()
                        .add(jPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(jLabel10, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 110, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(jLabel11, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 117, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(jPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(jPanel1Layout.createSequentialGroup()
                                .add(WANProb, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 70, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                .add(jLabel40))
                            .add(jPanel1Layout.createSequentialGroup()
                                .add(SelectionProb, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 70, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                                .add(jLabel39)))
                        .add(22, 22, 22)))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                .add(jSeparator4, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                .add(jPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(jPanel1Layout.createSequentialGroup()
                        .add(jLabel2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 79, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(Label, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 182, Short.MAX_VALUE))
                    .add(jPanel1Layout.createSequentialGroup()
                        .add(jLabel3, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 117, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(RequestLength, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 70, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(jLabel44, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 30, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                    .add(jPanel1Layout.createSequentialGroup()
                        .add(jLabel4, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 109, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(RequestsPerFlow, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 70, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                    .add(jPanel1Layout.createSequentialGroup()
                        .add(jLabel7)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(TimeBetweenRequests, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 70, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(jLabel46, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 30, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                    .add(jPanel1Layout.createSequentialGroup()
                        .add(jLabel9, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 101, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(TimeBetweenFlows, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 70, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(jLabel47, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 30, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                    .add(jPanel1Layout.createSequentialGroup()
                        .add(jLabel8, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 77, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(TimeToRespond, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 70, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(jLabel45, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 30, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap())
        );

        jPanel1Layout.linkSize(new java.awt.Component[] {jLabel44, jLabel45, jLabel46, jLabel47}, org.jdesktop.layout.GroupLayout.HORIZONTAL);

        jPanel1Layout.linkSize(new java.awt.Component[] {hoplimitCheckBox, jLabel10, jLabel2, jLabel3, jLabel4, jLabel5, jLabel6, jLabel7, jLabel8, jLabel9, portCheckBox}, org.jdesktop.layout.GroupLayout.HORIZONTAL);

        jPanel1Layout.setVerticalGroup(
            jPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .add(jPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(profileIdLabel)
                    .add(profileId, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 20, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel5, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 16, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(ReplayLength, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 20, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel38, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 17, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel6, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 16, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(RepliesPerRequest, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 20, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel10, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 17, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(SelectionProb, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 20, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel39))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel11, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 17, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel40)
                    .add(WANProb, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 20, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .add(40, 40, 40)
                .add(jPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(portCheckBox)
                    .add(Port, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 20, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(hoplimitCheckBox)
                    .add(HopLimit, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 20, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(35, Short.MAX_VALUE))
            .add(jSeparator4, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 261, Short.MAX_VALUE)
            .add(jPanel1Layout.createSequentialGroup()
                .addContainerGap()
                .add(jPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel2)
                    .add(Label, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 20, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel3, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 17, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(RequestLength, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 20, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel44))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel4, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 17, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(RequestsPerFlow, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 20, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel7)
                    .add(TimeBetweenRequests, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 20, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel46))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel9)
                    .add(TimeBetweenFlows, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 20, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel47))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel1Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel8)
                    .add(TimeToRespond, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 20, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel45, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 14, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(99, Short.MAX_VALUE))
        );

        jPanel1Layout.linkSize(new java.awt.Component[] {HopLimit, Label, Port, ReplayLength, RepliesPerRequest, RequestLength, RequestsPerFlow, SelectionProb, TimeBetweenFlows, TimeBetweenRequests, TimeToRespond, WANProb, profileId}, org.jdesktop.layout.GroupLayout.VERTICAL);

        jPanel1Layout.linkSize(new java.awt.Component[] {jLabel38, jLabel39, jLabel40, jLabel44, jLabel45, jLabel46, jLabel47}, org.jdesktop.layout.GroupLayout.VERTICAL);

        org.jdesktop.layout.GroupLayout trafficProfilesPaneLayout = new org.jdesktop.layout.GroupLayout(trafficProfilesPane);
        trafficProfilesPane.setLayout(trafficProfilesPaneLayout);
        trafficProfilesPaneLayout.setHorizontalGroup(
            trafficProfilesPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(trafficProfilesPaneLayout.createSequentialGroup()
                .addContainerGap()
                .add(trafficProfilesPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(trafficProfilesPaneLayout.createSequentialGroup()
                        .add(trafficProfileLoadButton)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(trafficProfileSaveButton))
                    .add(trafficProfilesPaneLayout.createSequentialGroup()
                        .add(trafficProfileFileLabel)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                        .add(trafficProfileFile, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 267, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                    .add(trafficProfilesLabel)
                    .add(trafficProfilesScrollPane, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 163, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jPanel1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(94, Short.MAX_VALUE))
        );
        trafficProfilesPaneLayout.setVerticalGroup(
            trafficProfilesPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(trafficProfilesPaneLayout.createSequentialGroup()
                .addContainerGap()
                .add(trafficProfilesPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(trafficProfileFileLabel)
                    .add(trafficProfileFile, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 20, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(trafficProfilesPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(trafficProfileLoadButton)
                    .add(trafficProfileSaveButton))
                .add(18, 18, 18)
                .add(trafficProfilesLabel)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                .add(trafficProfilesScrollPane, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 150, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 265, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(273, Short.MAX_VALUE))
        );

        replaceNodeTypesPane.addTab("Traffic Profiles", trafficProfilesPane);

        serverSettingsPane.setPreferredSize(new java.awt.Dimension(700, 800));

        serverSettingsLoadButton.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        serverSettingsLoadButton.setText("Load");
        serverSettingsLoadButton.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                serverSettingsChanged(evt);
            }
        });
        serverSettingsLoadButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                serverSettingsLoadButtonActionPerformed(evt);
            }
        });

        serverSettingsSaveButton.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        serverSettingsSaveButton.setText("Save");
        serverSettingsSaveButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                serverSettingsSaveButtonActionPerformed(evt);
            }
        });

        jLabel12.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel12.setText("Server Settings File");

        jTextField2.setEditable(false);
        jTextField2.setFont(new java.awt.Font("Lucida Sans", 0, 11));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettingsFilePath}"), jTextField2, org.jdesktop.beansbinding.BeanProperty.create("text"));
        bindingGroup.addBinding(binding);

        jLabel13.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel13.setText("Bandwidth ");

        jPanel2.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        jLabel14.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel14.setText("Host -> Edge");

        jLabel15.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel15.setText("Edge -> Host");

        jLabel16.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel16.setText("Server -> Edge");

        jLabel17.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel17.setText("Edge -> Gateway");

        jLabel18.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel18.setText("Gateway ->  Core");

        jLabel19.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel19.setText("Core -> Core");

        jLabel20.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel20.setText("Stub -> Stub");

        jLabel21.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel21.setText("Transit -> Stub");

        jLabel22.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel22.setText("Transit -> Transit");

        jSpinner12.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner12.setModel(new javax.swing.SpinnerNumberModel(Float.valueOf(0.0f), Float.valueOf(0.0f), null, Float.valueOf(1.0f)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.host2Edge}"), jSpinner12, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jSpinner12.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                serverSettingsChanged(evt);
            }
        });

        jSpinner13.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner13.setModel(new javax.swing.SpinnerNumberModel(Float.valueOf(0.0f), null, null, Float.valueOf(1.0f)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.edge2Host}"), jSpinner13, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jSpinner13.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                serverSettingsChanged(evt);
            }
        });

        jSpinner14.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner14.setModel(new javax.swing.SpinnerNumberModel(Float.valueOf(0.0f), Float.valueOf(0.0f), null, Float.valueOf(1.0f)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.server2Edge}"), jSpinner14, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jSpinner14.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                serverSettingsChanged(evt);
            }
        });

        jSpinner15.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner15.setModel(new javax.swing.SpinnerNumberModel(Float.valueOf(0.0f), Float.valueOf(0.0f), null, Float.valueOf(1.0f)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.edge2Gateway}"), jSpinner15, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jSpinner15.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                serverSettingsChanged(evt);
            }
        });

        jSpinner16.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner16.setModel(new javax.swing.SpinnerNumberModel(Float.valueOf(0.0f), Float.valueOf(0.0f), null, Float.valueOf(1.0f)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.gateway2Core}"), jSpinner16, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jSpinner16.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                serverSettingsChanged(evt);
            }
        });

        jSpinner17.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner17.setModel(new javax.swing.SpinnerNumberModel(Float.valueOf(0.0f), Float.valueOf(0.0f), null, Float.valueOf(1.0f)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.core2Core}"), jSpinner17, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jSpinner17.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                serverSettingsChanged(evt);
            }
        });

        jSpinner18.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner18.setModel(new javax.swing.SpinnerNumberModel(Float.valueOf(0.0f), Float.valueOf(0.0f), null, Float.valueOf(1.0f)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.stub2Stub}"), jSpinner18, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jSpinner18.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                serverSettingsChanged(evt);
            }
        });

        jSpinner19.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner19.setModel(new javax.swing.SpinnerNumberModel(Float.valueOf(0.0f), Float.valueOf(0.0f), null, Float.valueOf(1.0f)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.transit2Stub}"), jSpinner19, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jSpinner19.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                serverSettingsChanged(evt);
            }
        });

        jSpinner20.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner20.setModel(new javax.swing.SpinnerNumberModel(Float.valueOf(0.0f), Float.valueOf(0.0f), null, Float.valueOf(1.0f)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.transit2Transit}"), jSpinner20, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jSpinner20.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                serverSettingsChanged(evt);
            }
        });

        jSpinner33.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner33.setModel(new javax.swing.SpinnerNumberModel(Integer.valueOf(0), Integer.valueOf(0), null, Integer.valueOf(1)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.host2EdgeLatency}"), jSpinner33, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, latencyCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jSpinner33, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jSpinner33.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                serverSettingsChanged(evt);
            }
        });

        jSpinner34.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner34.setModel(new javax.swing.SpinnerNumberModel(Integer.valueOf(0), Integer.valueOf(0), null, Integer.valueOf(1)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.edge2HostLatency}"), jSpinner34, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, latencyCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jSpinner34, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jSpinner34.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                serverSettingsChanged(evt);
            }
        });

        jSpinner22.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner22.setModel(new javax.swing.SpinnerNumberModel(Integer.valueOf(0), Integer.valueOf(0), null, Integer.valueOf(1)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.server2EdgeLatency}"), jSpinner22, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, latencyCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jSpinner22, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jSpinner22.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                serverSettingsChanged(evt);
            }
        });

        jSpinner35.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner35.setModel(new javax.swing.SpinnerNumberModel(Integer.valueOf(0), Integer.valueOf(0), null, Integer.valueOf(1)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.edge2GatewayLatency}"), jSpinner35, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, latencyCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jSpinner35, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jSpinner35.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                serverSettingsChanged(evt);
            }
        });

        jSpinner36.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner36.setModel(new javax.swing.SpinnerNumberModel(Integer.valueOf(0), Integer.valueOf(0), null, Integer.valueOf(1)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.edge2GatewayLatency}"), jSpinner36, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, latencyCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jSpinner36, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jSpinner36.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                serverSettingsChanged(evt);
            }
        });

        jSpinner37.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner37.setModel(new javax.swing.SpinnerNumberModel(Integer.valueOf(0), Integer.valueOf(0), null, Integer.valueOf(1)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.core2CoreLatency}"), jSpinner37, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, latencyCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jSpinner37, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jSpinner37.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                serverSettingsChanged(evt);
            }
        });

        jSpinner38.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner38.setModel(new javax.swing.SpinnerNumberModel(Integer.valueOf(0), Integer.valueOf(0), null, Integer.valueOf(1)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.stub2StubLatency}"), jSpinner38, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, latencyCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jSpinner38, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jSpinner38.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                serverSettingsChanged(evt);
            }
        });

        jSpinner39.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner39.setModel(new javax.swing.SpinnerNumberModel(Integer.valueOf(0), Integer.valueOf(0), null, Integer.valueOf(1)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.transit2StubLatency}"), jSpinner39, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, latencyCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jSpinner39, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jSpinner39.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                serverSettingsChanged(evt);
            }
        });

        jSpinner40.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner40.setModel(new javax.swing.SpinnerNumberModel(Integer.valueOf(0), Integer.valueOf(0), null, Integer.valueOf(1)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.transit2TransitLatency}"), jSpinner40, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, latencyCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jSpinner40, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jSpinner40.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                serverSettingsChanged(evt);
            }
        });

        jLabel65.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel65.setText("Mbit/s");

        jLabel66.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel66.setText("Mbit/s");

        jLabel67.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel67.setText("Mbit/s");

        jLabel68.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel68.setText("Mbit/s");

        jLabel69.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel69.setText("Mbit/s");

        jLabel70.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel70.setText("Mbit/s");

        jLabel71.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel71.setText("Mbit/s");

        jLabel72.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel72.setText("Mbit/s");

        jLabel73.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel73.setText("Mbit/s");

        jLabel74.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel74.setText("ms");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, latencyCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jLabel74, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jLabel75.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel75.setText("ms");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, latencyCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jLabel75, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jLabel76.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel76.setText("ms");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, latencyCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jLabel76, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jLabel77.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel77.setText("ms");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, latencyCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jLabel77, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jLabel78.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel78.setText("ms");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, latencyCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jLabel78, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jLabel79.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel79.setText("ms");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, latencyCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jLabel79, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jLabel80.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel80.setText("ms");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, latencyCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jLabel80, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jLabel81.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel81.setText("ms");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, latencyCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jLabel81, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jLabel82.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel82.setText("ms");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, latencyCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jLabel82, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        org.jdesktop.layout.GroupLayout jPanel2Layout = new org.jdesktop.layout.GroupLayout(jPanel2);
        jPanel2.setLayout(jPanel2Layout);
        jPanel2Layout.setHorizontalGroup(
            jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(org.jdesktop.layout.GroupLayout.TRAILING, jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .add(jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.TRAILING)
                    .add(jSpinner40, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 63, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jSpinner39, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 63, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jSpinner35, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 63, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jSpinner22, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 63, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(org.jdesktop.layout.GroupLayout.LEADING, jPanel2Layout.createSequentialGroup()
                        .add(jLabel14)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, 84, Short.MAX_VALUE)
                        .add(jSpinner12, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 63, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                    .add(org.jdesktop.layout.GroupLayout.LEADING, jPanel2Layout.createSequentialGroup()
                        .add(jLabel15)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, 84, Short.MAX_VALUE)
                        .add(jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(jSpinner13, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 63, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(jSpinner33, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 63, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(jSpinner34, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 63, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)))
                    .add(org.jdesktop.layout.GroupLayout.LEADING, jPanel2Layout.createSequentialGroup()
                        .add(jLabel16)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, 72, Short.MAX_VALUE)
                        .add(jSpinner14, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 63, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                    .add(org.jdesktop.layout.GroupLayout.LEADING, jPanel2Layout.createSequentialGroup()
                        .add(jLabel17)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, 61, Short.MAX_VALUE)
                        .add(jSpinner15, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 63, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                    .add(org.jdesktop.layout.GroupLayout.LEADING, jPanel2Layout.createSequentialGroup()
                        .add(jLabel18)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, 58, Short.MAX_VALUE)
                        .add(jSpinner16, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 63, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                    .add(org.jdesktop.layout.GroupLayout.LEADING, jPanel2Layout.createSequentialGroup()
                        .add(jLabel19)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, 84, Short.MAX_VALUE)
                        .add(jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(jSpinner17, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 63, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(jSpinner36, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 63, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)))
                    .add(jSpinner37, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 63, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(org.jdesktop.layout.GroupLayout.LEADING, jPanel2Layout.createSequentialGroup()
                        .add(jLabel20)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, 86, Short.MAX_VALUE)
                        .add(jSpinner18, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 63, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                    .add(org.jdesktop.layout.GroupLayout.LEADING, jPanel2Layout.createSequentialGroup()
                        .add(jLabel21)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, 72, Short.MAX_VALUE)
                        .add(jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(jSpinner19, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 63, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(jSpinner38, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 63, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)))
                    .add(org.jdesktop.layout.GroupLayout.LEADING, jPanel2Layout.createSequentialGroup()
                        .add(jLabel22)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, 58, Short.MAX_VALUE)
                        .add(jSpinner20, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 63, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(jLabel65)
                    .add(jLabel66)
                    .add(jLabel67)
                    .add(jLabel68)
                    .add(jLabel69)
                    .add(jLabel70)
                    .add(jLabel71)
                    .add(jLabel72)
                    .add(jLabel73)
                    .add(jLabel74)
                    .add(jLabel75)
                    .add(jLabel76)
                    .add(jLabel77)
                    .add(jLabel78)
                    .add(jLabel79)
                    .add(jLabel80)
                    .add(jLabel81)
                    .add(jLabel82))
                .add(20, 20, 20))
        );
        jPanel2Layout.setVerticalGroup(
            jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel2Layout.createSequentialGroup()
                .addContainerGap()
                .add(jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel14)
                    .add(jSpinner12, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel65))
                .add(5, 5, 5)
                .add(jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jSpinner33, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel74))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel15)
                    .add(jSpinner13, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel66))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jSpinner34, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel75))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel16)
                    .add(jSpinner14, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel67))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jSpinner22, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel76))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel17)
                    .add(jSpinner15, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel68))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jSpinner35, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel77))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel18)
                    .add(jSpinner16, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel69))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jSpinner36, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel78))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel19)
                    .add(jSpinner17, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel70))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jSpinner37, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel79))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel20)
                    .add(jSpinner18, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel71))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jSpinner38, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel80))
                .add(5, 5, 5)
                .add(jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel21)
                    .add(jSpinner19, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel72))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jSpinner39, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel81))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel22)
                    .add(jSpinner20, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel73))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel2Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jSpinner40, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel82))
                .addContainerGap(org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        jLabel23.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel23.setText("Server Fraction");

        jPanel3.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        jLabel25.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel25.setText("Name");

        jLabel26.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel26.setText("Streaming");

        jLabel27.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel27.setText("Backup");

        jLabel28.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel28.setText("Interactive");

        jLabel29.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel29.setText("Web");

        jLabel30.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel30.setText("Mail");

        jSpinner23.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner23.setModel(new javax.swing.SpinnerNumberModel(0, 0, 100, 1));
        jSpinner23.setEnabled(false);

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.nameServer}"), jSpinner23, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jSpinner23.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                jSpinner23StateChanged(evt);
            }
        });

        jSpinner24.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner24.setModel(new javax.swing.SpinnerNumberModel(0, 0, 100, 1));
        jSpinner24.setEnabled(false);

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.streamingServer}"), jSpinner24, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jSpinner24.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                jSpinner24StateChanged(evt);
            }
        });

        jSpinner25.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner25.setModel(new javax.swing.SpinnerNumberModel(0, 0, 100, 1));
        jSpinner25.setEnabled(false);

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.backupServer}"), jSpinner25, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jSpinner25.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                jSpinner25StateChanged(evt);
            }
        });

        jSpinner26.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner26.setModel(new javax.swing.SpinnerNumberModel(0, 0, 100, 1));
        jSpinner26.setEnabled(false);

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.interactiveServer}"), jSpinner26, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jSpinner26.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                jSpinner26StateChanged(evt);
            }
        });

        jSpinner27.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner27.setModel(new javax.swing.SpinnerNumberModel(0, 0, 100, 1));
        jSpinner27.setEnabled(false);

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.webServer}"), jSpinner27, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jSpinner27.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                jSpinner27StateChanged(evt);
            }
        });

        jSpinner28.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner28.setModel(new javax.swing.SpinnerNumberModel(0, 0, 100, 1));
        jSpinner28.setEnabled(false);

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.mailServer}"), jSpinner28, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jSpinner28.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                jSpinner28StateChanged(evt);
            }
        });

        jLabel24.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel24.setText("Server Types");

        jTextField7.setBackground(new java.awt.Color(244, 244, 244));
        jTextField7.setEditable(false);
        jTextField7.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jTextField7.setHorizontalAlignment(javax.swing.JTextField.RIGHT);
        jTextField7.setEnabled(false);

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.serverSum}"), jTextField7, org.jdesktop.beansbinding.BeanProperty.create("text"));
        bindingGroup.addBinding(binding);

        jLabel51.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel51.setText("%");

        jLabel52.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel52.setText("%");

        jLabel53.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel53.setText("%");

        jLabel54.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel54.setText("%");

        jLabel55.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel55.setText("%");

        jLabel56.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel56.setText("%");

        org.jdesktop.layout.GroupLayout jPanel3Layout = new org.jdesktop.layout.GroupLayout(jPanel3);
        jPanel3.setLayout(jPanel3Layout);
        jPanel3Layout.setHorizontalGroup(
            jPanel3Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel3Layout.createSequentialGroup()
                .addContainerGap()
                .add(jPanel3Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(jPanel3Layout.createSequentialGroup()
                        .add(jLabel24)
                        .addContainerGap(204, Short.MAX_VALUE))
                    .add(jPanel3Layout.createSequentialGroup()
                        .add(jPanel3Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(jLabel25)
                            .add(jLabel26)
                            .add(jLabel27)
                            .add(jLabel28)
                            .add(jLabel30)
                            .add(jLabel29))
                        .add(83, 83, 83)
                        .add(jPanel3Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.TRAILING, false)
                            .add(jSpinner28, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 66, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(jSpinner27, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 66, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(jSpinner26, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 66, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(jSpinner25, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 66, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(jSpinner24, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 66, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(jSpinner23, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 66, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, 13, Short.MAX_VALUE)
                        .add(jPanel3Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(jLabel51)
                            .add(jLabel52)
                            .add(jLabel53)
                            .add(jLabel54)
                            .add(jLabel55)
                            .add(jLabel56))
                        .add(49, 49, 49))))
            .add(jPanel3Layout.createSequentialGroup()
                .add(117, 117, 117)
                .add(jSeparator2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 106, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(69, Short.MAX_VALUE))
            .add(jPanel3Layout.createSequentialGroup()
                .add(147, 147, 147)
                .add(jTextField7, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 51, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(94, Short.MAX_VALUE))
        );
        jPanel3Layout.setVerticalGroup(
            jPanel3Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel3Layout.createSequentialGroup()
                .addContainerGap()
                .add(jLabel24)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel3Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel25)
                    .add(jSpinner23, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel51))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel3Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel26)
                    .add(jSpinner24, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel52))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel3Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel27)
                    .add(jSpinner25, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel53))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel3Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel28)
                    .add(jSpinner26, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel54))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel3Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jSpinner27, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel29)
                    .add(jLabel55))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel3Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel30)
                    .add(jSpinner28, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel56))
                .add(18, 18, 18)
                .add(jSeparator2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 10, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jTextField7, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );

        jLabel31.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel31.setText("Router Fraction");

        RouterFractionSpinner.setFont(new java.awt.Font("Arial", 0, 11));
        RouterFractionSpinner.setModel(new javax.swing.SpinnerNumberModel(Float.valueOf(0.0f), Float.valueOf(0.0f), Float.valueOf(100.0f), Float.valueOf(1.0f)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.routerFraction}"), RouterFractionSpinner, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        RouterFractionSpinner.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                RouterFractionSpinnerStateChanged(evt);
            }
        });

        jPanel4.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        jLabel33.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel33.setText("Trace");

        jSpinner29.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner29.setModel(new javax.swing.SpinnerNumberModel(0, 0, 100, 1));
        jSpinner29.setEnabled(false);

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.traceRouter}"), jSpinner29, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        jSpinner29.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                jSpinner29StateChanged(evt);
            }
        });

        jLabel32.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel32.setText("Router Types");

        jTextField8.setBackground(new java.awt.Color(244, 244, 244));
        jTextField8.setEditable(false);
        jTextField8.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jTextField8.setHorizontalAlignment(javax.swing.JTextField.RIGHT);
        jTextField8.setEnabled(false);

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.routerSum}"), jTextField8, org.jdesktop.beansbinding.BeanProperty.create("text"));
        bindingGroup.addBinding(binding);

        jLabel57.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel57.setText("%");

        org.jdesktop.layout.GroupLayout jPanel4Layout = new org.jdesktop.layout.GroupLayout(jPanel4);
        jPanel4.setLayout(jPanel4Layout);
        jPanel4Layout.setHorizontalGroup(
            jPanel4Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel4Layout.createSequentialGroup()
                .add(21, 21, 21)
                .add(jPanel4Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(jPanel4Layout.createSequentialGroup()
                        .add(jLabel33)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, 76, Short.MAX_VALUE)
                        .add(jPanel4Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(jPanel4Layout.createSequentialGroup()
                                .add(22, 22, 22)
                                .add(jPanel4Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                                    .add(jPanel4Layout.createSequentialGroup()
                                        .add(jSpinner29, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 67, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                        .add(jLabel57))
                                    .add(jTextField8, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 49, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, 6, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                            .add(org.jdesktop.layout.GroupLayout.TRAILING, jSeparator3, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 114, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                        .add(46, 46, 46))
                    .add(jPanel4Layout.createSequentialGroup()
                        .add(jLabel32)
                        .addContainerGap(196, Short.MAX_VALUE))))
        );
        jPanel4Layout.setVerticalGroup(
            jPanel4Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel4Layout.createSequentialGroup()
                .add(10, 10, 10)
                .add(jLabel32)
                .add(18, 18, 18)
                .add(jPanel4Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(jPanel4Layout.createSequentialGroup()
                        .add(jPanel4Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                            .add(jSpinner29, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(jLabel57))
                        .add(18, 18, 18)
                        .add(jSeparator3, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 10, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(jTextField8, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                    .add(jLabel33))
                .addContainerGap(27, Short.MAX_VALUE))
        );

        serverSettingsDefaultButton.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        serverSettingsDefaultButton.setText("Default");
        serverSettingsDefaultButton.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                serverSettingsChanged(evt);
            }
        });
        serverSettingsDefaultButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                serverSettingsDefaultButtonActionPerformed(evt);
            }
        });

        serverSettingsRunButton.setFont(new java.awt.Font("Lucida Sans", 0, 11)); // NOI18N
        serverSettingsRunButton.setText("Run");
        serverSettingsRunButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                serverSettingsRunButtonActionPerformed(evt);
            }
        });

        serverSettingsSetScriptPathButton.setFont(new java.awt.Font("Lucida Sans", 0, 11)); // NOI18N
        serverSettingsSetScriptPathButton.setText("Set Script Path");
        serverSettingsSetScriptPathButton.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                serverSettingsChanged(evt);
            }
        });
        serverSettingsSetScriptPathButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                serverSettingsSetScriptPathButtonActionPerformed(evt);
            }
        });

        jLabel34.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel34.setText("Input NED File");

        jLabel35.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel35.setText("Output NED File");

        jTextField3.setFont(new java.awt.Font("Lucida Sans", 0, 11)); // NOI18N

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverTopologyInputFilePath}"), jTextField3, org.jdesktop.beansbinding.BeanProperty.create("text"));
        bindingGroup.addBinding(binding);

        jTextField4.setFont(new java.awt.Font("Lucida Sans", 0, 11));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverTopologyOutputFilePath}"), jTextField4, org.jdesktop.beansbinding.BeanProperty.create("text"));
        bindingGroup.addBinding(binding);

        serverSettingsSelectTopologyInputFileButton.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        serverSettingsSelectTopologyInputFileButton.setText("Select");
        serverSettingsSelectTopologyInputFileButton.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                serverSettingsChanged(evt);
            }
        });
        serverSettingsSelectTopologyInputFileButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                serverSettingsSelectTopologyInputFileButtonActionPerformed(evt);
            }
        });

        serverSettingsSelectTopologyOutputFileButton.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        serverSettingsSelectTopologyOutputFileButton.setText("Select");
        serverSettingsSelectTopologyOutputFileButton.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                serverSettingsChanged(evt);
            }
        });
        serverSettingsSelectTopologyOutputFileButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                serverSettingsSelectTopologyOutputFileButtonActionPerformed(evt);
            }
        });

        ServerFractionSpinner.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        ServerFractionSpinner.setModel(new javax.swing.SpinnerNumberModel(Float.valueOf(0.0f), Float.valueOf(0.0f), Float.valueOf(100.0f), Float.valueOf(1.0f)));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.serverFraction}"), ServerFractionSpinner, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);

        ServerFractionSpinner.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                ServerFractionSpinnerStateChanged(evt);
            }
        });

        jLabel58.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel58.setText("%");

        jLabel59.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel59.setText("%");

        latencyCheckBox.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        latencyCheckBox.setText("and Latency");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${serverSettings.useCustomLatencies}"), latencyCheckBox, org.jdesktop.beansbinding.BeanProperty.create("selected"));
        bindingGroup.addBinding(binding);

        latencyCheckBox.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                latencyCheckBoxActionPerformed(evt);
            }
        });

        org.jdesktop.layout.GroupLayout serverSettingsPaneLayout = new org.jdesktop.layout.GroupLayout(serverSettingsPane);
        serverSettingsPane.setLayout(serverSettingsPaneLayout);
        serverSettingsPaneLayout.setHorizontalGroup(
            serverSettingsPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(serverSettingsPaneLayout.createSequentialGroup()
                .add(serverSettingsPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(serverSettingsPaneLayout.createSequentialGroup()
                        .add(135, 135, 135)
                        .add(jTextField2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 261, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                    .add(serverSettingsPaneLayout.createSequentialGroup()
                        .add(12, 12, 12)
                        .add(jLabel12))
                    .add(serverSettingsPaneLayout.createSequentialGroup()
                        .addContainerGap()
                        .add(serverSettingsPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.TRAILING)
                            .add(org.jdesktop.layout.GroupLayout.LEADING, serverSettingsPaneLayout.createSequentialGroup()
                                .add(serverSettingsPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                                    .add(serverSettingsPaneLayout.createSequentialGroup()
                                        .add(jLabel13)
                                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                        .add(latencyCheckBox, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 170, Short.MAX_VALUE)
                                        .add(59, 59, 59))
                                    .add(jPanel2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                                .add(20, 20, 20)
                                .add(serverSettingsPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING, false)
                                    .add(serverSettingsPaneLayout.createSequentialGroup()
                                        .add(jLabel23, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 93, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                                        .add(57, 57, 57)
                                        .add(ServerFractionSpinner, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 62, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                        .add(jLabel58))
                                    .add(serverSettingsPaneLayout.createSequentialGroup()
                                        .add(jLabel31)
                                        .add(67, 67, 67)
                                        .add(RouterFractionSpinner, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 59, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                        .add(jLabel59))
                                    .add(jPanel3, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                    .add(jPanel4, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                            .add(org.jdesktop.layout.GroupLayout.LEADING, serverSettingsPaneLayout.createSequentialGroup()
                                .add(serverSettingsLoadButton)
                                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                .add(serverSettingsSaveButton)
                                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                .add(serverSettingsDefaultButton)))
                        .add(72, 72, 72))
                    .add(org.jdesktop.layout.GroupLayout.TRAILING, serverSettingsPaneLayout.createSequentialGroup()
                        .add(serverSettingsPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.TRAILING)
                            .add(org.jdesktop.layout.GroupLayout.LEADING, serverSettingsPaneLayout.createSequentialGroup()
                                .addContainerGap()
                                .add(jSeparator1, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 618, Short.MAX_VALUE))
                            .add(serverSettingsPaneLayout.createSequentialGroup()
                                .add(12, 12, 12)
                                .add(serverSettingsPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                                    .add(jLabel35)
                                    .add(jLabel34))
                                .add(20, 20, 20)
                                .add(serverSettingsPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                                    .add(serverSettingsPaneLayout.createSequentialGroup()
                                        .add(jTextField3, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 171, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                        .add(serverSettingsSelectTopologyInputFileButton))
                                    .add(serverSettingsPaneLayout.createSequentialGroup()
                                        .add(jTextField4, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 171, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                        .add(serverSettingsSelectTopologyOutputFileButton)
                                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                                .add(117, 117, 117)
                                .add(serverSettingsSetScriptPathButton)
                                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                .add(serverSettingsRunButton, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 66, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)))
                        .add(74, 74, 74)))
                .add(44, 44, 44))
        );
        serverSettingsPaneLayout.setVerticalGroup(
            serverSettingsPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(serverSettingsPaneLayout.createSequentialGroup()
                .add(serverSettingsPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(serverSettingsPaneLayout.createSequentialGroup()
                        .add(42, 42, 42)
                        .add(serverSettingsPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                            .add(jLabel35)
                            .add(serverSettingsSelectTopologyOutputFileButton, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 15, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(jTextField4, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)))
                    .add(serverSettingsPaneLayout.createSequentialGroup()
                        .addContainerGap()
                        .add(serverSettingsPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                            .add(jLabel34)
                            .add(serverSettingsSelectTopologyInputFileButton, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 15, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(jTextField3, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(serverSettingsRunButton)
                            .add(serverSettingsSetScriptPathButton))))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                .add(jSeparator1, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 9, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(serverSettingsPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.TRAILING)
                    .add(jLabel12)
                    .add(jTextField2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                .add(serverSettingsPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(serverSettingsLoadButton)
                    .add(serverSettingsSaveButton)
                    .add(serverSettingsDefaultButton))
                .add(18, 18, 18)
                .add(serverSettingsPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(serverSettingsPaneLayout.createSequentialGroup()
                        .add(serverSettingsPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                            .add(jLabel13)
                            .add(latencyCheckBox))
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(jPanel2, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                    .add(serverSettingsPaneLayout.createSequentialGroup()
                        .add(serverSettingsPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                            .add(jLabel23)
                            .add(ServerFractionSpinner, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(jLabel58))
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(jPanel3, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                        .add(32, 32, 32)
                        .add(serverSettingsPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                            .add(jLabel31)
                            .add(RouterFractionSpinner, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                            .add(jLabel59))
                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                        .add(jPanel4, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(42, Short.MAX_VALUE))
        );

        replaceNodeTypesPane.addTab("Server Settings", serverSettingsPane);

        ReplaceNodesPane.setPreferredSize(new java.awt.Dimension(700, 800));

        rntSetScriptPathButton.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        rntSetScriptPathButton.setText("Set Script Path");
        rntSetScriptPathButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                rntSetScriptPathButtonActionPerformed(evt);
            }
        });

        rntRunButton.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        rntRunButton.setText("Run");
        rntRunButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                rntRunButtonActionPerformed(evt);
            }
        });

        jLabel36.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel36.setText("Input NED File");

        jLabel37.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel37.setText("Output NED File");

        jTextField5.setFont(new java.awt.Font("Lucida Sans", 0, 11));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${rntTopologyInputFilePath}"), jTextField5, org.jdesktop.beansbinding.BeanProperty.create("text"));
        bindingGroup.addBinding(binding);

        jTextField5.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                jTextField5ActionPerformed(evt);
            }
        });

        jTextField6.setFont(new java.awt.Font("Lucida Sans", 0, 11));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${rntTopologyOutputFilePath}"), jTextField6, org.jdesktop.beansbinding.BeanProperty.create("text"));
        bindingGroup.addBinding(binding);

        rntTopologyInputFileSelectButton.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        rntTopologyInputFileSelectButton.setText("Select");
        rntTopologyInputFileSelectButton.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                replaceNodeTypeChanged(evt);
            }
        });
        rntTopologyInputFileSelectButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                rntTopologyInputFileSelectButtonActionPerformed(evt);
            }
        });

        rntTopologyOutputFileSelectButton.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        rntTopologyOutputFileSelectButton.setText("Select");
        rntTopologyOutputFileSelectButton.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                replaceNodeTypeChanged(evt);
            }
        });
        rntTopologyOutputFileSelectButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                rntTopologyOutputFileSelectButtonActionPerformed(evt);
            }
        });

        jPanel5.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        rntDDoSZombieCheckBox.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        rntDDoSZombieCheckBox.setText("DDoSZombies (replace InetUserHost)");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${replaceNodeTypes.DDoSZombieEnabled}"), rntDDoSZombieCheckBox, org.jdesktop.beansbinding.BeanProperty.create("selected"));
        bindingGroup.addBinding(binding);

        rntDDoSZombieCheckBox.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                replaceNodeTypeChanged(evt);
            }
        });

        jSpinner30.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner30.setModel(new javax.swing.SpinnerNumberModel(0, 0, 1000, 1));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${replaceNodeTypes.inetUserHost2DDoSZombie}"), jSpinner30, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, rntDDoSZombieCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jSpinner30, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jSpinner30.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                replaceNodeTypeChanged(evt);
            }
        });

        jLabel41.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel41.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel41.setText("Ratio (‰)");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, rntDDoSZombieCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jLabel41, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        org.jdesktop.layout.GroupLayout jPanel5Layout = new org.jdesktop.layout.GroupLayout(jPanel5);
        jPanel5.setLayout(jPanel5Layout);
        jPanel5Layout.setHorizontalGroup(
            jPanel5Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel5Layout.createSequentialGroup()
                .add(jPanel5Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(jPanel5Layout.createSequentialGroup()
                        .addContainerGap()
                        .add(rntDDoSZombieCheckBox))
                    .add(jPanel5Layout.createSequentialGroup()
                        .add(50, 50, 50)
                        .add(jLabel41)
                        .add(42, 42, 42)
                        .add(jSpinner30, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 73, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)))
                .add(325, 325, 325))
        );
        jPanel5Layout.setVerticalGroup(
            jPanel5Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel5Layout.createSequentialGroup()
                .addContainerGap()
                .add(rntDDoSZombieCheckBox)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(jPanel5Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel41)
                    .add(jSpinner30, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(33, Short.MAX_VALUE))
        );

        jPanel7.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        rntWormHostCheckBox.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        rntWormHostCheckBox.setText("WormHost (replace InetUserHost)");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${replaceNodeTypes.wormHostEnabled}"), rntWormHostCheckBox, org.jdesktop.beansbinding.BeanProperty.create("selected"));
        bindingGroup.addBinding(binding);

        rntWormHostCheckBox.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                replaceNodeTypeChanged(evt);
            }
        });
        rntWormHostCheckBox.addKeyListener(new java.awt.event.KeyAdapter() {
            public void keyPressed(java.awt.event.KeyEvent evt) {
                rntWormHostCheckBoxKeyPressed(evt);
            }
        });

        jSpinner31.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner31.setModel(new javax.swing.SpinnerNumberModel(0, 0, 1000, 1));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${replaceNodeTypes.inetUserHost2WormHost}"), jSpinner31, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, rntWormHostCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jSpinner31, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jSpinner31.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                replaceNodeTypeChanged(evt);
            }
        });

        jLabel42.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel42.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel42.setText("Ratio (‰)");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, rntWormHostCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jLabel42, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        org.jdesktop.layout.GroupLayout jPanel7Layout = new org.jdesktop.layout.GroupLayout(jPanel7);
        jPanel7.setLayout(jPanel7Layout);
        jPanel7Layout.setHorizontalGroup(
            jPanel7Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel7Layout.createSequentialGroup()
                .add(jPanel7Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(jPanel7Layout.createSequentialGroup()
                        .addContainerGap()
                        .add(rntWormHostCheckBox))
                    .add(jPanel7Layout.createSequentialGroup()
                        .add(50, 50, 50)
                        .add(jLabel42)
                        .add(41, 41, 41)
                        .add(jSpinner31, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 73, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)))
                .add(326, 326, 326))
        );
        jPanel7Layout.setVerticalGroup(
            jPanel7Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel7Layout.createSequentialGroup()
                .addContainerGap()
                .add(rntWormHostCheckBox)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                .add(jPanel7Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jSpinner31, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel42))
                .addContainerGap(27, Short.MAX_VALUE))
        );

        jPanel8.setBorder(javax.swing.BorderFactory.createEtchedBorder());

        rntIDSCheckBox.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        rntIDSCheckBox.setText("DistackOmnetIDS (replace Router)");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${replaceNodeTypes.distackIDSEnabled}"), rntIDSCheckBox, org.jdesktop.beansbinding.BeanProperty.create("selected"));
        bindingGroup.addBinding(binding);

        rntIDSCheckBox.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                rntIDSCheckBoxActionPerformed(evt);
            }
        });

        jSpinner32.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jSpinner32.setModel(new javax.swing.SpinnerNumberModel(0, 0, 1000, 1));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${replaceNodeTypes.router2DistackIDS}"), jSpinner32, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, rntIDSCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jSpinner32, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jLabel43.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel43.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel43.setText("Ratio (‰)");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, rntIDSCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jLabel43, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        org.jdesktop.layout.GroupLayout jPanel8Layout = new org.jdesktop.layout.GroupLayout(jPanel8);
        jPanel8.setLayout(jPanel8Layout);
        jPanel8Layout.setHorizontalGroup(
            jPanel8Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel8Layout.createSequentialGroup()
                .add(jPanel8Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(jPanel8Layout.createSequentialGroup()
                        .addContainerGap()
                        .add(rntIDSCheckBox))
                    .add(jPanel8Layout.createSequentialGroup()
                        .add(48, 48, 48)
                        .add(jLabel43)
                        .add(47, 47, 47)
                        .add(jSpinner32, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(354, Short.MAX_VALUE))
        );
        jPanel8Layout.setVerticalGroup(
            jPanel8Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel8Layout.createSequentialGroup()
                .addContainerGap()
                .add(rntIDSCheckBox)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                .add(jPanel8Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel43)
                    .add(jSpinner32, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(27, Short.MAX_VALUE))
        );

        jPanel6.setBorder(javax.swing.BorderFactory.createEtchedBorder());
        jPanel6.setFocusable(false);
        jPanel6.setFont(new java.awt.Font("Arial", 0, 11));

        rntUserConfigCheckBox.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        rntUserConfigCheckBox.setText("User-Configurable Replacement");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${replaceNodeTypes.userConfEnabled}"), rntUserConfigCheckBox, org.jdesktop.beansbinding.BeanProperty.create("selected"));
        bindingGroup.addBinding(binding);

        rntUserConfigCheckBox.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                replaceNodeTypeChanged(evt);
            }
        });
        rntUserConfigCheckBox.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                rntUserConfigCheckBoxActionPerformed(evt);
            }
        });

        jLabel62.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel62.setHorizontalAlignment(javax.swing.SwingConstants.CENTER);
        jLabel62.setText("Ratio (‰)");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, rntUserConfigCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jLabel62, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jSpinner21.setFont(new java.awt.Font("Lucida Sans", 0, 11));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${replaceNodeTypes.userConf2UserConf}"), jSpinner21, org.jdesktop.beansbinding.BeanProperty.create("value"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, rntUserConfigCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jSpinner21, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jSpinner21.addChangeListener(new javax.swing.event.ChangeListener() {
            public void stateChanged(javax.swing.event.ChangeEvent evt) {
                replaceNodeTypeChanged(evt);
            }
        });

        jLabel63.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel63.setText("Replace node type");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, rntUserConfigCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jLabel63, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        rntUserConfigFromTextField.setFont(new java.awt.Font("Lucida Sans", 0, 11));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${replaceNodeTypes.userConfFrom}"), rntUserConfigFromTextField, org.jdesktop.beansbinding.BeanProperty.create("text"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, rntUserConfigCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), rntUserConfigFromTextField, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        jLabel64.setFont(new java.awt.Font("Lucida Sans", 0, 11));
        jLabel64.setText("by node type");

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, rntUserConfigCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), jLabel64, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        rntUserConfigToTextField.setFont(new java.awt.Font("Lucida Sans", 0, 11));

        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, this, org.jdesktop.beansbinding.ELProperty.create("${replaceNodeTypes.userConfTo}"), rntUserConfigToTextField, org.jdesktop.beansbinding.BeanProperty.create("text"));
        bindingGroup.addBinding(binding);
        binding = org.jdesktop.beansbinding.Bindings.createAutoBinding(org.jdesktop.beansbinding.AutoBinding.UpdateStrategy.READ_WRITE, rntUserConfigCheckBox, org.jdesktop.beansbinding.ELProperty.create("${selected}"), rntUserConfigToTextField, org.jdesktop.beansbinding.BeanProperty.create("enabled"));
        bindingGroup.addBinding(binding);

        org.jdesktop.layout.GroupLayout jPanel6Layout = new org.jdesktop.layout.GroupLayout(jPanel6);
        jPanel6.setLayout(jPanel6Layout);
        jPanel6Layout.setHorizontalGroup(
            jPanel6Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel6Layout.createSequentialGroup()
                .add(jPanel6Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(jPanel6Layout.createSequentialGroup()
                        .addContainerGap()
                        .add(rntUserConfigCheckBox))
                    .add(jPanel6Layout.createSequentialGroup()
                        .add(45, 45, 45)
                        .add(jPanel6Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                            .add(jPanel6Layout.createSequentialGroup()
                                .add(jLabel62)
                                .add(49, 49, 49)
                                .add(jSpinner21, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 73, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                            .add(jPanel6Layout.createSequentialGroup()
                                .add(jLabel63)
                                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                .add(rntUserConfigFromTextField, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 137, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                                .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                                .add(jLabel64)
                                .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                                .add(rntUserConfigToTextField, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 178, Short.MAX_VALUE)))))
                .addContainerGap())
        );
        jPanel6Layout.setVerticalGroup(
            jPanel6Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jPanel6Layout.createSequentialGroup()
                .addContainerGap()
                .add(rntUserConfigCheckBox)
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                .add(jPanel6Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel63)
                    .add(rntUserConfigFromTextField, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(jLabel64)
                    .add(rntUserConfigToTextField, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .add(18, 18, 18)
                .add(jPanel6Layout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel62)
                    .add(jSpinner21, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .addContainerGap(24, Short.MAX_VALUE))
        );

        org.jdesktop.layout.GroupLayout ReplaceNodesPaneLayout = new org.jdesktop.layout.GroupLayout(ReplaceNodesPane);
        ReplaceNodesPane.setLayout(ReplaceNodesPaneLayout);
        ReplaceNodesPaneLayout.setHorizontalGroup(
            ReplaceNodesPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(ReplaceNodesPaneLayout.createSequentialGroup()
                .addContainerGap()
                .add(ReplaceNodesPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                    .add(ReplaceNodesPaneLayout.createSequentialGroup()
                        .add(jPanel6, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addContainerGap())
                    .add(ReplaceNodesPaneLayout.createSequentialGroup()
                        .add(ReplaceNodesPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.TRAILING, false)
                            .add(org.jdesktop.layout.GroupLayout.LEADING, jPanel8, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                            .add(org.jdesktop.layout.GroupLayout.LEADING, jPanel7, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 589, Short.MAX_VALUE)
                            .add(org.jdesktop.layout.GroupLayout.LEADING, jPanel5, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 589, Short.MAX_VALUE)
                            .add(org.jdesktop.layout.GroupLayout.LEADING, ReplaceNodesPaneLayout.createSequentialGroup()
                                .add(ReplaceNodesPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                                    .add(jLabel36)
                                    .add(jLabel37))
                                .add(30, 30, 30)
                                .add(ReplaceNodesPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
                                    .add(ReplaceNodesPaneLayout.createSequentialGroup()
                                        .add(jTextField5, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 171, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                                        .add(rntTopologyInputFileSelectButton)
                                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                        .add(rntSetScriptPathButton)
                                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                                        .add(rntRunButton))
                                    .add(ReplaceNodesPaneLayout.createSequentialGroup()
                                        .add(jTextField6, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 171, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                                        .addPreferredGap(org.jdesktop.layout.LayoutStyle.UNRELATED)
                                        .add(rntTopologyOutputFileSelectButton)))))
                        .add(45, 45, 45))))
        );

        ReplaceNodesPaneLayout.linkSize(new java.awt.Component[] {jPanel5, jPanel6, jPanel7, jPanel8}, org.jdesktop.layout.GroupLayout.HORIZONTAL);

        ReplaceNodesPaneLayout.setVerticalGroup(
            ReplaceNodesPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(ReplaceNodesPaneLayout.createSequentialGroup()
                .addContainerGap()
                .add(ReplaceNodesPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel36)
                    .add(jTextField5, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(rntTopologyInputFileSelectButton, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 16, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(rntRunButton)
                    .add(rntSetScriptPathButton))
                .addPreferredGap(org.jdesktop.layout.LayoutStyle.RELATED)
                .add(ReplaceNodesPaneLayout.createParallelGroup(org.jdesktop.layout.GroupLayout.BASELINE)
                    .add(jLabel37)
                    .add(jTextField6, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                    .add(rntTopologyOutputFileSelectButton, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, 16, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE))
                .add(38, 38, 38)
                .add(jPanel5, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .add(18, 18, 18)
                .add(jPanel7, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .add(18, 18, 18)
                .add(jPanel8, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .add(18, 18, 18)
                .add(jPanel6, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(200, Short.MAX_VALUE))
        );

        ReplaceNodesPaneLayout.linkSize(new java.awt.Component[] {jPanel5, jPanel7, jPanel8}, org.jdesktop.layout.GroupLayout.VERTICAL);

        replaceNodeTypesPane.addTab("Replace Node Types", ReplaceNodesPane);

        jScrollPane1.setViewportView(replaceNodeTypesPane);

        org.jdesktop.layout.GroupLayout layout = new org.jdesktop.layout.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jScrollPane1, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, 777, Short.MAX_VALUE)
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(org.jdesktop.layout.GroupLayout.LEADING)
            .add(jScrollPane1, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, org.jdesktop.layout.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
        );

        bindingGroup.bind();

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void rntIDSCheckBoxActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_rntIDSCheckBoxActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_rntIDSCheckBoxActionPerformed

    private void rntUserConfigCheckBoxActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_rntUserConfigCheckBoxActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_rntUserConfigCheckBoxActionPerformed

    private void rntTopologyOutputFileSelectButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_rntTopologyOutputFileSelectButtonActionPerformed
        if(topologyInputOutputFileChooser.showOpenDialog(null) == JFileChooser.APPROVE_OPTION) {
            String selectedFile = new String(topologyInputOutputFileChooser.getSelectedFile().getPath());
            if (!selectedFile.endsWith(".ned")) {
                selectedFile = selectedFile.concat(".ned");
            }
            setRntTopologyOutputFilePath(selectedFile);
        }
        updateFileChooserOpenDir(topologyInputOutputFileChooser.getCurrentDirectory());
    }//GEN-LAST:event_rntTopologyOutputFileSelectButtonActionPerformed

    private void rntTopologyInputFileSelectButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_rntTopologyInputFileSelectButtonActionPerformed
        if(topologyInputOutputFileChooser.showOpenDialog(null) == JFileChooser.APPROVE_OPTION) {
            String selectedFile = new String(topologyInputOutputFileChooser.getSelectedFile().getPath());
            if (!selectedFile.endsWith(".ned")) {
                selectedFile = selectedFile.concat(".ned");
            }
            setRntTopologyInputFilePath(selectedFile);
        }
        updateFileChooserOpenDir(topologyInputOutputFileChooser.getCurrentDirectory());
}//GEN-LAST:event_rntTopologyInputFileSelectButtonActionPerformed

    private void rntRunButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_rntRunButtonActionPerformed
        if (applicationSettings.getRntScriptPath() == null) {
            if (JOptionPane.showConfirmDialog(null, "Please specify path to replaceNodeTypes.pl .", "Replace Node Types Script path not specified",
                    JOptionPane.OK_CANCEL_OPTION) == JOptionPane.CANCEL_OPTION) {
                return;
            }
            
            if (rntScriptPathChooser.showOpenDialog(null) != JFileChooser.APPROVE_OPTION) {
                return;
            }
            
            applicationSettings.setRntScriptPath(rntScriptPathChooser.getSelectedFile().getPath());
        }
        
        if(rntTopologyInputFilePath == null
                || rntTopologyOutputFilePath == null) {
            JOptionPane.showMessageDialog(null, "Please specify topology input and output file path.");
            return;
        }
        
        try {
            File tempTopology1 = File.createTempFile("topology", "1");
            File tempTopology2 = File.createTempFile("topology", "2");
            File tempTopology3 = File.createTempFile("topology", "3");
            
            String inputFile = rntTopologyInputFilePath;
            String outputFile = rntTopologyOutputFilePath;
            
            boolean outputFileCreated = false;
            
            if(replaceNodeTypes.isDDoSZombieEnabled() && replaceNodeTypes.getInetUserHost2DDoSZombie() > 0) {
                if(replaceNodeTypes.isWormHostEnabled() || replaceNodeTypes.isDistackIDSEnabled()
                        || replaceNodeTypes.isUserConfEnabled())                    
                    outputFile =  tempTopology1.getAbsolutePath();
                
                Process p1 = Runtime.getRuntime().exec(
                        applicationSettings.getRntScriptPath()
                        + " " + inputFile
                        + " " + outputFile
                        + " " + "InetUserHost"
                        + " " + "DDoSZombie"
                        + " " + replaceNodeTypes.getInetUserHost2DDoSZombie()
                        );
                
                // wait for end of runtime process and check if successfully returned or not
                checkProcessOutput(p1);
                outputFileCreated = true;
            }
            
            if(replaceNodeTypes.isWormHostEnabled() && replaceNodeTypes.getInetUserHost2WormHost() > 0) {
                // specify outfile
                if(replaceNodeTypes.isDDoSZombieEnabled()) {
                    if(replaceNodeTypes.isDistackIDSEnabled() || replaceNodeTypes.isUserConfEnabled())
                        outputFile = tempTopology2.getAbsolutePath();
                    else
                        outputFile =rntTopologyOutputFilePath;
                } else {
                    if(replaceNodeTypes.isDDoSZombieEnabled() || replaceNodeTypes.isUserConfEnabled())
                        outputFile = tempTopology1.getAbsolutePath();
                    else
                        outputFile =rntTopologyOutputFilePath;
                }
                // specify infile
                if(replaceNodeTypes.isDDoSZombieEnabled()) {
                    inputFile = tempTopology1.getAbsolutePath();
                } else {
                    inputFile = rntTopologyInputFilePath;
                }
                
                Process p2 = Runtime.getRuntime().exec(
                        applicationSettings.getRntScriptPath()
                        + " " + inputFile
                        + " " + outputFile
                        + " " + "InetUserHost"
                        + " " + "WormHost"
                        + " " + replaceNodeTypes.getInetUserHost2WormHost()
                        );
                
                checkProcessOutput(p2);
                outputFileCreated = true;
            }
            
            if(replaceNodeTypes.isDistackIDSEnabled() && replaceNodeTypes.getRouter2DistackIDS() > 0) {
                // specify outfile
                if(replaceNodeTypes.isDDoSZombieEnabled() && replaceNodeTypes.isWormHostEnabled()) {
                    if(replaceNodeTypes.isUserConfEnabled())
                        outputFile = tempTopology3.getAbsolutePath();
                    else
                        outputFile =rntTopologyOutputFilePath;
                } else if(replaceNodeTypes.isDDoSZombieEnabled() || replaceNodeTypes.isWormHostEnabled()) {
                    if(replaceNodeTypes.isUserConfEnabled())
                        outputFile = tempTopology2.getAbsolutePath();
                    else
                        outputFile =rntTopologyOutputFilePath;
                } else {
                    if(replaceNodeTypes.isWormHostEnabled() || replaceNodeTypes.isUserConfEnabled())
                        outputFile = tempTopology1.getAbsolutePath();
                    else
                        outputFile =rntTopologyOutputFilePath;                    
                }
                // specify infile
                if(replaceNodeTypes.isDDoSZombieEnabled() && replaceNodeTypes.isWormHostEnabled()) {
                    inputFile = tempTopology2.getAbsolutePath();
                } else if(replaceNodeTypes.isDDoSZombieEnabled() || replaceNodeTypes.isWormHostEnabled()) {
                    inputFile = tempTopology1.getAbsolutePath();
                } else {
                    inputFile = rntTopologyInputFilePath;
                }

                Process p3 = Runtime.getRuntime().exec(
                            applicationSettings.getRntScriptPath()
                            + " " + inputFile
                            + " " + outputFile
                            + " " + "Router"
                            + " " + "DistackOmnetIDS"
                            + " " + replaceNodeTypes.getRouter2DistackIDS()
                            );

                checkProcessOutput(p3);
                outputFileCreated = true;
            }
            
            if(replaceNodeTypes.isUserConfEnabled() && replaceNodeTypes.getUserConf2UserConf() > 0) {
                // specify outfile
                outputFile = rntTopologyOutputFilePath;
                // specify infile
                if(replaceNodeTypes.isDDoSZombieEnabled() && replaceNodeTypes.isWormHostEnabled()
                        && replaceNodeTypes.isDistackIDSEnabled()) {
                    inputFile = tempTopology3.getAbsolutePath();
                } else if(!replaceNodeTypes.isDDoSZombieEnabled() && replaceNodeTypes.isWormHostEnabled()
                        && replaceNodeTypes.isDistackIDSEnabled()) {
                    inputFile = tempTopology2.getAbsolutePath();
                } else if(replaceNodeTypes.isDDoSZombieEnabled() && !replaceNodeTypes.isWormHostEnabled()
                        && replaceNodeTypes.isDistackIDSEnabled()) {
                    inputFile = tempTopology2.getAbsolutePath();                    
                } else if(replaceNodeTypes.isDDoSZombieEnabled() && replaceNodeTypes.isWormHostEnabled()
                        && !replaceNodeTypes.isDistackIDSEnabled()) {
                    inputFile = tempTopology2.getAbsolutePath();                    
                } else if(replaceNodeTypes.isDDoSZombieEnabled() || replaceNodeTypes.isWormHostEnabled()
                        || replaceNodeTypes.isDistackIDSEnabled()) {
                    inputFile = tempTopology1.getAbsolutePath();
                } else {
                    inputFile = rntTopologyInputFilePath;
                }

                Process p4 = Runtime.getRuntime().exec(
                        applicationSettings.getRntScriptPath()
                        + " " + inputFile
                        + " " + outputFile
                        + " " + replaceNodeTypes.getUserConfFrom()
                        + " " + replaceNodeTypes.getUserConfTo()
                        + " " + replaceNodeTypes.getUserConf2UserConf()
                        );
                
                checkProcessOutput(p4);
                outputFileCreated = true;
            }
            
            tempTopology1.delete();
            tempTopology2.delete();
            tempTopology3.delete();
            
            if(outputFileCreated) {
                JOptionPane.showMessageDialog(null, "Node types replaced sucessfully.");
            } else {
                JOptionPane.showMessageDialog(null, "Nothing to do.. please check your settings.");
            }
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Replacing node types failed: " + e.getMessage());
        }
    }//GEN-LAST:event_rntRunButtonActionPerformed

    private void rntSetScriptPathButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_rntSetScriptPathButtonActionPerformed
        if(rntScriptPathChooser.showOpenDialog(null) == JFileChooser.APPROVE_OPTION) {
            getApplicationSettings().setRntScriptPath(rntScriptPathChooser.getSelectedFile().getPath());
        }
    }//GEN-LAST:event_rntSetScriptPathButtonActionPerformed

    private void ServerFractionSpinnerStateChanged(javax.swing.event.ChangeEvent evt) {//GEN-FIRST:event_ServerFractionSpinnerStateChanged
        if(serverSettings.getServerFraction() != 0) {
            jSpinner23.setEnabled(true);
            jSpinner24.setEnabled(true);
            jSpinner25.setEnabled(true);
            jSpinner26.setEnabled(true);
            jSpinner27.setEnabled(true);
            jSpinner28.setEnabled(true);
            jTextField7.setEnabled(true);
            if(serverSettings.getServerSum() != 100)
                jTextField7.setBackground(new Color(255,0,0));
            else
                jTextField7.setBackground(new Color(244,244,244));
        } else {
            jSpinner23.setEnabled(false);
            jSpinner24.setEnabled(false);
            jSpinner25.setEnabled(false);
            jSpinner26.setEnabled(false);
            jSpinner27.setEnabled(false);
            jSpinner28.setEnabled(false);
            jTextField7.setBackground(new Color(244,244,244));
            jTextField7.setEnabled(false);
        }
        serverSettingsChanged = true;
        
    }//GEN-LAST:event_ServerFractionSpinnerStateChanged

    private void serverSettingsSelectTopologyOutputFileButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_serverSettingsSelectTopologyOutputFileButtonActionPerformed
        if(topologyInputOutputFileChooser.showOpenDialog(null) != JFileChooser.APPROVE_OPTION) {
            return;
        }
        
        String selectedFile = new String(topologyInputOutputFileChooser.getSelectedFile().getPath());
        if (!selectedFile.endsWith(".ned")) {
            selectedFile = selectedFile.concat(".ned");
        }
        if (getRntTopologyInputFilePath() == null) {
            setRntTopologyInputFilePath(selectedFile);
        }
        
        setServerTopologyOutputFilePath(selectedFile);
        updateFileChooserOpenDir(topologyInputOutputFileChooser.getCurrentDirectory());
    }//GEN-LAST:event_serverSettingsSelectTopologyOutputFileButtonActionPerformed

    private void serverSettingsSelectTopologyInputFileButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_serverSettingsSelectTopologyInputFileButtonActionPerformed
        if(topologyInputOutputFileChooser.showOpenDialog(null) == JFileChooser.APPROVE_OPTION) {
            String selectedFile = new String(topologyInputOutputFileChooser.getSelectedFile().getPath());
            if (!selectedFile.endsWith(".ned")) {
                selectedFile = selectedFile.concat(".ned");
            }
            setServerTopologyInputFilePath(selectedFile);
        }
        updateFileChooserOpenDir(topologyInputOutputFileChooser.getCurrentDirectory());
    }//GEN-LAST:event_serverSettingsSelectTopologyInputFileButtonActionPerformed

    private void serverSettingsSetScriptPathButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_serverSettingsSetScriptPathButtonActionPerformed
        if(serverScriptChooser.showOpenDialog(null) == JFileChooser.APPROVE_OPTION) {
            applicationSettings.setServerScriptPath(serverScriptChooser.getSelectedFile().getPath());
        }
    }//GEN-LAST:event_serverSettingsSetScriptPathButtonActionPerformed

    private void serverSettingsRunButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_serverSettingsRunButtonActionPerformed
        if (applicationSettings.getServerScriptPath() == null) {
            if (JOptionPane.showConfirmDialog(null, "Please specify path to setServer.pl", "setServer.pl path not specified",
                    JOptionPane.OK_CANCEL_OPTION) == JOptionPane.CANCEL_OPTION) {
                return;
            }
            
            if (serverScriptChooser.showOpenDialog(null) != JFileChooser.APPROVE_OPTION) {
                return;
            }
            
            applicationSettings.setServerScriptPath(serverScriptChooser.getSelectedFile().getPath());
        }
        
        if (serverTopologyInputFilePath == null
                ||  serverTopologyOutputFilePath == null) {
            JOptionPane.showMessageDialog(null, "Please specify input and output topology files before running.");
            return;
        }
        
        if(serverSettingsFilePath == null) {
            JOptionPane.showMessageDialog(null, "Please save server settings file before running.");
            return;
        }
        
        if(serverSettingsChanged){
            saveServerSettingsFile(new File(serverSettingsFilePath));
        }
        
        if (getRntTopologyInputFilePath() == null ||
                getServerTopologyOutputFilePath().compareTo(getRntTopologyInputFilePath()) != 0) {
            setRntTopologyInputFilePath(getServerTopologyOutputFilePath());
        }
        
        try {
            Process p = Runtime.getRuntime().exec(
                    applicationSettings.getServerScriptPath() + " "
                    + serverSettingsFilePath +  " "
                    + serverTopologyInputFilePath + " "
                    + serverTopologyOutputFilePath);
            
            checkProcessOutput(p);
            
            JOptionPane.showMessageDialog(null, "Server settings set sucessfully.");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Failed setting server settings: " + e.getMessage());
        }
    }//GEN-LAST:event_serverSettingsRunButtonActionPerformed

    private void serverSettingsDefaultButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_serverSettingsDefaultButtonActionPerformed
        setServerSettings(ServerSettings.createDefaultServerSettings());
        serverSettingsChanged = true;
    }//GEN-LAST:event_serverSettingsDefaultButtonActionPerformed

    private void jSpinner29StateChanged(javax.swing.event.ChangeEvent evt) {//GEN-FIRST:event_jSpinner29StateChanged
        if(serverSettings.getRouterSum() != 100 && serverSettings.getRouterFraction() != 0)
            jTextField8.setBackground(new Color(255,0,0));
        else
            jTextField8.setBackground(new Color(244,244,244));
        serverSettingsChanged = true;
    }//GEN-LAST:event_jSpinner29StateChanged

    private void RouterFractionSpinnerStateChanged(javax.swing.event.ChangeEvent evt) {//GEN-FIRST:event_RouterFractionSpinnerStateChanged
        if(serverSettings.getRouterFraction() != 0) {
            jSpinner29.setEnabled(true);
            jTextField8.setEnabled(true);
            if(serverSettings.getServerSum() != 100)
                jTextField8.setBackground(new Color(255,0,0));
            else
                jTextField8.setBackground(new Color(244,244,244));
        } else {
            jSpinner29.setEnabled(false);
            jTextField8.setBackground(new Color(244,244,244));
            jTextField8.setEnabled(false);
        }
        serverSettingsChanged = true;
    }//GEN-LAST:event_RouterFractionSpinnerStateChanged

    private void jSpinner28StateChanged(javax.swing.event.ChangeEvent evt) {//GEN-FIRST:event_jSpinner28StateChanged
        if(serverSettings.getServerSum() != 100 && serverSettings.getServerFraction() != 0)
            jTextField7.setBackground(new Color(255,0,0));
        else
            jTextField7.setBackground(new Color(244,244,244));
        serverSettingsChanged = true;
    }//GEN-LAST:event_jSpinner28StateChanged

    private void jSpinner27StateChanged(javax.swing.event.ChangeEvent evt) {//GEN-FIRST:event_jSpinner27StateChanged
        if(serverSettings.getServerSum() != 100 && serverSettings.getServerFraction() != 0)
            jTextField7.setBackground(new Color(255,0,0));
        else
            jTextField7.setBackground(new Color(244,244,244));
        serverSettingsChanged = true;
    }//GEN-LAST:event_jSpinner27StateChanged

    private void jSpinner26StateChanged(javax.swing.event.ChangeEvent evt) {//GEN-FIRST:event_jSpinner26StateChanged
        if(serverSettings.getServerSum() != 100 && serverSettings.getServerFraction() != 0)
            jTextField7.setBackground(new Color(255,0,0));
        else
            jTextField7.setBackground(new Color(244,244,244));
        serverSettingsChanged = true;
    }//GEN-LAST:event_jSpinner26StateChanged

    private void jSpinner25StateChanged(javax.swing.event.ChangeEvent evt) {//GEN-FIRST:event_jSpinner25StateChanged
        if(serverSettings.getServerSum() != 100 && serverSettings.getServerFraction() != 0)
            jTextField7.setBackground(new Color(255,0,0));
        else
            jTextField7.setBackground(new Color(244,244,244));
        serverSettingsChanged = true;
    }//GEN-LAST:event_jSpinner25StateChanged

    private void jSpinner24StateChanged(javax.swing.event.ChangeEvent evt) {//GEN-FIRST:event_jSpinner24StateChanged
        if(serverSettings.getServerSum() != 100 && serverSettings.getServerFraction() != 0)
            jTextField7.setBackground(new Color(255,0,0));
        else
            jTextField7.setBackground(new Color(244,244,244));
        serverSettingsChanged = true;
    }//GEN-LAST:event_jSpinner24StateChanged

    private void jSpinner23StateChanged(javax.swing.event.ChangeEvent evt) {//GEN-FIRST:event_jSpinner23StateChanged
        if(serverSettings.getServerSum() != 100 && serverSettings.getServerFraction() != 0)
            jTextField7.setBackground(new Color(255,0,0));
        else
            jTextField7.setBackground(new Color(244,244,244));
        serverSettingsChanged = true;
    }//GEN-LAST:event_jSpinner23StateChanged

    private void serverSettingsChanged(javax.swing.event.ChangeEvent evt) {//GEN-FIRST:event_serverSettingsChanged
        serverSettingsChanged = true;
    }//GEN-LAST:event_serverSettingsChanged

    private void serverSettingsSaveButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_serverSettingsSaveButtonActionPerformed
        if (serverSettingsChooser.showSaveDialog(null) == JFileChooser.APPROVE_OPTION) {
            saveServerSettingsFile(serverSettingsChooser.getSelectedFile());
             serverSettingsChanged = false;
        }
        updateFileChooserOpenDir(serverSettingsChooser.getCurrentDirectory());
    }//GEN-LAST:event_serverSettingsSaveButtonActionPerformed

    private void serverSettingsLoadButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_serverSettingsLoadButtonActionPerformed
        if (serverSettingsChooser.showOpenDialog(null) == JFileChooser.APPROVE_OPTION) {
            loadServerSettingsFile(serverSettingsChooser.getSelectedFile());
        }
        updateFileChooserOpenDir(serverSettingsChooser.getCurrentDirectory());
    }//GEN-LAST:event_serverSettingsLoadButtonActionPerformed

    private void trafficProfileSaveButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_trafficProfileSaveButtonActionPerformed
        if (trafficFileChooser.showSaveDialog(null) == JFileChooser.APPROVE_OPTION) {
            saveTrafficSettingsFile(trafficFileChooser.getSelectedFile());
        }
        updateFileChooserOpenDir(trafficFileChooser.getCurrentDirectory());
    }//GEN-LAST:event_trafficProfileSaveButtonActionPerformed

    private void trafficProfileLoadButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_trafficProfileLoadButtonActionPerformed
        if (trafficFileChooser.showOpenDialog(null) == JFileChooser.APPROVE_OPTION) {
            loadTrafficSettingsFile(trafficFileChooser.getSelectedFile());
        }
        updateFileChooserOpenDir(trafficFileChooser.getCurrentDirectory());
    }//GEN-LAST:event_trafficProfileLoadButtonActionPerformed

    private void topologyChanged(javax.swing.event.ChangeEvent evt) {//GEN-FIRST:event_topologyChanged
        topologyHasChanged = true;
    }//GEN-LAST:event_topologyChanged

    private void libraryPathSelectButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_libraryPathSelectButtonActionPerformed
        if (libraryPathChooser.showOpenDialog(null) == JFileChooser.APPROVE_OPTION) {
            applicationSettings.setLibraryPath(libraryPathChooser.getSelectedFile().getPath());
        }
    }//GEN-LAST:event_libraryPathSelectButtonActionPerformed

    private void topologyDefaultButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_topologyDefaultButtonActionPerformed
        setTopologyParameters(TopologyParameters.createDefaultTopologyParameters());
        topologyHasChanged = true;
    }//GEN-LAST:event_topologyDefaultButtonActionPerformed

    private void topologySelectPathButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_topologySelectPathButtonActionPerformed
        if (tgmPathChooser.showOpenDialog(null) != JFileChooser.APPROVE_OPTION) {
            return;
        }
        
        applicationSettings.setTgmPath(tgmPathChooser.getSelectedFile().getPath());
    }//GEN-LAST:event_topologySelectPathButtonActionPerformed

    private void miscStatsPrefixCheckBoxActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_miscStatsPrefixCheckBoxActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_miscStatsPrefixCheckBoxActionPerformed

    private void miscOutputFileSelectButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_miscOutputFileSelectButtonActionPerformed
        if (outputFileChooser.showOpenDialog(null) != JFileChooser.APPROVE_OPTION) {
            return;
        }
        
        String selectedFile = new String(outputFileChooser.getSelectedFile().getPath());
        if (!selectedFile.endsWith(".ned")) {
            selectedFile = selectedFile.concat(".ned");
        }
       
        topologyParameters.setTopologyFile(selectedFile);
        updateFileChooserOpenDir(outputFileChooser.getCurrentDirectory());
    
        if (getServerTopologyInputFilePath() == null || 
                topologyParameters.getTopologyFile().compareTo(getServerTopologyInputFilePath()) != 0) {
            setServerTopologyInputFilePath(selectedFile);
        }    
    }//GEN-LAST:event_miscOutputFileSelectButtonActionPerformed

    private void topologyRunButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_topologyRunButtonActionPerformed
        if (applicationSettings.getTgmPath() == null) {
            if (JOptionPane.showConfirmDialog(null, "Please specify path to TGM.", "TGM path not specified",
                    JOptionPane.OK_CANCEL_OPTION) == JOptionPane.CANCEL_OPTION) {
                return;
            }
            
            if (tgmPathChooser.showOpenDialog(null) != JFileChooser.APPROVE_OPTION) {
                return;
            }
            
            applicationSettings.setTgmPath(tgmPathChooser.getSelectedFile().getPath());
        }
        
        if (topologyParameterFilePath == null) {
            if (JOptionPane.showConfirmDialog(null, "Please save file.", "File not saved",
                    JOptionPane.OK_CANCEL_OPTION) == JOptionPane.CANCEL_OPTION) {
                return;
            }
            
            if (fileChooser.showSaveDialog(null) != JFileChooser.APPROVE_OPTION) {
                return;
            }
            
            saveTopologyParameterFile(fileChooser.getSelectedFile());
            updateFileChooserOpenDir(fileChooser.getCurrentDirectory());
        }
        
        if(topologyHasChanged){
            saveTopologyParameterFile(new File(topologyParameterFilePath));
        
        }
        
        if (getServerTopologyInputFilePath() == null ||
                topologyParameters.getTopologyFile().compareTo(getServerTopologyInputFilePath()) != 0) {
            setServerTopologyInputFilePath(topologyParameters.getTopologyFile());
        }
        
        int i=0, j=0;
        try {
            Process p = null;

                if (libraryPathCheckBox.isSelected()) {
                p = Runtime.getRuntime().exec(
                        applicationSettings.getTgmPath() + " " + topologyParameterFilePath,
                        new String[]{"LD_LIBRARY_PATH=$LD_LIBRARY_PATH;" + libraryPath.getText()});
            } else {
                p = Runtime.getRuntime().exec(
                        applicationSettings.getTgmPath() + " " + topologyParameterFilePath);
            }
            checkProcessOutput(p);
            
            JOptionPane.showMessageDialog(null, "Topology generation succedded.");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Topology generation failed: " + e.getMessage());
        }
    }//GEN-LAST:event_topologyRunButtonActionPerformed

    private void topologySaveButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_topologySaveButtonActionPerformed
        if (fileChooser.showSaveDialog(null) != JFileChooser.APPROVE_OPTION) {
            return;
        }
        saveTopologyParameterFile(fileChooser.getSelectedFile());
        updateFileChooserOpenDir(fileChooser.getCurrentDirectory());
        topologyHasChanged = false;
    }//GEN-LAST:event_topologySaveButtonActionPerformed

    private void topologyLoadButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_topologyLoadButtonActionPerformed
        if (fileChooser.showOpenDialog(null) != JFileChooser.APPROVE_OPTION) {
            return;
        }
        loadTopologyParameterFile(fileChooser.getSelectedFile());
        updateFileChooserOpenDir(fileChooser.getCurrentDirectory());
    }//GEN-LAST:event_topologyLoadButtonActionPerformed

    private void rntWormHostCheckBoxKeyPressed(java.awt.event.KeyEvent evt) {//GEN-FIRST:event_rntWormHostCheckBoxKeyPressed
        // TODO add your handling code here:
    }//GEN-LAST:event_rntWormHostCheckBoxKeyPressed

    private void replaceNodeTypeChanged(javax.swing.event.ChangeEvent evt) {//GEN-FIRST:event_replaceNodeTypeChanged
        rntChanged = true;
    }//GEN-LAST:event_replaceNodeTypeChanged

private void jTextField5ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jTextField5ActionPerformed
// TODO add your handling code here:
}//GEN-LAST:event_jTextField5ActionPerformed

private void latencyCheckBoxActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_latencyCheckBoxActionPerformed
    // TODO add your handling code here:
}//GEN-LAST:event_latencyCheckBoxActionPerformed


    private void checkProcessOutput(Process p)
            throws Exception
    {

            InputStreamReader streamReader = new InputStreamReader(p.getErrorStream());
            BufferedReader reader = new BufferedReader(streamReader);
            String message = new String();
            String line;
            while ((line = reader.readLine()) != null)
            {
                message += line + "\n\r";
            }

            streamReader = new InputStreamReader(p.getInputStream());
            reader = new BufferedReader(streamReader);
            while ((line = reader.readLine()) != null)
            {
                message += line + "\n\r";
            }
            
            int i = p.waitFor();

            if (i != 0)
            throw new Exception(message);
//        }
    }
    /**
     * @param args the command line arguments
     */
    public static void main(String args[])
    {
        java.awt.EventQueue.invokeLater(new Runnable()
        {

            public void run()
            {
                new MainForm().setVisible(true);
            }
        });
    }
    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JSpinner HopLimit;
    private javax.swing.JTextField Label;
    private javax.swing.JSpinner Port;
    private javax.swing.JPanel ReplaceNodesPane;
    private javax.swing.JSpinner ReplayLength;
    private javax.swing.JSpinner RepliesPerRequest;
    private javax.swing.JSpinner RequestLength;
    private javax.swing.JSpinner RequestsPerFlow;
    private javax.swing.JSpinner RouterFractionSpinner;
    private javax.swing.JSpinner SelectionProb;
    private javax.swing.JSpinner ServerFractionSpinner;
    private javax.swing.JSpinner TimeBetweenFlows;
    private javax.swing.JSpinner TimeBetweenRequests;
    private javax.swing.JSpinner TimeToRespond;
    private javax.swing.JSpinner WANProb;
    private javax.swing.JCheckBox asLevelCheckBox;
    private javax.swing.JPanel asLevelPanel;
    private javax.swing.JSpinner asNodes;
    private javax.swing.JLabel asNodesLabel;
    private javax.swing.JSpinner asParameterDelta;
    private javax.swing.JLabel asParameterDeltaLabel;
    private javax.swing.JSpinner asParameterP;
    private javax.swing.JLabel asParameterPLabel;
    private javax.swing.JSpinner asTransitNodeThresh;
    private javax.swing.JLabel asTransitNodeThreshLabel;
    private javax.swing.JCheckBox hoplimitCheckBox;
    private javax.swing.JCheckBox jCheckBox1;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel10;
    private javax.swing.JLabel jLabel11;
    private javax.swing.JLabel jLabel12;
    private javax.swing.JLabel jLabel13;
    private javax.swing.JLabel jLabel14;
    private javax.swing.JLabel jLabel15;
    private javax.swing.JLabel jLabel16;
    private javax.swing.JLabel jLabel17;
    private javax.swing.JLabel jLabel18;
    private javax.swing.JLabel jLabel19;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel20;
    private javax.swing.JLabel jLabel21;
    private javax.swing.JLabel jLabel22;
    private javax.swing.JLabel jLabel23;
    private javax.swing.JLabel jLabel24;
    private javax.swing.JLabel jLabel25;
    private javax.swing.JLabel jLabel26;
    private javax.swing.JLabel jLabel27;
    private javax.swing.JLabel jLabel28;
    private javax.swing.JLabel jLabel29;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JLabel jLabel30;
    private javax.swing.JLabel jLabel31;
    private javax.swing.JLabel jLabel32;
    private javax.swing.JLabel jLabel33;
    private javax.swing.JLabel jLabel34;
    private javax.swing.JLabel jLabel35;
    private javax.swing.JLabel jLabel36;
    private javax.swing.JLabel jLabel37;
    private javax.swing.JLabel jLabel38;
    private javax.swing.JLabel jLabel39;
    private javax.swing.JLabel jLabel4;
    private javax.swing.JLabel jLabel40;
    private javax.swing.JLabel jLabel41;
    private javax.swing.JLabel jLabel42;
    private javax.swing.JLabel jLabel43;
    private javax.swing.JLabel jLabel44;
    private javax.swing.JLabel jLabel45;
    private javax.swing.JLabel jLabel46;
    private javax.swing.JLabel jLabel47;
    private javax.swing.JLabel jLabel48;
    private javax.swing.JLabel jLabel49;
    private javax.swing.JLabel jLabel5;
    private javax.swing.JLabel jLabel50;
    private javax.swing.JLabel jLabel51;
    private javax.swing.JLabel jLabel52;
    private javax.swing.JLabel jLabel53;
    private javax.swing.JLabel jLabel54;
    private javax.swing.JLabel jLabel55;
    private javax.swing.JLabel jLabel56;
    private javax.swing.JLabel jLabel57;
    private javax.swing.JLabel jLabel58;
    private javax.swing.JLabel jLabel59;
    private javax.swing.JLabel jLabel6;
    private javax.swing.JLabel jLabel60;
    private javax.swing.JLabel jLabel61;
    private javax.swing.JLabel jLabel62;
    private javax.swing.JLabel jLabel63;
    private javax.swing.JLabel jLabel64;
    private javax.swing.JLabel jLabel65;
    private javax.swing.JLabel jLabel66;
    private javax.swing.JLabel jLabel67;
    private javax.swing.JLabel jLabel68;
    private javax.swing.JLabel jLabel69;
    private javax.swing.JLabel jLabel7;
    private javax.swing.JLabel jLabel70;
    private javax.swing.JLabel jLabel71;
    private javax.swing.JLabel jLabel72;
    private javax.swing.JLabel jLabel73;
    private javax.swing.JLabel jLabel74;
    private javax.swing.JLabel jLabel75;
    private javax.swing.JLabel jLabel76;
    private javax.swing.JLabel jLabel77;
    private javax.swing.JLabel jLabel78;
    private javax.swing.JLabel jLabel79;
    private javax.swing.JLabel jLabel8;
    private javax.swing.JLabel jLabel80;
    private javax.swing.JLabel jLabel81;
    private javax.swing.JLabel jLabel82;
    private javax.swing.JLabel jLabel9;
    private javax.swing.JPanel jPanel1;
    private javax.swing.JPanel jPanel2;
    private javax.swing.JPanel jPanel3;
    private javax.swing.JPanel jPanel4;
    private javax.swing.JPanel jPanel5;
    private javax.swing.JPanel jPanel6;
    private javax.swing.JPanel jPanel7;
    private javax.swing.JPanel jPanel8;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JSeparator jSeparator1;
    private javax.swing.JSeparator jSeparator2;
    private javax.swing.JSeparator jSeparator3;
    private javax.swing.JSeparator jSeparator4;
    private javax.swing.JSpinner jSpinner12;
    private javax.swing.JSpinner jSpinner13;
    private javax.swing.JSpinner jSpinner14;
    private javax.swing.JSpinner jSpinner15;
    private javax.swing.JSpinner jSpinner16;
    private javax.swing.JSpinner jSpinner17;
    private javax.swing.JSpinner jSpinner18;
    private javax.swing.JSpinner jSpinner19;
    private javax.swing.JSpinner jSpinner20;
    private javax.swing.JSpinner jSpinner21;
    private javax.swing.JSpinner jSpinner22;
    private javax.swing.JSpinner jSpinner23;
    private javax.swing.JSpinner jSpinner24;
    private javax.swing.JSpinner jSpinner25;
    private javax.swing.JSpinner jSpinner26;
    private javax.swing.JSpinner jSpinner27;
    private javax.swing.JSpinner jSpinner28;
    private javax.swing.JSpinner jSpinner29;
    private javax.swing.JSpinner jSpinner30;
    private javax.swing.JSpinner jSpinner31;
    private javax.swing.JSpinner jSpinner32;
    private javax.swing.JSpinner jSpinner33;
    private javax.swing.JSpinner jSpinner34;
    private javax.swing.JSpinner jSpinner35;
    private javax.swing.JSpinner jSpinner36;
    private javax.swing.JSpinner jSpinner37;
    private javax.swing.JSpinner jSpinner38;
    private javax.swing.JSpinner jSpinner39;
    private javax.swing.JSpinner jSpinner40;
    private javax.swing.JTextField jTextField2;
    private javax.swing.JTextField jTextField3;
    private javax.swing.JTextField jTextField4;
    private javax.swing.JTextField jTextField5;
    private javax.swing.JTextField jTextField6;
    private javax.swing.JTextField jTextField7;
    private javax.swing.JTextField jTextField8;
    private javax.swing.JCheckBox latencyCheckBox;
    private javax.swing.JTextField libraryPath;
    private javax.swing.JCheckBox libraryPathCheckBox;
    private javax.swing.JButton libraryPathSelectButton;
    private javax.swing.JLabel miscLabel;
    private javax.swing.JTextField miscOutputFile;
    private javax.swing.JLabel miscOutputFileLabel;
    private javax.swing.JButton miscOutputFileSelectButton;
    private javax.swing.JPanel miscPanel;
    private javax.swing.JCheckBox miscStatsPrefixCheckBox;
    private javax.swing.JTextField miscStatsPrefixTextField;
    private javax.swing.JCheckBox portCheckBox;
    private javax.swing.JSpinner profileId;
    private javax.swing.JLabel profileIdLabel;
    private javax.swing.JTabbedPane replaceNodeTypesPane;
    private javax.swing.JCheckBox rntDDoSZombieCheckBox;
    private javax.swing.JCheckBox rntIDSCheckBox;
    private javax.swing.JButton rntRunButton;
    private javax.swing.JButton rntSetScriptPathButton;
    private javax.swing.JButton rntTopologyInputFileSelectButton;
    private javax.swing.JButton rntTopologyOutputFileSelectButton;
    private javax.swing.JCheckBox rntUserConfigCheckBox;
    private javax.swing.JTextField rntUserConfigFromTextField;
    private javax.swing.JTextField rntUserConfigToTextField;
    private javax.swing.JCheckBox rntWormHostCheckBox;
    private javax.swing.JSpinner routerCoreCrossLinkRatio;
    private javax.swing.JLabel routerCoreCrossLinkRatioLabel;
    private javax.swing.JSpinner routerCoreRatio;
    private javax.swing.JLabel routerCoreRatioLabel;
    private javax.swing.JCheckBox routerLevelCheckBox;
    private javax.swing.JPanel routerLevelPanel;
    private javax.swing.JSpinner routerMaxHostsPerEdge;
    private javax.swing.JLabel routerMaxHostsPerEdgeLabel;
    private javax.swing.JSpinner routerMaxNodes;
    private javax.swing.JSpinner routerMinHostsPerEdge;
    private javax.swing.JLabel routerMinHostsPerEdgeLabel;
    private javax.swing.JSpinner routerMinNodes;
    private javax.swing.JLabel routerNodesMaxLabel;
    private javax.swing.JLabel routerNodesMinLabel;
    private javax.swing.JButton serverSettingsDefaultButton;
    private javax.swing.JButton serverSettingsLoadButton;
    private javax.swing.JPanel serverSettingsPane;
    private javax.swing.JButton serverSettingsRunButton;
    private javax.swing.JButton serverSettingsSaveButton;
    private javax.swing.JButton serverSettingsSelectTopologyInputFileButton;
    private javax.swing.JButton serverSettingsSelectTopologyOutputFileButton;
    private javax.swing.JButton serverSettingsSetScriptPathButton;
    private javax.swing.JButton topologyDefaultButton;
    private javax.swing.JTextField topologyFileNameLabel;
    private javax.swing.JButton topologyLoadButton;
    private javax.swing.JPanel topologyPanel;
    private javax.swing.JButton topologyRunButton;
    private javax.swing.JButton topologySaveButton;
    private javax.swing.JButton topologySelectPathButton;
    private javax.swing.JTextField trafficProfileFile;
    private javax.swing.JLabel trafficProfileFileLabel;
    private javax.swing.JButton trafficProfileLoadButton;
    private javax.swing.JButton trafficProfileSaveButton;
    private javax.swing.JLabel trafficProfilesLabel;
    private javax.swing.JList trafficProfilesListControl;
    private javax.swing.JPanel trafficProfilesPane;
    private javax.swing.JScrollPane trafficProfilesScrollPane;
    private org.jdesktop.beansbinding.BindingGroup bindingGroup;
    // End of variables declaration//GEN-END:variables
}
