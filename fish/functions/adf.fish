# astronvim neovide fzf
function adf
  set -l selected_file (fzf --preview "cat {}" --height 70%)
  if test -n "$selected_file"
    env NVIM_APPNAME="astronvim_v5" neovide "$selected_file"
  end
end
