#!/usr/bin/perl
#use strict;
#use warnings;
use Data::Dumper;
use JSON;

#my $json=`curl -s http://node1.sarun.hwx.com:50070/jmx`;

my $json=`curl -s http://172.25.16.188:50070/jmx`;
my $decoded = decode_json($json);
#print Dumper $decoded;

my @values = @{ $decoded->{'beans'} };
foreach my $f(@values)
{
#print $f->{"name"} . "\n";

    $up_val=$f -> {"UpgradeFinalized"} . "\n";
    $live_dn= $f -> {"NumLiveDataNodes"} . "\n";
    $decom_dn= $f -> {"NumDecomLiveDataNodes"} . "\n";
    $software_version= $f ->{"SoftwareVersion"} ."\n";
    $dead_dn= $f -> {"DeadNodes"} . "\n";
    $total_blocks= $f -> {"TotalBlocks"} . "\n";
    $total_files = $f -> {"TotalFiles"} . "\n";
    $no_of_missing_files = $f -> {"NumberOfMissingBlocks"} . "\n";
    $rpc_queue = $f ->{"RpcQueueTimeAvgTime"} . "\n";

    $call_queue= $f -> {"CallQueueLength"} . "\n";
    push(@call,$call_queue);
# call length will not display if its equal to 0
if($call_queue=~m/0/)
{

    print "CallQueueLength: $call_queue";
    }
    if($software_version != NULL)
    {
        print "Software version : $software_version";
    }
    if($decom_dn != NULL)
    {
        print "Decomissioned Node: $decom_dn";

    }
    if($live_dn != NULL)
    {
        print "Live Datanodes: $live_dn";
    }
    if($up_val != NULL)
    {
        print "UpgradeFinalized : $up_val";
    }
    if($dead_dn =~ m/\{\}/)
    {
        print "Dead_dn: $dead_dn";
    }
    if($total_blocks != NULL)
    {
        print "Total Blocks: $total_blocks";
    }

    if($total_files != NULL)
    {
        print "Total files : $total_files";
    }

    if($no_of_missing_files != NULL)
    {
        print "No of Missing Files : $no_of_missing_files";
    }
    if($rpc_queue != NULL)
        {
        print "RpcQueueTimeAvgTime : $rpc_queue";
    }


}
