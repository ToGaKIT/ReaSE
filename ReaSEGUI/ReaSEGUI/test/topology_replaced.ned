//--package declaration here--

import rease.nodes.inet.DDoSZombie;
import inet.nodes.inet.Router;
import rease.nodes.inet.InetUserHost;
import rease.nodes.inet.BackupServer;
import rease.nodes.inet.NameServer;
import rease.nodes.inet.InteractiveServer;
import rease.nodes.inet.MailServer;
import rease.nodes.inet.WebServer;
import rease.nodes.inet.StreamingServer;
import rease.nodes.inet.TraceRouter;
import rease.base.ConnectionManager;
import rease.base.TrafficProfileManager;
import rease.networklayer.autorouting.TGMNetworkConfigurator;

channel server2edge extends ned.DatarateChannel
{
	parameters:
		delay = 1us;
		datarate = 10Mbps;
}

channel host2edge extends ned.DatarateChannel
{
	parameters:
		delay = 1us;
		datarate = 0.128Mbps;
}
channel edge2host extends ned.DatarateChannel
{
	parameters:
		delay = 1us;
		datarate = 0.768Mbps;
}
channel edge2gateway extends ned.DatarateChannel
{
	parameters:
		delay = 1us;
		datarate = 155Mbps;
}
channel gateway2core extends ned.DatarateChannel
{
	parameters:
		delay = 1us;
		datarate = 1000Mbps;
}
channel core2core extends ned.DatarateChannel
{
	parameters:
		delay = 1us;
		datarate = 2500Mbps;
}
channel stub2stub extends ned.DatarateChannel
{
	parameters:
		delay = 1us;
		datarate = 5000Mbps;
}
channel stub2transit extends ned.DatarateChannel
{
	parameters:
		delay = 1us;
		datarate = 5000Mbps;
}
channel transit2transit extends ned.DatarateChannel
{
	parameters:
		delay = 1us;
		datarate = 10000Mbps;
}

module Internet
{
	parameters:
		@Internet();
	submodules:
		tgmNetworkConfigurator: TGMNetworkConfigurator {
			parameters:
				totalCountOfAS = 10;
				@display("p=20,20;i=abstract/table_s");
		}
		connectionManager: ConnectionManager {
			parameters:
				@display("p=60,20;i=block/classifier_s");
		}
		trafficProfileManager: TrafficProfileManager {
			parameters:
				@display("p=100,20;i=block/cogwheel_s");
		}

		sas0: SAS0 {
			parameters:
				@AS();
				@display("i=misc/cloud_s");
		}
		tas1: TAS1 {
			parameters:
				@AS();
				@display("i=misc/globe_s");
		}
		tas2: TAS2 {
			parameters:
				@AS();
				@display("i=misc/globe_s");
		}
		tas3: TAS3 {
			parameters:
				@AS();
				@display("i=misc/globe_s");
		}
		tas4: TAS4 {
			parameters:
				@AS();
				@display("i=misc/globe_s");
		}
		sas5: SAS5 {
			parameters:
				@AS();
				@display("i=misc/cloud_s");
		}
		sas6: SAS6 {
			parameters:
				@AS();
				@display("i=misc/cloud_s");
		}
		sas7: SAS7 {
			parameters:
				@AS();
				@display("i=misc/cloud_s");
		}
		sas8: SAS8 {
			parameters:
				@AS();
				@display("i=misc/cloud_s");
		}
		sas9: SAS9 {
			parameters:
				@AS();
				@display("i=misc/cloud_s");
		}

	connections:
		sas0.pppg++ <--> stub2transit <--> tas1.pppg++;
		sas0.pppg++ <--> stub2transit <--> tas2.pppg++;
		tas1.pppg++ <--> transit2transit <--> tas2.pppg++;
		tas1.pppg++ <--> transit2transit <--> tas4.pppg++;
		tas1.pppg++ <--> transit2transit <--> tas3.pppg++;
		tas1.pppg++ <--> stub2transit <--> sas8.pppg++;
		tas2.pppg++ <--> transit2transit <--> tas3.pppg++;
		tas2.pppg++ <--> stub2transit <--> sas7.pppg++;
		tas2.pppg++ <--> stub2transit <--> sas9.pppg++;
		tas3.pppg++ <--> stub2transit <--> sas5.pppg++;
		tas3.pppg++ <--> transit2transit <--> tas4.pppg++;
		tas4.pppg++ <--> stub2transit <--> sas6.pppg++;
		sas5.pppg++ <--> stub2stub <--> sas7.pppg++;
		sas6.pppg++ <--> stub2stub <--> sas8.pppg++;
		sas6.pppg++ <--> stub2stub <--> sas7.pppg++;

}

network Inet extends Internet
{
	parameters:
}

module SAS0
{
	gates:
		inout pppg[];
	submodules:
		connectionManager: ConnectionManager {
			parameters:
				@display("p=20,20;i=block/classifier_s");
		}

		core0: Router {
			parameters:
				@RL();
				@CoreRouter();
				@display("i=abstract/switch");
		}
		gw1: Router {
			parameters:
				@RL();
				@display("i=abstract/router2");
		}
		gw2: Router {
			parameters:
				@RL();
				@display("i=abstract/router2");
		}
		edge3: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge4: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge5: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge6: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge7: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge8: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge9: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge10: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge11: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge12: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		host_DDoSZombie13: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host14: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie15: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie20: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie21: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_InteractiveServer22: InteractiveServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie24: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer25: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie41: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host42: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host44: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host47: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host48: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host49: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie50: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_MailServer51: MailServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host52: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer53: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie54: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host55: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host56: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host57: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_InteractiveServer58: InteractiveServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host59: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host60: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer61: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host62: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host63: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host64: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host65: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host66: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host67: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie68: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host69: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host70: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host71: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host72: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host73: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host74: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer75: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host76: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host77: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host78: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_MailServer79: MailServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host80: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host81: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host82: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie83: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host84: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host85: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host86: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie87: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host88: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host89: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host90: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host91: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host92: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host93: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}

	connections:
		pppg++ <--> core0.pppg++;
		pppg++ <--> core0.pppg++;

		core0.pppg++ <--> gateway2core <--> gw1.pppg++;
		core0.pppg++ <--> gateway2core <--> gw2.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge3.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge4.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge5.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge6.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge7.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge8.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge9.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge10.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge11.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge12.pppg++;
		host_DDoSZombie13.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host_DDoSZombie13.pppg$i++;
		host14.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host14.pppg$i++;
		host_DDoSZombie15.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host_DDoSZombie15.pppg$i++;
		host16.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host16.pppg$i++;
		host17.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host17.pppg$i++;
		host18.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host18.pppg$i++;
		host19.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host19.pppg$i++;
		host_DDoSZombie20.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host_DDoSZombie20.pppg$i++;
		host_DDoSZombie21.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host_DDoSZombie21.pppg$i++;
		host_InteractiveServer22.pppg$o++ --> server2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> server2edge --> host_InteractiveServer22.pppg$i++;
		host23.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host23.pppg$i++;
		host_DDoSZombie24.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host_DDoSZombie24.pppg$i++;
		host_WebServer25.pppg$o++ --> server2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> server2edge --> host_WebServer25.pppg$i++;
		host26.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host26.pppg$i++;
		host27.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host27.pppg$i++;
		host28.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host28.pppg$i++;
		host29.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host29.pppg$i++;
		host30.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host30.pppg$i++;
		host31.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host31.pppg$i++;
		host32.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host32.pppg$i++;
		host33.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host33.pppg$i++;
		host34.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host34.pppg$i++;
		host35.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host35.pppg$i++;
		host36.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host36.pppg$i++;
		host37.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host37.pppg$i++;
		host38.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host38.pppg$i++;
		host39.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host39.pppg$i++;
		host40.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host40.pppg$i++;
		host_DDoSZombie41.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host_DDoSZombie41.pppg$i++;
		host42.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host42.pppg$i++;
		host43.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host43.pppg$i++;
		host44.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host44.pppg$i++;
		host45.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host45.pppg$i++;
		host46.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host46.pppg$i++;
		host47.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host47.pppg$i++;
		host48.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host48.pppg$i++;
		host49.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host49.pppg$i++;
		host_DDoSZombie50.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host_DDoSZombie50.pppg$i++;
		host_MailServer51.pppg$o++ --> server2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> server2edge --> host_MailServer51.pppg$i++;
		host52.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host52.pppg$i++;
		host_WebServer53.pppg$o++ --> server2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> server2edge --> host_WebServer53.pppg$i++;
		host_DDoSZombie54.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host_DDoSZombie54.pppg$i++;
		host55.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host55.pppg$i++;
		host56.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host56.pppg$i++;
		host57.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host57.pppg$i++;
		host_InteractiveServer58.pppg$o++ --> server2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> server2edge --> host_InteractiveServer58.pppg$i++;
		host59.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host59.pppg$i++;
		host60.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host60.pppg$i++;
		host_WebServer61.pppg$o++ --> server2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> server2edge --> host_WebServer61.pppg$i++;
		host62.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host62.pppg$i++;
		host63.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host63.pppg$i++;
		host64.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host64.pppg$i++;
		host65.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host65.pppg$i++;
		host66.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host66.pppg$i++;
		host67.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host67.pppg$i++;
		host_DDoSZombie68.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host_DDoSZombie68.pppg$i++;
		host69.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host69.pppg$i++;
		host70.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host70.pppg$i++;
		host71.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host71.pppg$i++;
		host72.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host72.pppg$i++;
		host73.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host73.pppg$i++;
		host74.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host74.pppg$i++;
		host_WebServer75.pppg$o++ --> server2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> server2edge --> host_WebServer75.pppg$i++;
		host76.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host76.pppg$i++;
		host77.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host77.pppg$i++;
		host78.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host78.pppg$i++;
		host_MailServer79.pppg$o++ --> server2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> server2edge --> host_MailServer79.pppg$i++;
		host80.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host80.pppg$i++;
		host81.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host81.pppg$i++;
		host82.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host82.pppg$i++;
		host_DDoSZombie83.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host_DDoSZombie83.pppg$i++;
		host84.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host84.pppg$i++;
		host85.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host85.pppg$i++;
		host86.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host86.pppg$i++;
		host_DDoSZombie87.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host_DDoSZombie87.pppg$i++;
		host88.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host88.pppg$i++;
		host89.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host89.pppg$i++;
		host90.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host90.pppg$i++;
		host91.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host91.pppg$i++;
		host92.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host92.pppg$i++;
		host93.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host93.pppg$i++;
}

module TAS1
{
	gates:
		inout pppg[];
	submodules:
		connectionManager: ConnectionManager {
			parameters:
				@display("p=20,20;i=block/classifier_s");
		}

