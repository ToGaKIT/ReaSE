
channel host2edge extends ned.DatarateChannel
{
	parameters:
		delay = 1us;
		datarate = 1Mbps;
}
channel edge2host extends ned.DatarateChannel
{
	parameters:
		delay = 1us;
		datarate = 1Mbps;
}
channel server2edge extends ned.DatarateChannel
{
	parameters:
		delay = 1us;
		datarate = 10Mbps;
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
		datarate = 622Mbps;
}
channel core2core extends ned.DatarateChannel
{
	parameters:
		delay = 1us;
		datarate = 1000Mbps;
}
channel stub2stub extends ned.DatarateChannel
{
	parameters:
		delay = 1us;
		datarate = 1000Mbps;
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
	submodules:
		sas0: SAS0 {
			parameters:
				@display("i=misc/cloud_s");
		}
		tas1: TAS1 {
			parameters:
				@display("i=misc/globe_s");
		}
		sas2: SAS2 {
			parameters:
				@display("i=misc/cloud_s");
		}
		sas3: SAS3 {
			parameters:
				@display("i=misc/cloud_s");
		}
		sas4: SAS4 {
			parameters:
				@display("i=misc/cloud_s");
		}

	connections:
		sas0.pppg++ <--> stub2transit <--> tas1.pppg++;
		sas0.pppg++ <--> stub2stub <--> sas2.pppg++;
		sas0.pppg++ <--> stub2stub <--> sas3.pppg++;
		tas1.pppg++ <--> stub2transit <--> sas2.pppg++;
		tas1.pppg++ <--> stub2transit <--> sas3.pppg++;
		tas1.pppg++ <--> stub2transit <--> sas4.pppg++;
		sas2.pppg++ <--> stub2stub <--> sas4.pppg++;

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
		core0: Router {
			parameters:
				@display("i=abstract/switch");
		}
		core1: Router {
			parameters:
				@display("i=abstract/switch");
		}
		gw2: Router {
			parameters:
				@display("i=abstract/router2");
		}
		edge3: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge4: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge5: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge6: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge7: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge8: Router {
			parameters:
				@display("i=abstract/router");
		}
		host9: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host10: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host11: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host12: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host13: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host14: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host15: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host16: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host38: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host39: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host40: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host41: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host42: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host43: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host44: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host45: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host46: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host47: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host48: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host49: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host50: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host51: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host52: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host53: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host54: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host55: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host56: StandardHost {
			parameters:
				@display("i=device/laptop");
		}

	connections:
		pppg++ <--> core0.pppg++;
		pppg++ <--> core1.pppg++;
		pppg++ <--> core0.pppg++;

		core0.pppg++ <--> core2core <--> core1.pppg++;
		core0.pppg++ <--> gateway2core <--> gw2.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge3.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge4.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge5.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge6.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge7.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge8.pppg++;
		host9.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host9.pppg$i++;
		host10.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host10.pppg$i++;
		host11.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host11.pppg$i++;
		host12.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host12.pppg$i++;
		host13.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host13.pppg$i++;
		host14.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host14.pppg$i++;
		host15.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host15.pppg$i++;
		host16.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host16.pppg$i++;
		host17.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host17.pppg$i++;
		host18.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host18.pppg$i++;
		host19.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host19.pppg$i++;
		host20.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host20.pppg$i++;
		host21.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host21.pppg$i++;
		host22.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host22.pppg$i++;
		host23.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host23.pppg$i++;
		host24.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host24.pppg$i++;
		host25.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host25.pppg$i++;
		host26.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host26.pppg$i++;
		host27.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host27.pppg$i++;
		host28.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host28.pppg$i++;
		host29.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host29.pppg$i++;
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
		host35.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host35.pppg$i++;
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
		host48.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host48.pppg$i++;
		host49.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host49.pppg$i++;
		host50.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host50.pppg$i++;
		host51.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host51.pppg$i++;
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
}

