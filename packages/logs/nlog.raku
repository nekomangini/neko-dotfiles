#!/usr/bin/env raku
use v6.d;

# ──────────────────────────────────────────────
# DIRECTORY
# ──────────────────────────────────────────────

my $JOURNAL_DIR_PATH = "/mnt/D/homelab/sync/notes/02-journal";
my $BLOG_DIR_PATH    = "/mnt/D/homelab/sync/notes/01-para/02-areas/media/blogs";

# ──────────────────────────────────────────────
# CONSTANTS
# ──────────────────────────────────────────────

constant $DEFAULT_EXT = '.org';
constant $DATE = DateTime.now.Date.Str;

# ──────────────────────────────────────────────
# DAILY LOG
# ──────────────────────────────────────────────

constant $DAILY_TEMPLATE = qq:to/END/;
* 🎯 TODAY'S TASK:
** Primary task:
*** 

** Other tasks:
***
***

* 🚧 TROUBLESHOOTING
** Problem Encountered:
*** 
** Hypothesized Cause (Patterns):
*** 
** Resolution (What fixed it?):
*** 
** Code/Commands:
#+BEGIN_SRC shell
#+END_SRC

* 🧠 LEARNINGS & TOOLS NOTES
** What I learned:
***
** Code/Commands:
#+BEGIN_SRC shell
#+END_SRC

** Where to document (wiki/blog):

* 📝 UNSTRUCTURED NOTES
*** 

* 💾 END-OF-DAY SAVE POINT
** What I was doing:
** What to do first tomorrow:
END

# ──────────────────────────────────────────────
# WEEKLY LOG
# ──────────────────────────────────────────────

constant $WEEKLY_TEMPLATE = qq:to/END/;
* 📊 WEEKLY SNAPSHOT
** Key projects worked on:
*** Project Progress:

* 🏆 ACHIEVEMENTS
** 

* 🧠 KEY LEARNINGS
** 

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
** 

* 🛠️ TECH STACK EVOLUTION
** What tools did I master this month?
** What should be added to the Blog?
END

# ──────────────────────────────────────────────
# QUICK CAPTURE LOG
# ──────────────────────────────────────────────

constant $QCAP-TEMPLATE = qq:to/END/;
date: $DATE
* 🎯 Task in Focus
** What I’m doing:
**
** Why I’m doing it:
**

* 🔥 Problem
** What’s broken or missing:
**

* 💡 Solution
** My approach:
**
** Code / Commands:

#+BEGIN_SRC shell
#+END_SRC

* 📚 Resources:
**

* 🧠 Key Insight
** What I learned:
**

* 💾 Next Steps
**
END

# ──────────────────────────────────────────────
# JOURNAL PATH/FILENAME HELPERS
# ──────────────────────────────────────────────

sub journal-dir(Str $type) {
    my $year = DateTime.now.year.Str;
    my $dir = "$JOURNAL_DIR_PATH/$type/$year";
    mkdir($dir) unless $dir.IO.d;
    return $dir;
}

sub journal-filename(Str $type) {
    given $type {
        when 'daily' {
            return $DATE ~ $DEFAULT_EXT;
        }
        when 'weekly' {
            my ($iso-year, $iso-week) = Date.today.week;
            return sprintf("%d-W%02d", $iso-year, $iso-week) ~ $DEFAULT_EXT;
        }
        when 'monthly' {
            my $now = DateTime.now;
            return sprintf("%d-%02d", $now.year, $now.month) ~ $DEFAULT_EXT;
        }
    }
}

# ──────────────────────────────────────────────
# FUNCTIONS
# ──────────────────────────────────────────────

sub create-qfile() {
    my $prompt-filename = prompt("Enter filename: ");
    my $prompt-category = prompt("Enter category: ");
    my $raw-filename = $prompt-filename.wordcase;
    my $category = $prompt-category.wordcase;

    my $dir = journal-dir('quick-capture');
    my $filename = "$category" ~ "___" ~ "$raw-filename";
    unless $filename.lc.ends-with($DEFAULT_EXT) {
        $filename ~= $DEFAULT_EXT;
    }
    my $full-path = "$dir/$filename";

    if $full-path.IO.e {
        say "File '$full-path' already exists. Aborting...";
        exit;
    }

    say "Creating file '$full-path' with template content...";
    sleep 1;

    spurt($full-path, $QCAP-TEMPLATE);
    say "Successfully created '$full-path'";
}

sub create-file($template-arg, Str $type) {
    my $dir = journal-dir($type);
    my $filename = journal-filename($type);
    my $full-path = "$dir/$filename";

    if $full-path.IO.e {
        say "File '$full-path' already exists. Aborting.";
        exit;
    }

    say "Creating file '$full-path' with template content...";
    sleep 1;

    spurt($full-path, $template-arg);

    say "Successfully created: '$full-path'";
}

sub create-blog() {
    my $prompt-blogname = prompt("Enter blogpost title: ");
    my $blog-filename = "blog-" ~ $prompt-blogname.trim.lc.subst(/\s+/, '-', :g);
    $blog-filename ~= $DEFAULT_EXT unless $blog-filename.ends-with($DEFAULT_EXT);

    chdir($BLOG_DIR_PATH);

    if $blog-filename.IO.e {
        say "File '$blog-filename' already exists. Aborting...";
        exit;
    }

    say "Creating file '$blog-filename'...";
    sleep 1;

    spurt($blog-filename, "");
    say "Successfully created '$blog-filename'";
}

sub create-log {
    my @options = (
        'Quick capture',
        'Daily log',
        'Weekly log',
        'Monthly log',
        'Blog draft',
    );

    my $fzf = run <fzf --height=~50% --border --layout=reverse --prompt=Select-Template:>, :in, :out;
    $fzf.in.say($_) for @options;
    $fzf.in.close;
    my $choice = $fzf.out.slurp.trim;

    given $choice {
        when 'Quick capture' {
            create-qfile();
        }
        when 'Daily log' {
            create-file($DAILY_TEMPLATE, 'daily');
        }
        when 'Weekly log' {
            create-file($WEEKLY_TEMPLATE, 'weekly');
        }
        when 'Monthly log' {
            create-file($MONTHLY_TEMPLATE, 'monthly');
        }
        when 'Blog draft' {
            create-blog();
        }
        default {
            say "Aborted.";
        }
    }
}

create-log();
