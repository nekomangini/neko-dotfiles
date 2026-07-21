#!/usr/bin/env raku
use v6.d;

constant @ACTIONS = <
    lock
    logout
    reboot
    poweroff
>;

sub MAIN(Str $action?) {
    my $selected = $action // choose-action();

    # User pressed Esc or closed fuzzel.
    exit 0 unless $selected;

    unless $selected ∈ @ACTIONS {
        note "Invalid action: $selected";
        exit 1;
    }

    execute-action($selected);
}

sub choose-action(--> Str) {
    my $proc = run
        'fuzzel',
        '--dmenu',
        '--prompt=Power Menu: ',
        :in,
        :out,
        :err;

    $proc.in.say($_) for @ACTIONS;
    $proc.in.close;

    my $selection = $proc.out.slurp(:close).trim;

    # Consume stderr so the process is fully reaped.
    $proc.err.slurp(:close);

    # Esc or fuzzel error.
    return Nil if $proc.exitcode != 0;

    return $selection;
}

sub execute-action(Str $action) {
    given $action {
        when 'lock' {
            run 'hyprlock';
        }

        when 'logout' {
            run 'niri', 'msg', 'action', 'quit';
        }

        when 'reboot' {
            run 'systemctl', 'reboot';
        }

        when 'poweroff' {
            run 'systemctl', 'poweroff';
        }

        default {
            die "Unknown action: $action";
        }
    }
}
