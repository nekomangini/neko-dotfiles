function kakf
  set -l selected_file (fzf --preview "cat {}" --height 70%)
  if test -n "$selected_file"
    kak "$selected_file"
  end
end
