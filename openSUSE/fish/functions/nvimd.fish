# lazyvim neovide fzf
function nvimd
  set -l selected_file (fzf --preview "cat {}" --height 70%)
  if test -n "$selected_file"
    neovide "$selected_file"
  end
end
