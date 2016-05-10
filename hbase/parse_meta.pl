#!/usr/bin/perl
#use strict;
#use warnings;
use Data::Dumper;

@line=`cat meta_parsed_start_endkey|awk -F "," '{print \$3,\$4}'`;
foreach $rec(@line)
{
    my @tokens = split / /, $rec;
    chomp(@tokens);
    #print Dumper @tokens;
    my @regions = split /\./, $tokens[0];
    print "Regions: $regions[1]\n";
#   print "Region: $tokens[0]\n";
    print "Start Key: $tokens[1]\n";
    print "End Key: $tokens[3]\n";
}
