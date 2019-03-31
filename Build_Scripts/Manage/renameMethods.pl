#!/bin/perl

use strict;
use warnings;
use File::Find;
use Tie::File;

my $retTypes = '^(double|bool|int|int64_t|void|SHDatetime\*)';
my %methodMap = ();
while(<>){
  if($_ =~ m/$retTypes/){
    (my $methodName = $_) =~ s/$retTypes *([A-Za-z0-9_]+)\(.*/$2/g;
    chomp($methodName);
    next if $methodName =~ m/^sh/;
    my $transformedName = "sh".uc(substr("$methodName",0,1)).substr($methodName,1,length($methodName));
    $methodMap{$methodName} = $transformedName; 
  }
}

sub wanted {
  return unless /\.(c|m|h)$/;
  return if $File::Find::dir =~ /\/\..+/;  
  tie(my @lines,'Tie::File',$_) or die "Couldn't open $_ or tie"; 
  foreach my $key (keys(%methodMap)) {
    my $mappedValue = $methodMap{$key};
    for(@lines){
      s/$key/$mappedValue/g;   
    } 
  } 
  untie @lines
}

my @files = <*>;
find(\&wanted,@files);
