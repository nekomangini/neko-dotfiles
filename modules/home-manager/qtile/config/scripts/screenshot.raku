#!/usr/bin/env raku
use v6.d;

# Define geometry map for monitors (X,Y,W,H)
constant %GEOMETRY = (
    DVI  => "0,0,1920,1080",    # Captures only the DVI monitor area
    HDMI => "1920,0,1360,768",  # Captures only the HDMI monitor area
    BOTH => "0,0,3280,1080",    # Captures the entire span (both monitors)
);

sub MAIN(Str $monitor = "DVI") {
    # 1. Timestamp
    my $timestamp = qqx/date +%Y-%m-%d-%H%M%S/.chomp;

    # 2. Screenshot directory setup
    my $dir = "/home/nekomangini/Pictures/qtile-screenshots";
    # Create the directory and all parent directories if they don't exist
    mkdir $dir unless $dir.IO.e;

    # 3. File name and Geometry lookup
    my $geom = %GEOMETRY{$monitor} // die "Unknown monitor: $monitor. Valid monitors are: " ~ %GEOMETRY.keys.join(', ');
    my $file = "$dir/$monitor-$timestamp.png";

    say "Attempting screenshot for $monitor ($geom) to $file";

    # 4. Take screenshot (scrot)
    # The -a flag limits the capture area to the specified geometry ($geom)
    my $scrot-result = run 'scrot', '-a', $geom, $file, :out(Nil), :err;

    if $scrot-result.exitcode != 0 {
        warn "ERROR: Scrot failed (Exit Code: $scrot-result.exit-code). Check if 'scrot' is installed and its output:\n$scrot-result.err";
        exit 1;
    }

    # 5. Send dunst notification
    # Ensure the file exists before notifying
    if $file.IO.e {
        say "Sending notification.";
        
        # Use run for dunstify
        run <dunstify>, "-i", $file, "Screenshot Taken", "Saved as $file";
    } else {
        warn "ERROR: Screenshot file was not created at $file";
        exit 1;
    }
}
