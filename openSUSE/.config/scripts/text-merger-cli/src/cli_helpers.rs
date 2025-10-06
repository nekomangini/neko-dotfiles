use anyhow::Result;
use dialoguer::{theme::ColorfulTheme, Select};
use indicatif::{ProgressBar, ProgressStyle};
//use std::path::Path;
use std::{fs, thread, time::Duration};

// Prompts the user to selecct a file from the given directory
//
// This function list all .txt files in the specified directory and allows
// the user to select one, navigate up the directory tree, or finish selection.
//
// # Arguments
//
// *directory - A string slice that holds the path to the directory
//
// # Returns
//
// Returns Ok(Some(String)) with the selected file path, Ok(Some("..")) to go up a directory
// Ok(None) when selection is finished, or an error if something goes wrong.
pub fn select_file(directory: &str) -> Result<Option<String>> {
    // List all .txt files in the directory
    let files: Vec<_> = fs::read_dir(directory)?
        .filter_map(|entry| {
            let entry = entry.ok()?;
            let path = entry.path();
            if path.is_file() && path.extension().and_then(|s| s.to_str()) == Some("txt") {
                Some(path.to_string_lossy().into_owned())
            } else {
                None
            }
        })
        .collect();

    // Check if any .txt files were found
    if files.is_empty() {
        println!("No text files found in this directory.");
        return Ok(None);
    }

    // Prepare options for selection
    let mut options = files.clone();
    options.push(String::from(".."));
    options.push(String::from("Done"));

    // Prompt user to select a file
    let selection = Select::with_theme(&ColorfulTheme::default())
        .with_prompt("Select a file to merge (or '..' to go up, 'Done' to finish)")
        .items(&options)
        .default(0)
        .interact()?;

    // Return the selected option
    match options[selection].as_str() {
        ".." => Ok(Some(String::from(".."))),
        "Done" => Ok(None),
        file => Ok(Some(file.to_string())),
    }
}

// Displays a loading bar while performing an operation
//
// This function shows a progress bar to indicate that an operation is in progress.
// It's used to provide visual feedback during the file merging process.
//
// # Arguments
//
// *operation - A closer that performs the actual operation
//
// # Returns
//
// Returns the result of the operation wrapped in Result<T>
pub fn display_loading<F, T>(operation: F) -> Result<T>
where
    F: FnOnce() -> Result<T>,
{
    // Set up the progress bar
    let pb = ProgressBar::new(100);
    pb.set_style(
        ProgressStyle::default_bar()
            .template(
                "{spinner:.green} [{elapsed_precise}] [{bar:40.cyan/blue}] {pos}/{len} ({eta})",
            )
            .progress_chars("#>-"),
    );

    // Perform the operation
    let result = operation();

    // Simulate progress
    for _ in 0..100 {
        pb.inc(1);
        thread::sleep(Duration::from_millis(10));
    }
    pb.finish_with_message("Done");

    result
}
