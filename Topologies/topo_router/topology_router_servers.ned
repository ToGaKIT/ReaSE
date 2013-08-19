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

module Internet
{
	parameters:
		@Internet();
	submodules:
		tgmNetworkConfigurator: TGMNetworkConfigurator {
			parameters:
				totalCountOfAS = 0;
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
		host_WebServer33: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_StreamingServer35: StreamingServer {
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
		host_WebServer40: WebServer {
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
		host50: InetUserHost {
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
		host_WebServer53: WebServer {
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
		host96: InetUserHost {
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
		host_InteractiveServer100: InteractiveServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer101: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host102: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host103: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host104: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_InteractiveServer105: InteractiveServer {
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
		host_MailServer110: MailServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host111: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host112: InetUserHost {
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
		host117: InetUserHost {
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
		host128: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host129: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer130: WebServer {
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
		host133: InetUserHost {
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
		host_NameServer137: NameServer {
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
		host144: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host145: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host146: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_InteractiveServer147: InteractiveServer {
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
		host160: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host161: InetUserHost {
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
		host165: InetUserHost {
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
		host169: InetUserHost {
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
		host_WebServer172: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host173: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host174: InetUserHost {
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
		host177: InetUserHost {
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
		host182: InetUserHost {
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
		host186: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host187: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host188: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host189: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host190: InetUserHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_MailServer191: MailServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host_WebServer192: WebServer {
			parameters:
				@RL();
				@display("i=device/laptop");
		}

	connections:
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
		gw2.pppg++ <--> edge2gateway <--> edge12.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge13.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge14.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge15.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge16.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge17.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge18.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge19.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge20.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge21.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge22.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge23.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge24.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge25.pppg++;
		host26.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host26.pppg$i++;
		host27.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host27.pppg$i++;
		host28.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host28.pppg$i++;
		host29.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host29.pppg$i++;
		host30.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host30.pppg$i++;
		host31.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host31.pppg$i++;
		host32.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host32.pppg$i++;
		host_WebServer33.pppg$o++ --> server2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> server2edge --> host_WebServer33.pppg$i++;
		host34.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host34.pppg$i++;
		host_StreamingServer35.pppg$o++ --> server2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> server2edge --> host_StreamingServer35.pppg$i++;
		host36.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host36.pppg$i++;
		host_WebServer37.pppg$o++ --> server2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> server2edge --> host_WebServer37.pppg$i++;
		host38.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host38.pppg$i++;
		host39.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host39.pppg$i++;
		host_WebServer40.pppg$o++ --> server2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> server2edge --> host_WebServer40.pppg$i++;
		host41.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host41.pppg$i++;
		host42.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host42.pppg$i++;
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
		host48.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host48.pppg$i++;
		host49.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host49.pppg$i++;
		host50.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host50.pppg$i++;
		host_WebServer51.pppg$o++ --> server2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> server2edge --> host_WebServer51.pppg$i++;
		host52.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host52.pppg$i++;
		host_WebServer53.pppg$o++ --> server2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> server2edge --> host_WebServer53.pppg$i++;
		host54.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host54.pppg$i++;
		host55.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host55.pppg$i++;
		host56.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host56.pppg$i++;
		host57.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host57.pppg$i++;
		host58.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host58.pppg$i++;
		host59.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host59.pppg$i++;
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
		host67.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host67.pppg$i++;
		host68.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host68.pppg$i++;
		host69.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host69.pppg$i++;
		host70.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host70.pppg$i++;
		host71.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host71.pppg$i++;
		host72.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host72.pppg$i++;
		host73.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host73.pppg$i++;
		host74.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host74.pppg$i++;
		host75.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host75.pppg$i++;
		host76.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host76.pppg$i++;
		host77.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host77.pppg$i++;
		host78.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host78.pppg$i++;
		host79.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host79.pppg$i++;
		host80.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host80.pppg$i++;
		host81.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host81.pppg$i++;
		host82.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host82.pppg$i++;
		host83.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host83.pppg$i++;
		host84.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host84.pppg$i++;
		host85.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host85.pppg$i++;
		host86.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host86.pppg$i++;
		host87.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host87.pppg$i++;
		host88.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host88.pppg$i++;
		host89.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host89.pppg$i++;
		host90.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host90.pppg$i++;
		host91.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host91.pppg$i++;
		host92.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host92.pppg$i++;
		host93.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host93.pppg$i++;
		host94.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host94.pppg$i++;
		host95.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host95.pppg$i++;
		host96.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host96.pppg$i++;
		host97.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host97.pppg$i++;
		host98.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host98.pppg$i++;
		host99.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host99.pppg$i++;
		host_InteractiveServer100.pppg$o++ --> server2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> server2edge --> host_InteractiveServer100.pppg$i++;
		host_WebServer101.pppg$o++ --> server2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> server2edge --> host_WebServer101.pppg$i++;
		host102.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host102.pppg$i++;
		host103.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host103.pppg$i++;
		host104.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host104.pppg$i++;
		host_InteractiveServer105.pppg$o++ --> server2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> server2edge --> host_InteractiveServer105.pppg$i++;
		host106.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host106.pppg$i++;
		host107.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host107.pppg$i++;
		host108.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host108.pppg$i++;
		host109.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host109.pppg$i++;
		host_MailServer110.pppg$o++ --> server2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> server2edge --> host_MailServer110.pppg$i++;
		host111.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host111.pppg$i++;
		host112.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host112.pppg$i++;
		host113.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host113.pppg$i++;
		host114.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host114.pppg$i++;
		host115.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host115.pppg$i++;
		host116.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host116.pppg$i++;
		host117.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host117.pppg$i++;
		host118.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host118.pppg$i++;
		host119.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host119.pppg$i++;
		host120.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host120.pppg$i++;
		host121.pppg$o++ --> host2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> edge2host --> host121.pppg$i++;
		host122.pppg$o++ --> host2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> edge2host --> host122.pppg$i++;
		host123.pppg$o++ --> host2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> edge2host --> host123.pppg$i++;
		host124.pppg$o++ --> host2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> edge2host --> host124.pppg$i++;
		host125.pppg$o++ --> host2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> edge2host --> host125.pppg$i++;
		host126.pppg$o++ --> host2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> edge2host --> host126.pppg$i++;
		host127.pppg$o++ --> host2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> edge2host --> host127.pppg$i++;
		host128.pppg$o++ --> host2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> edge2host --> host128.pppg$i++;
		host129.pppg$o++ --> host2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> edge2host --> host129.pppg$i++;
		host_WebServer130.pppg$o++ --> server2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> server2edge --> host_WebServer130.pppg$i++;
		host131.pppg$o++ --> host2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> edge2host --> host131.pppg$i++;
		host132.pppg$o++ --> host2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> edge2host --> host132.pppg$i++;
		host133.pppg$o++ --> host2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> edge2host --> host133.pppg$i++;
		host134.pppg$o++ --> host2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> edge2host --> host134.pppg$i++;
		host135.pppg$o++ --> host2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> edge2host --> host135.pppg$i++;
		host136.pppg$o++ --> host2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> edge2host --> host136.pppg$i++;
		host_NameServer137.pppg$o++ --> server2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> server2edge --> host_NameServer137.pppg$i++;
		host138.pppg$o++ --> host2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> edge2host --> host138.pppg$i++;
		host139.pppg$o++ --> host2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> edge2host --> host139.pppg$i++;
		host140.pppg$o++ --> host2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> edge2host --> host140.pppg$i++;
		host141.pppg$o++ --> host2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> edge2host --> host141.pppg$i++;
		host142.pppg$o++ --> host2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> edge2host --> host142.pppg$i++;
		host143.pppg$o++ --> host2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> edge2host --> host143.pppg$i++;
		host144.pppg$o++ --> host2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> edge2host --> host144.pppg$i++;
		host145.pppg$o++ --> host2edge --> edge20.pppg$i++;
		edge20.pppg$o++ --> edge2host --> host145.pppg$i++;
		host146.pppg$o++ --> host2edge --> edge20.pppg$i++;
		edge20.pppg$o++ --> edge2host --> host146.pppg$i++;
		host_InteractiveServer147.pppg$o++ --> server2edge --> edge20.pppg$i++;
		edge20.pppg$o++ --> server2edge --> host_InteractiveServer147.pppg$i++;
		host148.pppg$o++ --> host2edge --> edge20.pppg$i++;
		edge20.pppg$o++ --> edge2host --> host148.pppg$i++;
		host149.pppg$o++ --> host2edge --> edge20.pppg$i++;
		edge20.pppg$o++ --> edge2host --> host149.pppg$i++;
		host150.pppg$o++ --> host2edge --> edge20.pppg$i++;
		edge20.pppg$o++ --> edge2host --> host150.pppg$i++;
		host151.pppg$o++ --> host2edge --> edge20.pppg$i++;
		edge20.pppg$o++ --> edge2host --> host151.pppg$i++;
		host152.pppg$o++ --> host2edge --> edge20.pppg$i++;
		edge20.pppg$o++ --> edge2host --> host152.pppg$i++;
		host153.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host153.pppg$i++;
		host154.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host154.pppg$i++;
		host155.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host155.pppg$i++;
		host156.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host156.pppg$i++;
		host157.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host157.pppg$i++;
		host158.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host158.pppg$i++;
		host159.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host159.pppg$i++;
		host160.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host160.pppg$i++;
		host161.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host161.pppg$i++;
		host162.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host162.pppg$i++;
		host163.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host163.pppg$i++;
		host164.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host164.pppg$i++;
		host165.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host165.pppg$i++;
		host166.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host166.pppg$i++;
		host167.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host167.pppg$i++;
		host168.pppg$o++ --> host2edge --> edge22.pppg$i++;
		edge22.pppg$o++ --> edge2host --> host168.pppg$i++;
		host169.pppg$o++ --> host2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> edge2host --> host169.pppg$i++;
		host170.pppg$o++ --> host2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> edge2host --> host170.pppg$i++;
		host171.pppg$o++ --> host2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> edge2host --> host171.pppg$i++;
		host_WebServer172.pppg$o++ --> server2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> server2edge --> host_WebServer172.pppg$i++;
		host173.pppg$o++ --> host2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> edge2host --> host173.pppg$i++;
		host174.pppg$o++ --> host2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> edge2host --> host174.pppg$i++;
		host175.pppg$o++ --> host2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> edge2host --> host175.pppg$i++;
		host176.pppg$o++ --> host2edge --> edge23.pppg$i++;
		edge23.pppg$o++ --> edge2host --> host176.pppg$i++;
		host177.pppg$o++ --> host2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> edge2host --> host177.pppg$i++;
		host178.pppg$o++ --> host2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> edge2host --> host178.pppg$i++;
		host179.pppg$o++ --> host2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> edge2host --> host179.pppg$i++;
		host180.pppg$o++ --> host2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> edge2host --> host180.pppg$i++;
		host181.pppg$o++ --> host2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> edge2host --> host181.pppg$i++;
		host182.pppg$o++ --> host2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> edge2host --> host182.pppg$i++;
		host_MailServer183.pppg$o++ --> server2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> server2edge --> host_MailServer183.pppg$i++;
		host184.pppg$o++ --> host2edge --> edge24.pppg$i++;
		edge24.pppg$o++ --> edge2host --> host184.pppg$i++;
		host185.pppg$o++ --> host2edge --> edge25.pppg$i++;
		edge25.pppg$o++ --> edge2host --> host185.pppg$i++;
		host186.pppg$o++ --> host2edge --> edge25.pppg$i++;
		edge25.pppg$o++ --> edge2host --> host186.pppg$i++;
		host187.pppg$o++ --> host2edge --> edge25.pppg$i++;
		edge25.pppg$o++ --> edge2host --> host187.pppg$i++;
		host188.pppg$o++ --> host2edge --> edge25.pppg$i++;
		edge25.pppg$o++ --> edge2host --> host188.pppg$i++;
		host189.pppg$o++ --> host2edge --> edge25.pppg$i++;
		edge25.pppg$o++ --> edge2host --> host189.pppg$i++;
		host190.pppg$o++ --> host2edge --> edge25.pppg$i++;
		edge25.pppg$o++ --> edge2host --> host190.pppg$i++;
		host_MailServer191.pppg$o++ --> server2edge --> edge25.pppg$i++;
		edge25.pppg$o++ --> server2edge --> host_MailServer191.pppg$i++;
		host_WebServer192.pppg$o++ --> server2edge --> edge25.pppg$i++;
		edge25.pppg$o++ --> server2edge --> host_WebServer192.pppg$i++;

}

network Inet extends Internet
{
	parameters:
}

