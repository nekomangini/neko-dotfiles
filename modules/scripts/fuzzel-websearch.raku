#!/usr/bin/env raku
use v6.d;

# 1. Configuration
constant %ENGINES = (
    'Google'       => 'https://www.google.com/search?q=',
    'DuckDuckGo'   => 'https://duckduckgo.com/?q=',
    'Ecosia'       => 'https://www.ecosia.org/search?q=',
    'Wikipedia'    => 'https://en.wikipedia.org/wiki/Special:Search?search=',
    'Arch Manual'  => 'https://man.archlinux.org/search?q=',
    'DevDocs'      => 'https://devdocs.io/#q=',
);

# 2. URI Encoding Helper
sub uri-encode(Str $str --> Str) {
    return $str.comb.map(-> $c {
        $c ~~ /<[A..Za..z0..9._~-]>/
            ?? $c
            !! $c.encode('utf8').list.map({ sprintf('%%%02X', $_) }).join
    }).join;
}

sub MAIN() {
    # Stage 1: Select Engine
    my $engine-list = %ENGINES.keys.sort.join("\n");

    my $sel-proc = run 'fuzzel', '--dmenu', '--prompt', '🔍 Search: ', :in, :out;
    $sel-proc.in.print($engine-list);
    $sel-proc.in.close;

    my $selected-engine = $sel-proc.out.slurp.trim;
    return unless %ENGINES{$selected-engine}:exists;

    # Stage 2: Get Query
    my $query-proc = run 'fuzzel', '--dmenu', '--prompt', "✨ $selected-engine: ", :out;
    my $query = $query-proc.out.slurp.trim;

    if $query.chars > 0 {
        my $encoded-query = uri-encode($query);
        my $final-url = %ENGINES{$selected-engine} ~ $encoded-query;

        # Launch Vivaldi
        run 'vivaldi', $final-url;
    }
}
