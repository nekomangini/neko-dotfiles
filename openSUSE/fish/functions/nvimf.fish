# lazyvim fzf
function nvimf
  set -l selected_file (fzf --preview "cat {}" --height 70%)
  if test -n "$selected_file"
    nvim "$selected_file"
  end
end
