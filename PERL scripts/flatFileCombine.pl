###############################################################################################
#                                                                                          
# Description: This file combines smaller flat files into larger files.
# Language: Perl
# Author: Jacob R. Porter
# Date: 10/16/2015
#
###############################################################################################
# http://perl101.org/arrays.html (Think about using maps and hashes)

# Here, we can define our global arrays.

my @hgdf_x_base_array;
my @hgdf_x_external_1_array;
my @hgdf_x_external_2_array;
my @hgdf_x_protein_array;
my $i = 0;
my $j = 0;

###############################################################################################
#
# The first thing that we want to do is turn our hgdf_x_base flat file into an array of format
# array[i][j]     
#
###############################################################################################

open(MYINPUTFILE, "<hgdf_x_base_flat.txt");

while(<MYINPUTFILE>) {
	chomp;
	my $line = $_;
        $line =~ s/'//;
        $line =~ s/"//;
        $line =~ s/\n//;

        my @hgdfarray = split/\t/, $line;

	foreach my $hgdfarray (@hgdfarray) {
		$hgdf_x_base_array[$i][$j] = $hgdfarray[$j];
		$j = $j+1;	
	}	
	$i = $i+1;
	$j = 0;
} 

close MYINPUTFILE;

#print "hgdf_x_base_array[4][5]: ".$hgdf_x_base_array[4][5]."\n";

$i = 0;
$j = 0;

###############################################################################################
#
# The second thing that we want to do is turn our hgdf_x_external_1 flat file into an array of
# format array[i][j]
#
###############################################################################################

open(MYINPUTFILE, "<hgdf_x_external_1_flat.txt");

while(<MYINPUTFILE>) {
        chomp;
        my $line = $_;
        $line =~ s/'//;
        $line =~ s/"//;
        $line =~ s/\n//;

        my @hgdfarray = split/\t/, $line;

        foreach my $hgdf_array (@hgdfarray) {
                $hgdf_x_external_1_array[$i][$j] = $hgdfarray[$j];
                $j = $j+1;
        }
        $i = $i+1;
        $j = 0;
}

close MYINPUTFILE;

#print "hgdf_x_external_1_array[4][5]: ".$hgdf_x_external_1_array[4][5]."\n";

$i = 0;
$j = 0;

###############################################################################################
#
# The third thing that we want to do is turn our hgdf_x_external_2 flat file into an array of 
# format array[i][j]
#
###############################################################################################

open(MYINPUTFILE, "<hgdf_x_external_2_flat.txt");

while(<MYINPUTFILE>) {
        chomp;
        my $line = $_;
        $line =~ s/'//;
        $line =~ s/"//;
        $line =~ s/\n//;

        my @hgdfarray = split/\t/, $line;

        foreach my $hgdf_array (@hgdfarray) {
                $hgdf_x_external_2_array[$i][$j] = $hgdfarray[$j];
                $j = $j+1;
        }
        $i = $i+1;
        $j = 0;
}

close MYINPUTFILE;

#print "hgdf_x_external_2_array[4][5]: ".$hgdf_x_external_2_array[4][5]."\n";

# http://perl101.org/arrays.html (Think about using maps and hashes)

$i = 0;
$j = 0;

###############################################################################################
#
# The fourth thing that we want to do is turn our hgdf_x_protein flat file into an array of 
# format array[i][j]
#
###############################################################################################

open(MYINPUTFILE, "<hgdf_x_protein_flat.txt");

while(<MYINPUTFILE>) {
        chomp;
        my $line = $_;
        $line =~ s/'//;
        $line =~ s/"//;
        $line =~ s/\n//;

        my @hgdfarray = split/\t/, $line;

        foreach my $hgdf_array (@hgdfarray) {
                $hgdf_x_protein_array[$i][$j] = $hgdfarray[$j];
                $j = $j+1;
        }
        $i = $i+1;
        $j = 0;
}

close MYINPUTFILE;

#print "hgdf_x_protein_array[4][5]: ".$hgdf_x_protein_array[4][5]."\n";

$i = 0;
$j = 0;

###############################################################################################################
# We now have four arrays in array[i][j] format:
#
# my @hgdf_x_base_array;
# my @hgdf_x_external_1_array;
# my @hgdf_x_external_2_array;
# my @hgdf_x_protein_array;
#
# We will combine the latter 3 arrays into @hgdf_x_base_array by pushing the indexes after [0] if [0] has the
# same EnsmemblGeneID as $hgdf_x_base_array[0]
#
##############################################################################################################

