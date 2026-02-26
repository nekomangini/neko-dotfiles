#!/usr/bin/env raku
use v6.d;

sub MAIN() {

    # Start picom in background
    shell 'picom &';

    # Setup screen orientation first
    shell 'xrandr --output DVI-D-0 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output HDMI-0 --mode 1920x1080 --pos 1920x0 --rotate right &';

    # Set wallpaper
    shell 'feh --bg-fill ~/neko-dotfiles/wallpaper/cars_036.jpg ~/neko-dotfiles/wallpaper/itachi_014.jpg';

    # Check if emacs daemon is running
    my $check = shell "emacsclient -s nekoserver -e t", :out, :err;

    unless $check.exitcode == 0 {
        say "Starting emacs daemon...";
        shell "emacs --fg-daemon=nekoserver &" ;

        sleep 2;   # Allow daemon to start
    }
}
