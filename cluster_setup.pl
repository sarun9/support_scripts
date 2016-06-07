#!/usr/bin/perl
use Data::Dumper;
@hosts=`cat host_file`;
chomp(@hosts);

### Genrating the ssh keys on the server node, these will be later copied to all the agent machines.
$generate_ssh_keys = `ssh-keygen`;
$authorized_keys = `cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys`;
$change_file_permissions = `chmod 700 ~/.ssh`;
$change_file_perm = `chmod 600 ~/.ssh/authorized_keys`;


foreach $rec1(@hosts)
{
#print "$rec1 \n";
print "Copying the keys to other nodes in the new cluster\n";
$id_rsa_key_copy = `scp /root/.ssh/id_rsa.pub root\@$rec1:/root/\.ssh/`;

#### Once we have the keys we will create the authorized keys for password less access

$authorized_key_copy = `ssh root\@$rec1 'cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys'`;
## changing the file permissions
$chnaging_perm1 = `chmod 700 ~/.ssh`;
$changing_perm2 = `chmod 600 ~/.ssh/authorized_keys`;
}


foreach $installation(@hosts)
{
  print "===================================\n";
  print "Installing the following to host: $installation \n";
  print "===================================\n";
  print "Installing NTP\n";
  $ntp = `ssh $installation 'yum -y install ntp'`;
  print "Installing wget\n";
  $install_wget = `ssh $installation 'yum -y install wget'`;
  print "Switching off IP TABLES\n";
  $switch_off_iptables = `ssh $installation 'chkconfig iptables off'`;
  print "setenforce to 0\n";
  $set_force = `ssh $installation 'setenforce 0'`;
  print "Enables setting to 0\n";
  $enable = `ssh $installation 'enabled=0'`;
  print "Stoping IP tables\n";
  $iptable_stop = `ssh $installation '/etc/init.d/iptables stop'`;
  print "installing yum-utils\n";
  $create_repo = `ssh $installation 'yum -y install yum-utils createrepo'`;
  print "Checkconfig starting ntp\n";
  $conf_ntp_start = `chkconfig ntpd on`;
  print "Service ntpd start\n";
  $ntp_start = `service ntpd start`;
}

foreach $testing(@hosts)
{
  print "\n\n !!validations!! \n";
  print "=========================\n";
  print "This is to validate if all the above steps were completed successfully\n";
  print "Host-Ip: $testing\n";
  $check = `ssh $testing 'ls -ltr /root/.ssh/'`;
  print "Check to see if the keys were copied\n";
  print "$check\n";
}

$repo_link = $ARGV[0];
$get_amabrirepo = "wget -nv $repo_link";
print "$get_ambarirepo\n";
$test = `$get_amabrirepo`;
print "Repository is configured by checking the repo list\n";
$repolist = `yum -y repolist`;

#print "Installing Ambari\n";
#$install_ambari = `yum  install ambari-server`;
#print "$install_ambari\n";
