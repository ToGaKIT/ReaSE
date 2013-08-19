#!/usr/bin/perl

use POSIX;
#srand(99);
srand(time());

# Function of this script: replaces a specific node type by another type
# in the whole topology
# input parameter: percentage of nodes to replace

die ("replaceNodeType.pl <InputNedFile> <OutputNedFile> <OldNodeType> <NewNodeType> <Percentage 0/000>\n") if($#ARGV != 4);

open TOP, "$ARGV[0]" or die "Could not open input ned file\n";
open OUT, ">$ARGV[1]" or die "Could not open output ned file\n";

# number of nodes with given old node type
$nodeCount = 0;
# number of replaced nodes
$replacedNodeCount = 0;
# shows if connections part of a module is reached
$replaceConnections = 1;
# remember replaced names
%replacedNames = ();
$importDone = 0;

foreach $line (<TOP>)
{

	if($line =~ /import/ && $importDone == 0)
	{
# only add import line once
		$line = "import rease.nodes.inet.$ARGV[3];\n$line";
		$importDone = 1;
	}

	if($line =~ /(([a-zA-Z_]+)(\d+)):\s+$ARGV[2]/) 
	{
		$nodeCount++;

		# replace node type according to given one-tenth of a percent
		if(int(rand(1000)) < $ARGV[4])
		{
			$oldLabel = $1;
			$newLabel = $2."_".$ARGV[3].$3;
			#print "DEBUG newlabel: $newLabel (old: $oldLabel)\n";
			$replacedNames{$1} = $2."_".$ARGV[3].$3;
			$line =~ s/$oldLabel:\s+$ARGV[2] {/$newLabel: $ARGV[3] {/;

			$replacedNodeCount++;
		}
	}

	if($line =~ /\s*connections:/)
	{
		$replaceConnections = 1;
	}

	
	if($replaceConnections == 1 && $line =~ /((\w+\d*)\.*(pppg\$o|pppg\$i|pppg)\+\+).*\s((\w+\d*)\.*(pppg\$o|pppg\$i|pppg)\+\+)/)
	{
		$firstLabel = $2;
		$secondLabel = $5;

		if(exists $replacedNames{$firstLabel})
		{
			$line =~ s/$firstLabel\./$replacedNames{$firstLabel}\./;
		}
		if(exists $replacedNames{$secondLabel})
		{
			$line =~ s/$secondLabel\./$replacedNames{$secondLabel}\./;
		}
	}

	if($replaceConnections == 1 && $line =~ /(\s+((pppg\$o|pppg\$i|pppg)\+\+).*\s)((\w+\d*)\.*(pppg\$o|pppg\$i|pppg)\+\+)/)
	{
		$secondLabel = $5;

		if(exists $replacedNames{$secondLabel})
		{
			$line =~ s/$secondLabel\./$replacedNames{$secondLabel}\./;
		}
	}

# if replaceConnections equals 1, we can safely assume that any closing bracket is the closing bracket of an AS module
	if($replaceConnections == 1 && $line =~ /}/)
	{
		$replaceConnections = 0;
		%replacedNames = ();
	}

	print OUT $line;
}

#summary
print "$replacedNodeCount nodes of $nodeCount type $ARGV[2] nodes have been replaced by type $ARGV[3] nodes\n"; 
