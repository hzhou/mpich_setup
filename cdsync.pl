#!/usr/bin/perl
use strict;
use Cwd;
my $cwd = cwd();
$cwd=~s/\/var\/lib\/jenkins-slave\/users/$ENV{HOME}\/temp/;
my $cur_tty;
my %pid_hash;
my $cmd = "ps -u zhouh -o pid,tty,cmd";
open In, "$cmd |" or die "Can't open $cmd |.\n";
while(<In>){
    if(/(\d+)\s+(\S+)\s+(.*)/){
        my ($pid, $tty, $cmd) = ($1, $2, $3);
        if($pid eq $$){
            $cur_tty = $tty;
        }
        elsif($cmd eq "-bash"){
            $pid_hash{$pid} = $tty;
        }
    }
}
close In;
my $cnt = 0;
foreach my $pid (keys %pid_hash){
    if($pid_hash{$pid} ne $cur_tty){
        my $dir = `pwdx $pid`;
        if($dir=~/\d+:\s*(\S+)/){
            my $t = $1;
            if($cwd ne $t){
                $t=~s/\/var\/lib\/jenkins-slave\/users/$ENV{HOME}\/temp/;
                print "$t\n";
                $cnt++;
            }
        }
    }
}
if(!$cnt){
    print "$cwd\n";
}
