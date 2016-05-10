#!/usr/bin/perl
use Data::Dumper;

my $file=$ARGV[0];
open (R, ">parsed_meta");

my @line=`cat $file|awk -F "," '{print \$3,\$4}'`;
foreach my $rec(@line)
{
    my @tokens = split / /, $rec;
    chomp(@tokens);
    my @regions = split /\./, $tokens[0];
    print R "Regions: $regions[1]\n";
    print R "Start Key: $tokens[1]\n";
    print R "End Key: $tokens[3]\n";
}
