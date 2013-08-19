
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
	parameters:
		@Internet();
	submodules:
		sas0: SAS0 {
			parameters:
				@AS();
				@display("i=misc/cloud_s");
		}
		sas1: SAS1 {
			parameters:
				@AS();
				@display("i=misc/cloud_s");
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
		tas6: TAS6 {
			parameters:
				@AS();
				@display("i=misc/globe_s");
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
		tas9: TAS9 {
			parameters:
				@AS();
				@display("i=misc/globe_s");
		}
		tas10: TAS10 {
			parameters:
				@AS();
				@display("i=misc/globe_s");
		}
		sas11: SAS11 {
			parameters:
				@AS();
				@display("i=misc/cloud_s");
		}
		sas12: SAS12 {
			parameters:
				@AS();
				@display("i=misc/cloud_s");
		}
		sas13: SAS13 {
			parameters:
				@AS();
				@display("i=misc/cloud_s");
		}
		sas14: SAS14 {
			parameters:
				@AS();
				@display("i=misc/cloud_s");
		}
		sas15: SAS15 {
			parameters:
				@AS();
				@display("i=misc/cloud_s");
		}
		sas16: SAS16 {
			parameters:
				@AS();
				@display("i=misc/cloud_s");
		}
		sas17: SAS17 {
			parameters:
				@AS();
				@display("i=misc/cloud_s");
		}
		sas18: SAS18 {
			parameters:
				@AS();
				@display("i=misc/cloud_s");
		}
		sas19: SAS19 {
			parameters:
				@AS();
				@display("i=misc/cloud_s");
		}

	connections:
		sas0.pppg++ <--> stub2stub <--> sas1.pppg++;
		sas0.pppg++ <--> stub2transit <--> tas2.pppg++;
		sas0.pppg++ <--> stub2stub <--> sas5.pppg++;
		sas0.pppg++ <--> stub2transit <--> tas6.pppg++;
		sas0.pppg++ <--> stub2stub <--> sas16.pppg++;
		sas1.pppg++ <--> stub2transit <--> tas2.pppg++;
		sas1.pppg++ <--> stub2transit <--> tas3.pppg++;
		sas1.pppg++ <--> stub2transit <--> tas10.pppg++;
		sas1.pppg++ <--> stub2transit <--> tas9.pppg++;
		tas2.pppg++ <--> transit2transit <--> tas3.pppg++;
		tas2.pppg++ <--> transit2transit <--> tas4.pppg++;
		tas2.pppg++ <--> transit2transit <--> tas6.pppg++;
		tas2.pppg++ <--> stub2transit <--> sas7.pppg++;
		tas2.pppg++ <--> transit2transit <--> tas9.pppg++;
		tas2.pppg++ <--> stub2transit <--> sas5.pppg++;
		tas2.pppg++ <--> stub2transit <--> sas12.pppg++;
		tas2.pppg++ <--> stub2transit <--> sas15.pppg++;
		tas2.pppg++ <--> transit2transit <--> tas10.pppg++;
		tas2.pppg++ <--> stub2transit <--> sas18.pppg++;
		tas3.pppg++ <--> transit2transit <--> tas4.pppg++;
		tas3.pppg++ <--> transit2transit <--> tas10.pppg++;
		tas3.pppg++ <--> stub2transit <--> sas12.pppg++;
		tas3.pppg++ <--> stub2transit <--> sas13.pppg++;
		tas4.pppg++ <--> stub2transit <--> sas5.pppg++;
		tas4.pppg++ <--> transit2transit <--> tas6.pppg++;
		tas4.pppg++ <--> stub2transit <--> sas11.pppg++;
		tas4.pppg++ <--> stub2transit <--> sas17.pppg++;
		tas4.pppg++ <--> stub2transit <--> sas14.pppg++;
		sas5.pppg++ <--> stub2transit <--> tas10.pppg++;
		tas6.pppg++ <--> stub2transit <--> sas8.pppg++;
		tas6.pppg++ <--> transit2transit <--> tas10.pppg++;
		tas6.pppg++ <--> stub2transit <--> sas14.pppg++;
		sas7.pppg++ <--> stub2transit <--> tas10.pppg++;
		tas9.pppg++ <--> stub2transit <--> sas19.pppg++;
		tas10.pppg++ <--> stub2transit <--> sas11.pppg++;
		tas10.pppg++ <--> stub2transit <--> sas14.pppg++;
		tas10.pppg++ <--> stub2transit <--> sas16.pppg++;
		sas11.pppg++ <--> stub2stub <--> sas13.pppg++;
		sas14.pppg++ <--> stub2stub <--> sas18.pppg++;
		sas18.pppg++ <--> stub2stub <--> sas19.pppg++;

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
		host12: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host13: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host14: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host15: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host42: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host44: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host47: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host48: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host49: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host50: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host51: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host52: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host53: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host54: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host55: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host56: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host57: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host58: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host59: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host60: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host61: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host62: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host63: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host64: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host65: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host66: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host67: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host68: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host69: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host70: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host71: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host72: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host73: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host74: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host75: StandardHost {
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
		gw1.pppg++ <--> edge2gateway <--> edge3.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge4.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge5.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge6.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge7.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge8.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge9.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge10.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge11.pppg++;
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
		host18.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host18.pppg$i++;
		host19.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host19.pppg$i++;
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
		host38.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host38.pppg$i++;
		host39.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host39.pppg$i++;
		host40.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host40.pppg$i++;
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
		host47.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host47.pppg$i++;
		host48.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host48.pppg$i++;
		host49.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host49.pppg$i++;
		host50.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host50.pppg$i++;
		host51.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host51.pppg$i++;
		host52.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host52.pppg$i++;
		host53.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host53.pppg$i++;
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
		host64.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host64.pppg$i++;
		host65.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host65.pppg$i++;
		host66.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host66.pppg$i++;
		host67.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host67.pppg$i++;
		host68.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host68.pppg$i++;
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
		host74.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host74.pppg$i++;
		host75.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host75.pppg$i++;
}

module SAS1
{
	gates:
		inout pppg[];
	submodules:
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
		host12: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host13: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host14: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host15: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host42: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host44: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host47: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host48: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host49: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host50: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host51: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host52: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host53: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host54: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host55: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host56: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host57: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host58: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host59: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host60: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host61: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host62: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host63: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host64: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host65: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host66: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host67: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host68: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host69: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host70: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host71: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host72: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host73: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host74: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host75: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host76: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host77: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host78: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host79: StandardHost {
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
		gw1.pppg++ <--> edge2gateway <--> edge3.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge4.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge5.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge6.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge7.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge8.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge9.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge10.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge11.pppg++;
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
		host18.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host18.pppg$i++;
		host19.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host19.pppg$i++;
		host20.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host20.pppg$i++;
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
		host49.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host49.pppg$i++;
		host50.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host50.pppg$i++;
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
		host65.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host65.pppg$i++;
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
		host73.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host73.pppg$i++;
		host74.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host74.pppg$i++;
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
}

module TAS2
{
	gates:
		inout pppg[];
	submodules:
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
		host8: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host9: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host10: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host11: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host12: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host13: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host14: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host15: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host42: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host44: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host47: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host48: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host49: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host50: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host51: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host52: StandardHost {
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
		pppg++ <--> core0.pppg++;
		pppg++ <--> core0.pppg++;
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
		gw1.pppg++ <--> edge2gateway <--> edge7.pppg++;
		host8.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host8.pppg$i++;
		host9.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host9.pppg$i++;
		host10.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host10.pppg$i++;
		host11.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host11.pppg$i++;
		host12.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host12.pppg$i++;
		host13.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host13.pppg$i++;
		host14.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host14.pppg$i++;
		host15.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host15.pppg$i++;
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
		host21.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host21.pppg$i++;
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
		host28.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host28.pppg$i++;
		host29.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host29.pppg$i++;
		host30.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host30.pppg$i++;
		host31.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host31.pppg$i++;
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
		host39.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host39.pppg$i++;
		host40.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host40.pppg$i++;
		host41.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host41.pppg$i++;
		host42.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host42.pppg$i++;
		host43.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host43.pppg$i++;
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
		host51.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host51.pppg$i++;
		host52.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host52.pppg$i++;
}

module TAS3
{
	gates:
		inout pppg[];
	submodules:
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
		edge13: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		host14: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host15: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host42: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host44: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host47: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host48: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host49: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host50: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host51: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host52: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host53: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host54: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host55: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host56: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host57: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host58: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host59: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host60: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host61: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host62: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host63: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host64: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host65: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host66: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host67: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host68: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host69: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host70: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host71: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host72: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host73: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host74: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host75: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host76: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host77: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host78: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host79: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host80: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host81: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host82: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host83: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host84: StandardHost {
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
		pppg++ <--> core0.pppg++;

		core0.pppg++ <--> gateway2core <--> gw1.pppg++;
		core0.pppg++ <--> gateway2core <--> gw2.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge3.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge4.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge5.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge6.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge7.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge8.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge9.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge10.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge11.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge12.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge13.pppg++;
		host14.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host14.pppg$i++;
		host15.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host15.pppg$i++;
		host16.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host16.pppg$i++;
		host17.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host17.pppg$i++;
		host18.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host18.pppg$i++;
		host19.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host19.pppg$i++;
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
		host43.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host43.pppg$i++;
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
		host50.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host50.pppg$i++;
		host51.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host51.pppg$i++;
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
		host66.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host66.pppg$i++;
		host67.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host67.pppg$i++;
		host68.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host68.pppg$i++;
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
		host79.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host79.pppg$i++;
		host80.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host80.pppg$i++;
		host81.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host81.pppg$i++;
		host82.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host82.pppg$i++;
		host83.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host83.pppg$i++;
		host84.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host84.pppg$i++;
}

module TAS4
{
	gates:
		inout pppg[];
	submodules:
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
		host9: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host10: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host11: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host12: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host13: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host14: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host15: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host42: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host44: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host47: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host48: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host49: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host50: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host51: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host52: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host53: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host54: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host55: StandardHost {
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
		host9.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host9.pppg$i++;
		host10.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host10.pppg$i++;
		host11.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host11.pppg$i++;
		host12.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host12.pppg$i++;
		host13.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host13.pppg$i++;
		host14.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host14.pppg$i++;
		host15.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host15.pppg$i++;
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
		host21.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host21.pppg$i++;
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
		host43.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host43.pppg$i++;
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
}

module SAS5
{
	gates:
		inout pppg[];
	submodules:
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
		host22: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host42: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host44: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host47: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host48: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host49: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host50: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host51: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host52: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host53: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host54: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host55: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host56: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host57: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host58: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host59: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host60: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host61: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host62: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host63: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host64: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host65: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host66: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host67: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host68: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host69: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host70: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host71: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host72: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host73: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host74: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host75: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host76: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host77: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host78: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host79: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host80: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host81: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host82: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host83: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host84: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host85: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host86: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host87: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host88: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host89: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host90: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host91: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host92: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host93: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host94: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host95: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host96: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host97: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host98: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host99: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host100: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host101: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host102: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host103: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host104: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host105: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host106: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host107: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host108: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host109: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host110: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host111: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host112: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host113: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host114: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host115: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host116: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host117: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host118: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host119: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host120: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host121: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host122: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host123: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host124: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host125: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host126: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host127: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host128: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host129: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host130: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host131: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host132: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host133: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host134: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host135: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host136: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host137: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host138: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host139: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host140: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host141: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host142: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host143: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host144: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host145: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host146: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host147: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host148: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host149: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host150: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host151: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host152: StandardHost {
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
		core0.pppg++ <--> gateway2core <--> gw2.pppg++;
		core0.pppg++ <--> gateway2core <--> gw3.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge4.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge5.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge6.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge7.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge8.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge9.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge10.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge11.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge12.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge13.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge14.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge15.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge16.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge17.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge18.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge19.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge20.pppg++;
		gw3.pppg++ <--> edge2gateway <--> edge21.pppg++;
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
		host39.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host39.pppg$i++;
		host40.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host40.pppg$i++;
		host41.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host41.pppg$i++;
		host42.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host42.pppg$i++;
		host43.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host43.pppg$i++;
		host44.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host44.pppg$i++;
		host45.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host45.pppg$i++;
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
		host51.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host51.pppg$i++;
		host52.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host52.pppg$i++;
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
		host65.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host65.pppg$i++;
		host66.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host66.pppg$i++;
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
		host73.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host73.pppg$i++;
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
		host79.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host79.pppg$i++;
		host80.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host80.pppg$i++;
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
		host94.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host94.pppg$i++;
		host95.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host95.pppg$i++;
		host96.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host96.pppg$i++;
		host97.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host97.pppg$i++;
		host98.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host98.pppg$i++;
		host99.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host99.pppg$i++;
		host100.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host100.pppg$i++;
		host101.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host101.pppg$i++;
		host102.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host102.pppg$i++;
		host103.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host103.pppg$i++;
		host104.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host104.pppg$i++;
		host105.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host105.pppg$i++;
		host106.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host106.pppg$i++;
		host107.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host107.pppg$i++;
		host108.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host108.pppg$i++;
		host109.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host109.pppg$i++;
		host110.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host110.pppg$i++;
		host111.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host111.pppg$i++;
		host112.pppg$o++ --> host2edge --> edge16.pppg$i++;
		edge16.pppg$o++ --> edge2host --> host112.pppg$i++;
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
		host120.pppg$o++ --> host2edge --> edge17.pppg$i++;
		edge17.pppg$o++ --> edge2host --> host120.pppg$i++;
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
		host127.pppg$o++ --> host2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> edge2host --> host127.pppg$i++;
		host128.pppg$o++ --> host2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> edge2host --> host128.pppg$i++;
		host129.pppg$o++ --> host2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> edge2host --> host129.pppg$i++;
		host130.pppg$o++ --> host2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> edge2host --> host130.pppg$i++;
		host131.pppg$o++ --> host2edge --> edge18.pppg$i++;
		edge18.pppg$o++ --> edge2host --> host131.pppg$i++;
		host132.pppg$o++ --> host2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> edge2host --> host132.pppg$i++;
		host133.pppg$o++ --> host2edge --> edge19.pppg$i++;
		edge19.pppg$o++ --> edge2host --> host133.pppg$i++;
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
		host139.pppg$o++ --> host2edge --> edge20.pppg$i++;
		edge20.pppg$o++ --> edge2host --> host139.pppg$i++;
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
		host145.pppg$o++ --> host2edge --> edge20.pppg$i++;
		edge20.pppg$o++ --> edge2host --> host145.pppg$i++;
		host146.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host146.pppg$i++;
		host147.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host147.pppg$i++;
		host148.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host148.pppg$i++;
		host149.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host149.pppg$i++;
		host150.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host150.pppg$i++;
		host151.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host151.pppg$i++;
		host152.pppg$o++ --> host2edge --> edge21.pppg$i++;
		edge21.pppg$o++ --> edge2host --> host152.pppg$i++;
}

module TAS6
{
	gates:
		inout pppg[];
	submodules:
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
		host15: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host42: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host44: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host47: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host48: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host49: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host50: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host51: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host52: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host53: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host54: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host55: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host56: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host57: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host58: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host59: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host60: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host61: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host62: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host63: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host64: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host65: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host66: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host67: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host68: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host69: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host70: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host71: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host72: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host73: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host74: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host75: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host76: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host77: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host78: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host79: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host80: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host81: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host82: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host83: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host84: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host85: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host86: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host87: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host88: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host89: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host90: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host91: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host92: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host93: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host94: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host95: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host96: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host97: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host98: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host99: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host100: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host101: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host102: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host103: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host104: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host105: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host106: StandardHost {
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
		pppg++ <--> core0.pppg++;

		core0.pppg++ <--> gateway2core <--> gw1.pppg++;
		core0.pppg++ <--> gateway2core <--> gw2.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge3.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge4.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge5.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge6.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge7.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge8.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge9.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge10.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge11.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge12.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge13.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge14.pppg++;
		host15.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host15.pppg$i++;
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
		host21.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host21.pppg$i++;
		host22.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host22.pppg$i++;
		host23.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host23.pppg$i++;
		host24.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host24.pppg$i++;
		host25.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host25.pppg$i++;
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
		host31.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host31.pppg$i++;
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
		host43.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host43.pppg$i++;
		host44.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host44.pppg$i++;
		host45.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host45.pppg$i++;
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
		host51.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host51.pppg$i++;
		host52.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host52.pppg$i++;
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
		host72.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host72.pppg$i++;
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
		host88.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host88.pppg$i++;
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
		host97.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host97.pppg$i++;
		host98.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host98.pppg$i++;
		host99.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host99.pppg$i++;
		host100.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host100.pppg$i++;
		host101.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host101.pppg$i++;
		host102.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host102.pppg$i++;
		host103.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host103.pppg$i++;
		host104.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host104.pppg$i++;
		host105.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host105.pppg$i++;
		host106.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host106.pppg$i++;
}

module SAS7
{
	gates:
		inout pppg[];
	submodules:
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
		host7: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host8: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host9: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host10: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host11: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host12: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host13: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host14: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host15: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: StandardHost {
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
		host12.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host12.pppg$i++;
		host13.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host13.pppg$i++;
		host14.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host14.pppg$i++;
		host15.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host15.pppg$i++;
		host16.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host16.pppg$i++;
		host17.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host17.pppg$i++;
		host18.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host18.pppg$i++;
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
		host38.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host38.pppg$i++;
		host39.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host39.pppg$i++;
}

module SAS8
{
	gates:
		inout pppg[];
	submodules:
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
		host9: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host10: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host11: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host12: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host13: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host14: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host15: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host42: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host44: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host47: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host48: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host49: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host50: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host51: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host52: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host53: StandardHost {
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
		gw1.pppg++ <--> edge2gateway <--> edge7.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge8.pppg++;
		host9.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host9.pppg$i++;
		host10.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host10.pppg$i++;
		host11.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host11.pppg$i++;
		host12.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host12.pppg$i++;
		host13.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host13.pppg$i++;
		host14.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host14.pppg$i++;
		host15.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host15.pppg$i++;
		host16.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host16.pppg$i++;
		host17.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host17.pppg$i++;
		host18.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host18.pppg$i++;
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
		host38.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host38.pppg$i++;
		host39.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host39.pppg$i++;
		host40.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host40.pppg$i++;
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
		host48.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host48.pppg$i++;
		host49.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host49.pppg$i++;
		host50.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host50.pppg$i++;
		host51.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host51.pppg$i++;
		host52.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host52.pppg$i++;
		host53.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host53.pppg$i++;
}

module TAS9
{
	gates:
		inout pppg[];
	submodules:
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
		edge13: Router {
			parameters:
				@RL();
				@display("i=abstract/router");
		}
		host14: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host15: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host42: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host44: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host47: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host48: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host49: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host50: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host51: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host52: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host53: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host54: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host55: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host56: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host57: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host58: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host59: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host60: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host61: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host62: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host63: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host64: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host65: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host66: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host67: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host68: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host69: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host70: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host71: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host72: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host73: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host74: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host75: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host76: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host77: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host78: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host79: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host80: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host81: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host82: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host83: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host84: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host85: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host86: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host87: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host88: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host89: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host90: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host91: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host92: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host93: StandardHost {
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
		gw1.pppg++ <--> edge2gateway <--> edge7.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge8.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge9.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge10.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge11.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge12.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge13.pppg++;
		host14.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host14.pppg$i++;
		host15.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host15.pppg$i++;
		host16.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host16.pppg$i++;
		host17.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host17.pppg$i++;
		host18.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host18.pppg$i++;
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
		host28.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host28.pppg$i++;
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
		host35.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host35.pppg$i++;
		host36.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host36.pppg$i++;
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
		host51.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host51.pppg$i++;
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
		host73.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host73.pppg$i++;
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
		host79.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host79.pppg$i++;
		host80.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host80.pppg$i++;
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
}

module TAS10
{
	gates:
		inout pppg[];
	submodules:
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
		host7: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host8: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host9: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host10: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host11: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host12: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host13: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host14: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host15: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host42: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host44: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: StandardHost {
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
		host8.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host8.pppg$i++;
		host9.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host9.pppg$i++;
		host10.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host10.pppg$i++;
		host11.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host11.pppg$i++;
		host12.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host12.pppg$i++;
		host13.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host13.pppg$i++;
		host14.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host14.pppg$i++;
		host15.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host15.pppg$i++;
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
		host21.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host21.pppg$i++;
		host22.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host22.pppg$i++;
		host23.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host23.pppg$i++;
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
		host40.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host40.pppg$i++;
		host41.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host41.pppg$i++;
		host42.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host42.pppg$i++;
		host43.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host43.pppg$i++;
		host44.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host44.pppg$i++;
		host45.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host45.pppg$i++;
		host46.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host46.pppg$i++;
}

module SAS11
{
	gates:
		inout pppg[];
	submodules:
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
		host8: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host9: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host10: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host11: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host12: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host13: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host14: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host15: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host42: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host44: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host47: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host48: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host49: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host50: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host51: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host52: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host53: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host54: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host55: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host56: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host57: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host58: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host59: StandardHost {
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
		gw1.pppg++ <--> edge2gateway <--> edge5.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge6.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge7.pppg++;
		host8.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host8.pppg$i++;
		host9.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host9.pppg$i++;
		host10.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host10.pppg$i++;
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
		host21.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host21.pppg$i++;
		host22.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host22.pppg$i++;
		host23.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host23.pppg$i++;
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
		host29.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host29.pppg$i++;
		host30.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host30.pppg$i++;
		host31.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host31.pppg$i++;
		host32.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host32.pppg$i++;
		host33.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host33.pppg$i++;
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
		host40.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host40.pppg$i++;
		host41.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host41.pppg$i++;
		host42.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host42.pppg$i++;
		host43.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host43.pppg$i++;
		host44.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host44.pppg$i++;
		host45.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host45.pppg$i++;
		host46.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host46.pppg$i++;
		host47.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host47.pppg$i++;
		host48.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host48.pppg$i++;
		host49.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host49.pppg$i++;
		host50.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host50.pppg$i++;
		host51.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host51.pppg$i++;
		host52.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host52.pppg$i++;
		host53.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host53.pppg$i++;
		host54.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host54.pppg$i++;
		host55.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host55.pppg$i++;
		host56.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host56.pppg$i++;
		host57.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host57.pppg$i++;
		host58.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host58.pppg$i++;
		host59.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host59.pppg$i++;
}

module SAS12
{
	gates:
		inout pppg[];
	submodules:
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
		host6: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host7: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host8: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host9: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host10: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host11: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host12: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host13: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host14: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host15: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: StandardHost {
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
		host6.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host6.pppg$i++;
		host7.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host7.pppg$i++;
		host8.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host8.pppg$i++;
		host9.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host9.pppg$i++;
		host10.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host10.pppg$i++;
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
		host30.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host30.pppg$i++;
		host31.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host31.pppg$i++;
}

module SAS13
{
	gates:
		inout pppg[];
	submodules:
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
		host7: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host8: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host9: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host10: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host11: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host12: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host13: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host14: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host15: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host42: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host44: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: StandardHost {
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
		host12.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host12.pppg$i++;
		host13.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host13.pppg$i++;
		host14.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host14.pppg$i++;
		host15.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host15.pppg$i++;
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
		host21.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host21.pppg$i++;
		host22.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host22.pppg$i++;
		host23.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host23.pppg$i++;
		host24.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host24.pppg$i++;
		host25.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host25.pppg$i++;
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
		host31.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host31.pppg$i++;
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
		host43.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host43.pppg$i++;
		host44.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host44.pppg$i++;
		host45.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host45.pppg$i++;
		host46.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host46.pppg$i++;
}

module SAS14
{
	gates:
		inout pppg[];
	submodules:
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
		host10: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host11: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host12: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host13: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host14: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host15: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host42: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host44: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host47: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host48: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host49: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host50: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host51: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host52: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host53: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host54: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host55: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host56: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host57: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host58: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host59: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host60: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host61: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host62: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host63: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host64: StandardHost {
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
		gw1.pppg++ <--> edge2gateway <--> edge8.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge9.pppg++;
		host10.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host10.pppg$i++;
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
		host21.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host21.pppg$i++;
		host22.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host22.pppg$i++;
		host23.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host23.pppg$i++;
		host24.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host24.pppg$i++;
		host25.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host25.pppg$i++;
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
		host50.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host50.pppg$i++;
		host51.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host51.pppg$i++;
		host52.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host52.pppg$i++;
		host53.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host53.pppg$i++;
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
}

module SAS15
{
	gates:
		inout pppg[];
	submodules:
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
		host13: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host14: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host15: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host42: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host44: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host47: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host48: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host49: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host50: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host51: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host52: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host53: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host54: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host55: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host56: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host57: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host58: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host59: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host60: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host61: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host62: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host63: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host64: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host65: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host66: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host67: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host68: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host69: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host70: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host71: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host72: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host73: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host74: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host75: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host76: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host77: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host78: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host79: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host80: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host81: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host82: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host83: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host84: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host85: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host86: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host87: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host88: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host89: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host90: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host91: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host92: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}

	connections:
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
		host18.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host18.pppg$i++;
		host19.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host19.pppg$i++;
		host20.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host20.pppg$i++;
		host21.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host21.pppg$i++;
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
		host34.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host34.pppg$i++;
		host35.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host35.pppg$i++;
		host36.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host36.pppg$i++;
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
		host43.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host43.pppg$i++;
		host44.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host44.pppg$i++;
		host45.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host45.pppg$i++;
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
		host51.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host51.pppg$i++;
		host52.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host52.pppg$i++;
		host53.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host53.pppg$i++;
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
		host60.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host60.pppg$i++;
		host61.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host61.pppg$i++;
		host62.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host62.pppg$i++;
		host63.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host63.pppg$i++;
		host64.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host64.pppg$i++;
		host65.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host65.pppg$i++;
		host66.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host66.pppg$i++;
		host67.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host67.pppg$i++;
		host68.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host68.pppg$i++;
		host69.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host69.pppg$i++;
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
		host75.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host75.pppg$i++;
		host76.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host76.pppg$i++;
		host77.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host77.pppg$i++;
		host78.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host78.pppg$i++;
		host79.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host79.pppg$i++;
		host80.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host80.pppg$i++;
		host81.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host81.pppg$i++;
		host82.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host82.pppg$i++;
		host83.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host83.pppg$i++;
		host84.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host84.pppg$i++;
		host85.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host85.pppg$i++;
		host86.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host86.pppg$i++;
		host87.pppg$o++ --> host2edge --> edge12.pppg$i++;
		edge12.pppg$o++ --> edge2host --> host87.pppg$i++;
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
}

module SAS16
{
	gates:
		inout pppg[];
	submodules:
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
		host15: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host42: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host44: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host47: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host48: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host49: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host50: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host51: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host52: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host53: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host54: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host55: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host56: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host57: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host58: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host59: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host60: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host61: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host62: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host63: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host64: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host65: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host66: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host67: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host68: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host69: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host70: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host71: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host72: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host73: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host74: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host75: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host76: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host77: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host78: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host79: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host80: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host81: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host82: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host83: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host84: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host85: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host86: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host87: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host88: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host89: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host90: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host91: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host92: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host93: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host94: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host95: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host96: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host97: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host98: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host99: StandardHost {
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
		gw1.pppg++ <--> edge2gateway <--> edge9.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge10.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge11.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge12.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge13.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge14.pppg++;
		host15.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host15.pppg$i++;
		host16.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host16.pppg$i++;
		host17.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host17.pppg$i++;
		host18.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host18.pppg$i++;
		host19.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host19.pppg$i++;
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
		host30.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host30.pppg$i++;
		host31.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host31.pppg$i++;
		host32.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host32.pppg$i++;
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
		host43.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host43.pppg$i++;
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
		host49.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host49.pppg$i++;
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
		host58.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host58.pppg$i++;
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
		host81.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host81.pppg$i++;
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
		host88.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host88.pppg$i++;
		host89.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host89.pppg$i++;
		host90.pppg$o++ --> host2edge --> edge13.pppg$i++;
		edge13.pppg$o++ --> edge2host --> host90.pppg$i++;
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
		host98.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host98.pppg$i++;
		host99.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host99.pppg$i++;
}

module SAS17
{
	gates:
		inout pppg[];
	submodules:
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
		host13: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host14: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host15: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host42: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host44: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host47: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host48: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host49: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host50: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host51: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host52: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host53: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host54: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host55: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host56: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host57: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host58: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host59: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host60: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host61: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host62: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host63: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host64: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host65: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host66: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host67: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host68: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host69: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host70: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host71: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host72: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host73: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host74: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host75: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host76: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host77: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host78: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host79: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host80: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host81: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}

	connections:
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
		host40.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host40.pppg$i++;
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
		host51.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host51.pppg$i++;
		host52.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host52.pppg$i++;
		host53.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host53.pppg$i++;
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
		host59.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host59.pppg$i++;
		host60.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host60.pppg$i++;
		host61.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host61.pppg$i++;
		host62.pppg$o++ --> host2edge --> edge9.pppg$i++;
		edge9.pppg$o++ --> edge2host --> host62.pppg$i++;
		host63.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host63.pppg$i++;
		host64.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host64.pppg$i++;
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
		host71.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host71.pppg$i++;
		host72.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host72.pppg$i++;
		host73.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host73.pppg$i++;
		host74.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host74.pppg$i++;
		host75.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host75.pppg$i++;
		host76.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host76.pppg$i++;
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
}

module SAS18
{
	gates:
		inout pppg[];
	submodules:
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
		host16: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host42: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host44: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host47: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host48: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host49: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host50: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host51: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host52: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host53: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host54: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host55: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host56: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host57: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host58: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host59: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host60: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host61: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host62: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host63: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host64: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host65: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host66: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host67: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host68: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host69: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host70: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host71: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host72: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host73: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host74: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host75: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host76: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host77: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host78: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host79: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host80: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host81: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host82: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host83: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host84: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host85: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host86: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host87: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host88: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host89: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host90: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host91: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host92: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host93: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host94: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host95: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host96: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host97: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host98: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host99: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host100: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host101: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host102: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host103: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host104: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host105: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host106: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host107: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host108: StandardHost {
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
		gw1.pppg++ <--> edge2gateway <--> edge7.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge8.pppg++;
		gw1.pppg++ <--> edge2gateway <--> edge9.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge10.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge11.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge12.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge13.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge14.pppg++;
		gw2.pppg++ <--> edge2gateway <--> edge15.pppg++;
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
		host21.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host21.pppg$i++;
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
		host43.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host43.pppg$i++;
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
		host51.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host51.pppg$i++;
		host52.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host52.pppg$i++;
		host53.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host53.pppg$i++;
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
		host60.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host60.pppg$i++;
		host61.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host61.pppg$i++;
		host62.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host62.pppg$i++;
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
		host73.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host73.pppg$i++;
		host74.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host74.pppg$i++;
		host75.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host75.pppg$i++;
		host76.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host76.pppg$i++;
		host77.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host77.pppg$i++;
		host78.pppg$o++ --> host2edge --> edge10.pppg$i++;
		edge10.pppg$o++ --> edge2host --> host78.pppg$i++;
		host79.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host79.pppg$i++;
		host80.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host80.pppg$i++;
		host81.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host81.pppg$i++;
		host82.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host82.pppg$i++;
		host83.pppg$o++ --> host2edge --> edge11.pppg$i++;
		edge11.pppg$o++ --> edge2host --> host83.pppg$i++;
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
		host94.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host94.pppg$i++;
		host95.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host95.pppg$i++;
		host96.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host96.pppg$i++;
		host97.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host97.pppg$i++;
		host98.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host98.pppg$i++;
		host99.pppg$o++ --> host2edge --> edge14.pppg$i++;
		edge14.pppg$o++ --> edge2host --> host99.pppg$i++;
		host100.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host100.pppg$i++;
		host101.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host101.pppg$i++;
		host102.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host102.pppg$i++;
		host103.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host103.pppg$i++;
		host104.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host104.pppg$i++;
		host105.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host105.pppg$i++;
		host106.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host106.pppg$i++;
		host107.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host107.pppg$i++;
		host108.pppg$o++ --> host2edge --> edge15.pppg$i++;
		edge15.pppg$o++ --> edge2host --> host108.pppg$i++;
}

module SAS19
{
	gates:
		inout pppg[];
	submodules:
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
		host9: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host10: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host11: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host12: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host13: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host14: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host15: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host16: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host17: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host18: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host19: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host20: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host21: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host22: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host23: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host24: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host25: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host26: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host27: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host28: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host29: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host30: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host31: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host32: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host33: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host34: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host35: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host36: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host37: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host38: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host39: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host40: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host41: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host42: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host43: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host44: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host45: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host46: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host47: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host48: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host49: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host50: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host51: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host52: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host53: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host54: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host55: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host56: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host57: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host58: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host59: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host60: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host61: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host62: StandardHost {
			parameters:
				@RL();
				@display("i=device/laptop");
		}
		host63: StandardHost {
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
		host9.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host9.pppg$i++;
		host10.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host10.pppg$i++;
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
		host16.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host16.pppg$i++;
		host17.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host17.pppg$i++;
		host18.pppg$o++ --> host2edge --> edge2.pppg$i++;
		edge2.pppg$o++ --> edge2host --> host18.pppg$i++;
		host19.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host19.pppg$i++;
		host20.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host20.pppg$i++;
		host21.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host21.pppg$i++;
		host22.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host22.pppg$i++;
		host23.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host23.pppg$i++;
		host24.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host24.pppg$i++;
		host25.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host25.pppg$i++;
		host26.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host26.pppg$i++;
		host27.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host27.pppg$i++;
		host28.pppg$o++ --> host2edge --> edge3.pppg$i++;
		edge3.pppg$o++ --> edge2host --> host28.pppg$i++;
		host29.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host29.pppg$i++;
		host30.pppg$o++ --> host2edge --> edge4.pppg$i++;
		edge4.pppg$o++ --> edge2host --> host30.pppg$i++;
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
		host36.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host36.pppg$i++;
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
		host42.pppg$o++ --> host2edge --> edge5.pppg$i++;
		edge5.pppg$o++ --> edge2host --> host42.pppg$i++;
		host43.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host43.pppg$i++;
		host44.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host44.pppg$i++;
		host45.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host45.pppg$i++;
		host46.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host46.pppg$i++;
		host47.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host47.pppg$i++;
		host48.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host48.pppg$i++;
		host49.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host49.pppg$i++;
		host50.pppg$o++ --> host2edge --> edge6.pppg$i++;
		edge6.pppg$o++ --> edge2host --> host50.pppg$i++;
		host51.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host51.pppg$i++;
		host52.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host52.pppg$i++;
		host53.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host53.pppg$i++;
		host54.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host54.pppg$i++;
		host55.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host55.pppg$i++;
		host56.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host56.pppg$i++;
		host57.pppg$o++ --> host2edge --> edge7.pppg$i++;
		edge7.pppg$o++ --> edge2host --> host57.pppg$i++;
		host58.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host58.pppg$i++;
		host59.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host59.pppg$i++;
		host60.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host60.pppg$i++;
		host61.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host61.pppg$i++;
		host62.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host62.pppg$i++;
		host63.pppg$o++ --> host2edge --> edge8.pppg$i++;
		edge8.pppg$o++ --> edge2host --> host63.pppg$i++;
}

