#!/usr/bin/perl

$DEBUG = 1;

use POSIX;
srand(time());

###
# Functionality of this script:
#
#
#  input:
#    parameter file:  all necessary parameters for creating a realistic simulation environmnet based on input ned file
#    input NED file:  NED file containing a realistic topology (AS-level as well as router level)
#  output:
#    output NED file: NED file containing additional router types and servers as well as necessary modules
###

# open parameter file (given by user)
die ("setServer.pl <para-file> <ned-file> <output>\n") if($#ARGV != 2);
open PARA, "$ARGV[0]" or die "Could not open parameter file\n";

$serverTypeSwitch = 0;
$routerTypeSwitch = 0;
%label = ();
# stores bandwidth between different node types
%bandwidth = ();
# stores latency between different node types
%latency = ();
# Percentual fraction of servers per AS (host systems - servers)
$serverFraction = 0.;
# hash values of different server types and their probability of occurrence
%serverTypes = ();
# Percentual fraction of routers per AS (host systems - servers)
$routerFraction = 0.;
# hash values of different router types and their probability of occurrence
%routerTypes = ();

# read parameters from file
foreach my $line (<PARA>)
{
# ignore comments
	next if ($line =~ /^\#/);
# reached section regarding ServerTypes?
	if($serverTypeSwitch == 1)
	{
# ignore opening bracket, reset serverTypeSwitch in case of closing bracket
		next if($line =~ /{/);
		$serverTypeSwitch = 0 if($line =~ /}/);
# store name and probability of server type in hash serverTypes
		$serverTypes{$1} = $2 if($line =~ /(\w+)\s*=\s*(\w+)\s*/);
# same processing for routers
	}
	elsif($routerTypeSwitch == 1)
	{
		next if($line =~ /{/);
		$routerTypeSwitch = 0 if($line =~ /}/);
		$routerTypes{$1} = $2 if($line =~ /(\w+)\s*=\s*(\w+)\s*/);
	} else {
# all nodes of topology file may have variable names
# the actual mapping of node type to node name is read here
		$label{'HostLabel'} = $1 if($line =~ /HostLabel\s*=\s*(\w+)\s*/);
		$label{'EdgeLabel'} = $1 if($line =~ /EdgeLabel\s*=\s*(\w+)\s*/);
		$label{'GatewayLabel'} = $1 if($line =~ /GatewayLabel\s*=\s*(\w+)\s*/);
		$label{'CoreLabel'} = $1 if($line =~ /CoreLabel\s*=\s*(\w+)\s*/);
		$label{'StubLabel'} = $1 if($line =~ /StubLabel\s*=\s*(\w+)\s*/);
		$label{'StubModule'} = uc($label{'StubLabel'});
		$label{'TransitLabel'} = $1 if($line =~ /TransitLabel\s*=\s*(\w+)\s*/);
		$label{'TransitModule'} = uc($label{'TransitLabel'});
# read parameters for bandwidths between different node types
		$bandwidth{'host2edge'} = $1 if($line =~ /Host2Edge\s*=\s*(\d+\.\d+)\s*/);
		$bandwidth{'edge2host'} = $1 if($line =~ /Edge2Host\s*=\s*(\d+\.\d+)\s*/);
		$bandwidth{'server2edge'} = $1 if($line =~ /Server2Edge\s*=\s*(\d+\.\d+)\s*/);
		$bandwidth{'edge2gateway'} = $1 if($line =~ /Edge2Gateway\s*=\s*(\d+\.\d+)\s*/);
		$bandwidth{'gateway2core'} = $1 if($line =~ /Gateway2Core\s*=\s*(\d+\.\d+)\s*/);
		$bandwidth{'core2core'} = $1 if($line =~ /Core2Core\s*=\s*(\d+\.\d+)\s*/);
		$bandwidth{'stub2stub'} = $1 if($line =~ /Stub2Stub\s*=\s*(\d+\.\d+)\s*/);
		$bandwidth{'stub2transit'} = $1 if($line =~ /Transit2Stub\s*=\s*(\d+\.\d+)\s*/);
		$bandwidth{'transit2transit'} = $1 if($line =~ /Transit2Transit\s*=\s*(\d+\.\d+)\s*/);
# read parameters for latency between different node types
		$latency{'host2edge'} = $1 if($line =~ /Host2EdgeLatency\s*=\s*(\w+)\s*/);
		$latency{'edge2host'} = $1 if($line =~ /Edge2HostLatency\s*=\s*(\w+)\s*/);
		$latency{'server2edge'} = $1 if($line =~ /Server2EdgeLatency\s*=\s*(\w+)\s*/);
		$latency{'edge2gateway'} = $1 if($line =~ /Edge2GatewayLatency\s*=\s*(\w+)\s*/);
		$latency{'gateway2core'} = $1 if($line =~ /Gateway2CoreLatency\s*=\s*(\w+)\s*/);
		$latency{'core2core'} = $1 if($line =~ /Core2CoreLatency\s*=\s*(\w+)\s*/);
		$latency{'stub2stub'} = $1 if($line =~ /Stub2StubLatency\s*=\s*(\w+)\s*/);
		$latency{'stub2transit'} = $1 if($line =~ /Transit2StubLatency\s*=\s*(\w+)\s*/);
		$latency{'transit2transit'} = $1 if($line =~ /Transit2TransitLatency\s*=\s*(\w+)\s*/);
# read fraction of servers and special routers per AS
		$serverFraction = $1 if($line =~ /ServerFraction\s*=\s*(\d+\.\d*)\s*/);
		$routerFraction = $1 if($line =~ /RouterFraction\s*=\s*(\d+\.\d*)\s*/);
# set serverTypeSwitch to true if keyword ServerTypes is read (routers work similar)
		$serverTypeSwitch = 1 if($line =~ /ServerTypes/);
		$routerTypeSwitch = 1 if($line =~ /RouterTypes/);
	}
}
close PARA;

#
# reading of parameters completed - now we can start adding servers and special routers :)
#

# original topology ned file: TOP / resulting topology ned file: NEWTOP
open NEWTOP, ">$ARGV[2]" or die "Could not open new ned file\n";
open TOP, "$ARGV[1]" or die "Could not open original ned file\n";


# now the actual transit and stub AS are created
# processStubAs and processTransitAs serve as switches as previously seen
$processStubAs = 0;
$processTransitAs = 0;
$process_InternetModule = 0;
@cur_AS = ();
$submodulesAreSet = 0;
$cur_Channel = 0;
$findModuleEnd = 0;
$Oversim = 0;
$serverChannel = 0;
$hasHosts = 0;
foreach my $line (<TOP>)
{

# new ned file starts with import statements for Router and InetUserHost
        # check for Oversim topology
	if($line =~ /package oversim/)
	{
		$Oversim = 1;
		print NEWTOP $line;
		next;
	}
#       else
#               print NEWTOP "//--package declaration here--\n\n";

# insert additional imports on first import line
	if($line =~ /import inet.nodes.inet.Router/)
	{
		print NEWTOP $line;
		if ($Oversim == 0)
		{
# include ned files that are necessary for configuration within OMNeT++, e.g. for traffic and routing
			print NEWTOP "import rease.networklayer.autorouting.TGMNetworkConfigurator;\n";
		}
		next;
	}
	if($line =~ /import inet.nodes.inet.StandardHost/)
	{
		$hasHosts = 1;
		
# include ned files that are necessary for configuration within OMNeT++, e.g. for traffic and routing
		print NEWTOP "import rease.base.ConnectionManager;\n";
		print NEWTOP "import rease.base.TrafficProfileManager;\n";
		print NEWTOP "import rease.nodes.inet.InetUserHost;\n";

# include ned files corresponding to router and server types of parameter file
		if (scalar keys %serverTypes)
		{
			foreach my $type (keys %serverTypes)
			{
				print NEWTOP "import rease.nodes.inet.$type;\n";
			}
			$serverChannel = 1;
		}

		if (scalar keys %routerTypes)
		{
			foreach my $type (keys %routerTypes)
			{
				print NEWTOP "import rease.nodes.inet.$type;\n";
			}
		}

		if ($serverChannel == 1)
		{
			print NEWTOP "\n\n";
			print NEWTOP "channel server2edge extends ned.DatarateChannel\n";
			print NEWTOP "{\n";
			print NEWTOP "\tparameters:\n";
			if (exists $latency{'server2edge'})
			{
				print NEWTOP "\t\tdelay = $latency{'server2edge'}ms;\n";
			} else {
				print NEWTOP "\t\tdelay = 1us;\n";
			}
			print NEWTOP "\t\tdatarate = $bandwidth{'server2edge'}Mbps;\n";
			print NEWTOP "}\n";
		}
		next;		
	}

# found definition of channels -> set new data rate and, if available, delay
	if($line =~ /channel (\w+)/)
	{
		$cur_Channel = $1;
		print NEWTOP $line;
		next;
	}
	if($cur_Channel ne "")
	{
		if($line =~ /datarate/)
		{
			print NEWTOP "\t\tdatarate = $bandwidth{$cur_Channel}Mbps;\n";
		}
		elsif($line =~ /delay/)
		{
			if (exists $latency{$cur_Channel})
			{
				print NEWTOP "\t\tdelay = $latency{$cur_Channel}ms;\n";
			} else {
				print NEWTOP $line;
			}		
		}
		elsif($line =~ /}/)
		{
			print NEWTOP $line;
			$cur_Channel = "";
			
		}
		else
		{
			print NEWTOP $line;
		}
		next;
	}


# process submodules and connections immediately if no AS-topology was created
	if($process_InternetModule == 1)
	{
# first, include all necessary additional submodules once
		if($line =~ /submodules:/)
		{
			push (@cur_AS, $line);
			if($Oversim == 0)
			{
				push (@cur_AS, "\t\ttgmNetworkConfigurator: TGMNetworkConfigurator {\n");
				push (@cur_AS, "\t\t\tparameters:\n");
				push (@cur_AS, "\t\t\t\ttotalCountOfAS = Anzahl Autonomer Systeme;\n");
				push (@cur_AS, "\t\t\t\t\@display(\"p=20,20;i=abstract/table_s\");\n");
				push (@cur_AS, "\t\t}\n");
			}
			if($hasHosts == 1)
			{
				push (@cur_AS, "\t\tconnectionManager: ConnectionManager {\n");
				push (@cur_AS, "\t\t\tparameters:\n");
				push (@cur_AS, "\t\t\t\t\@display(\"p=60,20;i=block/classifier_s\");\n");
				push (@cur_AS, "\t\t}\n");
				push (@cur_AS, "\t\ttrafficProfileManager: TrafficProfileManager {\n");
				push (@cur_AS, "\t\t\tparameters:\n");
				push (@cur_AS, "\t\t\t\t\@display(\"p=100,20;i=block/cogwheel_s\");\n");
				push (@cur_AS, "\t\t}\n\n");
			}
		} 
		elsif($line =~ /$label{'TransitLabel'}\d+/ || $line =~ /$label{'StubLabel'}\d+/)
		{
			$asTopologyIncluded = 1;
			push (@cur_AS, $line);
		} else {
			push (@cur_AS, $line);
			if($line =~/network Inet/ || $line =~/network ReaSEUnderlayNetwork/)
			{
# if last line of module Internet is reached, the switch is reset and the method processInternet is called... then the array is deleted
				$process_InternetModule = 0;
				if($asTopologyIncluded == 1)
				{
					&processInternet(@cur_AS);
				} else {
					&processAS(@cur_AS);
				}
				@cur_AS = ();
			}
		}
	}
# now we process each AS separately... first the according switch is set 
# then, each line of the original ned file belonging to the current AS is written into the array cur_AS
	elsif($processStubAs == 1)
	{
		if($line =~ /submodules:/ && ($hasHosts == 1))
		{
# each AS must have a submodule ConnectionManager
			push (@cur_AS, $line);
			push (@cur_AS, "\t\tconnectionManager: ConnectionManager {\n");
			push (@cur_AS, "\t\t\tparameters:\n");
			push (@cur_AS, "\t\t\t\t\@display(\"p=20,20;i=block/classifier_s\");\n");
			push (@cur_AS, "\t\t}\n\n");
		}
		elsif($line =~ /connections:/)
		{
			$findModuleEnd = 1;
			push(@cur_AS, $line);
		}
		else
		{
			push(@cur_AS, $line);
			if($line =~ /}/ && $findModuleEnd == 1)
			{
				$processStubAs = 0;
				&processAS(@cur_AS);
				@cur_AS = ();
				$findModuleEnd = 0;
			}
		}
	}
	elsif($processTransitAs == 1)
	{
		if($line =~ /submodules:/ && ($hasHosts == 1))
		{
			push (@cur_AS, $line);
			push (@cur_AS, "\t\tconnectionManager: ConnectionManager {\n");
			push (@cur_AS, "\t\t\tparameters:\n");
			push (@cur_AS, "\t\t\t\t\@display(\"p=20,20;i=block/classifier_s\");\n");
			push (@cur_AS, "\t\t}\n\n");
		}
		elsif($line =~ /connections:/)
		{
			$findModuleEnd = 1;
			push(@cur_AS, $line);
		}
		else
		{
			push(@cur_AS, $line);
			if($line =~ /}/ && $findModuleEnd == 1)
			{
				$processTransitAs = 0;
				&processAS(@cur_AS);
				@cur_AS = ();
				$findModuleEnd = 0;
			}
		}
	}
