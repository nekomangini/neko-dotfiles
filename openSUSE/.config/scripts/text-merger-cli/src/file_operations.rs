use anyhow::Result;
use std::fs::{File, OpenOptions};
use std::io::{Read, Write};

/// Merges multiple text files into a single output file, adding a numbered separator
/// and two newlines after the content of each file to create clear separation.
///
/// # Arguments
///
/// * `files` - A slice of file paths to be merged
/// * `output` - The path of the output file where merged content will be written
///
/// # Returns
///
/// Returns `Ok(())` if the operation is successful, or an `Error` if something goes wrong.
pub fn merge_files(files: &[String], output: &str) -> Result<()> {
    // Open the output file with write permissions, creating it if it doesn't exist
    // and truncating it if it does
    let mut outfile = OpenOptions::new()
        .write(true)
        .create(true)
        .truncate(true)
        .open(output)?;

    // Iterate through the input files
    for (index, file) in files.iter().enumerate() {
        // Read the entire content of the current file into a string
        let mut content = String::new();
        File::open(file)?.read_to_string(&mut content)?;

        // Write the content of the current file to the output file
        write!(outfile, "{}", content)?;

        // Add a numbered separator and two newlines after each file's content
        // We don't need to add this after the last file, so we check if it's not the last file
        if index < files.len() - 1 {
            // The index is 0-based, so we add 1 to get a 1-based file number
            writeln!(outfile, "\nEND OF PAGE: {}\n\n\n", index + 1)?;
        }
    }

    Ok(())
}
