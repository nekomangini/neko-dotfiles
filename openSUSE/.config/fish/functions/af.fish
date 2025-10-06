# astronvim fzf
function af
  # alias nf='nv (fzf --preview "cat {}" --height 70%)'
  # env nv (fzf --preview "cat {}" --height 70%)
  set -l selected_file (fzf --preview "cat {}" --height 70%)
  if test -n "$selected_file"
    env NVIM_APPNAME="astronvim_v5" nvim "$selected_file"
  end
end
