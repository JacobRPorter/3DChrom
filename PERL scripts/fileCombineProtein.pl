###################################################################################################################
#                                                                                          
# Description: This program turns our hgdf_x_protein_sorted file into a flat array.
# Language: Perl
# Author: Jacob R. Porter
# Date: 10/16/2015
#
# We create a flat array from our hgdf_x_protein_sorted.txt file
# It contains the following indexes:
# [0]EnsemblGeneID, [1]PfamID, [2]PfamStart, [3]PfamEnd, [4]EnsemblProteinFamilyID, [5]EnsemblFamilyDescription
# [6]InterproID, [7]InterproShortDescription, [8]InterproDescription, [9]PfscanID, [10]PfscanStart, [11]PfscanEnd
# [12]InterproStart, [13]InterproEnd
#
####################################################################################################################
my @hgdf_x_protein_array;

open(MYINPUTFILE, "<hgdf_x_protein_sorted.txt");
open(my $outputFile, '>', 'hgdf_x_protein_flat.txt');

$i = 0;
$j = 0;
$previousGene = 123123123;

while(<MYINPUTFILE>) {
        chomp;
        my $line = $_;
        $line =~ s/'//;
        $line =~ s/"//;
	$line =~ s/\n//;


        my @hgdfarray = split/\t/, $line;

        if ($hgdfarray[0] eq $previousGene) {
                # Associated with genes may be multiple transcript_id, protein_id, and the transcript_start and transcript_end will change. Therefore, we are storing all those possible
                # values in elements with format 1*2*3

		print "$i"."\n";
                $hgdf_x_protein_array[$j-1][1] = $hgdf_x_protein_array[$j-1][1] . "*" . $hgdfarray[1];
                $hgdf_x_protein_array[$j-1][2] = $hgdf_x_protein_array[$j-1][2] . "*" . $hgdfarray[2];
                $hgdf_x_protein_array[$j-1][3] = $hgdf_x_protein_array[$j-1][3] . "*" . $hgdfarray[3];
                $hgdf_x_protein_array[$j-1][4] = $hgdf_x_protein_array[$j-1][4] . "*" . $hgdfarray[4];
                $hgdf_x_protein_array[$j-1][5] = $hgdf_x_protein_array[$j-1][5] . "*" . $hgdfarray[5];
                $hgdf_x_protein_array[$j-1][6] = $hgdf_x_protein_array[$j-1][6] . "*" . $hgdfarray[6];
                $hgdf_x_protein_array[$j-1][7] = $hgdf_x_protein_array[$j-1][7] . "*" . $hgdfarray[7];
                $hgdf_x_protein_array[$j-1][8] = $hgdf_x_protein_array[$j-1][8] . "*" . $hgdfarray[8];
		$hgdf_x_protein_array[$j-1][9] = $hgdf_x_protein_array[$j-1][9] . "*" . $hgdfarray[9];
		$hgdf_x_protein_array[$j-1][10] = $hgdf_x_protein_array[$j-1][10] . "*" . $hgdfarray[10];
		$hgdf_x_protein_array[$j-1][11] = $hgdf_x_protein_array[$j-1][11] . "*" . $hgdfarray[11];
		$hgdf_x_protein_array[$j-1][12] = $hgdf_x_protein_array[$j-1][12] . "*" . $hgdfarray[12];
		$hgdf_x_protein_array[$j-1][13] = $hgdf_x_protein_array[$j-1][13] . "*" . $hgdfarray[13];

        } else {
		print "$hgdfarray[0]"."\n";

                $hgdf_x_protein_array[$j][0] = $hgdfarray[0];
                $hgdf_x_protein_array[$j][1] = $hgdfarray[1];
                $hgdf_x_protein_array[$j][2] = $hgdfarray[2];
                $hgdf_x_protein_array[$j][3] = $hgdfarray[3];
                $hgdf_x_protein_array[$j][4] = $hgdfarray[4];
                $hgdf_x_protein_array[$j][5] = $hgdfarray[5];
                $hgdf_x_protein_array[$j][6] = $hgdfarray[6];
                $hgdf_x_protein_array[$j][7] = $hgdfarray[7];
                $hgdf_x_protein_array[$j][8] = $hgdfarray[8];
		$hgdf_x_protein_array[$j][9] = $hgdfarray[9];
		$hgdf_x_protein_array[$j][10] = $hgdfarray[10];
		$hgdf_x_protein_array[$j][11] = $hgdfarray[11];
		$hgdf_x_protein_array[$j][12] = $hgdfarray[12];
		$hgdf_x_protein_array[$j][13] = $hgdfarray[13];

                $j = $j+1;
                $previousGene = $hgdfarray[0];
        }
	$i = $i+1;
}

close MYINPUTFILE;

foreach (@hgdf_x_protein_array) {
        print $outputFile @$_[0] . "\t" . @$_[1] . "\t" . @$_[2] . "\t" . @$_[3] . "\t" . @$_[4] . "\t" . @$_[5] . "\t" . @$_[6] . "\t" . @$_[7]. "\t" . @$_[8] . "\t" . @$_[9] . "\t" . @$_[10] . "\t" . @$_[11] . "\t" . @$_[12] . "\t" . @$_[13]."\n";
}

close $outputFile;

print "Done with hgdf_x_protein_array flat file!"."\n";