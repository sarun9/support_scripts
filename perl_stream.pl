#!/usr/bin/perl
use Data::Dumper;

foreach $rec(<STDIN>)
{
@data= split / /,$rec;
chomp(@data);
### removing the blank values from an array
@data=grep { defined && m/[^\s]/ } @data;

##print "DATE \t TIME_SEC \t TIME_MS \t USER \t IP \t COMMAND_RAN  \t SOURCE_RAN\n";

##time breaker
@time_var= split /,/,$data[1];
@user=split /\t/,$data[4];
@user_1=split /=/,$user[1];
@spliting_more_data=split /\t/,$data[5];
@ip=split /=/,$spliting_more_data[1];

@command_ran=split /=/,$spliting_more_data[2];
@src_ran_on=split /=/,$spliting_more_data[3];

print "$data[0] $time_var[0] $time_var[1] $user_1[1] $ip[1] $command_ran[1] $src_ran_on[1]\n";

}
