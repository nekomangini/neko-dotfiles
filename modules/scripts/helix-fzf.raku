#!/usr/bin/env raku
use v6.d;

sub MAIN {
    my $selected-file = run('fzf', '--preview', 'cat {}', '--height', '70%', :out).out.slurp(:close).trim;
    if $selected-file {
        run 'hx', $selected-file;
    }
}
