#!/usr/bin/env perl

use strict;
use warnings;
use Time::HiRes qw(usleep);       						# For finer control over sleep duration
use Term::ReadKey;                						# To get the terminal width dynamically
use File::Spec;                   						# For handling file paths
use File::Basename;               						# To work with file names and directories

# Loading animation subroutine
sub loading_animation {
    # Get the terminal width
    my ($term_width) = GetTerminalSize();

    # Leave space for the "Loading: [" and "] Done!" text
    my $length = $term_width - length("Loading: [") - length("] Done!") - 1;
    $length = 1 if $length < 1; 						# Ensure at least 1 character for the loading bar

    my $delay = shift || 50_000; 						# Reduced delay in microseconds (50ms by default)

    # Use block character █ for the loading animation
    print "Loading: [";
    for my $i (1 .. $length) {
        print "█"; 
        usleep($delay); 							# Pause for a short period
        $| = 1; 								# Force the output to flush
    }
    print "] Done!\n";
}

# Folder counting subroutine
sub count_folders {
    print "Enter the path to check for folders: ";
    chomp(my $path = <STDIN>);  						# Read user input and remove the trailing newline

    # Validate the provided path
    if (!-d $path) {
        die "Error: '$path' is not a valid directory.\n";
    }

    # Show a loading animation while processing
    loading_animation(30_000); 							# Loading bar with reduced delay (30ms)

    # Open the directory
    opendir(my $dir, $path) or die "Error: Unable to open directory '$path': $!\n";

    # Initialize a counter for directories
    my $folder_count = 0;

    # Read all entries in the directory
    while (my $entry = readdir($dir)) {
        # Skip special entries '.' and '..'
        next if $entry eq '.' or $entry eq '..';

        # Create the full path of the entry
        my $full_path = File::Spec->catfile($path, $entry);

        # Check if the entry is a directory
        if (-d $full_path) {
            $folder_count++;  # Increment the folder count
        }
    }

    # Close the directory handle
    closedir($dir);

    print "The directory '$path' contains $folder_count folder(s).\n";
}

count_folders();
