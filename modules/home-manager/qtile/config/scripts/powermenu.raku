#!/usr/bin/env raku
use v6.d;

sub MAIN() {
    my @options = <Shutdown Reboot Suspend Hibernate Lock Cancel>;
    
    my %commands = 
        Shutdown  => ['systemctl', 'poweroff'],
        Reboot    => ['systemctl', 'reboot'],
        Suspend   => ['systemctl', 'suspend'],
        Hibernate => ['systemctl', 'hibernate'],
        Lock      => ['i3lock-color'],
        Cancel    => [];
    
    my $proc = run 'rofi', '-dmenu', '-i', '-p', 'Select',
        '-theme-str', 'window {width: 460px; height: 340px;}',
        '-theme-str', 'listview {lines: 6; scrollbar: false;}',
        '-theme-str', 'mainbox {children: [ "inputbar", "listview" ];}',
        :in, :out, :err;
    
    $proc.in.say($_) for @options;
    $proc.in.close;
    
    my $selected = $proc.out.slurp(:close).trim;
    
    if $selected and %commands{$selected}:exists {
        run |%commands{$selected} if %commands{$selected};
    } elsif $selected {
        say "Invalid selection: $selected";
        exit 1;
    }
}
