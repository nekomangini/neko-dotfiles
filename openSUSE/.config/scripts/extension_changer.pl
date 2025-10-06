#!/usr/bin/env perl

use strict;
use warnings;
use File::Spec; 									# For handling file paths
use File::Basename; 									# For handling file names

# Prompt the user for the directory path
print "Enter the directory path: ";
chomp(my $path = <STDIN>); 								# Read user input and remove trailing newline

# Validate the provided path
if (!-d $path) {
    die "Error: '$path' is not a valid directory.\n";
}

# Prompt the user for the current file extension
print "Enter the current file extension (e.g., txt): ";
chomp(my $current_extension = <STDIN>);

# Validate current extension input
if ($current_extension !~ /^\w+$/) {
    die "Error: Invalid extension format. Only letters and numbers are allowed.\n";
}

# Prompt the user for the new file extension
print "Enter the new file extension (e.g., md): ";
chomp(my $new_extension = <STDIN>);

# Validate new extension input
if ($new_extension !~ /^\w+$/) {
    die "Error: Invalid extension format. Only letters and numbers are allowed.\n";
}

# Open the directory
opendir(my $dir, $path) or die "Error: Unable to open directory '$path': $!\n";

# Loop through all entries in the directory
while (my $entry = readdir($dir)) {
    # Skip special entries '.' and '..'
    next if $entry eq '.' or $entry eq '..';

    # Build the full path of the entry
    my $full_path = File::Spec->catfile($path, $entry);

    # Skip if it's not a file
    next if !-f $full_path;

    # Check if the file has the specified current extension
    if ($entry =~ /\.$current_extension$/) {
        # Remove the current extension and add the new one
        my $new_name = $entry;
        $new_name =~ s/\.$current_extension$/.$new_extension/;

        # Build the full path for the new file name
        my $new_full_path = File::Spec->catfile($path, $new_name);

        # Rename the file
        rename($full_path, $new_full_path) or warn "Error renaming '$full_path' to '$new_full_path': $!\n";
        print "Renamed: $entry -> $new_name\n";
    }
}

# Close the directory handle
closedir($dir);

print "File extensions updated successfully.\n";
