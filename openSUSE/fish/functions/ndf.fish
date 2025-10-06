# nekovim neovide fzf
function ndf
  # alias nf='nv (fzf --preview "cat {}" --height 70%)'
  # env nv (fzf --preview "cat {}" --height 70%)
  set -l selected_file (fzf --preview "cat {}" --height 70%)
  if test -n "$selected_file"
    env NVIM_APPNAME="nekovim" neovide "$selected_file"
  end
end
