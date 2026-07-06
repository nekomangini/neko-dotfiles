#!/usr/bin/env raku
use v6.d;

sub tmux-session-exists(Str $session --> Bool) {
    my $proc = run 'tmux', 'has-session', '-t', $session, :out, :err;
    return $proc.exitcode == 0;
}

sub send(Str $session, Str $window, Str $cmd) {
    run 'tmux', 'send-keys', '-t', "$session:$window", $cmd, 'C-m';
}

sub MAIN() {
    my $project-dir  = $*CWD;
    my $session-name = $project-dir.basename;
    my $flake-path   = $project-dir;

    unless "$project-dir/Gemfile".IO.e && "$project-dir/bin/rails".IO.e {
        say "❌ Error: '$project-dir' does not look like a Rails project.";
        say "   (Missing Gemfile or bin/rails)";
        exit 1;
    }

    unless "$flake-path/flake.nix".IO.e {
        say "❌ Error: No flake.nix found in '$flake-path'.";
        exit 1;
    }

    if tmux-session-exists($session-name) {
        say "Session '$session-name' already exists. Attaching...";
        run 'tmux', 'attach', '-t', $session-name;
        exit;
    }

    say "🚀 Starting Rails dev session: $session-name";

    run 'tmux', 'new-session', '-d', '-s', $session-name, '-n', 'server';
    send $session-name, 'server', "cd $project-dir && nix develop $flake-path --command bash -c 'rails server; exec fish'";

    run 'tmux', 'new-window', '-t', $session-name, '-n', 'editor';
    send $session-name, 'editor',  "cd $project-dir && nix develop $flake-path --command bash -c 'hx .; exec fish'";

    run 'tmux', 'new-window', '-t', $session-name, '-n', 'console';
    send $session-name, 'console', "cd $project-dir && nix develop $flake-path --command bash -c 'rails console; exec fish'";

    run 'tmux', 'select-window', '-t', "$session-name:1";
    run 'tmux', 'attach', '-t', $session-name;
    run 'kitten', '@', 'set-tab-title', 'tmux-rubyonrails';
}
