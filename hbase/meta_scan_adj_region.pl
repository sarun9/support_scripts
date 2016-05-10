#!/usr/bin/perl

use Data::Dumper;
my $file=$ARGV[0];

open (R, ">parsed_meta");

my @line=`cat $file|awk -F "," '{print \$3,\$4}'`;
foreach my $rec1(@line)
{
	my @tokens = split / /, $rec1;
	chomp(@tokens);
	my @regions = split /\./, $tokens[0];
	print R "Regions: $regions[1]\n";
	print R "Start Key: $tokens[1]\n";
	print R "End Key: $tokens[3]\n";
}

$file1 = "/Users/singla/Downloads/component_wise_cases/hbase/verizon/77097/new_file";
$file2 = "parsed_meta";

open (S, ">adjacent_region_list");

@regions_size_zero = `cat $file1|grep ": 0"|awk '{print \$1}'`;
chomp(@regions_size_zero);
#print Dumper @cmd;

foreach $rec(@regions_size_zero)
{
    print S "Searching for region: $rec\n";
    print S "You can merge the regions to any of the regions\n";
    $adj_regions= `cat $file2|grep -C3 $rec|grep -v $rec|grep Regions`;
    print S "$adj_regions\n";
    print S "MOVING TO THE NEXT ONE\n";
    print S "***************************\n";
}
