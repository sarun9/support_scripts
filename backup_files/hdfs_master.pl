#!/usr/bin/perl
use Data::Dumper;
@namenode_proc=`ps -ef|grep namenode|cut -d ' ' -f25-|sed 1d`;
@zkfc=`ps -ef | grep zkfc|cut -d ' ' -f25-|sed 1d`;
chomp(@namenode_proc);
chomp(@zkfc);
@tp=split / /,@namenode_proc[1];
@tp1=split / /,@zkfc[1];

foreach $rec(@tp)
{
    if($rec=~ m/^-/)
    {
        $test = substr($rec, 1);
#print "$test\n";
        push(@with_namenode,$test);
    }
    else
    {
        push(@without_namenode,$rec);
    }
}

foreach $rec1(@tp1)
{
    if($rec1=~ m/^-/)
    {
        $test1= substr($rec1,1);
        push(@with_zkfc,$test1);
    }
    else
    {
        push(@without_zkfc,$rec1);
    }
}

$audit_log=$ARGV[0];
print "Users with highest number of operations.\n";
@user_operations=`cat $audit_log | grep ugi= | awk '{print \$6}' | sort | uniq -c`;
print @user_operations;

print "===================\n";
print "NameNode Details\n";
print "===================\n";


foreach(@with_namenode,@without_namenode)
{
    print "$_\n";
}

print "\n\n================\n";
print "ZKFC Details\n";
print "================\n";
foreach(@with_zkfc,@without_zkfc)
{
    print "$_\n";
}
