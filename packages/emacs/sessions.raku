#!/usr/bin/env raku
use v6.d;

constant %PATHS = (
    notes    => "/mnt/D/homelab/sync/notes",
    raku     => "/mnt/D/Programming/scripts",
    dotfiles => "/home/nekomangini/neko-dotfiles",
    blog     => "/mnt/D/homelab/sync/notes/01-para/02-areas/media/blogs"
);

sub MAIN(Str $session?) {
    my @sessions = %PATHS.keys.sort;

    my $selected = $session // do {
        my $proc = run 'fzf',
            '--prompt=Emacs session: ',
            '--height=~50%',
            '--layout=reverse',
            '--border',
            :in,
            :out;

        # Display all sessions followed by Quit
        for |@sessions, 'quit' -> $option {
            $proc.in.say($option);
        }

        $proc.in.close;
        $proc.out.slurp(:close).trim;
    };

    # User pressed Esc or selected Quit
    exit 0 unless $selected;
    exit 0 if $selected eq 'quit';

    unless %PATHS{$selected}:exists {
        note "Unknown session: '$selected'. Valid: { @sessions.join(', ') }";
        exit 1;
    }

    my $path = %PATHS{$selected};

    unless $path.IO.e {
        note "Path not found: '$path'";
        exit 1;
    }

    run 'kitten', '@', 'set-tab-title', "doom-$selected";
    run 'emacsclient', '-nw', '-a', '', $path;
}
