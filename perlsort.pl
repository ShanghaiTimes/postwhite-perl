#!/usr/bin/perl -w

#/ perlsort-1.pl
#/ Robert Chalmers
#/ robert@chalmers.com.au
#/ Twitter: @ShanghaiTimes
#/ 29th November 2015
#/ Modified 2st December 2005
#/ Version 1.1 
#/ Sort a huge list of IP addresses, both IPv4 and IPv6
#/ originally produced by Steve Jenkin's great work, 'postwhite'
#/ See the comments sprinkled throughout...

# Some CPAN includes - should be built into most
use strict;
use Path::Class;
use Net::IP;
use List::MoreUtils qw(uniq);

use vars qw/@ip_strings/;

my ($src, $dest) = @ARGV;

#my $dir = dir("/tmp"); # /tmp
#my $file = $dir->file("outfile.txt"); # /tmp/file.txt

my $file = $ENV{TMP5};

my $string = '\tpermit';
#my $filename = 'unsorted.txt';
my $filename = $ENV{TMP3};


#or $src=$ENV{TRMP3};
#   $dest=$ENV{5};


# Open the output file ready for writing.
open(my $fh, '>', $file) or die "Could not open file '$file' $!";
# Get a file_handle (IO::File object) you can write to
#my $file_handle = $file->openw();

# Open the input file. Store it's contents into @ip_strings
open (FH, "< $filename") or die "Can't open $filename for read: $!";
my @ip_strings = <FH>;
close FH or die "Cannot close $filename: $!";

# Strip the word "permit" from the end so sort can do it's thing
        foreach my $line (@ip_strings) { 
	$line =~ s/\s+\w+$//;
                };
# Sort the whole thing...
my @sorted = 
    map  { $_->[0] }
    sort { $a->[1] <=> $b->[1] }
    map  { [ $_, eval { Net::IP->new( $_ )->intip } ] }
    @ip_strings;

	# use unique to sort the unique words from @sorted.
	my @unique_words = uniq @sorted;

	# chomp the newline from the end of the string, then add 'permit' again
       	 foreach my $line (@unique_words) {
	 chomp $line;
	 my $newline = "${line}${string}\n";
	# print it out to the 'outfile.txt'
	 print $fh $newline;
                };	
# Close it up and go home...	
close $fh;
