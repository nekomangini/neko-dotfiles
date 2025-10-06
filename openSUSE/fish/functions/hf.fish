function hf
  set -l selected_file (fzf --preview "cat {}" --height 70%)
  if test -n "$selected_file"
    helix "$selected_file"
  end
end
