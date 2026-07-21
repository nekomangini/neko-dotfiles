#!/usr/bin/env raku
use v6.d;

sub MAIN(Str $action?) {
    my @actions = <reboot poweroff logout lock suspend hibernate>;

    my $selected = $action // do {
        my $proc = run 'fuzzel', '--dmenu', '--prompt=Power Menu: ',
                       :in, :out, :err;
        $proc.in.print(@actions.join("\n"));
        $proc.in.close;
        $proc.out.slurp(:close).trim;
    };

    return unless $selected;

    unless $selected ∈ @actions {
        note "Invalid action: $selected";
        exit 1;
    }

    if $selected ∈ @actions {
        execute-action($selected);
    } else {
        note "Invalid action: $selected";
        exit 1;
    }
}

sub execute-action(Str $action) {
    given $action {
        when 'reboot'    { run 'systemctl', 'reboot'          }
        when 'poweroff'  { run 'systemctl', 'poweroff'        }
        when 'suspend'   { run 'systemctl', 'suspend'         }
        when 'hibernate' { run 'systemctl', 'hibernate'       }
        when 'logout'    { run 'hyprctl',   'dispatch', 'exit'}
        when 'lock'      { run 'hyprlock',                    }
    }
}
