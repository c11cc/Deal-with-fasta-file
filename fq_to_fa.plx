#fastq deal_getting counts
use strict;
use warnings;

print "function: transform fq to fa and count duplicates number\n";

print "enter fastq file name:\t";
my $file=<>;


#transform fq to fa format
my $new=0;
my @out=split /\./,$file;
my $out=$out[0].".fa";
open IN, "$file" or die $!;
open OUT, ">$out" or die $!;
while(<IN>)
  {
    chomp;   
    if($_=~/^\@/)	#new_line
      {
        $new=1;
        print OUT ">$_\n";
      }
    elsif($_!~/^\@/ and $new)
      {
        print OUT  "$_\n";
        $new=0;
      }
  }
close IN;
close OUT;

#----------------------------------------------------------------
#count the read count
my %seq;
my %counts;
my $tmp;
open IN, "$out" or die $!;
while(<IN>)
 {     
   chomp;
   if($_=~/^>/)
     {
       $tmp=$_;       
     }
   else
     {
     	 $seq{$_}=$tmp;
     	 $counts{$_}++;
     }
 }
close IN;

open OUT, ">$out" or die $!;
foreach my $key ( sort{$counts{$b} <=> $counts{$a}} keys %counts)
 {
 	 print OUT "$seq{$key}\tread_count:\t$counts{$key}\n$key\n";
 }
close OUT;