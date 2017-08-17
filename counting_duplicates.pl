#!/usr/bin/perl  
#Lori Gladney 9-29-14
#For counting duplicates in NCBI pathogen trees using pathogen metadata tables (metadata.csv) and #newick trees from the NCBI FTP site
#Usage: counting_duplicates.pl tree.nwk metadata.csv

use warnings;
use strict; 

 open(TREE,$ARGV[0]);

 my $wholeTree=<TREE>; 
 
 close TREE;

 open(MAP,$ARGV[1]);
 
 my $header=<MAP>; 
 
 my $ASM;
 my $SAMN;
 my $PDT;
 my $counts;
 my %hash;
 while(<MAP>){
 
	chomp; 
	
	($ASM,$SAMN,$PDT)=(split /\t/)[7,16,35]; 
	
	$SAMN=$ASM if($SAMN eq "NULL"); 
	
	$wholeTree=~s/$PDT/$SAMN/g;  
	
	$hash{$SAMN}++;

	
	
}

#print $wholeTree;

foreach my $i (sort keys %hash) {

if ($hash{$i} > 1) {
print "$i seen $hash{$i} times\n";
}

}

exit; 