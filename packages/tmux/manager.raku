#!/usr/bin/env raku
use v6.d;

sub MAIN {
    my @options = (
        'List sessions',
        'Run tmx-sessions',
        'Run tmx-rails',
        'Create tmux session',
        'Delete tmux session',
        'Attach to session',
    );

    my $fzf = run <
        fzf
        --height=~50%
        --border
        --layout=reverse
        --prompt=Tmux-Manager:
    >, :in, :out;

    $fzf.in.say($_) for @options;
    $fzf.in.close;

    my $choice = $fzf.out.slurp.trim;

    given $choice {
        when 'List sessions' {
            run 'tmux', 'ls';
        }

        when 'Run tmx-sessions' {
            run 'tmx-sessions';
        }

        when 'Run tmx-rails' {
            run 'tmx-rails';
        }

        when 'Create tmux session' {
            create-session;
        }

        when 'Delete tmux session' {
            delete-session;
        }

        when 'Attach to session' {
            attach-session;
        }

        default {
            say 'Aborted.';
        }
    }
}

sub create-session {
    print "Session name: ";
    my $name = $*IN.get.trim;

    return unless $name;

    run 'tmux', 'new-session', '-d', '-s', $name;
}

sub delete-session {
    my $tmux = run 'tmux', 'ls', :out;

    my $fzf = run <fzf --height=~50% --border --layout=reverse --prompt=Kill-Session:>, :in, :out;

    $fzf.in.print($tmux.out.slurp);
    $fzf.in.close;

    my $selected = $fzf.out.slurp.trim;
    return unless $selected;

    my $session = $selected.split(':')[0];

    run 'tmux', 'kill-session', '-t', $session;
}

sub attach-session {
    my $tmux = run 'tmux', 'ls', :out;

    my $fzf = run <fzf --height=~50% --border --layout=reverse --prompt=Attach-Session:>, :in, :out;

    $fzf.in.print($tmux.out.slurp);
    $fzf.in.close;

    my $selected = $fzf.out.slurp.trim;
    return unless $selected;

    my $session = $selected.split(':')[0];

    run 'tmux', 'attach-session', '-t', $session;
}
