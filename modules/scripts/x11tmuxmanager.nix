{ pkgs, ... }:
let
  x11tmuxmanager = pkgs.writeScriptBin "x11tmuxmanager" ''
    #!${pkgs.rakudo}/bin/raku
    use v6.d;

    our %env;

    sub BUILD-ENV {
        my $env-file = %*ENV<TMUX_PATHS_FILE> // "/run/agenix/my-paths";
        my $file = $env-file.IO;

        unless $file.e {
            note "⚠️ Secret not found at: $env-file";
            return;
        }

        %env = $file.lines
            .grep({ .contains('=') && !.starts-with('#') })
            .map({
                my ($key, $val) = .split('=', 2);
                $val = $val.trim;
                $val ~~ s/^ <['"]> //;
                $val ~~ s/ <['"]> $ //;
                $val = $val.subst(/^ '~'/, $*HOME.Str) if $val.starts-with('~');
                $key.trim => $val;
            })
            .hash;
    }

    sub MAIN(Str $choice?) {
        BUILD-ENV();

        my @sessions = <vue flutter notes dotfiles main>;

        my $selected = $choice // do {
            my $proc = run '${pkgs.rofi}/bin/rofi', '-dmenu', '-i', '-p', 'Tmux session:', :in, :out;
            $proc.in.say: @sessions.join("\n");
            $proc.in.close;
            $proc.out.slurp(:close).trim;
        };

        exit 0 unless $selected;

        unless $selected ∈ @sessions {
            note "❌ '$selected' is not a predefined session.";
            exit 1;
        }

        my $check = run '${pkgs.tmux}/bin/tmux', 'has-session', '-t', $selected, :out, :err;
        create-session($selected) if $check.exitcode != 0;

        if %*ENV<TMUX> {
            shell '${pkgs.tmux}/bin/tmux switch-client -t ' ~ $selected;
        } else {
            shell '${pkgs.tmux}/bin/tmux attach-session -t ' ~ $selected;
        }
    }

    sub create-session(Str $name) {
        my $path = do given $name {
            when 'flutter'  { %env<FLUTTER_PATH>  }
            when 'vue'      { %env<VUE_PATH>      }
            when 'notes'    { %env<NOTES_PATH>    }
            when 'dotfiles' { %env<DOTFILES_PATH> }
            when 'main'     { %env<PROJECTS_DIR>  }
            default         { $*HOME.Str          }
        } // $*HOME.Str;

        unless $path.IO.e && $path.IO.d {
            note "📂 Path not found: '$path'. Falling back to \$HOME.";
            $path = $*HOME.Str;
        }

        say "🚀 Creating '$name' in: $path";
        run '${pkgs.tmux}/bin/tmux', 'new-session', '-d', '-s', $name, '-c', $path;
        sleep 0.1;

        given $name {
            when 'vue' {
                run '${pkgs.tmux}/bin/tmux', 'rename-window', '-t', "{$name}:0", 'editor';
                run '${pkgs.tmux}/bin/tmux', 'send-keys', '-t', "{$name}:0", 'hx .', 'C-m';
            }
            when 'flutter' {
                run '${pkgs.tmux}/bin/tmux', 'send-keys', '-t', $name, 'y', 'C-m';
            }
            when 'dotfiles' {
                run '${pkgs.tmux}/bin/tmux', 'rename-window', '-t', "{$name}:0", 'files';
                run '${pkgs.tmux}/bin/tmux', 'send-keys', '-t', "{$name}:0", 'y', 'C-m';
                run '${pkgs.tmux}/bin/tmux', 'new-window', '-t', $name, '-n', 'editor', '-c', $path;
                run '${pkgs.tmux}/bin/tmux', 'send-keys', '-t', "{$name}:editor", 'hx .', 'C-m';
                run '${pkgs.tmux}/bin/tmux', 'select-window', '-t', "{$name}:editor";
            }
            when 'notes' {
                run '${pkgs.tmux}/bin/tmux', 'send-keys', '-t', $name, 'y', 'C-m';
            }
            default {
                run '${pkgs.tmux}/bin/tmux', 'send-keys', '-t', $name, 'y', 'C-m';
            }
        }
    }
  '';
in
{
  home.packages = [ x11tmuxmanager ];
}
