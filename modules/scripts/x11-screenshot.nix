{ pkgs, ... }:

let
  x11Screenshot = pkgs.writeScriptBin "x-screenshot" ''
    #!/usr/bin/env raku
    use v6.d;

    # Define geometry map for monitors (X,Y,W,H)
    constant %GEOMETRY = (
        DVI  => "0,0,1920,1080",
        HDMI => "1920,0,1080,1920",
        BOTH => "0,0,3000,1920",
    );

    sub MAIN(Str $monitor = "DVI") {
        # 1. Timestamp
        my $dt = DateTime.now;
        my $timestamp = sprintf("%d-%02d-%02d-%02d%02d%02d",
                                $dt.year, $dt.month, $dt.day,
                                $dt.hour, $dt.minute, $dt.second);

        # 2. Screenshot directory setup
        my $dir = "/home/nekomangini/Pictures/x11-screenshots";
        mkdir $dir unless $dir.IO.d;

        # 3. File name and Geometry lookup
        my $geom = %GEOMETRY{$monitor.uc} // die "Unknown monitor: $monitor.";
        my $file = "$dir/$monitor-{$timestamp}.png";

        say "📸 Capturing $monitor ($geom)...";

        # 4. Take screenshot (scrot)
        # The -a flag limits the capture area to the specified geometry ($geom)
        my $proc = run 'scrot', '-a', $geom, $file, :err;

        # 5. Send dunst notification
        # Ensure the file exists before notifying
        if $proc.exitcode != 0 {
            note "❌ Scrot failed: " ~ $proc.err.slurp(:close);
            exit 1;
        }

        if $file.IO.e {
            say "✅ Saved to $file";
            run 'dunstify', '-i', $file, "Screenshot Taken", "Saved as { $file.IO.basename }";
        }
    }
  '';
in

{

  home.packages = [ x11Screenshot ];
}
