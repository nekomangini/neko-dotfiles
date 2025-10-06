## BUILDING THE CLI
- Build the code using `cargo build --release`
  - This will compile the project and create an executable in the `target/release` folder

## RUNNING THE CLI
- Run `cargo run -- [OPTIONS]`
  - Example `cargo run -- -d /$HOME/scripts/rust/text_to_merge/ -o merged_result.txt`
    - The double dash `--` is used to separete the arguments for the cargo run command from the arguments you want to pass to your actual program
    - Everything before the `--` is interpreted as arguments for `cargo run`
    - Everything after the `--` is passed as arguments to your program
    - This command will:
      1. Run the Rust program
      2. Start looking for text files in the `$HOME/scripts/rust/text_to_merge/` directory
      3. Save the merged content in a file named "combined_text.txt"
      
- Or navigate to the `target/release` directory and run the executable directly
  - `./text_merger_cli [Options]`
  - Example `./text_merger_cli -d $HOME/scripts/rust/text_to_merge/ -o merged_result.txt`
    - `-d, --directory <DIRECTORY>`: Specify the starting directory(default is current directory)
    - `-o, --output <OUTPUT>`: Specify the output file name(default is "merged_output.txt")

## USING THE CLI
- Run `cargo build` before using this CLI
- When you run the CLI, it will prompt you to select text files to merge.
- Navigate through directories by selecting ".." option.
- Select "Done" when you've chosen all the files you want to merge.
- The CLI will display a progress bar while merging the files.
- The merged content wil be saved in the specified output file
- Run `cargo run -- --help` to see the help information
