#!/usr/bin/env raku
use v6.d;

constant $DEFAULT_EXT = '.org';
constant $DATE = DateTime.now.Date.Str;
constant $MORNING_LOGNAME = 'morning-log';
constant $EVENING_LOGNAME = 'evening-log';
constant $WEEKLY_LOGNAME = 'weekly-log';
constant $LOGSEQ_PAGES_PATH = '/run/media/nekomangini/D/logseq-files/pages/';
constant $MORNING_LOG_PATH = '/run/media/nekomangini/D/emacs-save-files/emacs-org-sync/2-areas/dev-logs/morning-logs/';
constant $EVENING_LOG_PATH = '/run/media/nekomangini/D/emacs-save-files/emacs-org-sync/2-areas/dev-logs/evening-logs/';
constant $WEEKLY_LOG_PATH = '/run/media/nekomangini/D/emacs-save-files/emacs-org-sync/2-areas/dev-logs/weekly-logs/';


constant $MORNING_TEMPLATE = qq:to/END/;
#+TITLE: $DATE - Daily Focus

* 🎯 TODAY'S MITs (Most Important Tasks)
** 🎬 MOTION GRAPHICS
- Task:
- Success looks like:
- Why this matters:
- Estimated time:

** 📱 APP DEVELOPMENT
- Task:
- Success looks like:
- Why this matters:
- Estimated time:

** 🔐 NETWORKING
- Task:
- Success looks like:
- Why this matters:
- Estimated time:

* ⚠️ POTENTIAL DISTRACTIONS
- Editor tinkering temptation: [ ]
- Over-researching instead of doing: [ ]

* 🛡️ ANTI-PROCRASTINATION PLEDGE
- I will start with REAL work before any editor configuration
- I will ship something ugly rather than perfect nothing

* 🔥 MOTIVATION REMINDER
- Why I'm doing this:
- How this moves me toward financial independence:
- What I'm avoiding by staying in comfort zone:
END

constant $EVENING_TEMPLATE = qq:to/END/;
#+TITLE: $DATE - Evening Review

* ✅ WHAT I ACTUALLY DID TODAY
** 🎬 Motion Graphics
- Created:
- Published:
- Learned:
- Time spent:

** 📱 App Development
- Coded:
- Solved:
- Designed:
- Time spent:

** 🔐 Networking
- Studied:
- Practiced:
- Understood:
- Time spent:

* 🎭 COMFORT ZONE ANALYSIS
** Did I do REAL work or just tinker?
- Real productive work: /10
- Tool/config tinkering: /10
- Avoidance activities:

** Editor Usage Breakdown
- Helix (primary): hours
- Doom Emacs (if used): hours
- Justification for switching:

** Resistance Faced
- What I avoided:
- How I avoided it:
- What story I told myself:

* 📊 PROGRESS TOWARD GOALS
** Goal 1:
- Movement: [ ] No progress [ ] Small step [ ] Significant [ ] Breakthrough
- Evidence:

** Goal 2:
- Movement: [ ] No progress [ ] Small step [ ] Significant [ ] Breakthrough
- Evidence:

** Goal 3:
- Movement: [ ] No progress [ ] Small step [ ] Significant [ ] Breakthrough
- Evidence:

* 🚨 HONEST ASSESSMENT
** Did I work on what TRULY matters?
- Answer:
- Excuses I made:
- Truth I avoided:

** Did I ship or just prepare to ship?
- Shipped:
- Prepared:
- Procrastinated:

* 💡 TOMORROW'S IMPROVEMENT
** One thing I'll do differently:
-

** One boundary I'll set:
-

** One uncomfortable action I'll take:
-

* 🌟 SUCCESS MOMENT
** One thing I'm proud of today:
-
END

constant $WEEKLY_TEMPLATE = qq:to/END/;
#+TITLE: $DATE - Weekly Review

* 📈 COMFORT ZONE TRENDS
** Editor Tinkering vs Real Work
- Real work hours:
- Tinkering hours:
- Ratio:

** Goal Progress Velocity
- Motion graphics: shorts created
- App development: features shipped
- Networking: concepts mastered

* 🔁 PATTERNS NOTICED
- When I procrastinate:
- What triggers avoidance:
- What helps me focus:

* 🎯 NEXT WEEK'S FOCUS
- Primary goal:
- Anti-procrastination strategy:
- Editor rule:
END

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
    my $template-selector = prompt("Select template: (1) Qlog, (2) Morning Log, (3) Evening Log, (4) Weekly Log: ");

    given $template-selector.trim {
        when "1" {
            say "template 1 is selected";
            create-qfile();
        }
        when "2" {
            say "template 2 is selected";
            create-file($MORNING_TEMPLATE, $MORNING_LOGNAME, $MORNING_LOG_PATH);
        }
        when "3" {
            say "template 3 is selected";
            create-file($EVENING_TEMPLATE, $EVENING_LOGNAME, $EVENING_LOG_PATH);
        }
        when "4" {
            say "template 4 is selected";
            create-file($WEEKLY_TEMPLATE, $WEEKLY_LOGNAME, $WEEKLY_LOG_PATH);
        }
        default {
            say "Please select valid templates";
        }
    }
}

create-log();
