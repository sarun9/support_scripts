#!/usr/bin/perl
use Data::Dumper;
use MIME::Lite;
$cmd="curl -s http://node5.sarun.hwx.com:8088/jmx?qry=Hadoop:*|grep AppsPending";
@arr=`$cmd`;
chmod(@arr);
foreach $rec(@arr)
{

    @test=split(/:/,$rec);
    if($test[1]>= 2)
    {
        print "$test[0] $test[1]";
        $data1="$test[0] $test[1]";
        push(@apps_above,$test[1]);

        $to = 'saruntek@gmail.com';
        $from = 'ssingla@hortonworks.com';
        $subject = 'Probable RM issue';
        $message = '<h1>Please Check</h1>';

        $msg = MIME::Lite->new(
                From     => $from,
                To       => $to,
                Cc       => $cc,
                Subject  => "Check the cluster",
                Data     => $data1
                );
        $msg->attr("content-type" => "text/html");
        $msg->send;
        print "Email Sent Successfully\n";
    }
}
