// Importing necessary modules from the standard library
use std::env; // For accessing command-line arguments
use std::fs::File; // For handling files
use std::io::{BufRead, BufReader, Write}; // For reading and writing to files
use std::path::Path; // For handling file paths

// The main function, which is the entry point of the program
fn main() -> std::io::Result<()> {
    // Get command-line arguments
    let args: Vec<String> = env::args().collect();

    // Ensure that both input and output file paths are provided
    if args.len() != 3 {
        eprintln!("Usage: {} <input_file> <output_file>", args[0]);
        std::process::exit(1);
    }

    // Read input and output file paths from command-line arguments
    let input_path = Path::new(&args[1]);
    let output_path = Path::new(&args[2]);

    // Check if the input file exists
    if !input_path.exists() {
        eprintln!("Input file does not exist: {}", input_path.display());
        return Err(std::io::Error::new(
            std::io::ErrorKind::NotFound,
            "input file not found",
        ));
    }

    // Read the file
    let file = File::open(input_path)?;
    let reader = BufReader::new(file);

    // Collect lines into a vector
    let mut lines: Vec<String> = reader.lines().collect::<Result<_, _>>()?;

    // Sort the lines alphabetically
    lines.sort();

    // Write sorted lines to the output file
    let mut output_file = File::create(output_path)?;
    for line in lines {
        writeln!(output_file, "{}", line)?;
    }

    // Print a success message
    println!("Sorted lines have been written to {:?}", output_path);

    Ok(())
}
