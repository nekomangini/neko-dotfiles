{ pkgs, ... }:

let
  x11Powemenu = pkgs.writeScriptBin "x-powermenu" ''
    #!/usr/bin/env raku
    use v6.d;

    sub MAIN() {
        # Using the options and commands style from your reference
        my @options = <Shutdown Reboot Suspend Hibernate Logout Lock Cancel>;
        
        my %commands = 
            Shutdown  => ['systemctl', 'poweroff'],
            Reboot    => ['systemctl', 'reboot'],
            Suspend   => ['systemctl', 'suspend'],
            Hibernate => ['systemctl', 'hibernate'],
            Lock      => ['i3lock-color', '-c', '000000'],
            Cancel    => [];

        # Build the Rofi process with your specific theme overrides
        my $proc = run 'rofi', '-dmenu', '-i', '-p', 'Power Menu',
            '-theme-str', 'window {width: 460px; height: 380px;}',
            '-theme-str', 'listview {lines: 7; scrollbar: false;}',
            '-theme-str', 'mainbox {children: [ "inputbar", "listview" ];}',
            :in, :out, :err;
        
        # Feed options to Rofi
        $proc.in.say($_) for @options;
        $proc.in.close;
        
        my $selected = $proc.out.slurp(:close).trim;
        
        return if !$selected || $selected eq 'Cancel';

        if %commands{$selected}:exists {
            run |%commands{$selected};
        } elsif $selected eq 'Logout' {
            execute-logout();
        } else {
            note "Invalid selection: $selected";
            exit 1;
        }
    }

    sub execute-logout() {
        # Detect session and logout appropriately
        my $session = %*ENV<DESKTOP_SESSION> // "";

        run 'pkill', '-TERM', 'vivaldi-bin';
        sleep 2;
        
        if $session.lc.contains('qtile') {
            run 'qtile', 'cmd-obj', '-o', 'cmd', '-f', 'shutdown';
        } elsif $session.lc.contains('i3') {
            run 'i3-msg', 'exit';
        } else {
            say "Session not recognized. Attempting generic exit...";
            run 'pkill', '-KILL', '-u', %*ENV<USER>;
        }
    }
  '';

in
{
  home.packages = [ x11Powemenu ];
}