module TAS1
{
	gates:
		inout pppg[];
	submodules:
		core0: Router {
			parameters:
				@display("i=abstract/switch");
		}
		core1: Router {
			parameters:
				@display("i=abstract/switch");
		}
		gw2: Router {
			parameters:
				@display("i=abstract/router2");
		}
		gw3: Router {
			parameters:
				@display("i=abstract/router2");
		}
		edge4: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge5: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge6: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge7: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge8: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge9: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge10: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge11: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge12: Router {
			parameters:
				@display("i=abstract/router");
		}
		host13: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host14: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host15: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host16: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host38: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host39: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host40: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host41: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host42: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host43: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host44: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host45: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host46: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host47: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host48: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host49: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host50: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host51: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host52: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host53: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host54: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host55: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host56: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host57: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host58: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host59: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host60: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host61: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host62: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host63: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host64: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host65: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host66: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host67: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host68: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host69: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host70: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host71: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host72: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host73: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host74: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host75: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host76: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host77: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host78: StandardHost {
			parameters:
				@display("i=device/laptop");
		}

	connections:
		pppg++ <--> core0.pppg++;
		pppg++ <--> core1.pppg++;
		pppg++ <--> core0.pppg++;
		pppg++ <--> core1.pppg++;

		core0.pppg++ <--> core2core <--> core1.pppg++;
		core0.pppg++ <--> gateway2core <--> gw2.pppg++;
		core1.pppg++ <--> gateway2core <--> gw3.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge4.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge5.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge6.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge7.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge8.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge9.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge10.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge11.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge12.pppg++;
		host13.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host13.pppg$i++;
		host14.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host14.pppg$i++;
		host15.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host15.pppg$i++;
		host16.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host16.pppg$i++;
		host17.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host17.pppg$i++;
		host18.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host18.pppg$i++;
		host19.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host19.pppg$i++;
		host20.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host20.pppg$i++;
		host21.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host21.pppg$i++;
		host22.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host22.pppg$i++;
		host23.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host23.pppg$i++;
		host24.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host24.pppg$i++;
		host25.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host25.pppg$i++;
		host26.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host26.pppg$i++;
		host27.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host27.pppg$i++;
		host28.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host28.pppg$i++;
		host29.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host29.pppg$i++;
		host30.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host30.pppg$i++;
		host31.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host31.pppg$i++;
		host32.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host32.pppg$i++;
		host33.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host33.pppg$i++;
		host34.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host34.pppg$i++;
		host35.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host35.pppg$i++;
		host36.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host36.pppg$i++;
		host37.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host37.pppg$i++;
		host38.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host38.pppg$i++;
		host39.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host39.pppg$i++;
		host40.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host40.pppg$i++;
		host41.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host41.pppg$i++;
		host42.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host42.pppg$i++;
		host43.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host43.pppg$i++;
		host44.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host44.pppg$i++;
		host45.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host45.pppg$i++;
		host46.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host46.pppg$i++;
		host47.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host47.pppg$i++;
		host48.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host48.pppg$i++;
		host49.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host49.pppg$i++;
		host50.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host50.pppg$i++;
		host51.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host51.pppg$i++;
		host52.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host52.pppg$i++;
		host53.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host53.pppg$i++;
		host54.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host54.pppg$i++;
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
		host61.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host61.pppg$i++;
		host62.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host62.pppg$i++;
		host63.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host63.pppg$i++;
		host64.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host64.pppg$i++;
		host65.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host65.pppg$i++;
		host66.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host66.pppg$i++;
		host67.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host67.pppg$i++;
		host68.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host68.pppg$i++;
		host69.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host69.pppg$i++;
		host70.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host70.pppg$i++;
		host71.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host71.pppg$i++;
		host72.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host72.pppg$i++;
		host73.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host73.pppg$i++;
		host74.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host74.pppg$i++;
		host75.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host75.pppg$i++;
		host76.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host76.pppg$i++;
		host77.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host77.pppg$i++;
		host78.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host78.pppg$i++;
}

module SAS2
{
	gates:
		inout pppg[];
	submodules:
		core0: Router {
			parameters:
				@display("i=abstract/switch");
		}
		core1: Router {
			parameters:
				@display("i=abstract/switch");
		}
		gw2: Router {
			parameters:
				@display("i=abstract/router2");
		}
		edge3: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge4: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge5: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge6: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge7: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge8: Router {
			parameters:
				@display("i=abstract/router");
		}
		host9: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host10: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host11: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host12: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host13: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host14: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host15: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host16: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host38: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host39: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host40: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host41: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host42: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host43: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host44: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host45: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host46: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host47: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host48: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host49: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host50: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host51: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host52: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host53: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host54: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host55: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host56: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host57: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host58: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host59: StandardHost {
			parameters:
				@display("i=device/laptop");
		}