		core0: Router {
			parameters:
				@RL();
				@CoreRouter();
				@display("i=abstract/switch");
		}
		gw1: Router {
			parameters:
				@RL();
				@display("i=abstract/router2");
		}
		edge2: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge3: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge4: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge5: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge6: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		host7: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie8: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host9: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_MailServer10: MailServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host11: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host12: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host13: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host14: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host15: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie16: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie19: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host21: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer22: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie28: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_InteractiveServer29: InteractiveServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie31: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie34: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer37: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie38: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}

	connections:
		pppg++ <--> core0.pppg++;
		pppg++ <--> core0.pppg++;
		pppg++ <--> core0.pppg++;
		pppg++ <--> core0.pppg++;
		pppg++ <--> core0.pppg++;

		core0.pppg++ <--> gateway2core <--> gw1.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge2.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge3.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge4.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge5.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge6.pppg++;
		host7.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host7.pppg$i++;
		host_DDoSZombie8.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host_DDoSZombie8.pppg$i++;
		host9.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host9.pppg$i++;
		host_MailServer10.pppg$o++ --> server2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> server2edge --> host_MailServer10.pppg$i++;
		host11.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host11.pppg$i++;
		host12.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host12.pppg$i++;
		host13.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host13.pppg$i++;
		host14.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host14.pppg$i++;
		host15.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host15.pppg$i++;
		host_DDoSZombie16.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host_DDoSZombie16.pppg$i++;
		host17.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host17.pppg$i++;
		host18.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host18.pppg$i++;
		host_DDoSZombie19.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host_DDoSZombie19.pppg$i++;
		host20.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host20.pppg$i++;
		host21.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host21.pppg$i++;
		host_WebServer22.pppg$o++ --> server2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> server2edge --> host_WebServer22.pppg$i++;
		host23.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host23.pppg$i++;
		host24.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host24.pppg$i++;
		host25.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host25.pppg$i++;
		host26.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host26.pppg$i++;
		host27.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host27.pppg$i++;
		host_DDoSZombie28.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host_DDoSZombie28.pppg$i++;
		host_InteractiveServer29.pppg$o++ --> server2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> server2edge --> host_InteractiveServer29.pppg$i++;
		host30.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host30.pppg$i++;
		host_DDoSZombie31.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host_DDoSZombie31.pppg$i++;
		host32.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host32.pppg$i++;
		host33.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host33.pppg$i++;
		host_DDoSZombie34.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host_DDoSZombie34.pppg$i++;
		host35.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host35.pppg$i++;
		host36.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host36.pppg$i++;
		host_WebServer37.pppg$o++ --> server2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> server2edge --> host_WebServer37.pppg$i++;
		host_DDoSZombie38.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host_DDoSZombie38.pppg$i++;
		host39.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host39.pppg$i++;
		host40.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host40.pppg$i++;
		host41.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host41.pppg$i++;
}

module TAS2
{
	gates:
		inout pppg[];
	submodules:
		connectionManager: ConnectionManager {
			parameters:
				@display("p=20,20;i=block/classifier_s");
		}

