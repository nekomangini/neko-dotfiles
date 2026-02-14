#!/usr/bin/env raku
use v6.d;

# ──────────────────────────────────────────────
# CONSTANTS
# ──────────────────────────────────────────────

constant $DEFAULT_EXT = '.org';
constant $DATE = DateTime.now.Date.Str;
constant $DAILY_LOGNAME = 'daily-log';
constant $MONTHLY_LOGNAME = 'monthly-log';
constant $WEEKLY_LOGNAME = 'weekly-log';
constant $LOGSEQ_PAGES_PATH = '/run/media/nekomangini/D/logseq-files/pages/';
constant $DAILY_LOG_PATH = '/run/media/nekomangini/D/emacs-org-sync/2-areas/dev-logs/daily-logs/';
constant $MONTHLY_LOG_PATH = '/run/media/nekomangini/D/emacs-org-sync/2-areas/dev-logs/monthly-logs/';
constant $WEEKLY_LOG_PATH = '/run/media/nekomangini/D/emacs-org-sync/2-areas/dev-logs/weekly-logs/';


# ──────────────────────────────────────────────
# DAILY LOG
# ──────────────────────────────────────────────

constant $DAILY_TEMPLATE = qq:to/END/;
#+TITLE: $DATE - Daily Log

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

* 🎭 REFLECTION
- Things I could have done better:
- Ideas for workflow/system improvements:
END

# ──────────────────────────────────────────────
# WEEKLY LOG
# ──────────────────────────────────────────────

constant $WEEKLY_TEMPLATE = qq:to/END/;
#+TITLE: $DATE - Weekly Review

* 📊 WEEKLY SNAPSHOT
** Key projects worked on:
-

* 🏆 ACHIEVEMENTS
- 

* 🧠 KEY LEARNINGS
- 

* 🏗️ SYSTEM IMPROVEMENTS
- Workflow/Process ideas to pitch:

* 🧭 NEXT WEEK'S FOCUS
** Primary goal:
** Skills to level up:
** One thing to do differently:
END

# ──────────────────────────────────────────────
# MONTHLY LOG
# ──────────────────────────────────────────────

constant $MONTHLY_TEMPLATE = qq:to/END/;
#+TITLE: $DATE - Monthly Review

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
    my $filename = $DATE ~ "-" ~ $logname-arg;
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
            create-file($DAILY_TEMPLATE, $DAILY_LOGNAME, $DAILY_LOG_PATH);
        }
        when "3" {
            say "template 3 is selected";
            create-file($WEEKLY_TEMPLATE, $WEEKLY_LOGNAME, $WEEKLY_LOG_PATH);
        }
        when "4" {
            say "template 4 is selected";
            create-file($MONTHLY_TEMPLATE, $MONTHLY_LOGNAME, $MONTHLY_LOG_PATH);
        }
        default {
            say "Please select valid templates";
        }
    }
}

create-log();
