{ pkgs, ... }:

let
  tmuxRails = pkgs.writeScriptBin "tmx-rails" ''
    #!/usr/bin/env raku
    use v6.d;

    constant $SESSION_NAME = 'rails-dev';

    sub tmux-session-exists(--> Bool) {
        my $proc = run 'tmux', 'has-session', '-t', $SESSION_NAME, :out, :err;
        return $proc.exitcode == 0;
    }

    sub MAIN() {
        if tmux-session-exists() {
            say "Session '$SESSION_NAME' already exists. Attaching...";
            run 'tmux', 'attach', '-t', $SESSION_NAME;
            exit;
        }

        say "Starting new tmux session: $SESSION_NAME...";

        say "Creating server window";
        run 'tmux', 'new-session', '-d', '-s', $SESSION_NAME, '-n', 'server';
        run 'tmux', 'send-keys', '-t', "$SESSION_NAME:0", "nix develop --command bash -c 'rails server; exec fish'", 'C-m';

        say "Creating editor window";
        run 'tmux', 'new-window', '-t', $SESSION_NAME, '-n', 'editor';
        run 'tmux', 'send-keys', '-t', "$SESSION_NAME:1", "nix develop --command bash -c 'hx .; exec fish'", 'C-m';

        say "Creating console window";
        run 'tmux', 'new-window', '-t', $SESSION_NAME, '-n', 'console';
        run 'tmux', 'send-keys', '-t', "$SESSION_NAME:2", "nix develop --command bash -c 'rails console; exec fish'", 'C-m';

        say "Selecting editor window and attaching...";
        run 'tmux', 'select-window', '-t', "$SESSION_NAME:1";
        run 'tmux', 'attach', '-t', $SESSION_NAME;
    }
  '';
in

{
  home.packages = [ tmuxRails ];
}