	connections:
		pppg++ <--> core0.pppg++;
		pppg++ <--> core1.pppg++;
		pppg++ <--> core0.pppg++;

		core0.pppg++ <--> core2core <--> core1.pppg++;
		core0.pppg++ <--> gateway2core <--> gw2.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge3.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge4.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge5.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge6.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge7.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge8.pppg++;
		host9.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host9.pppg$i++;
		host10.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host10.pppg$i++;
		host11.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host11.pppg$i++;
		host12.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host12.pppg$i++;
		host13.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host13.pppg$i++;
		host14.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host14.pppg$i++;
		host15.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host15.pppg$i++;
		host16.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host16.pppg$i++;
		host17.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host17.pppg$i++;
		host18.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host18.pppg$i++;
		host19.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host19.pppg$i++;
		host20.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host20.pppg$i++;
		host21.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host21.pppg$i++;
		host22.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host22.pppg$i++;
		host23.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host23.pppg$i++;
		host24.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host24.pppg$i++;
		host25.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host25.pppg$i++;
		host26.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host26.pppg$i++;
		host27.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host27.pppg$i++;
		host28.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host28.pppg$i++;
		host29.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host29.pppg$i++;
		host30.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host30.pppg$i++;
		host31.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host31.pppg$i++;
		host32.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host32.pppg$i++;
		host33.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host33.pppg$i++;
		host34.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host34.pppg$i++;
		host35.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host35.pppg$i++;
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
		host41.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host41.pppg$i++;
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
		host49.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host49.pppg$i++;
		host50.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host50.pppg$i++;
		host51.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host51.pppg$i++;
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
}

module SAS3
{
	gates:
		inout pppg[];
	submodules:
		core0: Router {
			parameters:
				@display("i=abstract/switch");
		}
		core1: Router {
			parameters:
				@display("i=abstract/switch");
		}
		gw2: Router {
			parameters:
				@display("i=abstract/router2");
		}
		gw3: Router {
			parameters:
				@display("i=abstract/router2");
		}
		edge4: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge5: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge6: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge7: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge8: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge9: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge10: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge11: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge12: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge13: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge14: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge15: Router {
			parameters:
				@display("i=abstract/router");
		}
		host16: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host38: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host39: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host40: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host41: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host42: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host43: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host44: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host45: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host46: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host47: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host48: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host49: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host50: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host51: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host52: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host53: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host54: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host55: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host56: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host57: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host58: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host59: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host60: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host61: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host62: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host63: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host64: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host65: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host66: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host67: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host68: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host69: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host70: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host71: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host72: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host73: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host74: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host75: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host76: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host77: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host78: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host79: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host80: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host81: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host82: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host83: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host84: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host85: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host86: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host87: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host88: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host89: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host90: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host91: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host92: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host93: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host94: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host95: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host96: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host97: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host98: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host99: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host100: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host101: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host102: StandardHost {
			parameters:
				@display("i=device/laptop");
		}

	connections:
		pppg++ <--> core0.pppg++;
		pppg++ <--> core1.pppg++;

