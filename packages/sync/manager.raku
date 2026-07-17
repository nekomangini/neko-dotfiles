#!/usr/bin/env raku
use v6.d;

constant %SCRIPTS =
    notes      => 'sync-notes',
    nekopaper  => 'sync-nekopaper',
    blog       => 'sync-blog';

sub MAIN(Str $choice?) {

    my $selected = $choice // choose-script();

    # User pressed Esc or selected "quit"
    exit 0 unless $selected;
    exit 0 if $selected eq 'quit';

    unless %SCRIPTS{$selected}:exists {
        note "Unknown option: $selected";
        exit 1;
    }

    say "Running {%SCRIPTS{$selected}}...";

    run %SCRIPTS{$selected};
}

sub choose-script {

    my $proc = run 'fzf',
        '--prompt=Sync Repo: ',
        '--height=~50%',
        '--layout=reverse',
        '--border',
        :in,
        :out;

    # Display all scripts plus the Quit option
    for |%SCRIPTS.keys.sort, 'quit' -> $option {
        $proc.in.say($option);
    }

    $proc.in.close;

    $proc.out.slurp(:close).trim;
}
