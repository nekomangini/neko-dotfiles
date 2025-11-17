#!/usr/bin/env raku
use v6.d;

sub MAIN() {

    # Start picom in background
    shell 'picom &';

    # Set wallpaper
    shell 'feh --bg-scale ~/neko-dotfiles/wallpaper/frieren.jpeg';

    # Check if emacs daemon is running
    my $check = shell "emacsclient -s nekoserver -e t", :out, :err;

    unless $check.exitcode == 0 {
        say "Starting emacs daemon...";
        shell "emacs --fg-daemon=nekoserver &" ;

        sleep 2;   # Allow daemon to start
    }
}