		core0: Router {
			parameters:
				@RL();
				@CoreRouter();
				@display("i=abstract/switch");
		}
		gw1: Router {
			parameters:
				@RL();
				@display("i=abstract/router2");
		}
		gw2: Router {
			parameters:
				@RL();
				@display("i=abstract/router2");
		}
		gw3: Router {
			parameters:
				@RL();
				@display("i=abstract/router2");
		}
		edge4: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge5: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge6: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge7: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge8: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge9: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge10: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge11: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge12: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge13: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge14: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge15: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge16: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge17: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge18: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge19: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge20: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge21: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge22: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge23: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge24: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge25: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge26: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge27: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge28: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge29: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge30: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		host31: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie39: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie42: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie44: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer47: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie48: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host49: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie50: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host51: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host52: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host53: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host54: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie55: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host56: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie57: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host58: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie59: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host60: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host61: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie62: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host63: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host64: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host65: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host66: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host67: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host68: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host69: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host70: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host71: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host72: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host73: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host74: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host75: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host76: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie77: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_InteractiveServer78: InteractiveServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host79: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host80: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host81: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host82: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host83: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer84: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host85: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host86: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host87: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host88: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host89: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host90: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host91: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host92: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer93: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer94: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host95: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_InteractiveServer96: InteractiveServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host97: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host98: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host99: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host100: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host101: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_InteractiveServer102: InteractiveServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie103: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host104: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie105: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie106: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host107: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host108: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host109: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host110: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie111: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host112: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_MailServer113: MailServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host114: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host115: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie116: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie117: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie118: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host119: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host120: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host121: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host122: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host123: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host124: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host125: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host126: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host127: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie128: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host129: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host130: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host131: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_MailServer132: MailServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer133: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_MailServer134: MailServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host135: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host136: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host137: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host138: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host139: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host140: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host141: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host142: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host143: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer144: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer145: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host146: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie147: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host148: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host149: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie150: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host151: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host152: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host153: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host154: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host155: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host156: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie157: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host158: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host159: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host160: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie161: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host162: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host163: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host164: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie165: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host166: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host167: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host168: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie169: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host170: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host171: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host172: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_NameServer173: NameServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host174: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie175: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie176: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer177: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host178: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host179: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host180: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host181: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie182: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_MailServer183: MailServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host184: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host185: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie186: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie187: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie188: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie189: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie190: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host191: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host192: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host193: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host194: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host195: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie196: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host197: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_InteractiveServer198: InteractiveServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host199: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host200: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host201: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host202: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie203: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host204: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host205: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host206: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host207: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host208: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer209: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie210: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host211: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host212: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host213: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host214: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host215: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host216: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host217: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host218: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie219: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host220: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host221: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host222: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_StreamingServer223: StreamingServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie224: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie225: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie226: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie227: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host228: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host229: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer230: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host231: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}

	connections:
		pppg++ <--> core0.pppg++;
		pppg++ <--> core0.pppg++;
		pppg++ <--> core0.pppg++;
		pppg++ <--> core0.pppg++;
		pppg++ <--> core0.pppg++;

		core0.pppg++ <--> gateway2core <--> gw1.pppg++;
		core0.pppg++ <--> gateway2core <--> gw2.pppg++;
		core0.pppg++ <--> gateway2core <--> gw3.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge4.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge5.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge6.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge7.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge8.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge9.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge10.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge11.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge12.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge13.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge14.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge15.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge16.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge17.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge18.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge19.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge20.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge21.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge22.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge23.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge24.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge25.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge26.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge27.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge28.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge29.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge30.pppg++;
		host31.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host31.pppg$i++;
		host32.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host32.pppg$i++;
		host33.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host33.pppg$i++;
		host34.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host34.pppg$i++;
		host35.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host35.pppg$i++;
		host36.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host36.pppg$i++;
		host37.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host37.pppg$i++;
		host38.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host38.pppg$i++;
		host_DDoSZombie39.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host_DDoSZombie39.pppg$i++;
		host40.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host40.pppg$i++;
		host41.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host41.pppg$i++;
		host_DDoSZombie42.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host_DDoSZombie42.pppg$i++;
		host43.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host43.pppg$i++;
		host_DDoSZombie44.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host_DDoSZombie44.pppg$i++;
		host45.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host45.pppg$i++;
		host46.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host46.pppg$i++;
		host_WebServer47.pppg$o++ --> server2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> server2edge --> host_WebServer47.pppg$i++;
		host_DDoSZombie48.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host_DDoSZombie48.pppg$i++;
		host49.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host49.pppg$i++;
		host_DDoSZombie50.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host_DDoSZombie50.pppg$i++;
		host51.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host51.pppg$i++;
		host52.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host52.pppg$i++;
		host53.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host53.pppg$i++;
		host54.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host54.pppg$i++;
		host_DDoSZombie55.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host_DDoSZombie55.pppg$i++;
		host56.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host56.pppg$i++;
		host_DDoSZombie57.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host_DDoSZombie57.pppg$i++;
		host58.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host58.pppg$i++;
		host_DDoSZombie59.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host_DDoSZombie59.pppg$i++;
		host60.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host60.pppg$i++;
		host61.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host61.pppg$i++;
		host_DDoSZombie62.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host_DDoSZombie62.pppg$i++;
		host63.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host63.pppg$i++;
		host64.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host64.pppg$i++;
		host65.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host65.pppg$i++;
		host66.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host66.pppg$i++;
		host67.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host67.pppg$i++;
		host68.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host68.pppg$i++;
		host69.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host69.pppg$i++;
		host70.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host70.pppg$i++;
		host71.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host71.pppg$i++;
		host72.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host72.pppg$i++;
		host73.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host73.pppg$i++;
		host74.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host74.pppg$i++;
		host75.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host75.pppg$i++;
		host76.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host76.pppg$i++;
		host_DDoSZombie77.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host_DDoSZombie77.pppg$i++;
		host_InteractiveServer78.pppg$o++ --> server2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> server2edge --> host_InteractiveServer78.pppg$i++;
		host79.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host79.pppg$i++;
		host80.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host80.pppg$i++;
		host81.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host81.pppg$i++;
		host82.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host82.pppg$i++;
		host83.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host83.pppg$i++;
		host_WebServer84.pppg$o++ --> server2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> server2edge --> host_WebServer84.pppg$i++;
		host85.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host85.pppg$i++;
		host86.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host86.pppg$i++;
		host87.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host87.pppg$i++;
		host88.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host88.pppg$i++;
		host89.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host89.pppg$i++;
		host90.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host90.pppg$i++;
		host91.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host91.pppg$i++;
		host92.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host92.pppg$i++;
		host_WebServer93.pppg$o++ --> server2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> server2edge --> host_WebServer93.pppg$i++;
		host_WebServer94.pppg$o++ --> server2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> server2edge --> host_WebServer94.pppg$i++;
		host95.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host95.pppg$i++;
		host_InteractiveServer96.pppg$o++ --> server2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> server2edge --> host_InteractiveServer96.pppg$i++;
		host97.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host97.pppg$i++;
		host98.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host98.pppg$i++;
		host99.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host99.pppg$i++;
		host100.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host100.pppg$i++;
		host101.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host101.pppg$i++;
		host_InteractiveServer102.pppg$o++ --> server2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> server2edge --> host_InteractiveServer102.pppg$i++;
		host_DDoSZombie103.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host_DDoSZombie103.pppg$i++;
		host104.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host104.pppg$i++;
		host_DDoSZombie105.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host_DDoSZombie105.pppg$i++;
		host_DDoSZombie106.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host_DDoSZombie106.pppg$i++;
		host107.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host107.pppg$i++;
		host108.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host108.pppg$i++;
		host109.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host109.pppg$i++;
		host110.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host110.pppg$i++;
		host_DDoSZombie111.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host_DDoSZombie111.pppg$i++;
		host112.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host112.pppg$i++;
		host_MailServer113.pppg$o++ --> server2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> server2edge --> host_MailServer113.pppg$i++;
		host114.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host114.pppg$i++;
		host115.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host115.pppg$i++;
		host_DDoSZombie116.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host_DDoSZombie116.pppg$i++;
		host_DDoSZombie117.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host_DDoSZombie117.pppg$i++;
		host_DDoSZombie118.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host_DDoSZombie118.pppg$i++;
		host119.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host119.pppg$i++;
		host120.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host120.pppg$i++;
		host121.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host121.pppg$i++;
		host122.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host122.pppg$i++;
		host123.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host123.pppg$i++;
		host124.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host124.pppg$i++;
		host125.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host125.pppg$i++;
		host126.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host126.pppg$i++;
		host127.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host127.pppg$i++;
		host_DDoSZombie128.pppg$o++ --> host2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> edge2host --> host_DDoSZombie128.pppg$i++;
		host129.pppg$o++ --> host2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> edge2host --> host129.pppg$i++;
		host130.pppg$o++ --> host2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> edge2host --> host130.pppg$i++;
		host131.pppg$o++ --> host2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> edge2host --> host131.pppg$i++;
		host_MailServer132.pppg$o++ --> server2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> server2edge --> host_MailServer132.pppg$i++;
		host_WebServer133.pppg$o++ --> server2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> server2edge --> host_WebServer133.pppg$i++;
		host_MailServer134.pppg$o++ --> server2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> server2edge --> host_MailServer134.pppg$i++;
		host135.pppg$o++ --> host2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> edge2host --> host135.pppg$i++;
		host136.pppg$o++ --> host2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> edge2host --> host136.pppg$i++;
		host137.pppg$o++ --> host2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> edge2host --> host137.pppg$i++;
		host138.pppg$o++ --> host2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> edge2host --> host138.pppg$i++;
		host139.pppg$o++ --> host2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> edge2host --> host139.pppg$i++;
		host140.pppg$o++ --> host2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> edge2host --> host140.pppg$i++;
		host141.pppg$o++ --> host2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> edge2host --> host141.pppg$i++;
		host142.pppg$o++ --> host2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> edge2host --> host142.pppg$i++;
		host143.pppg$o++ --> host2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> edge2host --> host143.pppg$i++;
		host_WebServer144.pppg$o++ --> server2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> server2edge --> host_WebServer144.pppg$i++;
		host_WebServer145.pppg$o++ --> server2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> server2edge --> host_WebServer145.pppg$i++;
		host146.pppg$o++ --> host2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> edge2host --> host146.pppg$i++;
		host_DDoSZombie147.pppg$o++ --> host2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> edge2host --> host_DDoSZombie147.pppg$i++;
		host148.pppg$o++ --> host2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> edge2host --> host148.pppg$i++;
		host149.pppg$o++ --> host2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> edge2host --> host149.pppg$i++;
		host_DDoSZombie150.pppg$o++ --> host2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> edge2host --> host_DDoSZombie150.pppg$i++;
		host151.pppg$o++ --> host2edge --> edge20.pppg$i++;
		edge20.pppg$o++ --> edge2host --> host151.pppg$i++;
		host152.pppg$o++ --> host2edge --> edge20.pppg$i++;
		edge20.pppg$o++ --> edge2host --> host152.pppg$i++;
		host153.pppg$o++ --> host2edge --> edge20.pppg$i++;
		edge20.pppg$o++ --> edge2host --> host153.pppg$i++;
		host154.pppg$o++ --> host2edge --> edge20.pppg$i++;
		edge20.pppg$o++ --> edge2host --> host154.pppg$i++;
		host155.pppg$o++ --> host2edge --> edge20.pppg$i++;
		edge20.pppg$o++ --> edge2host --> host155.pppg$i++;
		host156.pppg$o++ --> host2edge --> edge20.pppg$i++;
		edge20.pppg$o++ --> edge2host --> host156.pppg$i++;
		host_DDoSZombie157.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host_DDoSZombie157.pppg$i++;
		host158.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host158.pppg$i++;
		host159.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host159.pppg$i++;
		host160.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host160.pppg$i++;
		host_DDoSZombie161.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host_DDoSZombie161.pppg$i++;
		host162.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host162.pppg$i++;
		host163.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host163.pppg$i++;
		host164.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host164.pppg$i++;
		host_DDoSZombie165.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host_DDoSZombie165.pppg$i++;
		host166.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host166.pppg$i++;
		host167.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host167.pppg$i++;
		host168.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host168.pppg$i++;
		host_DDoSZombie169.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host_DDoSZombie169.pppg$i++;
		host170.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host170.pppg$i++;
		host171.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host171.pppg$i++;
		host172.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host172.pppg$i++;
		host_NameServer173.pppg$o++ --> server2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> server2edge --> host_NameServer173.pppg$i++;
		host174.pppg$o++ --> host2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> edge2host --> host174.pppg$i++;
		host_DDoSZombie175.pppg$o++ --> host2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> edge2host --> host_DDoSZombie175.pppg$i++;
		host_DDoSZombie176.pppg$o++ --> host2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> edge2host --> host_DDoSZombie176.pppg$i++;
		host_WebServer177.pppg$o++ --> server2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> server2edge --> host_WebServer177.pppg$i++;
		host178.pppg$o++ --> host2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> edge2host --> host178.pppg$i++;
		host179.pppg$o++ --> host2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> edge2host --> host179.pppg$i++;
		host180.pppg$o++ --> host2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> edge2host --> host180.pppg$i++;
		host181.pppg$o++ --> host2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> edge2host --> host181.pppg$i++;
		host_DDoSZombie182.pppg$o++ --> host2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> edge2host --> host_DDoSZombie182.pppg$i++;
		host_MailServer183.pppg$o++ --> server2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> server2edge --> host_MailServer183.pppg$i++;
		host184.pppg$o++ --> host2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> edge2host --> host184.pppg$i++;
		host185.pppg$o++ --> host2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> edge2host --> host185.pppg$i++;
		host_DDoSZombie186.pppg$o++ --> host2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> edge2host --> host_DDoSZombie186.pppg$i++;
		host_DDoSZombie187.pppg$o++ --> host2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> edge2host --> host_DDoSZombie187.pppg$i++;
		host_DDoSZombie188.pppg$o++ --> host2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> edge2host --> host_DDoSZombie188.pppg$i++;
		host_DDoSZombie189.pppg$o++ --> host2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> edge2host --> host_DDoSZombie189.pppg$i++;
		host_DDoSZombie190.pppg$o++ --> host2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> edge2host --> host_DDoSZombie190.pppg$i++;
		host191.pppg$o++ --> host2edge --> edge25.pppg$i++;
		edge25.pppg$o++ --> edge2host --> host191.pppg$i++;
		host192.pppg$o++ --> host2edge --> edge25.pppg$i++;
		edge25.pppg$o++ --> edge2host --> host192.pppg$i++;
		host193.pppg$o++ --> host2edge --> edge25.pppg$i++;
		edge25.pppg$o++ --> edge2host --> host193.pppg$i++;
		host194.pppg$o++ --> host2edge --> edge25.pppg$i++;
		edge25.pppg$o++ --> edge2host --> host194.pppg$i++;
		host195.pppg$o++ --> host2edge --> edge25.pppg$i++;
		edge25.pppg$o++ --> edge2host --> host195.pppg$i++;
		host_DDoSZombie196.pppg$o++ --> host2edge --> edge25.pppg$i++;
		edge25.pppg$o++ --> edge2host --> host_DDoSZombie196.pppg$i++;
		host197.pppg$o++ --> host2edge --> edge25.pppg$i++;
		edge25.pppg$o++ --> edge2host --> host197.pppg$i++;
		host_InteractiveServer198.pppg$o++ --> server2edge --> edge26.pppg$i++;
		edge26.pppg$o++ --> server2edge --> host_InteractiveServer198.pppg$i++;
		host199.pppg$o++ --> host2edge --> edge26.pppg$i++;
		edge26.pppg$o++ --> edge2host --> host199.pppg$i++;
		host200.pppg$o++ --> host2edge --> edge26.pppg$i++;
		edge26.pppg$o++ --> edge2host --> host200.pppg$i++;
		host201.pppg$o++ --> host2edge --> edge26.pppg$i++;
		edge26.pppg$o++ --> edge2host --> host201.pppg$i++;
		host202.pppg$o++ --> host2edge --> edge26.pppg$i++;
		edge26.pppg$o++ --> edge2host --> host202.pppg$i++;
		host_DDoSZombie203.pppg$o++ --> host2edge --> edge26.pppg$i++;
		edge26.pppg$o++ --> edge2host --> host_DDoSZombie203.pppg$i++;
		host204.pppg$o++ --> host2edge --> edge26.pppg$i++;
		edge26.pppg$o++ --> edge2host --> host204.pppg$i++;
		host205.pppg$o++ --> host2edge --> edge27.pppg$i++;
		edge27.pppg$o++ --> edge2host --> host205.pppg$i++;
		host206.pppg$o++ --> host2edge --> edge27.pppg$i++;
		edge27.pppg$o++ --> edge2host --> host206.pppg$i++;
		host207.pppg$o++ --> host2edge --> edge27.pppg$i++;
		edge27.pppg$o++ --> edge2host --> host207.pppg$i++;
		host208.pppg$o++ --> host2edge --> edge27.pppg$i++;
		edge27.pppg$o++ --> edge2host --> host208.pppg$i++;
		host_WebServer209.pppg$o++ --> server2edge --> edge27.pppg$i++;
		edge27.pppg$o++ --> server2edge --> host_WebServer209.pppg$i++;
		host_DDoSZombie210.pppg$o++ --> host2edge --> edge28.pppg$i++;
		edge28.pppg$o++ --> edge2host --> host_DDoSZombie210.pppg$i++;
		host211.pppg$o++ --> host2edge --> edge28.pppg$i++;
		edge28.pppg$o++ --> edge2host --> host211.pppg$i++;
		host212.pppg$o++ --> host2edge --> edge28.pppg$i++;
		edge28.pppg$o++ --> edge2host --> host212.pppg$i++;
		host213.pppg$o++ --> host2edge --> edge28.pppg$i++;
		edge28.pppg$o++ --> edge2host --> host213.pppg$i++;
		host214.pppg$o++ --> host2edge --> edge28.pppg$i++;
		edge28.pppg$o++ --> edge2host --> host214.pppg$i++;
		host215.pppg$o++ --> host2edge --> edge28.pppg$i++;
		edge28.pppg$o++ --> edge2host --> host215.pppg$i++;
		host216.pppg$o++ --> host2edge --> edge28.pppg$i++;
		edge28.pppg$o++ --> edge2host --> host216.pppg$i++;
		host217.pppg$o++ --> host2edge --> edge29.pppg$i++;
		edge29.pppg$o++ --> edge2host --> host217.pppg$i++;
		host218.pppg$o++ --> host2edge --> edge29.pppg$i++;
		edge29.pppg$o++ --> edge2host --> host218.pppg$i++;
		host_DDoSZombie219.pppg$o++ --> host2edge --> edge29.pppg$i++;
		edge29.pppg$o++ --> edge2host --> host_DDoSZombie219.pppg$i++;
		host220.pppg$o++ --> host2edge --> edge29.pppg$i++;
		edge29.pppg$o++ --> edge2host --> host220.pppg$i++;
		host221.pppg$o++ --> host2edge --> edge29.pppg$i++;
		edge29.pppg$o++ --> edge2host --> host221.pppg$i++;
		host222.pppg$o++ --> host2edge --> edge29.pppg$i++;
		edge29.pppg$o++ --> edge2host --> host222.pppg$i++;
		host_StreamingServer223.pppg$o++ --> server2edge --> edge29.pppg$i++;
		edge29.pppg$o++ --> server2edge --> host_StreamingServer223.pppg$i++;
		host_DDoSZombie224.pppg$o++ --> host2edge --> edge30.pppg$i++;
		edge30.pppg$o++ --> edge2host --> host_DDoSZombie224.pppg$i++;
		host_DDoSZombie225.pppg$o++ --> host2edge --> edge30.pppg$i++;
		edge30.pppg$o++ --> edge2host --> host_DDoSZombie225.pppg$i++;
		host_DDoSZombie226.pppg$o++ --> host2edge --> edge30.pppg$i++;
		edge30.pppg$o++ --> edge2host --> host_DDoSZombie226.pppg$i++;
		host_DDoSZombie227.pppg$o++ --> host2edge --> edge30.pppg$i++;
		edge30.pppg$o++ --> edge2host --> host_DDoSZombie227.pppg$i++;
		host228.pppg$o++ --> host2edge --> edge30.pppg$i++;
		edge30.pppg$o++ --> edge2host --> host228.pppg$i++;
		host229.pppg$o++ --> host2edge --> edge30.pppg$i++;
		edge30.pppg$o++ --> edge2host --> host229.pppg$i++;
		host_WebServer230.pppg$o++ --> server2edge --> edge30.pppg$i++;
		edge30.pppg$o++ --> server2edge --> host_WebServer230.pppg$i++;
		host231.pppg$o++ --> host2edge --> edge30.pppg$i++;
		edge30.pppg$o++ --> edge2host --> host231.pppg$i++;
}