# start processing of a certain module: stub AS, transit AS, or Internet
	elsif($line =~/module $label{'StubModule'}\d+/)
	{
		$processStubAs = 1;
		push(@cur_AS, $line);
	}
	elsif($line =~/module $label{'TransitModule'}\d+/)
	{
		$processTransitAs = 1; 
		push(@cur_AS, $line);
	}
	elsif($line =~ /module Internet/)
	{
		$process_InternetModule = 1;
		$asTopologyIncluded = 0;
		print NEWTOP "$line";
	}
# transfer all lines that did not match one of the above patterns directly into the new ned file
	else
	{
		print NEWTOP "$line";
	}
}



# processAS
# parameter: array of lines describing current Autonomous System
#
# main method for replacing nodes by server and special router types
# connections have to be changed too for replaced nodes
# at the end, new ned file is written
sub processAS
{
# number of routers and hosts of this AS, hash arrays store lines describing these nodes
	my $noRouters = 0;
	my $noHosts = 0;
	my %routerLines = ();
	my %hostLines = ();
# save the number of routers and servers per type that should be replaced within this AS
	my %noRouterTypesToReplace = ();
	my %noServerTypesToReplace = ();
# save all hosts and routers
	foreach $line (@_)
	{
		if(($line =~ /($label{'EdgeLabel'}\d+)/)||($line =~ /($label{'GatewayLabel'}\d+)/)||($line =~ /($label{'CoreLabel'}\d+)/))
		{
			$noRouters++;
# save complete line in a hash array with key "router type:index", e.g. edge10... router types can be core, gateway, and edge
			$routerLines{$1} = $line;
		}
		elsif($line =~ /($label{'HostLabel'}\d+)/)
		{
			$noHosts++;
			$hostLines{$1} = $line;
		}
		elsif($line =~ /connections/)
		{
# connections are found at the end of a submodule and thus, reading of entities is stopped here
			last;
		}
	}
# now number of routers and hosts as well as their describing lines are known

# first, we process routers: number of standard routers to be replaced is calculated based on values of parameter file
	my $noRoutersToReplace = int(($noRouters * $routerFraction / 100) + 0.5);
# a hash array that saves names of all replaced hosts: necessary for subsequent connection entries
	%replacedRouterNames = ();
# the number of standard routers to be replaced by a special router type is calculated and saved in array noRouterTypesToReplace
	if($noRoutersToReplace > 0)
	{
		$actuallyReplacedRouters = 0;
		foreach my $type (keys %routerTypes)
		{
# round up/down to the nearest integer value
			$noRouterTypesToReplace{$type} = int(($noRoutersToReplace * $routerTypes{$type} / 100) + 0.5);
			$actuallyReplacedRouters += $noRouterTypesToReplace{$type};
		}
		print "INFO: Total number of routers: $noRouters, $actuallyReplacedRouters ($noRoutersToReplace) of these will be replaced by special router types\n";

# start replacing standard routers by special router types randomly
# save keys (router type : index) of router hash array in routerArray
		my @routerArray = keys %routerLines;
# temporary hash array that is necessary to mark already replaced routers
# ATTENTION: If the number of routers to be replaced is high, finding an unused random number may last some time (even worse: a really long time)
		my %usedValues = ();
		for(my $i = 0; $i < $noRouters; $i++)
		{
			$usedValues[$i] = 0;
		}

		foreach my $type (keys %noRouterTypesToReplace)
		{
# routers are replaced according to the number of router types previously calculated
			for($i = 0; $i < $noRouterTypesToReplace{$type}; $i++)
			{
				my $r = int(rand($noRouters));
# if the chosen routers has already been replaced, restart this iteration
				redo if($usedValues{$r} == 1);
# else replace randomly selected router key by special router (thus, the according line has to be changed)
#   the name of the router also is replaced by a new name indicating its new functionality
				if($routerLines{$routerArray[$r]} =~ /Router/)
				{
					if($routerLines{$routerArray[$r]} =~ /($label{'EdgeLabel'}(\d+)):\s+Router/) {
						$oldLabel = $1;
						$newLabel = $label{'EdgeLabel'}."_".$type.$2;
						$replacedRouterNames{$1} = $label{'EdgeLabel'}."_".$type.$2;
						$routerLines{$routerArray[$r]} =~ s/$oldLabel: Router/$newLabel: $type/;
						$usedValues{$r} = 1;
					} elsif($routerLines{$routerArray[$r]} =~ /($label{'GatewayLabel'}(\d+)):\s+Router/) {
						$oldLabel = $1;
						$newLabel = $label{'GatewayLabel'}."_".$type.$2;
						$replacedRouterNames{$1} = $label{'GatewayLabel'}."_".$type.$2;
						$routerLines{$routerArray[$r]} =~ s/$oldLabel: Router/$newLabel: $type/;
						$usedValues{$r} = 1;
					} elsif($routerLines{$routerArray[$r]} =~ /($label{'CoreLabel'}(\d+)):\s+Router/) {
						$oldLabel = $1;
						$newLabel = $label{'CoreLabel'}."_".$type.$2;
						$replacedRouterNames{$1} = $label{'CoreLabel'}."_".$type.$2;
						$routerLines{$routerArray[$r]} =~ s/$oldLabel: Router/$newLabel: $type/;
						$usedValues{$r} = 1;
					}

				} else {
				    print "ERROR: Router should be replaced by special router type but line does not contain a Router module:\n  $routerLines{$routerArray[$r]}\n";
				    exit(1);
				}
			}
		}
	} else {
		print "INFO: Total number of routers: $noRouters, none of these will be replaced by special router types\n";
	}

# and now the same with hosts being replaced by special servers
	my $noHostsToReplace = int(($noHosts * $serverFraction / 100) + 0.5);
# a hash array that saves names of all replaced hosts: necessary for subsequent connection entries
	%replacedHostNames = ();
	if($noHostsToReplace > 0)
	{
		$actuallyReplacedHosts = 0;
		foreach my $type (keys %serverTypes)
		{
			$noServerTypesToReplace{$type} = int(($noHostsToReplace * $serverTypes{$type} / 100) + 0.5);
			$actuallyReplacedHosts += $noServerTypesToReplace{$type}
		}
		print "INFO: Total number of hosts: $noHosts, $actuallyReplacedHosts ($noHostsToReplace) of these will be replaced by servers\n";

		my @hostArray = keys %hostLines;
		my %usedValues = ();
		for(my $i = 0; $i < $noHosts; $i++)
		{
			$usedValues[$i] = 0;
		} 

		foreach my $type (keys %noServerTypesToReplace)
		{
			for($i = 0; $i < $noServerTypesToReplace{$type}; $i++)
			{
				my $r = int(rand($noHosts));
				redo if($usedValues{$r} == 1);

				if($hostLines{$hostArray[$r]} =~ /: StandardHost/)
				{
					if($hostLines{$hostArray[$r]} =~ /($label{'HostLabel'}(\d+)):\s+StandardHost/) {
						$oldLabel = $1;
						$newLabel = $label{'HostLabel'}."_".$type.$2;
						$replacedHostNames{$1} = $label{'HostLabel'}."_".$type.$2;
						$hostLines{$hostArray[$r]} =~ s/$oldLabel: StandardHost/$newLabel: $type/;
						$usedValues{$r} = 1;
					}
				} else {
				    print "ERROR: Host should be replaced by server but line does not contain a StandardHost module:\n  $hostLines{$hostArray[$r]}\n";
				    exit(1);
				}
			}
		}
	} else {
		print "INFO: Total number of hosts: $noHosts, none of these will be replaced by servers\n";
	}


# finally, the new ned topology file will be written containing all newly integrated servers and special router types
# in addition all modules StandardHost are replaced by InetUserHost
	my $insideNode = 0;
	my $insideCoreNode = 0;
	foreach $line (@_)
	{
		if($insideCoreNode == 1)
		{
			if($line =~ /parameters:/)
			{
				print NEWTOP $line;
				$insideCoreNode = 0;
			}
			else
			{
				print NEWTOP $line;
			}
		}
		elsif($insideNode == 1)
		{
			if($line =~ /parameters:/)
			{
				print NEWTOP $line;
				$insideNode = 0;
			}
			else
			{
				print NEWTOP $line;
			}
		}
		elsif($line =~ /($label{'CoreLabel'}\d+): Router/)
		{
			print NEWTOP $routerLines{$1};
			$insideCoreNode = 1;
		}
		elsif(($line =~ /($label{'EdgeLabel'}\d+): Router/) || ($line =~ /($label{'GatewayLabel'}\d+): Router/))
		{
			print NEWTOP $routerLines{$1};
			$insideNode = 1;
		}
		elsif($line =~ /($label{'HostLabel'}\d+): StandardHost/)
		{
			$insideNode = 1;
			my $tmp = $1;
			if($hostLines{$tmp} =~ /StandardHost/)
			{
# replace StandardHost by InetUserHost
				$hostLines{$tmp} =~ s/StandardHost/InetUserHost/;
			}
			print NEWTOP $hostLines{$tmp};
		}
# connections between the nodes of the current AS are replaced by the appropriate channels
		elsif($line =~ /(($label{'HostLabel'}\d+)\.(pppg\$o|pppg\$i)\+\+).*(($label{'EdgeLabel'}\d+)\.(pppg\$o|pppg\$i)\+\+)/)
		{
# if host or router was replaced by a server or special router the connection has to be changed
			if(exists $replacedHostNames{$2} && exists $replacedRouterNames{$5})
			{
				print NEWTOP "\t\t$replacedHostNames{$2}\.$3\+\+ --> server2edge --> $replacedRouterNames{$5}\.$6\+\+;\n";
			} 
			elsif(exists $replacedHostNames{$2}) {
				print NEWTOP "\t\t$replacedHostNames{$2}\.$3\+\+ --> server2edge --> $4;\n";
			}
			elsif(exists $replacedRouterNames{$5})
			{
				print NEWTOP "\t\t$1 --> host2edge --> $replacedRouterNames{$5}\.$6\+\+;\n";
			}
			else
			{
				print NEWTOP $line;
			}
		}
		elsif($line =~ /(($label{'EdgeLabel'}\d+)\.(pppg\$o|pppg\$i)\+\+).*(($label{'HostLabel'}\d+)\.(pppg\$o|pppg\$i)\+\+)/)
		{
			if(exists $replacedRouterNames{$2} && exists $replacedHostNames{$5})
			{
				print NEWTOP "\t\t$replacedRouterNames{$2}\.$3\+\+ --> server2edge --> $replacedHostNames{$5}\.$6\+\+;\n";
			}
			elsif(exists $replacedRouterNames{$2}) {
				print NEWTOP "\t\t$replacedRouterNames{$2}\.$3\+\+ --> edge2host --> $4;\n";
			}
			elsif(exists $replacedHostNames{$5})
			{
				print NEWTOP "\t\t$1 --> server2edge --> $replacedHostNames{$5}\.$6\+\+;\n";
			}
			else
			{
				print NEWTOP $line;
			}
		}
		elsif($line =~ /(($label{'EdgeLabel'}\d+)\.pppg\+\+).*(($label{'GatewayLabel'}\d+)\.pppg\+\+)/)
		{
			if(exists $replacedRouterNames{$2} && exists $replacedRouterNames{$4})
			{
				print NEWTOP "\t\t$replacedRouterNames{$2}\.pppg\+\+ <--> edge2gateway <--> $replacedRouterNames{$4}\.pppg\+\+;\n";
			}
			elsif(exists $replacedRouterNames{$2}) {
				print NEWTOP "\t\t$replacedRouterNames{$2}\.pppg\+\+ <--> edge2gateway <--> $3;\n";
			}
			elsif(exists $replacedRouterNames{$4})
			{
				print NEWTOP "\t\t$1 <--> edge2gateway <--> $replacedRouterNames{$4}\.pppg\+\+;\n";
			}
			else
			{
				print NEWTOP $line;
			}
		}
		elsif($line =~ /(($label{'GatewayLabel'}\d+)\.pppg\+\+).*(($label{'EdgeLabel'}\d+)\.pppg\+\+)/)
		{
			if(exists $replacedRouterNames{$2} && exists $replacedRouterNames{$4})
			{
				print NEWTOP "\t\t$replacedRouterNames{$2}\.pppg\+\+ <--> edge2gateway <--> $replacedRouterNames{$4}\.pppg\+\+;\n";
			}
			elsif(exists $replacedRouterNames{$2}) {
				print NEWTOP "\t\t$replacedRouterNames{$2}\.pppg\+\+ <--> edge2gateway <--> $3;\n";
			}
			elsif(exists $replacedRouterNames{$4})
			{
				print NEWTOP "\t\t$1 <--> edge2gateway <--> $replacedRouterNames{$4}\.pppg\+\+;\n";
			}
			else
			{
				print NEWTOP $line;
			}
		}
		elsif($line =~ /(($label{'GatewayLabel'}\d+)\.pppg\+\+).*(($label{'CoreLabel'}\d+)\.pppg\+\+)/)
		{
			if(exists $replacedRouterNames{$2} && exists $replacedRouterNames{$4})
			{
				print NEWTOP "\t\t$replacedRouterNames{$2}\.pppg\+\+ <--> gateway2core <--> $replacedRouterNames{$4}\.pppg\+\+;\n";
			}
			elsif(exists $replacedRouterNames{$2}) {
				print NEWTOP "\t\t$replacedRouterNames{$2}\.pppg\+\+ <--> gateway2core <--> $3;\n";
			}
			elsif(exists $replacedRouterNames{$4})
			{
				print NEWTOP "\t\t$1 <--> gateway2core <--> $replacedRouterNames{$4}\.pppg\+\+;\n";
			}
			else
			{
				print NEWTOP $line;
			}
		}
		elsif($line =~ /(($label{'CoreLabel'}\d+)\.pppg\+\+).*(($label{'GatewayLabel'}\d+)\.pppg\+\+)/)
		{
			if(exists $replacedRouterNames{$2} && exists $replacedRouterNames{$4})
			{
				print NEWTOP "\t\t$replacedRouterNames{$2}\.pppg\+\+ <--> gateway2core <--> $replacedRouterNames{$4}\.pppg\+\+;\n";
			}
			elsif(exists $replacedRouterNames{$2}) {
				print NEWTOP "\t\t$replacedRouterNames{$2}\.pppg\+\+ <--> gateway2core <--> $3;\n";
			}
			elsif(exists $replacedRouterNames{$4})
			{
				print NEWTOP "\t\t$1 <--> gateway2core <--> $replacedRouterNames{$4}\.pppg\+\+;\n";
			}
			else
			{
				print NEWTOP $line;
			}
		}
		elsif($line =~ /(($label{'CoreLabel'}\d+)\.pppg\+\+).*(($label{'CoreLabel'}\d)+\.pppg\+\+)/)
		{
			if(exists $replacedRouterNames{$2} && exists $replacedRouterNames{$4})
			{
				print NEWTOP "\t\t$replacedRouterNames{$2}\.pppg\+\+ <--> core2core <--> $replacedRouterNames{$4}\.pppg\+\+;\n";
			}
			elsif(exists $replacedRouterNames{$2}) {
				print NEWTOP "\t\t$replacedRouterNames{$2}\.pppg\+\+ <--> core2core <--> $3;\n";
			}
			elsif(exists $replacedRouterNames{$4})
			{
				print NEWTOP "\t\t$1 <--> core2core <--> $replacedRouterNames{$4}\.pppg\+\+;\n";
			}
			else
			{
				print NEWTOP $line;
			}
		}
		# replace connections between different Autonomous Systems
		elsif($line =~ /((pppg\+\+).*)(($label{'CoreLabel'}\d)+\.pppg\+\+)/)
		{
			if(exists $replacedRouterNames{$4})
			{
				print NEWTOP "\t\t$1 $replacedRouterNames{$4}\.pppg\+\+;\n";
			}
			else
			{
				print NEWTOP $line;
			}
		}
# in case we have only a router-level topology and no AS at all, this line must be added into the module Internet
		elsif($line =~ /totalCountOfAS = /)
		{
			print NEWTOP "\t\t\t\ttotalCountOfAS = 0;\n";
		}
		else
		{
			print NEWTOP $line;
		}
	}
}

