###############################################################################################
#
# This is a parsing program for seperating hgdf data into smaller files for easier use later.
# Author: Jacob R. Porter
# Language: Perl
# Date: 10/14/2015
#
###############################################################################################

# First, we will open the POS directory, read all of the file names into arrays, and define our global arrays.
my $directory = "/mnt/student/jporter5/POS";
opendir(DIR, $directory) or die "couldn't open $directory: $!\n";
my @files = readdir DIR;
closedir DIR;

my @erase_human;
my @erase_human_sorted;

# This splice is so that we are getting rid of the . .. > when we read in all the directories.
splice @files, $index, 1;
splice @files, $index, 1;

# Here, we are going through each file name and getting rid of everything except for the domain range. Afterwards, we sort all of them into numerical order.
foreach (@files) {
  $_ =~ s/human_X_//;
  $_ =~ s/.pos//;
  push (@erase_human, $_);
}
@erase_human_sorted = sort { $a <=> $b } @erase_human;

# This is where we will go through each one of the sorted arrays. For each one, we want to create an array where $array[0] is rangeStart and @array[1] is rangeEnd.
foreach (@erase_human_sorted) {
	# This is where we create our $array[0] and $array[1] for ranges. Afterwards, we want to open our hgdf file so that we can later go through it one line at a time.
	# We also want to open our output and name it hgdf_rangestart_rangeend.txt
 	my @array = split /_/, $_;
	my $rangeStart = $array[0];
	my $rangeEnd = $array[1];
	print "$rangeStart\n";
	print "$rangeEnd\n";
	open(MYINPUTFILE, "<hgdf_x_flat_file.txt");
	open(my $outputFile, '>', 'hgdf_' . $_ . '.txt');
	
	# Now, we want to go through every single line of the hgdf file. If any particular line of the file contains a genestart or geneend that matches the range of array[0] or array[1], we want to print it to a file.
	# We also want to strip all " from the file for easier parsing later, and split the values by \t when we print them to the file.
	while(<MYINPUTFILE>) {
		$_ =~ s/"//;
        	my @hgdfarray = split/\t/, $_;
		my $geneStart = $hgdfarray[5];
		my $geneEnd = $hgdfarray[6];

		# Right above we created an array so that we could use the indexes of genestart and geneend. If the genestart or geneend exists within the range of our current file name, we create a new file and push the data to it.
		if (($geneStart <= $rangeEnd && $geneStart >= $rangeStart) || ($geneEnd <= $rangeEnd && $geneEnd >= $rangeStart) || ($geneStart <= $rangeStart && $geneEnd >= $rangeEnd) || ($geneStart >= $rangeStart && $geneEnd <= $rangeEnd)) {
			print $outputFile "$_\n";
          	}
	}         
	close $outputFile;
	close MYINPUTFILE;
}