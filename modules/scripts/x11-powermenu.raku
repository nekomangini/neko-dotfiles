#!/usr/bin/env raku
use v6.d;

sub MAIN(Str $action?) {
    my @actions = <reboot poweroff logout lock suspend hibernate>;

    my $selected = $action // do {
        my $proc = run 'dmenu', '-p', 'Power Menu:', '-i', :in, :out;
        
        # Feed the actions into dmenu's STDIN
        $proc.in.say(@actions.join("\n"));
        $proc.in.close;
        
        # Capture the selection
        $proc.out.slurp(:close).trim;
    };

    return unless $selected;

    if $selected ∈ @actions {
        execute-action($selected);
    } else {
        note "Invalid action: $selected";
        exit 1;
    }
}

sub execute-action(Str $action) {
    say "Executing: $action";
    given $action {
        when 'reboot'    { run 'systemctl', 'reboot'    }
        when 'poweroff'  { run 'systemctl', 'poweroff'  }
        when 'suspend'   { run 'systemctl', 'suspend'   }
        when 'hibernate' { run 'systemctl', 'hibernate' }
        
        # i3wm specific logout
        when 'logout'    { run 'i3-msg', 'exit'         }
        
        # Common X11 lock tools (i3lock is standard on i3)
        when 'lock'      { run 'i3lock-color', '-c', '000000' } 
    }
}