module TAS3
{
	gates:
		inout pppg[];
	submodules:
		connectionManager: ConnectionManager {
			parameters:
				@display("p=20,20;i=block/classifier_s");
		}

		core0: Router {
			parameters:
				@RL();
				@CoreRouter();
				@display("i=abstract/switch");
		}
		gw1: Router {
			parameters:
				@RL();
				@display("i=abstract/router2");
		}
		edge2: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge3: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge4: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge5: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge6: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge7: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		host_DDoSZombie8: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host9: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host10: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host11: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_InteractiveServer12: InteractiveServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host13: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie14: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host15: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie16: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie18: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie21: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_MailServer25: MailServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer27: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer30: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie33: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie34: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie35: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie42: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie44: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}

	connections:
		pppg++ <--> core0.pppg++;
		pppg++ <--> core0.pppg++;
		pppg++ <--> core0.pppg++;
		pppg++ <--> core0.pppg++;

		core0.pppg++ <--> gateway2core <--> gw1.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge2.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge3.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge4.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge5.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge6.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge7.pppg++;
		host_DDoSZombie8.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host_DDoSZombie8.pppg$i++;
		host9.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host9.pppg$i++;
		host10.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host10.pppg$i++;
		host11.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host11.pppg$i++;
		host_InteractiveServer12.pppg$o++ --> server2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> server2edge --> host_InteractiveServer12.pppg$i++;
		host13.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host13.pppg$i++;
		host_DDoSZombie14.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host_DDoSZombie14.pppg$i++;
		host15.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host15.pppg$i++;
		host_DDoSZombie16.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host_DDoSZombie16.pppg$i++;
		host17.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host17.pppg$i++;
		host_DDoSZombie18.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host_DDoSZombie18.pppg$i++;
		host19.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host19.pppg$i++;
		host20.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host20.pppg$i++;
		host_DDoSZombie21.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host_DDoSZombie21.pppg$i++;
		host22.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host22.pppg$i++;
		host23.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host23.pppg$i++;
		host24.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host24.pppg$i++;
		host_MailServer25.pppg$o++ --> server2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> server2edge --> host_MailServer25.pppg$i++;
		host26.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host26.pppg$i++;
		host_WebServer27.pppg$o++ --> server2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> server2edge --> host_WebServer27.pppg$i++;
		host28.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host28.pppg$i++;
		host29.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host29.pppg$i++;
		host_WebServer30.pppg$o++ --> server2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> server2edge --> host_WebServer30.pppg$i++;
		host31.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host31.pppg$i++;
		host32.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host32.pppg$i++;
		host_DDoSZombie33.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host_DDoSZombie33.pppg$i++;
		host_DDoSZombie34.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host_DDoSZombie34.pppg$i++;
		host_DDoSZombie35.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host_DDoSZombie35.pppg$i++;
		host36.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host36.pppg$i++;
		host37.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host37.pppg$i++;
		host38.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host38.pppg$i++;
		host39.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host39.pppg$i++;
		host40.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host40.pppg$i++;
		host41.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host41.pppg$i++;
		host_DDoSZombie42.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host_DDoSZombie42.pppg$i++;
		host43.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host43.pppg$i++;
		host_DDoSZombie44.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host_DDoSZombie44.pppg$i++;
		host45.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host45.pppg$i++;
}

module TAS4
{
	gates:
		inout pppg[];
	submodules:
		connectionManager: ConnectionManager {
			parameters:
				@display("p=20,20;i=block/classifier_s");
		}

		core0: Router {
			parameters:
				@RL();
				@CoreRouter();
				@display("i=abstract/switch");
		}
		gw1: Router {
			parameters:
				@RL();
				@display("i=abstract/router2");
		}
		edge2: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge3: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge4: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		host5: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer6: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host7: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host8: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host9: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host10: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host11: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie12: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host13: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie14: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host15: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie18: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host21: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie23: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}

	connections:
		pppg++ <--> core0.pppg++;
		pppg++ <--> core0.pppg++;
		pppg++ <--> core0.pppg++;

		core0.pppg++ <--> gateway2core <--> gw1.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge2.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge3.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge4.pppg++;
		host5.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host5.pppg$i++;
		host_WebServer6.pppg$o++ --> server2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> server2edge --> host_WebServer6.pppg$i++;
		host7.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host7.pppg$i++;
		host8.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host8.pppg$i++;
		host9.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host9.pppg$i++;
		host10.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host10.pppg$i++;
		host11.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host11.pppg$i++;
		host_DDoSZombie12.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host_DDoSZombie12.pppg$i++;
		host13.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host13.pppg$i++;
		host_DDoSZombie14.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host_DDoSZombie14.pppg$i++;
		host15.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host15.pppg$i++;
		host16.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host16.pppg$i++;
		host17.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host17.pppg$i++;
		host_DDoSZombie18.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host_DDoSZombie18.pppg$i++;
		host19.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host19.pppg$i++;
		host20.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host20.pppg$i++;
		host21.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host21.pppg$i++;
		host22.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host22.pppg$i++;
		host_DDoSZombie23.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host_DDoSZombie23.pppg$i++;
		host24.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host24.pppg$i++;
		host25.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host25.pppg$i++;
		host26.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host26.pppg$i++;
		host27.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host27.pppg$i++;
		host28.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host28.pppg$i++;
}

module SAS5
{
	gates:
		inout pppg[];
	submodules:
		connectionManager: ConnectionManager {
			parameters:
				@display("p=20,20;i=block/classifier_s");
		}

		core0: Router {
			parameters:
				@RL();
				@CoreRouter();
				@display("i=abstract/switch");
		}
		gw1: Router {
			parameters:
				@RL();
				@display("i=abstract/router2");
		}
		edge2: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge3: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge4: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge5: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge6: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge7: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge8: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge9: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge10: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge11: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		host12: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host13: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host14: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie15: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie21: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer24: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie26: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer29: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie34: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie36: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host42: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host44: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host47: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie48: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host49: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie50: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer51: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host52: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host53: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host54: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host55: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host56: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host57: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host58: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host59: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host60: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host61: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host62: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host63: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host64: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host65: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host66: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_MailServer67: MailServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host68: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer69: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host70: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie71: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host72: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host73: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie74: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host75: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host76: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_InteractiveServer77: InteractiveServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host78: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host79: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host80: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host81: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}

	connections:
		pppg++ <--> core0.pppg++;
		pppg++ <--> core0.pppg++;

		core0.pppg++ <--> gateway2core <--> gw1.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge2.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge3.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge4.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge5.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge6.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge7.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge8.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge9.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge10.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge11.pppg++;
		host12.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host12.pppg$i++;
		host13.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host13.pppg$i++;
		host14.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host14.pppg$i++;
		host_DDoSZombie15.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host_DDoSZombie15.pppg$i++;
		host16.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host16.pppg$i++;
		host17.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host17.pppg$i++;
		host18.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host18.pppg$i++;
		host19.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host19.pppg$i++;
		host20.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host20.pppg$i++;
		host_DDoSZombie21.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host_DDoSZombie21.pppg$i++;
		host22.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host22.pppg$i++;
		host23.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host23.pppg$i++;
		host_WebServer24.pppg$o++ --> server2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> server2edge --> host_WebServer24.pppg$i++;
		host25.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host25.pppg$i++;
		host_DDoSZombie26.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host_DDoSZombie26.pppg$i++;
		host27.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host27.pppg$i++;
		host28.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host28.pppg$i++;
		host_WebServer29.pppg$o++ --> server2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> server2edge --> host_WebServer29.pppg$i++;
		host30.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host30.pppg$i++;
		host31.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host31.pppg$i++;
		host32.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host32.pppg$i++;
		host33.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host33.pppg$i++;
		host_DDoSZombie34.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host_DDoSZombie34.pppg$i++;
		host35.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host35.pppg$i++;
		host_DDoSZombie36.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host_DDoSZombie36.pppg$i++;
		host37.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host37.pppg$i++;
		host38.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host38.pppg$i++;
		host39.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host39.pppg$i++;
		host40.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host40.pppg$i++;
		host41.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host41.pppg$i++;
		host42.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host42.pppg$i++;
		host43.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host43.pppg$i++;
		host44.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host44.pppg$i++;
		host45.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host45.pppg$i++;
		host46.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host46.pppg$i++;
		host47.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host47.pppg$i++;
		host_DDoSZombie48.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host_DDoSZombie48.pppg$i++;
		host49.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host49.pppg$i++;
		host_DDoSZombie50.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host_DDoSZombie50.pppg$i++;
		host_WebServer51.pppg$o++ --> server2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> server2edge --> host_WebServer51.pppg$i++;
		host52.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host52.pppg$i++;
		host53.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host53.pppg$i++;
		host54.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host54.pppg$i++;
		host55.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host55.pppg$i++;
		host56.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host56.pppg$i++;
		host57.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host57.pppg$i++;
		host58.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host58.pppg$i++;
		host59.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host59.pppg$i++;
		host60.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host60.pppg$i++;
		host61.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host61.pppg$i++;
		host62.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host62.pppg$i++;
		host63.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host63.pppg$i++;
		host64.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host64.pppg$i++;
		host65.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host65.pppg$i++;
		host66.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host66.pppg$i++;
		host_MailServer67.pppg$o++ --> server2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> server2edge --> host_MailServer67.pppg$i++;
		host68.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host68.pppg$i++;
		host_WebServer69.pppg$o++ --> server2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> server2edge --> host_WebServer69.pppg$i++;
		host70.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host70.pppg$i++;
		host_DDoSZombie71.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host_DDoSZombie71.pppg$i++;
		host72.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host72.pppg$i++;
		host73.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host73.pppg$i++;
		host_DDoSZombie74.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host_DDoSZombie74.pppg$i++;
		host75.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host75.pppg$i++;
		host76.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host76.pppg$i++;
		host_InteractiveServer77.pppg$o++ --> server2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> server2edge --> host_InteractiveServer77.pppg$i++;
		host78.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host78.pppg$i++;
		host79.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host79.pppg$i++;
		host80.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host80.pppg$i++;
		host81.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host81.pppg$i++;
}