#### First, let us start with combining the hgdf_x_base_array and hgdf_x_external_1_array. ###################

$i = 0;
$j = 0;
foreach $hgdf_x_base (@hgdf_x_base_array) {
	foreach $hgdf_x_external_1 (@hgdf_x_external_1_array) {
		if (@$hgdf_x_base[0] eq @$hgdf_x_external_1[0]) {
			$hgdf_x_base_array[$i][8] = @$hgdf_x_external_1[1];
                       	$hgdf_x_base_array[$i][9] = @$hgdf_x_external_1[2];
                       	$hgdf_x_base_array[$i][10] = @$hgdf_x_external_1[3];
                       	$hgdf_x_base_array[$i][11] = @$hgdf_x_external_1[4];
                       	$hgdf_x_base_array[$i][12] = @$hgdf_x_external_1[5];
                       	$hgdf_x_base_array[$i][13] = @$hgdf_x_external_1[6];
                       	$hgdf_x_base_array[$i][14] = @$hgdf_x_external_1[7];
                       	$hgdf_x_base_array[$i][15] = @$hgdf_x_external_1[8];
		}
	}
	$i = $i+1;
}

#### Second, let us combine the hgdf_x_base_array and hgdf_x_external_2_array. ##############################

$i = 0;
$j = 0;
foreach $hgdf_x_base (@hgdf_x_base_array) {
        foreach $hgdf_x_external_2 (@hgdf_x_external_2_array) {
                if (@$hgdf_x_base[0] eq @$hgdf_x_external_2[0]) {
                        $hgdf_x_base_array[$i][16] = @$hgdf_x_external_2[1];
                        $hgdf_x_base_array[$i][17] = @$hgdf_x_external_2[2];
                }
        }
        $i = $i+1;
}


#### Third, let us combine the hgdf_x_base_array and hgdf_x_protein_array. ###################

$i = 0;
$j = 0;
foreach $hgdf_x_base (@hgdf_x_base_array) {
        foreach $hgdf_x_protein (@hgdf_x_protein_array) {
                if (@$hgdf_x_base[0] eq @$hgdf_x_protein[0]) {
                        $hgdf_x_base_array[$i][18] = @$hgdf_x_protein[1];
                        $hgdf_x_base_array[$i][19] = @$hgdf_x_protein[2];
                        $hgdf_x_base_array[$i][20] = @$hgdf_x_protein[3];
                        $hgdf_x_base_array[$i][21] = @$hgdf_x_protein[4];
                        $hgdf_x_base_array[$i][22] = @$hgdf_x_protein[5];
                        $hgdf_x_base_array[$i][23] = @$hgdf_x_protein[6];
                        $hgdf_x_base_array[$i][24] = @$hgdf_x_protein[7];
                        $hgdf_x_base_array[$i][25] = @$hgdf_x_protein[8];
			$hgdf_x_base_array[$i][26] = @$hgdf_x_protein[4];
                        $hgdf_x_base_array[$i][27] = @$hgdf_x_protein[5];
                        $hgdf_x_base_array[$i][28] = @$hgdf_x_protein[6];
                        $hgdf_x_base_array[$i][29] = @$hgdf_x_protein[7];
                        $hgdf_x_base_array[$i][30] = @$hgdf_x_protein[8];
                }
        }
        $i = $i+1;
}

$i = 0;
$j = 0;

#### Finally, we are going to print all these $hgdf_x_base_array into one large file. ##########

open(my $outputFile, '>', 'hgdf_x_flat_file.txt');


foreach (@hgdf_x_base_array) {
	print $outputFile @$_[0] . "\t" . @$_[1] . "\t" . @$_[2] . "\t" . @$_[3] . "\t" . @$_[4] . "\t" . @$_[5] . "\t" . @$_[6] . "\t" . @$_[7] . "\t" . @$_[8] . "\t" . @$_[9] . "\t" . @$_[10] . "\t" . @$_[11] . "\t" . @$_[12] . "\t" . @$_[13] . "\t" . @$_[14] . "\t" . @$_[15] . @$_[16] . "\t" . @$_[17] . "\t" . @$_[18] . "\t" . @$_[19] . "\t" . @$_[20] . "\t" . @$_[21] . "\t" . @$_[22] . "\t" . @$_[23] . "\t" . @$_[24] . "\t" . @$_[25] . "\t" . @$_[26] . "\t" . @$_[27] . "\t" . @$_[28] . "\t" . @$_[29] . "\t" . @$_[30] . "\t" . "\n";

}
close $outputfile;
print "Done";
