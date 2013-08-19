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
				totalCountOfAS = 3;
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

		tas0: TAS0 {
			parameters:
				@AS();
				@display("i=misc/globe_s");
		}
		sas1: SAS1 {
			parameters:
				@AS();
				@display("i=misc/cloud_s");
		}
		sas2: SAS2 {
			parameters:
				@AS();
				@display("i=misc/cloud_s");
		}

	connections:
		tas0.pppg++ <--> stub2transit <--> sas1.pppg++;
		tas0.pppg++ <--> stub2transit <--> sas2.pppg++;
		sas1.pppg++ <--> stub2stub <--> sas2.pppg++;

}

network Inet extends Internet
{
	parameters:
}

module TAS0
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
		host_WebServer5: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_DDoSZombie6: DDoSZombie {
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

	connections:
		pppg++ <--> core0.pppg++;
		pppg++ <--> core0.pppg++;

		core0.pppg++ <--> gateway2core <--> gw1.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge2.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge3.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge4.pppg++;
		host_WebServer5.pppg$o++ --> server2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> server2edge --> host_WebServer5.pppg$i++;
		host_DDoSZombie6.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host_DDoSZombie6.pppg$i++;
		host7.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host7.pppg$i++;
		host8.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host8.pppg$i++;
		host9.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host9.pppg$i++;
		host10.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host10.pppg$i++;
}

module SAS1
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
		host_WebServer23: WebServer {
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
		host_DDoSZombie27: DDoSZombie {
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
		host_DDoSZombie8.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host_DDoSZombie8.pppg$i++;
		host9.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host9.pppg$i++;
		host10.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host10.pppg$i++;
		host11.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host11.pppg$i++;
		host12.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host12.pppg$i++;
		host13.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host13.pppg$i++;
		host_DDoSZombie14.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host_DDoSZombie14.pppg$i++;
		host15.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host15.pppg$i++;
		host16.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host16.pppg$i++;
		host17.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host17.pppg$i++;
		host_DDoSZombie18.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host_DDoSZombie18.pppg$i++;
		host19.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host19.pppg$i++;
		host20.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host20.pppg$i++;
		host21.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host21.pppg$i++;
		host22.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host22.pppg$i++;
		host_WebServer23.pppg$o++ --> server2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> server2edge --> host_WebServer23.pppg$i++;
		host24.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host24.pppg$i++;
		host25.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host25.pppg$i++;
		host26.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host26.pppg$i++;
		host_DDoSZombie27.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host_DDoSZombie27.pppg$i++;
		host28.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host28.pppg$i++;
		host29.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host29.pppg$i++;
}

module SAS2
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
		host_DDoSZombie6: DDoSZombie {
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

	connections:
		pppg++ <--> core0.pppg++;
		pppg++ <--> core0.pppg++;

		core0.pppg++ <--> gateway2core <--> gw1.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge2.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge3.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge4.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge5.pppg++;
		host_DDoSZombie6.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host_DDoSZombie6.pppg$i++;
		host7.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host7.pppg$i++;
		host8.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host8.pppg$i++;
		host9.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host9.pppg$i++;
		host10.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host10.pppg$i++;
		host_DDoSZombie11.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host_DDoSZombie11.pppg$i++;
		host_DDoSZombie12.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host_DDoSZombie12.pppg$i++;
		host_WebServer13.pppg$o++ --> server2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> server2edge --> host_WebServer13.pppg$i++;
		host_DDoSZombie14.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host_DDoSZombie14.pppg$i++;
		host15.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host15.pppg$i++;
		host16.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host16.pppg$i++;
}