		core0.pppg++ <--> core2core <--> core1.pppg++;
		core0.pppg++ <--> gateway2core <--> gw2.pppg++;
		core1.pppg++ <--> gateway2core <--> gw3.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge4.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge5.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge6.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge7.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge8.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge9.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge10.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge11.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge12.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge13.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge14.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge15.pppg++;
		host16.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host16.pppg$i++;
		host17.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host17.pppg$i++;
		host18.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host18.pppg$i++;
		host19.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host19.pppg$i++;
		host20.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host20.pppg$i++;
		host21.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host21.pppg$i++;
		host22.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host22.pppg$i++;
		host23.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host23.pppg$i++;
		host24.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host24.pppg$i++;
		host25.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host25.pppg$i++;
		host26.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host26.pppg$i++;
		host27.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host27.pppg$i++;
		host28.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host28.pppg$i++;
		host29.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host29.pppg$i++;
		host30.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host30.pppg$i++;
		host31.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host31.pppg$i++;
		host32.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host32.pppg$i++;
		host33.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host33.pppg$i++;
		host34.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host34.pppg$i++;
		host35.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host35.pppg$i++;
		host36.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host36.pppg$i++;
		host37.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host37.pppg$i++;
		host38.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host38.pppg$i++;
		host39.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host39.pppg$i++;
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
		host49.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host49.pppg$i++;
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
		host55.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host55.pppg$i++;
		host56.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host56.pppg$i++;
		host57.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host57.pppg$i++;
		host58.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host58.pppg$i++;
		host59.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host59.pppg$i++;
		host60.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host60.pppg$i++;
		host61.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host61.pppg$i++;
		host62.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host62.pppg$i++;
		host63.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host63.pppg$i++;
		host64.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host64.pppg$i++;
		host65.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host65.pppg$i++;
		host66.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host66.pppg$i++;
		host67.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host67.pppg$i++;
		host68.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host68.pppg$i++;
		host69.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host69.pppg$i++;
		host70.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host70.pppg$i++;
		host71.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host71.pppg$i++;
		host72.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host72.pppg$i++;
		host73.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host73.pppg$i++;
		host74.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host74.pppg$i++;
		host75.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host75.pppg$i++;
		host76.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host76.pppg$i++;
		host77.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host77.pppg$i++;
		host78.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host78.pppg$i++;
		host79.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host79.pppg$i++;
		host80.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host80.pppg$i++;
		host81.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host81.pppg$i++;
		host82.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host82.pppg$i++;
		host83.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host83.pppg$i++;
		host84.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host84.pppg$i++;
		host85.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host85.pppg$i++;
		host86.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host86.pppg$i++;
		host87.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host87.pppg$i++;
		host88.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host88.pppg$i++;
		host89.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host89.pppg$i++;
		host90.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host90.pppg$i++;
		host91.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host91.pppg$i++;
		host92.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host92.pppg$i++;
		host93.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host93.pppg$i++;
		host94.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host94.pppg$i++;
		host95.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host95.pppg$i++;
		host96.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host96.pppg$i++;
		host97.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host97.pppg$i++;
		host98.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host98.pppg$i++;
		host99.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host99.pppg$i++;
		host100.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host100.pppg$i++;
		host101.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host101.pppg$i++;
		host102.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host102.pppg$i++;
}

module SAS4
{
	gates:
		inout pppg[];
	submodules:
		core0: Router {
			parameters:
				@display("i=abstract/switch");
		}
		core1: Router {
			parameters:
				@display("i=abstract/switch");
		}
		gw2: Router {
			parameters:
				@display("i=abstract/router2");
		}
		edge3: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge4: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge5: Router {
			parameters:
				@display("i=abstract/router");
		}
		edge6: Router {
			parameters:
				@display("i=abstract/router");
		}
		host7: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host8: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host9: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host10: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host11: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host12: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host13: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host14: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host15: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host16: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@display("i=device/laptop");
		}

	connections:
		pppg++ <--> core0.pppg++;
		pppg++ <--> core1.pppg++;

		core0.pppg++ <--> core2core <--> core1.pppg++;
		core0.pppg++ <--> gateway2core <--> gw2.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge3.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge4.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge5.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge6.pppg++;
		host7.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host7.pppg$i++;
		host8.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host8.pppg$i++;
		host9.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host9.pppg$i++;
		host10.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host10.pppg$i++;
		host11.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host11.pppg$i++;
		host12.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host12.pppg$i++;
		host13.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host13.pppg$i++;
		host14.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host14.pppg$i++;
		host15.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host15.pppg$i++;
		host16.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host16.pppg$i++;
		host17.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host17.pppg$i++;
		host18.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host18.pppg$i++;
		host19.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host19.pppg$i++;
		host20.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host20.pppg$i++;
		host21.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host21.pppg$i++;
		host22.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host22.pppg$i++;
		host23.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host23.pppg$i++;
		host24.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host24.pppg$i++;
		host25.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host25.pppg$i++;
		host26.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host26.pppg$i++;
		host27.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host27.pppg$i++;
		host28.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host28.pppg$i++;
		host29.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host29.pppg$i++;
		host30.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host30.pppg$i++;
		host31.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host31.pppg$i++;
		host32.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host32.pppg$i++;
		host33.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host33.pppg$i++;
		host34.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host34.pppg$i++;
		host35.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host35.pppg$i++;
		host36.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host36.pppg$i++;
		host37.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host37.pppg$i++;
}