module SAS6
{
	gates:
		inout pppg[];
	submodules:
		connectionManager: ConnectionManager {
			parameters:
				@display("p=20,20;i=block/classifier_s");
		}

		core0: Router {
			parameters:
				@RL();
				@CoreRouter();
				@display("i=abstract/switch");
		}
		gw1: Router {
			parameters:
				@RL();
				@display("i=abstract/router2");
		}
		gw2: Router {
			parameters:
				@RL();
				@display("i=abstract/router2");
		}
		gw3: Router {
			parameters:
				@RL();
				@display("i=abstract/router2");
		}
		gw4: Router {
			parameters:
				@RL();
				@display("i=abstract/router2");
		}
		edge5: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge6: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge7: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge8: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge9: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge10: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge11: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge12: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge13: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge14: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge15: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge16: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge17: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge18: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge19: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge20: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge21: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge22: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge23: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge24: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge25: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge26: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge27: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge28: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge29: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge30: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge31: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge32: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge33: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge34: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge35: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge36: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge37: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge38: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		host39: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host42: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host44: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host47: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host48: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host49: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_MailServer50: MailServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host51: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer52: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host53: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host54: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host55: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host56: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host57: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host58: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host59: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie60: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie61: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host62: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host63: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host64: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_NameServer65: NameServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host66: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host67: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host68: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host69: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host70: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie71: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host72: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host73: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host74: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie75: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host76: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie77: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie78: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host79: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host80: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host81: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie82: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer83: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host84: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie85: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host86: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host87: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host88: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host89: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_InteractiveServer90: InteractiveServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host91: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host92: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host93: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host94: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host95: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie96: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host97: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host98: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host99: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host100: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host101: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host102: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie103: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host104: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host105: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host106: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host107: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie108: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host109: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host110: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host111: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie112: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host113: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host114: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host115: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host116: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie117: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host118: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host119: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host120: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie121: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host122: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie123: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host124: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie125: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host126: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host127: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie128: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host129: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host130: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host131: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host132: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer133: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host134: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host135: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host136: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host137: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host138: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie139: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host140: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host141: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host142: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host143: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host144: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie145: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie146: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie147: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie148: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie149: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host150: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host151: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host152: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host153: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie154: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host155: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host156: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host157: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host158: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host159: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_MailServer160: MailServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host161: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie162: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host163: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer164: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host165: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie166: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie167: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host168: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer169: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host170: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host171: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie172: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host173: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_InteractiveServer174: InteractiveServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host175: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host176: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer177: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host178: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host179: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host180: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host181: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie182: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie183: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host184: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host185: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie186: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host187: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie188: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie189: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie190: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host191: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer192: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host193: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie194: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host195: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie196: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host197: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host198: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host199: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host200: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host201: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host202: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host203: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host204: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host205: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host206: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host207: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host208: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie209: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host210: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host211: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host212: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_InteractiveServer213: InteractiveServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer214: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer215: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host216: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_BackupServer217: BackupServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host218: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host219: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host220: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host221: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host222: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host223: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host224: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host225: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host226: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host227: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer228: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host229: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host230: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host231: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host232: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_MailServer233: MailServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host234: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host235: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host236: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer237: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host238: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host239: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host240: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_InteractiveServer241: InteractiveServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host242: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host243: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host244: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host245: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host246: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_StreamingServer247: StreamingServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie248: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie249: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie250: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host251: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer252: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host253: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host254: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host255: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host256: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie257: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host258: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host259: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie260: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host261: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie262: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host263: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_MailServer264: MailServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host265: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_InteractiveServer266: InteractiveServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host267: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer268: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host269: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host270: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host271: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host272: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie273: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host274: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host275: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie276: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie277: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host278: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host279: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host280: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host281: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host282: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host283: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host284: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_MailServer285: MailServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}

	connections:
		pppg++ <--> core0.pppg++;
		pppg++ <--> core0.pppg++;
		pppg++ <--> core0.pppg++;

		core0.pppg++ <--> gateway2core <--> gw1.pppg++;
		core0.pppg++ <--> gateway2core <--> gw2.pppg++;
		core0.pppg++ <--> gateway2core <--> gw3.pppg++;
		core0.pppg++ <--> gateway2core <--> gw4.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge5.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge6.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge7.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge8.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge9.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge10.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge11.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge12.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge13.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge14.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge15.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge16.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge17.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge18.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge19.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge20.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge21.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge22.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge23.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge24.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge25.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge26.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge27.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge28.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge29.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge30.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge31.pppg++;
		gw4.pppg++ <--> edge2gateway <--> edge32.pppg++;
		gw4.pppg++ <--> edge2gateway <--> edge33.pppg++;
		gw4.pppg++ <--> edge2gateway <--> edge34.pppg++;
		gw4.pppg++ <--> edge2gateway <--> edge35.pppg++;
		gw4.pppg++ <--> edge2gateway <--> edge36.pppg++;
		gw4.pppg++ <--> edge2gateway <--> edge37.pppg++;
		gw4.pppg++ <--> edge2gateway <--> edge38.pppg++;
		host39.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host39.pppg$i++;
		host40.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host40.pppg$i++;
		host41.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host41.pppg$i++;
		host42.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host42.pppg$i++;
		host43.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host43.pppg$i++;
		host44.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host44.pppg$i++;
		host45.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host45.pppg$i++;
		host46.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host46.pppg$i++;
		host47.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host47.pppg$i++;
		host48.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host48.pppg$i++;
		host49.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host49.pppg$i++;
		host_MailServer50.pppg$o++ --> server2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> server2edge --> host_MailServer50.pppg$i++;
		host51.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host51.pppg$i++;
		host_WebServer52.pppg$o++ --> server2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> server2edge --> host_WebServer52.pppg$i++;
		host53.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host53.pppg$i++;
		host54.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host54.pppg$i++;
		host55.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host55.pppg$i++;
		host56.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host56.pppg$i++;
		host57.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host57.pppg$i++;
		host58.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host58.pppg$i++;
		host59.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host59.pppg$i++;
		host_DDoSZombie60.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host_DDoSZombie60.pppg$i++;
		host_DDoSZombie61.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host_DDoSZombie61.pppg$i++;
		host62.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host62.pppg$i++;
		host63.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host63.pppg$i++;
		host64.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host64.pppg$i++;
		host_NameServer65.pppg$o++ --> server2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> server2edge --> host_NameServer65.pppg$i++;
		host66.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host66.pppg$i++;
		host67.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host67.pppg$i++;
		host68.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host68.pppg$i++;
		host69.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host69.pppg$i++;
		host70.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host70.pppg$i++;
		host_DDoSZombie71.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host_DDoSZombie71.pppg$i++;
		host72.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host72.pppg$i++;
		host73.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host73.pppg$i++;
		host74.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host74.pppg$i++;
		host_DDoSZombie75.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host_DDoSZombie75.pppg$i++;
		host76.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host76.pppg$i++;
		host_DDoSZombie77.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host_DDoSZombie77.pppg$i++;
		host_DDoSZombie78.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host_DDoSZombie78.pppg$i++;
		host79.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host79.pppg$i++;
		host80.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host80.pppg$i++;
		host81.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host81.pppg$i++;
		host_DDoSZombie82.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host_DDoSZombie82.pppg$i++;
		host_WebServer83.pppg$o++ --> server2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> server2edge --> host_WebServer83.pppg$i++;
		host84.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host84.pppg$i++;
		host_DDoSZombie85.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host_DDoSZombie85.pppg$i++;
		host86.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host86.pppg$i++;
		host87.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host87.pppg$i++;
		host88.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host88.pppg$i++;
		host89.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host89.pppg$i++;
		host_InteractiveServer90.pppg$o++ --> server2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> server2edge --> host_InteractiveServer90.pppg$i++;
		host91.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host91.pppg$i++;
		host92.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host92.pppg$i++;
		host93.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host93.pppg$i++;
		host94.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host94.pppg$i++;
		host95.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host95.pppg$i++;
		host_DDoSZombie96.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host_DDoSZombie96.pppg$i++;
		host97.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host97.pppg$i++;
		host98.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host98.pppg$i++;
		host99.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host99.pppg$i++;
		host100.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host100.pppg$i++;
		host101.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host101.pppg$i++;
		host102.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host102.pppg$i++;
		host_DDoSZombie103.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host_DDoSZombie103.pppg$i++;
		host104.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host104.pppg$i++;
		host105.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host105.pppg$i++;
		host106.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host106.pppg$i++;
		host107.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host107.pppg$i++;
		host_DDoSZombie108.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host_DDoSZombie108.pppg$i++;
		host109.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host109.pppg$i++;
		host110.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host110.pppg$i++;
		host111.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host111.pppg$i++;
		host_DDoSZombie112.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host_DDoSZombie112.pppg$i++;
		host113.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host113.pppg$i++;
		host114.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host114.pppg$i++;
		host115.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host115.pppg$i++;
		host116.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host116.pppg$i++;
		host_DDoSZombie117.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host_DDoSZombie117.pppg$i++;
		host118.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host118.pppg$i++;
		host119.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host119.pppg$i++;
		host120.pppg$o++ --> host2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> edge2host --> host120.pppg$i++;
		host_DDoSZombie121.pppg$o++ --> host2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> edge2host --> host_DDoSZombie121.pppg$i++;
		host122.pppg$o++ --> host2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> edge2host --> host122.pppg$i++;
		host_DDoSZombie123.pppg$o++ --> host2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> edge2host --> host_DDoSZombie123.pppg$i++;
		host124.pppg$o++ --> host2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> edge2host --> host124.pppg$i++;
		host_DDoSZombie125.pppg$o++ --> host2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> edge2host --> host_DDoSZombie125.pppg$i++;
		host126.pppg$o++ --> host2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> edge2host --> host126.pppg$i++;
		host127.pppg$o++ --> host2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> edge2host --> host127.pppg$i++;
		host_DDoSZombie128.pppg$o++ --> host2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> edge2host --> host_DDoSZombie128.pppg$i++;
		host129.pppg$o++ --> host2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> edge2host --> host129.pppg$i++;
		host130.pppg$o++ --> host2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> edge2host --> host130.pppg$i++;
		host131.pppg$o++ --> host2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> edge2host --> host131.pppg$i++;
		host132.pppg$o++ --> host2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> edge2host --> host132.pppg$i++;
		host_WebServer133.pppg$o++ --> server2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> server2edge --> host_WebServer133.pppg$i++;
		host134.pppg$o++ --> host2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> edge2host --> host134.pppg$i++;
		host135.pppg$o++ --> host2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> edge2host --> host135.pppg$i++;
		host136.pppg$o++ --> host2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> edge2host --> host136.pppg$i++;
		host137.pppg$o++ --> host2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> edge2host --> host137.pppg$i++;
		host138.pppg$o++ --> host2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> edge2host --> host138.pppg$i++;
		host_DDoSZombie139.pppg$o++ --> host2edge --> edge20.pppg$i++;
		edge20.pppg$o++ --> edge2host --> host_DDoSZombie139.pppg$i++;
		host140.pppg$o++ --> host2edge --> edge20.pppg$i++;
		edge20.pppg$o++ --> edge2host --> host140.pppg$i++;
		host141.pppg$o++ --> host2edge --> edge20.pppg$i++;
		edge20.pppg$o++ --> edge2host --> host141.pppg$i++;
		host142.pppg$o++ --> host2edge --> edge20.pppg$i++;
		edge20.pppg$o++ --> edge2host --> host142.pppg$i++;
		host143.pppg$o++ --> host2edge --> edge20.pppg$i++;
		edge20.pppg$o++ --> edge2host --> host143.pppg$i++;
		host144.pppg$o++ --> host2edge --> edge20.pppg$i++;
		edge20.pppg$o++ --> edge2host --> host144.pppg$i++;
		host_DDoSZombie145.pppg$o++ --> host2edge --> edge20.pppg$i++;
		edge20.pppg$o++ --> edge2host --> host_DDoSZombie145.pppg$i++;
		host_DDoSZombie146.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host_DDoSZombie146.pppg$i++;
		host_DDoSZombie147.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host_DDoSZombie147.pppg$i++;
		host_DDoSZombie148.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host_DDoSZombie148.pppg$i++;
		host_DDoSZombie149.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host_DDoSZombie149.pppg$i++;
		host150.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host150.pppg$i++;
		host151.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host151.pppg$i++;
		host152.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host152.pppg$i++;
		host153.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host153.pppg$i++;
		host_DDoSZombie154.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host_DDoSZombie154.pppg$i++;
		host155.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host155.pppg$i++;
		host156.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host156.pppg$i++;
		host157.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host157.pppg$i++;
		host158.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host158.pppg$i++;
		host159.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host159.pppg$i++;
		host_MailServer160.pppg$o++ --> server2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> server2edge --> host_MailServer160.pppg$i++;
		host161.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host161.pppg$i++;
		host_DDoSZombie162.pppg$o++ --> host2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> edge2host --> host_DDoSZombie162.pppg$i++;
		host163.pppg$o++ --> host2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> edge2host --> host163.pppg$i++;
		host_WebServer164.pppg$o++ --> server2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> server2edge --> host_WebServer164.pppg$i++;
		host165.pppg$o++ --> host2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> edge2host --> host165.pppg$i++;
		host_DDoSZombie166.pppg$o++ --> host2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> edge2host --> host_DDoSZombie166.pppg$i++;
		host_DDoSZombie167.pppg$o++ --> host2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> edge2host --> host_DDoSZombie167.pppg$i++;
		host168.pppg$o++ --> host2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> edge2host --> host168.pppg$i++;
		host_WebServer169.pppg$o++ --> server2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> server2edge --> host_WebServer169.pppg$i++;
		host170.pppg$o++ --> host2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> edge2host --> host170.pppg$i++;
		host171.pppg$o++ --> host2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> edge2host --> host171.pppg$i++;
		host_DDoSZombie172.pppg$o++ --> host2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> edge2host --> host_DDoSZombie172.pppg$i++;
		host173.pppg$o++ --> host2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> edge2host --> host173.pppg$i++;
		host_InteractiveServer174.pppg$o++ --> server2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> server2edge --> host_InteractiveServer174.pppg$i++;
		host175.pppg$o++ --> host2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> edge2host --> host175.pppg$i++;
		host176.pppg$o++ --> host2edge --> edge25.pppg$i++;
		edge25.pppg$o++ --> edge2host --> host176.pppg$i++;
		host_WebServer177.pppg$o++ --> server2edge --> edge25.pppg$i++;
		edge25.pppg$o++ --> server2edge --> host_WebServer177.pppg$i++;
		host178.pppg$o++ --> host2edge --> edge25.pppg$i++;
		edge25.pppg$o++ --> edge2host --> host178.pppg$i++;
		host179.pppg$o++ --> host2edge --> edge25.pppg$i++;
		edge25.pppg$o++ --> edge2host --> host179.pppg$i++;
		host180.pppg$o++ --> host2edge --> edge25.pppg$i++;
		edge25.pppg$o++ --> edge2host --> host180.pppg$i++;
		host181.pppg$o++ --> host2edge --> edge26.pppg$i++;
		edge26.pppg$o++ --> edge2host --> host181.pppg$i++;
		host_DDoSZombie182.pppg$o++ --> host2edge --> edge26.pppg$i++;
		edge26.pppg$o++ --> edge2host --> host_DDoSZombie182.pppg$i++;
		host_DDoSZombie183.pppg$o++ --> host2edge --> edge26.pppg$i++;
		edge26.pppg$o++ --> edge2host --> host_DDoSZombie183.pppg$i++;
		host184.pppg$o++ --> host2edge --> edge26.pppg$i++;
		edge26.pppg$o++ --> edge2host --> host184.pppg$i++;
		host185.pppg$o++ --> host2edge --> edge26.pppg$i++;
		edge26.pppg$o++ --> edge2host --> host185.pppg$i++;
		host_DDoSZombie186.pppg$o++ --> host2edge --> edge26.pppg$i++;
		edge26.pppg$o++ --> edge2host --> host_DDoSZombie186.pppg$i++;
		host187.pppg$o++ --> host2edge --> edge26.pppg$i++;
		edge26.pppg$o++ --> edge2host --> host187.pppg$i++;
		host_DDoSZombie188.pppg$o++ --> host2edge --> edge26.pppg$i++;
		edge26.pppg$o++ --> edge2host --> host_DDoSZombie188.pppg$i++;
		host_DDoSZombie189.pppg$o++ --> host2edge --> edge26.pppg$i++;
		edge26.pppg$o++ --> edge2host --> host_DDoSZombie189.pppg$i++;
		host_DDoSZombie190.pppg$o++ --> host2edge --> edge26.pppg$i++;
		edge26.pppg$o++ --> edge2host --> host_DDoSZombie190.pppg$i++;
		host191.pppg$o++ --> host2edge --> edge27.pppg$i++;
		edge27.pppg$o++ --> edge2host --> host191.pppg$i++;
		host_WebServer192.pppg$o++ --> server2edge --> edge27.pppg$i++;
		edge27.pppg$o++ --> server2edge --> host_WebServer192.pppg$i++;
		host193.pppg$o++ --> host2edge --> edge27.pppg$i++;
		edge27.pppg$o++ --> edge2host --> host193.pppg$i++;
		host_DDoSZombie194.pppg$o++ --> host2edge --> edge27.pppg$i++;
		edge27.pppg$o++ --> edge2host --> host_DDoSZombie194.pppg$i++;
		host195.pppg$o++ --> host2edge --> edge27.pppg$i++;
		edge27.pppg$o++ --> edge2host --> host195.pppg$i++;
		host_DDoSZombie196.pppg$o++ --> host2edge --> edge27.pppg$i++;
		edge27.pppg$o++ --> edge2host --> host_DDoSZombie196.pppg$i++;
		host197.pppg$o++ --> host2edge --> edge27.pppg$i++;
		edge27.pppg$o++ --> edge2host --> host197.pppg$i++;
		host198.pppg$o++ --> host2edge --> edge27.pppg$i++;
		edge27.pppg$o++ --> edge2host --> host198.pppg$i++;
		host199.pppg$o++ --> host2edge --> edge28.pppg$i++;
		edge28.pppg$o++ --> edge2host --> host199.pppg$i++;
		host200.pppg$o++ --> host2edge --> edge28.pppg$i++;
		edge28.pppg$o++ --> edge2host --> host200.pppg$i++;
		host201.pppg$o++ --> host2edge --> edge28.pppg$i++;
		edge28.pppg$o++ --> edge2host --> host201.pppg$i++;
		host202.pppg$o++ --> host2edge --> edge28.pppg$i++;
		edge28.pppg$o++ --> edge2host --> host202.pppg$i++;
		host203.pppg$o++ --> host2edge --> edge28.pppg$i++;
		edge28.pppg$o++ --> edge2host --> host203.pppg$i++;
		host204.pppg$o++ --> host2edge --> edge28.pppg$i++;
		edge28.pppg$o++ --> edge2host --> host204.pppg$i++;
		host205.pppg$o++ --> host2edge --> edge28.pppg$i++;
		edge28.pppg$o++ --> edge2host --> host205.pppg$i++;
		host206.pppg$o++ --> host2edge --> edge28.pppg$i++;
		edge28.pppg$o++ --> edge2host --> host206.pppg$i++;
		host207.pppg$o++ --> host2edge --> edge29.pppg$i++;
		edge29.pppg$o++ --> edge2host --> host207.pppg$i++;
		host208.pppg$o++ --> host2edge --> edge29.pppg$i++;
		edge29.pppg$o++ --> edge2host --> host208.pppg$i++;
		host_DDoSZombie209.pppg$o++ --> host2edge --> edge29.pppg$i++;
		edge29.pppg$o++ --> edge2host --> host_DDoSZombie209.pppg$i++;
		host210.pppg$o++ --> host2edge --> edge29.pppg$i++;
		edge29.pppg$o++ --> edge2host --> host210.pppg$i++;
		host211.pppg$o++ --> host2edge --> edge29.pppg$i++;
		edge29.pppg$o++ --> edge2host --> host211.pppg$i++;
		host212.pppg$o++ --> host2edge --> edge29.pppg$i++;
		edge29.pppg$o++ --> edge2host --> host212.pppg$i++;
		host_InteractiveServer213.pppg$o++ --> server2edge --> edge29.pppg$i++;
		edge29.pppg$o++ --> server2edge --> host_InteractiveServer213.pppg$i++;
		host_WebServer214.pppg$o++ --> server2edge --> edge29.pppg$i++;
		edge29.pppg$o++ --> server2edge --> host_WebServer214.pppg$i++;
		host_WebServer215.pppg$o++ --> server2edge --> edge30.pppg$i++;
		edge30.pppg$o++ --> server2edge --> host_WebServer215.pppg$i++;
		host216.pppg$o++ --> host2edge --> edge30.pppg$i++;
		edge30.pppg$o++ --> edge2host --> host216.pppg$i++;
		host_BackupServer217.pppg$o++ --> server2edge --> edge30.pppg$i++;
		edge30.pppg$o++ --> server2edge --> host_BackupServer217.pppg$i++;
		host218.pppg$o++ --> host2edge --> edge30.pppg$i++;
		edge30.pppg$o++ --> edge2host --> host218.pppg$i++;
		host219.pppg$o++ --> host2edge --> edge30.pppg$i++;
		edge30.pppg$o++ --> edge2host --> host219.pppg$i++;
		host220.pppg$o++ --> host2edge --> edge30.pppg$i++;
		edge30.pppg$o++ --> edge2host --> host220.pppg$i++;
		host221.pppg$o++ --> host2edge --> edge30.pppg$i++;
		edge30.pppg$o++ --> edge2host --> host221.pppg$i++;
		host222.pppg$o++ --> host2edge --> edge31.pppg$i++;
		edge31.pppg$o++ --> edge2host --> host222.pppg$i++;
		host223.pppg$o++ --> host2edge --> edge31.pppg$i++;
		edge31.pppg$o++ --> edge2host --> host223.pppg$i++;
		host224.pppg$o++ --> host2edge --> edge31.pppg$i++;
		edge31.pppg$o++ --> edge2host --> host224.pppg$i++;
		host225.pppg$o++ --> host2edge --> edge31.pppg$i++;
		edge31.pppg$o++ --> edge2host --> host225.pppg$i++;
		host226.pppg$o++ --> host2edge --> edge31.pppg$i++;
		edge31.pppg$o++ --> edge2host --> host226.pppg$i++;
		host227.pppg$o++ --> host2edge --> edge31.pppg$i++;
		edge31.pppg$o++ --> edge2host --> host227.pppg$i++;
		host_WebServer228.pppg$o++ --> server2edge --> edge31.pppg$i++;
		edge31.pppg$o++ --> server2edge --> host_WebServer228.pppg$i++;
		host229.pppg$o++ --> host2edge --> edge31.pppg$i++;
		edge31.pppg$o++ --> edge2host --> host229.pppg$i++;
		host230.pppg$o++ --> host2edge --> edge31.pppg$i++;
		edge31.pppg$o++ --> edge2host --> host230.pppg$i++;
		host231.pppg$o++ --> host2edge --> edge31.pppg$i++;
		edge31.pppg$o++ --> edge2host --> host231.pppg$i++;
		host232.pppg$o++ --> host2edge --> edge32.pppg$i++;
		edge32.pppg$o++ --> edge2host --> host232.pppg$i++;
		host_MailServer233.pppg$o++ --> server2edge --> edge32.pppg$i++;
		edge32.pppg$o++ --> server2edge --> host_MailServer233.pppg$i++;
		host234.pppg$o++ --> host2edge --> edge32.pppg$i++;
		edge32.pppg$o++ --> edge2host --> host234.pppg$i++;
		host235.pppg$o++ --> host2edge --> edge32.pppg$i++;
		edge32.pppg$o++ --> edge2host --> host235.pppg$i++;
		host236.pppg$o++ --> host2edge --> edge32.pppg$i++;
		edge32.pppg$o++ --> edge2host --> host236.pppg$i++;
		host_WebServer237.pppg$o++ --> server2edge --> edge32.pppg$i++;
		edge32.pppg$o++ --> server2edge --> host_WebServer237.pppg$i++;
		host238.pppg$o++ --> host2edge --> edge32.pppg$i++;
		edge32.pppg$o++ --> edge2host --> host238.pppg$i++;
		host239.pppg$o++ --> host2edge --> edge32.pppg$i++;
		edge32.pppg$o++ --> edge2host --> host239.pppg$i++;
		host240.pppg$o++ --> host2edge --> edge32.pppg$i++;
		edge32.pppg$o++ --> edge2host --> host240.pppg$i++;
		host_InteractiveServer241.pppg$o++ --> server2edge --> edge33.pppg$i++;
		edge33.pppg$o++ --> server2edge --> host_InteractiveServer241.pppg$i++;
		host242.pppg$o++ --> host2edge --> edge33.pppg$i++;
		edge33.pppg$o++ --> edge2host --> host242.pppg$i++;
		host243.pppg$o++ --> host2edge --> edge33.pppg$i++;
		edge33.pppg$o++ --> edge2host --> host243.pppg$i++;
		host244.pppg$o++ --> host2edge --> edge33.pppg$i++;
		edge33.pppg$o++ --> edge2host --> host244.pppg$i++;
		host245.pppg$o++ --> host2edge --> edge33.pppg$i++;
		edge33.pppg$o++ --> edge2host --> host245.pppg$i++;
		host246.pppg$o++ --> host2edge --> edge33.pppg$i++;
		edge33.pppg$o++ --> edge2host --> host246.pppg$i++;
		host_StreamingServer247.pppg$o++ --> server2edge --> edge33.pppg$i++;
		edge33.pppg$o++ --> server2edge --> host_StreamingServer247.pppg$i++;
		host_DDoSZombie248.pppg$o++ --> host2edge --> edge34.pppg$i++;
		edge34.pppg$o++ --> edge2host --> host_DDoSZombie248.pppg$i++;
		host_DDoSZombie249.pppg$o++ --> host2edge --> edge34.pppg$i++;
		edge34.pppg$o++ --> edge2host --> host_DDoSZombie249.pppg$i++;
		host_DDoSZombie250.pppg$o++ --> host2edge --> edge34.pppg$i++;
		edge34.pppg$o++ --> edge2host --> host_DDoSZombie250.pppg$i++;
		host251.pppg$o++ --> host2edge --> edge34.pppg$i++;
		edge34.pppg$o++ --> edge2host --> host251.pppg$i++;
		host_WebServer252.pppg$o++ --> server2edge --> edge34.pppg$i++;
		edge34.pppg$o++ --> server2edge --> host_WebServer252.pppg$i++;
		host253.pppg$o++ --> host2edge --> edge34.pppg$i++;
		edge34.pppg$o++ --> edge2host --> host253.pppg$i++;
		host254.pppg$o++ --> host2edge --> edge34.pppg$i++;
		edge34.pppg$o++ --> edge2host --> host254.pppg$i++;
		host255.pppg$o++ --> host2edge --> edge34.pppg$i++;
		edge34.pppg$o++ --> edge2host --> host255.pppg$i++;
		host256.pppg$o++ --> host2edge --> edge34.pppg$i++;
		edge34.pppg$o++ --> edge2host --> host256.pppg$i++;
		host_DDoSZombie257.pppg$o++ --> host2edge --> edge35.pppg$i++;
		edge35.pppg$o++ --> edge2host --> host_DDoSZombie257.pppg$i++;
		host258.pppg$o++ --> host2edge --> edge35.pppg$i++;
		edge35.pppg$o++ --> edge2host --> host258.pppg$i++;
		host259.pppg$o++ --> host2edge --> edge35.pppg$i++;
		edge35.pppg$o++ --> edge2host --> host259.pppg$i++;
		host_DDoSZombie260.pppg$o++ --> host2edge --> edge35.pppg$i++;
		edge35.pppg$o++ --> edge2host --> host_DDoSZombie260.pppg$i++;
		host261.pppg$o++ --> host2edge --> edge35.pppg$i++;
		edge35.pppg$o++ --> edge2host --> host261.pppg$i++;
		host_DDoSZombie262.pppg$o++ --> host2edge --> edge36.pppg$i++;
		edge36.pppg$o++ --> edge2host --> host_DDoSZombie262.pppg$i++;
		host263.pppg$o++ --> host2edge --> edge36.pppg$i++;
		edge36.pppg$o++ --> edge2host --> host263.pppg$i++;
		host_MailServer264.pppg$o++ --> server2edge --> edge36.pppg$i++;
		edge36.pppg$o++ --> server2edge --> host_MailServer264.pppg$i++;
		host265.pppg$o++ --> host2edge --> edge36.pppg$i++;
		edge36.pppg$o++ --> edge2host --> host265.pppg$i++;
		host_InteractiveServer266.pppg$o++ --> server2edge --> edge36.pppg$i++;
		edge36.pppg$o++ --> server2edge --> host_InteractiveServer266.pppg$i++;
		host267.pppg$o++ --> host2edge --> edge36.pppg$i++;
		edge36.pppg$o++ --> edge2host --> host267.pppg$i++;
		host_WebServer268.pppg$o++ --> server2edge --> edge36.pppg$i++;
		edge36.pppg$o++ --> server2edge --> host_WebServer268.pppg$i++;
		host269.pppg$o++ --> host2edge --> edge36.pppg$i++;
		edge36.pppg$o++ --> edge2host --> host269.pppg$i++;
		host270.pppg$o++ --> host2edge --> edge36.pppg$i++;
		edge36.pppg$o++ --> edge2host --> host270.pppg$i++;
		host271.pppg$o++ --> host2edge --> edge36.pppg$i++;
		edge36.pppg$o++ --> edge2host --> host271.pppg$i++;
		host272.pppg$o++ --> host2edge --> edge37.pppg$i++;
		edge37.pppg$o++ --> edge2host --> host272.pppg$i++;
		host_DDoSZombie273.pppg$o++ --> host2edge --> edge37.pppg$i++;
		edge37.pppg$o++ --> edge2host --> host_DDoSZombie273.pppg$i++;
		host274.pppg$o++ --> host2edge --> edge37.pppg$i++;
		edge37.pppg$o++ --> edge2host --> host274.pppg$i++;
		host275.pppg$o++ --> host2edge --> edge37.pppg$i++;
		edge37.pppg$o++ --> edge2host --> host275.pppg$i++;
		host_DDoSZombie276.pppg$o++ --> host2edge --> edge37.pppg$i++;
		edge37.pppg$o++ --> edge2host --> host_DDoSZombie276.pppg$i++;
		host_DDoSZombie277.pppg$o++ --> host2edge --> edge37.pppg$i++;
		edge37.pppg$o++ --> edge2host --> host_DDoSZombie277.pppg$i++;
		host278.pppg$o++ --> host2edge --> edge37.pppg$i++;
		edge37.pppg$o++ --> edge2host --> host278.pppg$i++;
		host279.pppg$o++ --> host2edge --> edge37.pppg$i++;
		edge37.pppg$o++ --> edge2host --> host279.pppg$i++;
		host280.pppg$o++ --> host2edge --> edge38.pppg$i++;
		edge38.pppg$o++ --> edge2host --> host280.pppg$i++;
		host281.pppg$o++ --> host2edge --> edge38.pppg$i++;
		edge38.pppg$o++ --> edge2host --> host281.pppg$i++;
		host282.pppg$o++ --> host2edge --> edge38.pppg$i++;
		edge38.pppg$o++ --> edge2host --> host282.pppg$i++;
		host283.pppg$o++ --> host2edge --> edge38.pppg$i++;
		edge38.pppg$o++ --> edge2host --> host283.pppg$i++;
		host284.pppg$o++ --> host2edge --> edge38.pppg$i++;
		edge38.pppg$o++ --> edge2host --> host284.pppg$i++;
		host_MailServer285.pppg$o++ --> server2edge --> edge38.pppg$i++;
		edge38.pppg$o++ --> server2edge --> host_MailServer285.pppg$i++;
}

