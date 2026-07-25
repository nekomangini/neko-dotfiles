#!/usr/bin/env raku
use v6.d;

sub MAIN {
    my $selected-file =
        run(
            'fzf',
            '--style', 'full',
            '--preview', 'bat {}',
            '--border',
            '--height', '~50%',
            :out
        ).out.slurp(:close).trim;

    if $selected-file {
        run 'hx', $selected-file;
    }
}