# processInternet
# parameter: array of lines describing current Autonomous System
#
# main method for writing main module Internet into the new ned file
# Total count of AS is included as well as connections renewed
sub processInternet
{
# calculate number of Autonomous Systems contained in the topology
	my $totalAsNumber = 0;
	foreach $line (@_)
	{
		if($line =~ /($label{'TransitLabel'}(\d+): )/)
		{
			$totalAsNumber++;
		}	
		elsif($line =~ /($label{'StubLabel'}(\d+): )/)
		{
			$totalAsNumber++;
		}
	}

	print "INFO: Number of Autonomous Systems: $totalAsNumber \n";

# writing definitions into output NED file
	my $processAs = 0;
	foreach $line (@_)
	{
		if($processAs == 1)
		{
			if($line =~ /parameters:/)
			{
				print NEWTOP $line;
				$processAs = 0;
			} else {
				print NEWTOP $line;
			}
		}
		elsif($line =~ /(totalCountOfAS = )/)
		{
			print NEWTOP "\t\t\t\ttotalCountOfAS = $totalAsNumber;\n";
		}
		elsif($line =~ /$label{'TransitLabel'}\d+/ || $line =~ /$label{'StubLabel'}\d+/)
		{
			print NEWTOP $line;
			$processAs = 1;
		} else {
			print NEWTOP $line;
		}
	}
}
