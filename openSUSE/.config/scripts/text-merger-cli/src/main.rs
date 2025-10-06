use anyhow::Result;
use clap::Parser;
mod cli_helpers;
mod file_operations;

// This will show in the --help command
/// A CLI tool to merge multiple text files into one
// Struct to hold command-line arguments
#[derive(Parser)]
// author: Sets the author name
// long_about = None: This uses the doc comment on the struct as the long description
#[clap(author = "Nekomangnini", version, about, long_about = None )]
struct Cli {
    // Starting directory for file selection
    // added value_name to each option to make the help output more descriptive
    #[clap(short, long, default_value = ".", value_name = "DIR")]
    directory: String,
    // Output file name for merged content
    #[clap(short, long, default_value = "merged_output.txt", value_name = "FILE")]
    output: String,
}

// Main function to run the Text Merger CLI
//
// This function parses command-line arguments, prompts the user toselect files,
// merges the selected files, and saves the result to the specified output file
//
// # Returns
//
// Returns Ok(()) if the operation is successful, or an error if something goes wrong
fn main() -> Result<()> {
    let cli = Cli::parse();
    let mut files_to_merge = Vec::new();

    // Loop to select files for merging
    loop {
        match cli_helpers::select_file(&cli.directory)? {
            Some(file) => files_to_merge.push(file),
            None => break,
        }
    }

    // Merge files if any were selected
    if !files_to_merge.is_empty() {
        cli_helpers::display_loading(|| {
            file_operations::merge_files(&files_to_merge, &cli.output)
        })?;
        println!("Files merged successfully into {}", cli.output);
    } else {
        println!("No files selected for merging.");
    }

    Ok(())
}
