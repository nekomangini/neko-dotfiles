# emacs terminal
function et
  # alias et='emacsclient -nw -s "server"' # systemd
  # emacsclient -new -s "server" $argv     # systemd
  emacsclient -nw -s nekoserver $argv # using daemon
end
