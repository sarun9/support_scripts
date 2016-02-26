#!/usr/bin/perl
# Sarun Singla
# Reference http://www.tizag.com/perlT/perlhashes.php
#
use Data::Dumper;

## Command that gets the application_id from the yarn application list
$app_id="yarn application -list  2> /dev/null|awk -F \" \" '{print \$1,\$4}'|grep application_";

#$audit_log=$ARGV[0];

@uniq_users=`cat /var/log/hadoop/hdfs/hdfs-audit.log|awk '{print \$6}'|awk -F "=" '{print \$2}'|sort|uniq`;
chomp(@uniq_users);
print "Unique users from the audit logs at this time\n";
print  Dumper @uniq_users;

#print "$app_id\n";
@var= `ssh kerb2 $app_id`;
chomp(@var);
## generating a hash for k-v pair on user and application_id
foreach $rec(@var)
{
    @var1=split / /,$rec;
    my @data = ("$var1[1]","$var1[0]");
#%hash=("$var1[1]","$var1[0]");

    while ($key = shift (@data))
    {
        $value   = shift (@data);

# push the value on the array
        push @{$hash{$key}}, $value;
    }
}

#print Dumper %hash;

print "\n\n";
#####Please do not delete this blocl as it will come handy for prod apps.
####$get_uniq_users="cat hdfs-audit.log.2015-08-17|awk '{print \$6}'|awk -F \"\=\" '{print \$2}'|sort|uniq";
####@uniq_users=`$get_uniq_users`;

@uniq_users=("hdfs","yarn");

#print Dumper @uniq_users;
##Testing new loops

foreach my $user(@uniq_users)
{
    print "Users in question are:  $user\n";
    @new_array = @hash{ grep { exists $hash{$_} } @uniq_users };
}
print Dumper @new_array;
