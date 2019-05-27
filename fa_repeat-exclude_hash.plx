#excluding repeated records in fasta format
use strict;
use warnings;


my %seq;
my $dupl=0;
my $tmp;

print "enter file name:\t";
my $file=<>;

open IN, "$file" or die $!;
while(<IN>)
  {
    chomp;
    if($_=~/^>/ and !$seq{$_})
      {
        $seq{$_}->[0]=1;
        $tmp=$_;
        $dupl=0;
        next;
      }
    elsif($_=~/^>/ and $seq{$_})
      {
        $dupl=1;
        next;
      }
    elsif($_!~/^>/ and !$dupl)
      {        
        $seq{$tmp}->[1].=$_;
      }
  }
close IN;

my @out=split /\./,$file;
my $outfile=$out[0]."_no_re.".$out[1];
open OUT, ">$outfile" or die $!;
foreach $tmp (sort keys %seq)
  {
    print OUT "$tmp\n$seq{$tmp}->[1]\n";
  }
close OUT;