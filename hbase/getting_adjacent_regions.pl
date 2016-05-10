#!/usr/bin/perl
#use strict;
#use warnings;
use Data::Dumper;

$file1 = "/Users/singla/Downloads/component_wise_cases/hbase/verizon/77097/new_file";
$file2 = "/Users/singla/Downloads/component_wise_cases/hbase/verizon/77097/output_parser";

@cmd = `cat $file1|grep ": 0"|awk '{print \$1}'`;
chomp(@cmd);
#print Dumper @cmd;

foreach $rec(@cmd)
{
    print "Searching for region: $rec\n";
    print "You can merge the regions to any of the regions\n";
    $cmd1= `cat $file2|grep -C3 $rec|grep -v $rec|grep Regions`;
#print "$cmd1\n";
    print "$cmd1\n";
    print "MOVING TO THE NEXT ONE\n";
    print "***************************\n";
}
