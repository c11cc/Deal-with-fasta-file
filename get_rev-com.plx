#deal with the sequences in fasta format and get their reverse-complement sequence.
use strict;
use warnings;

print"enter the sequence file\n";
my $file=<>;
my @gme;
my @rgme;

my $i=-1;
open IN,"$file"or die"$!";
  while(<IN>)
   {
   	 chomp;
     if($_=~ /^>/)
       {
       	 $i++;
         $gme[$i][0]=$_;
       }
     else
       {
         $gme[$i][1].=$_;
       }

   }
close IN;

foreach $i(0..$i)
  {  
    $gme[$i][1]=~tr/[a-z]/[A-Z]/;
    $rgme[$i][0]=$gme[$i][0];
    $rgme[$i][1]=reverse $gme[$i][1];
    $rgme[$i][1]=~tr/A/t/;
    $rgme[$i][1]=~tr/T/A/;
    $rgme[$i][1]=~tr/C/g/;
    $rgme[$i][1]=~tr/G/C/;
    $rgme[$i][1]=~tr/t/T/;
    $rgme[$i][1]=~tr/g/G/;
  }

open OUT,">$file"or die"$!";
foreach $i(0..$i)
  {
    print OUT $gme[$i][0],"\n";
    print OUT $gme[$i][1],"\n";
  }
close OUT;

open OUT,">reverse-$file" or die"$!";
foreach $i(0..$i)
  {
    print OUT $rgme[$i][0],"\n";
    print OUT $rgme[$i][1],"\n";
  }
close OUT;