module SAS7
{
	gates:
		inout pppg[];
	submodules:
		connectionManager: ConnectionManager {
			parameters:
				@display("p=20,20;i=block/classifier_s");
		}

		core0: Router {
			parameters:
				@RL();
				@CoreRouter();
				@display("i=abstract/switch");
		}
		gw1: Router {
			parameters:
				@RL();
				@display("i=abstract/router2");
		}
		gw2: Router {
			parameters:
				@RL();
				@display("i=abstract/router2");
		}
		edge3: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge4: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge5: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge6: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge7: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge8: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge9: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge10: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		host11: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host12: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie13: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host14: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host15: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie17: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie20: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_MailServer21: MailServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer22: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer26: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie28: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie30: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer31: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_InteractiveServer36: InteractiveServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie37: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie39: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host42: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host44: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host47: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host48: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie49: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host50: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host51: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host52: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host53: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host54: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host55: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host56: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host57: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host58: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host59: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host60: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host61: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}

	connections:
		pppg++ <--> core0.pppg++;
		pppg++ <--> core0.pppg++;
		pppg++ <--> core0.pppg++;

		core0.pppg++ <--> gateway2core <--> gw1.pppg++;
		core0.pppg++ <--> gateway2core <--> gw2.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge3.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge4.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge5.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge6.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge7.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge8.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge9.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge10.pppg++;
		host11.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host11.pppg$i++;
		host12.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host12.pppg$i++;
		host_DDoSZombie13.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host_DDoSZombie13.pppg$i++;
		host14.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host14.pppg$i++;
		host15.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host15.pppg$i++;
		host16.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host16.pppg$i++;
		host_DDoSZombie17.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host_DDoSZombie17.pppg$i++;
		host18.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host18.pppg$i++;
		host19.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host19.pppg$i++;
		host_DDoSZombie20.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host_DDoSZombie20.pppg$i++;
		host_MailServer21.pppg$o++ --> server2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> server2edge --> host_MailServer21.pppg$i++;
		host_WebServer22.pppg$o++ --> server2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> server2edge --> host_WebServer22.pppg$i++;
		host23.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host23.pppg$i++;
		host24.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host24.pppg$i++;
		host25.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host25.pppg$i++;
		host_WebServer26.pppg$o++ --> server2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> server2edge --> host_WebServer26.pppg$i++;
		host27.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host27.pppg$i++;
		host_DDoSZombie28.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host_DDoSZombie28.pppg$i++;
		host29.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host29.pppg$i++;
		host_DDoSZombie30.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host_DDoSZombie30.pppg$i++;
		host_WebServer31.pppg$o++ --> server2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> server2edge --> host_WebServer31.pppg$i++;
		host32.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host32.pppg$i++;
		host33.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host33.pppg$i++;
		host34.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host34.pppg$i++;
		host35.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host35.pppg$i++;
		host_InteractiveServer36.pppg$o++ --> server2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> server2edge --> host_InteractiveServer36.pppg$i++;
		host_DDoSZombie37.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host_DDoSZombie37.pppg$i++;
		host38.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host38.pppg$i++;
		host_DDoSZombie39.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host_DDoSZombie39.pppg$i++;
		host40.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host40.pppg$i++;
		host41.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host41.pppg$i++;
		host42.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host42.pppg$i++;
		host43.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host43.pppg$i++;
		host44.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host44.pppg$i++;
		host45.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host45.pppg$i++;
		host46.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host46.pppg$i++;
		host47.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host47.pppg$i++;
		host48.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host48.pppg$i++;
		host_DDoSZombie49.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host_DDoSZombie49.pppg$i++;
		host50.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host50.pppg$i++;
		host51.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host51.pppg$i++;
		host52.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host52.pppg$i++;
		host53.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host53.pppg$i++;
		host54.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host54.pppg$i++;
		host55.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host55.pppg$i++;
		host56.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host56.pppg$i++;
		host57.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host57.pppg$i++;
		host58.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host58.pppg$i++;
		host59.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host59.pppg$i++;
		host60.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host60.pppg$i++;
		host61.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host61.pppg$i++;
}

