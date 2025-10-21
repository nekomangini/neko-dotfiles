#!/usr/bin/env raku
use v6.d;

constant $REPO_PATH = '/run/media/nekomangini/D/emacs-save-files/emacs-org-sync';
constant $DATE_TODAY = DateTime.now(formatter => {sprintf "%d-%d-%d", .month, .day, .year});
constant $COMMIT_MESSAGE = "update notes $DATE_TODAY";

unless chdir($REPO_PATH) {
    warn "Error: Could not find or access repository at '$REPO_PATH'";
    exit 1;
}

# Handle git add with potential lock file issue
my $add-success = True;
try {
    shell 'git add .';
    CATCH {
        default {
            say "Git add failed: {.message}";
            say "Attempting to remove stale lock file...";
            if '.git/index.lock'.IO.e {
                unlink '.git/index.lock';
                say "Retrying git add...";
                shell 'git add .';  # Retry after removing lock
            } else {
                $add-success = False;
            }
        }
    }
}

unless $add-success {
    warn "ERROR: git add failed";
    exit 1;
}

my $proc = shell "git commit -m '$COMMIT_MESSAGE'";
if $proc.exitcode == 0 {
    say "SUCCESS: Changes committed.";

    # Only push if commit was successful
    my $push-proc = shell 'git push';
    if $push-proc.exitcode == 0 {
        say "SUCCESS: Changes pushed to remote.";
    } else {
        warn "ERROR: git push failed (Exit Code: {$push-proc.exitcode})";
        exit 1;
    }
} elsif $proc.exitcode == 1 {
    say "INFO: No changes detected. Skipping commit.";
} else {
    warn "ERROR: Git commit failed (Exit Code: {$proc.exitcode})";
    exit 1;
}
