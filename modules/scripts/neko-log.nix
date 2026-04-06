{ pkgs, ... }:

let
  nLog = pkgs.writeScriptBin "nlog" ''
    #!/usr/bin/env raku
    use v6.d;


    # ──────────────────────────────────────────────
    # DYNAMIC PATHS FROM AGENIX
    # ──────────────────────────────────────────────

    my $secrets-file = %*ENV<NOTES_SECRET_FILE> // "/run/agenix/note-path";
    die "⚠️ Secrets not found at $secrets-file" unless $secrets-file.IO.e;

    my %paths = $secrets-file.IO.lines
        .grep({ .contains('=') && !.starts-with('#') })
        .map({
            my ($key, $val) = .split('=', 2);
            $key.trim => $val.trim;
        });

    # ──────────────────────────────────────────────
    # CONSTANTS
    # ──────────────────────────────────────────────

    constant $DEFAULT_EXT = '.org';
    constant $LOGS= 'areas' ~ "___" ~ 'dev-logs';
    constant $DATE = DateTime.now.Date.Str;
    constant $DAILY_LOGNAME = $LOGS ~  '___' ~ 'daily-logs';
    constant $WEEKLY_LOGNAME = $LOGS ~  '___' ~ 'weekly-logs';
    constant $MONTHLY_LOGNAME = $LOGS ~  '___' ~ 'monthly-logs';
    # constant $LOGSEQ_PAGES_PATH = '/run/media/nekomangini/D/emacs-org-sync/02-areas/pages/';
    my $LOGSEQ_PAGES_PATH = %paths<LOGSEQ_PAGES_PATH>
        // die "⚠️ LOGSEQ_PAGES_PATH not set in $secrets-file";


    # ──────────────────────────────────────────────
    # DAILY LOG
    # ──────────────────────────────────────────────

    constant $DAILY_TEMPLATE = qq:to/END/;
    * 🎯 TODAY'S TASK:
    ** Primary task:
    - 

    ** Other tasks:
    -
    -

    * 🚧 TROUBLESHOOTING
    ** Problem Encountered:
    - 
    ** Hypothesized Cause (Patterns):
    - 
    ** Resolution (What fixed it?):
    - 
    ** Code/Commands:
    #+BEGIN_SRC shell
    #+END_SRC

    * 🧠 LEARNINGS & TOOLS NOTES
    ** What I learned:
    -
    ** Code/Commands:
    #+BEGIN_SRC shell
    #+END_SRC

    ** Where to document (wiki/blog):

    * 📝 UNSTRUCTURED NOTES
    - 

    * 💾 END-OF-DAY SAVE POINT
    - What I was doing:
    - What to do first tomorrow:
    END

    # ──────────────────────────────────────────────
    # WEEKLY LOG
    # ──────────────────────────────────────────────

    constant $WEEKLY_TEMPLATE = qq:to/END/;
    * 📊 WEEKLY SNAPSHOT
    ** Key projects worked on:
    - Project Progress:

    * 🏆 ACHIEVEMENTS
    - 

    * 🧠 KEY LEARNINGS
    - 

    * 🧭 NEXT WEEK'S FOCUS
    ** Primary goal:
    ** Skills to level up:
    ** One thing to do differently:
    END

    # ──────────────────────────────────────────────
    # MONTHLY LOG
    # ──────────────────────────────────────────────

    constant $MONTHLY_TEMPLATE = qq:to/END/;
    * 📊 ACHIEVEMENTS
    - 

    * 🛠️ TECH STACK EVOLUTION
    - What tools did I master this month?
    - What should be added to the Blog?
    END

    # ──────────────────────────────────────────────
    # QUICK CAPTURE LOG
    # ──────────────────────────────────────────────

    constant $QCAP-TEMPLATE = qq:to/END/;
    date: $DATE
    * 🎯 Task in Focus
    ** What I’m doing:
    -
    ** Why I’m doing it:
    -

    * 🔥 Problem
    ** What’s broken or missing:
    -

    * 💡 Solution
    ** My approach:
    -
    ** Code / Commands:

    #+BEGIN_SRC shell
    #+END_SRC

    * 📚 Resources:
    -

    * 🧠 Key Insight
    - What I learned:
    -

    * 💾 Next Steps
    -
    END

    # ──────────────────────────────────────────────
    # FUNCTIONS
    # ──────────────────────────────────────────────

    sub create-qfile() {

       my $prompt-filename = prompt("Enter filename: ");
       my $prompt-category = prompt("Enter category: ");
       my $raw-filename = $prompt-filename.wordcase;
       my $category = $prompt-category.wordcase;

       chdir($LOGSEQ_PAGES_PATH);

       my $filename = "$category" ~ "___" ~ "$raw-filename";
       unless $filename.lc.ends-with($DEFAULT_EXT) {
           $filename ~= $DEFAULT_EXT;
       }
       if $filename.IO.e {
           say "File '$filename' already exists. Aborting...";
           exit
       }

       say "Creating file '$filename' with template content...";
       sleep 1;

       spurt($filename, $QCAP-TEMPLATE);
       say "Successfully created '$filename'";
    }

    sub create-file($template-arg, $logname-arg, $logpath-arg) {
        chdir($logpath-arg);
        # TODO
        # my $filename = $DATE ~ "-" ~ $logname-arg;
        my $filename = $logname-arg ~ "___" ~ $DATE;
        unless $filename.lc.ends-with($DEFAULT_EXT) {
            $filename ~= $DEFAULT_EXT;
        }

        if $filename.IO.e {
            say "File '$filename' already exists. Aborting.";
            exit
        }

        my $content = $template-arg;

        say "Creating file '$filename' with template content...";
        sleep 1;

        spurt($filename, $content);

        say "Succesfully created: '$filename'";
    }

    sub create-log {
        my $template-selector = prompt("Select template: (1) Qlog, (2) Daily Log, (3) Weekly Log, (4) Monthly Log: ");

        given $template-selector.trim {
            when "1" {
                say "template 1 is selected";
                create-qfile();
            }
            when "2" {
                say "template 2 is selected";
                create-file($DAILY_TEMPLATE, $DAILY_LOGNAME, $LOGSEQ_PAGES_PATH);
            }
            when "3" {
                say "template 3 is selected";
                create-file($WEEKLY_TEMPLATE, $WEEKLY_LOGNAME, $LOGSEQ_PAGES_PATH);
            }
            when "4" {
                say "template 4 is selected";
                create-file($MONTHLY_TEMPLATE, $MONTHLY_LOGNAME, $LOGSEQ_PAGES_PATH);
            }
            default {
                say "Please select valid templates";
            }
        }
    }

    create-log();
  '';
in
{

  home.packages = [ nLog ];
}