module SAS8
{
	gates:
		inout pppg[];
	submodules:
		connectionManager: ConnectionManager {
			parameters:
				@display("p=20,20;i=block/classifier_s");
		}

		core0: Router {
			parameters:
				@RL();
				@CoreRouter();
				@display("i=abstract/switch");
		}
		gw1: Router {
			parameters:
				@RL();
				@display("i=abstract/router2");
		}
		edge2: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge3: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge4: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge5: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge6: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge7: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge8: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge9: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		host_DDoSZombie10: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie11: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie12: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host13: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host14: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host15: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie17: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie18: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie21: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_InteractiveServer24: InteractiveServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie26: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie28: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie32: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie36: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host42: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_MailServer44: MailServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host47: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer48: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host49: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie50: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host51: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie52: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host53: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer54: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host55: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host56: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie57: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host58: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host59: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host60: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie61: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host62: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer63: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host64: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer65: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host66: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie67: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host68: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host69: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host70: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host71: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host72: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host73: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host74: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie75: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}

	connections:
		pppg++ <--> core0.pppg++;
		pppg++ <--> core0.pppg++;

		core0.pppg++ <--> gateway2core <--> gw1.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge2.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge3.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge4.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge5.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge6.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge7.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge8.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge9.pppg++;
		host_DDoSZombie10.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host_DDoSZombie10.pppg$i++;
		host_DDoSZombie11.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host_DDoSZombie11.pppg$i++;
		host_DDoSZombie12.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host_DDoSZombie12.pppg$i++;
		host13.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host13.pppg$i++;
		host14.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host14.pppg$i++;
		host15.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host15.pppg$i++;
		host16.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host16.pppg$i++;
		host_DDoSZombie17.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host_DDoSZombie17.pppg$i++;
		host_DDoSZombie18.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host_DDoSZombie18.pppg$i++;
		host19.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host19.pppg$i++;
		host20.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host20.pppg$i++;
		host_DDoSZombie21.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host_DDoSZombie21.pppg$i++;
		host22.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host22.pppg$i++;
		host23.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host23.pppg$i++;
		host_InteractiveServer24.pppg$o++ --> server2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> server2edge --> host_InteractiveServer24.pppg$i++;
		host25.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host25.pppg$i++;
		host_DDoSZombie26.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host_DDoSZombie26.pppg$i++;
		host27.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host27.pppg$i++;
		host_DDoSZombie28.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host_DDoSZombie28.pppg$i++;
		host29.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host29.pppg$i++;
		host30.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host30.pppg$i++;
		host31.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host31.pppg$i++;
		host_DDoSZombie32.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host_DDoSZombie32.pppg$i++;
		host33.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host33.pppg$i++;
		host34.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host34.pppg$i++;
		host35.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host35.pppg$i++;
		host_DDoSZombie36.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host_DDoSZombie36.pppg$i++;
		host37.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host37.pppg$i++;
		host38.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host38.pppg$i++;
		host39.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host39.pppg$i++;
		host40.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host40.pppg$i++;
		host41.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host41.pppg$i++;
		host42.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host42.pppg$i++;
		host43.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host43.pppg$i++;
		host_MailServer44.pppg$o++ --> server2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> server2edge --> host_MailServer44.pppg$i++;
		host45.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host45.pppg$i++;
		host46.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host46.pppg$i++;
		host47.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host47.pppg$i++;
		host_WebServer48.pppg$o++ --> server2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> server2edge --> host_WebServer48.pppg$i++;
		host49.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host49.pppg$i++;
		host_DDoSZombie50.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host_DDoSZombie50.pppg$i++;
		host51.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host51.pppg$i++;
		host_DDoSZombie52.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host_DDoSZombie52.pppg$i++;
		host53.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host53.pppg$i++;
		host_WebServer54.pppg$o++ --> server2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> server2edge --> host_WebServer54.pppg$i++;
		host55.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host55.pppg$i++;
		host56.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host56.pppg$i++;
		host_DDoSZombie57.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host_DDoSZombie57.pppg$i++;
		host58.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host58.pppg$i++;
		host59.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host59.pppg$i++;
		host60.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host60.pppg$i++;
		host_DDoSZombie61.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host_DDoSZombie61.pppg$i++;
		host62.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host62.pppg$i++;
		host_WebServer63.pppg$o++ --> server2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> server2edge --> host_WebServer63.pppg$i++;
		host64.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host64.pppg$i++;
		host_WebServer65.pppg$o++ --> server2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> server2edge --> host_WebServer65.pppg$i++;
		host66.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host66.pppg$i++;
		host_DDoSZombie67.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host_DDoSZombie67.pppg$i++;
		host68.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host68.pppg$i++;
		host69.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host69.pppg$i++;
		host70.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host70.pppg$i++;
		host71.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host71.pppg$i++;
		host72.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host72.pppg$i++;
		host73.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host73.pppg$i++;
		host74.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host74.pppg$i++;
		host_DDoSZombie75.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host_DDoSZombie75.pppg$i++;
}

