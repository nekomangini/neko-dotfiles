{ ... }:

{
  programs.vim = {
    enable = true;
    extraConfig = ''
      " --- General Settings ---
      set nocompatible         " use vim defaults
      set scrolloff=3          " keep 3 lines when scrolling
      set ai                   " set auto-indenting on for programming
      set showcmd              " display incomplete commands
      set nobackup             " do not keep a backup file
      set number               " show line numbers
      set ruler                " show the current row and column

      " --- Search Settings ---
      set hlsearch             " highlight searches
      set incsearch            " do incremental searching
      set showmatch            " jump to matches when entering regexp
      set ignorecase           " ignore case when searching
      set smartcase            " no ignorecase if Uppercase char present

      " --- Interaction Settings ---
      set visualbell t_vb=     " turn off error beep/flash
      set novisualbell         " turn off visual bell
      set backspace=indent,eol,start

      " --- VimGolf Optimization ---
      " This specifically helps with the VimGolf issue you noted
      set runtimepath=$VIMRUNTIME
      set t_RV=
    '';
  };
}
