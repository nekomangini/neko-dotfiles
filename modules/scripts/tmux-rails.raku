#!/usr/bin/env raku
use v6.d;

# Tmux session name
constant $SESSION_NAME = 'rails-dev';

sub tmux-session-exists(Str $session-name --> Bool) {
    my $proc = run 'tmux', 'has-session', '-t', $SESSION_NAME, :out, :err;
    return $proc.exitcode == 0;
}


sub MAIN() {
    say "Starting new tmux session: $SESSION_NAME...";

    # Check if rails-dev session already exists
    if tmux-session-exists($SESSION_NAME) {
        say "Session '$SESSION_NAME' already exists.";
    }

    say "Creating server window";
    run 'tmux', 'new-session', '-d', '-s', "$SESSION_NAME", '-n', 'server';
    say 'Starting the rails server';
    my $server-cmd = "rs";
    run 'tmux', 'send-keys', '-t', "$SESSION_NAME:0", "$server-cmd", 'C-m';


    say "Creating editor window";
    my $fzf-cmd = "hf";
    run 'tmux', 'new-window', '-t', "$SESSION_NAME", '-n', 'editor';
    run 'tmux', 'send-keys', '-t', "$SESSION_NAME:1", "$fzf-cmd", 'C-m';


    say "Creating console window";
    my $console-cmd = "rc";
    run 'tmux', 'new-window', '-t', "$SESSION_NAME", '-n', 'console';
    say 'Starting the rails console';
    run 'tmux', 'send-keys', '-t', "$SESSION_NAME:2", "$console-cmd", 'C-m';


    say "Selecting the editor window and attach to the session";
    run 'tmux', 'select-window', '-t', "$SESSION_NAME:1";
    run 'tmux', 'attach', '-t', "$SESSION_NAME";
}