module SAS9
{
	gates:
		inout pppg[];
	submodules:
		connectionManager: ConnectionManager {
			parameters:
				@display("p=20,20;i=block/classifier_s");
		}

		core0: Router {
			parameters:
				@RL();
				@CoreRouter();
				@display("i=abstract/switch");
		}
		gw1: Router {
			parameters:
				@RL();
				@display("i=abstract/router2");
		}
		edge2: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge3: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge4: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge5: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		edge6: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		host7: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host8: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie9: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host10: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host11: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host12: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer13: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie14: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie15: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_MailServer21: MailServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie26: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie29: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie39: DDoSZombie {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_InteractiveServer40: InteractiveServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer41: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}

	connections:
		pppg++ <--> core0.pppg++;

		core0.pppg++ <--> gateway2core <--> gw1.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge2.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge3.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge4.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge5.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge6.pppg++;
		host7.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host7.pppg$i++;
		host8.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host8.pppg$i++;
		host_DDoSZombie9.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host_DDoSZombie9.pppg$i++;
		host10.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host10.pppg$i++;
		host11.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host11.pppg$i++;
		host12.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host12.pppg$i++;
		host_WebServer13.pppg$o++ --> server2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> server2edge --> host_WebServer13.pppg$i++;
		host_DDoSZombie14.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host_DDoSZombie14.pppg$i++;
		host_DDoSZombie15.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host_DDoSZombie15.pppg$i++;
		host16.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host16.pppg$i++;
		host17.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host17.pppg$i++;
		host18.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host18.pppg$i++;
		host19.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host19.pppg$i++;
		host20.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host20.pppg$i++;
		host_MailServer21.pppg$o++ --> server2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> server2edge --> host_MailServer21.pppg$i++;
		host22.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host22.pppg$i++;
		host23.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host23.pppg$i++;
		host24.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host24.pppg$i++;
		host25.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host25.pppg$i++;
		host_DDoSZombie26.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host_DDoSZombie26.pppg$i++;
		host27.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host27.pppg$i++;
		host28.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host28.pppg$i++;
		host_DDoSZombie29.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host_DDoSZombie29.pppg$i++;
		host30.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host30.pppg$i++;
		host31.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host31.pppg$i++;
		host32.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host32.pppg$i++;
		host33.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host33.pppg$i++;
		host34.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host34.pppg$i++;
		host35.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host35.pppg$i++;
		host36.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host36.pppg$i++;
		host37.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host37.pppg$i++;
		host38.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host38.pppg$i++;
		host_DDoSZombie39.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host_DDoSZombie39.pppg$i++;
		host_InteractiveServer40.pppg$o++ --> server2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> server2edge --> host_InteractiveServer40.pppg$i++;
		host_WebServer41.pppg$o++ --> server2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> server2edge --> host_WebServer41.pppg$i++;
}

