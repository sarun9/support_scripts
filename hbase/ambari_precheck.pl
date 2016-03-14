#!/usr/bin/perl

use Data::Dumper;
use JSON;

@hosts=`cat hostnames`;
chomp(@hosts);

foreach $rec (@hosts)
{
    $hdp_select= "ssh $rec hdp-select versions";
    print "HOSTNAME : $rec\n";
    print "HDP VERSION:\n";
    $check=`$hdp_select`;
    print "$check\n";;
}
print "\n";
print "CHECK IF ALL HOSTS ARE HEARTBEATING\n";
@heartbeat=`curl -s -u admin:admin node1.sarun.hwx.com:8080/api/v1/clusters/nuras_dev/hosts?Hosts/host_state!=HEALTHY|grep items`;
chomp(@heartbeat);
foreach $recter3(@heartbeat)
{
    @c4=split(/\"/,$recter3);
    @c5=split(/\:/,$c4[2]);
    chomp(@c5);
    $c5[1] =~ /^\s*(.*?)\s*$/;
    print  "$c5[1]\n";
}


print "CHECK IF NO SERVICES ARE IN MAINTENANCE MODE\n";
@maintenance_mode=`curl -s -u admin:admin http://node1.sarun.hwx.com:8080/api/v1/clusters/nuras_dev/services?ServiceInfo/maintenance_state=ON|grep items`;
chomp(@maintenance_mode);
foreach $recter2(@maintenance_mode)
{
    @c2=split(/\"/,$recter2);
    @c3=split(/\:/,$c2[2]);
    chomp(@c3);
    $c3[1] =~ /^\s*(.*?)\s*$/;
    print  "$c3[1]\n";
}
print "CHECK TO SEE THE COMPONENTS THAT ARE STARTED\n";
my @json_text = `curl -s -u admin:admin http://node1.sarun.hwx.com:8080/api/v1/clusters/nuras_dev/services?ServiceInfo/state!=STARTED|grep service_name`;
#print Dumper @json_text;
chomp(@json_text);
#my @newarray = grep(s/\s*$//g, @json_text);
foreach $recter (@json_text)
{
    @c1=split(/\"/,$recter);
    print "$c1[3]\n";
}
