{
  config,
  pkgs,

  customNeovim,
  ...
}:
{

  environment.systemPackages = with pkgs; [
    (lib.lowPrio pkgs.vim-full) # Lower Vim's priority
    (pkgs.writeShellApplication {
      name = "vi";
      runtimeInputs = [ pkgs.nvi ];
      text = ''
        exec ${pkgs.nvi}/bin/vi "$@"
      '';
    })

    customNeovim.neovim
  ];

  environment.etc."vimrc".text = ''
      set autoread
      au FocusGained,BufEnter * silent! checktime

      " Turn on the Wild menu
      set wildmenu

      " Ignore compiled files
      set wildignore=*.o,*~,*.pyc
      set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store


      set ruler

      set ignorecase
      set smartcase
      set hlsearch
      set incsearch
      set lazyredraw
      set magic
      set showmatch

      syntax enable
      set noswapfile

      " Use spaces instead of tabs
      set expandtab

      " Be smart when using tabs ;)
      set smarttab

      " 1 tab == 4 spaces
      set shiftwidth=4
      set tabstop=4

      set ai "Auto indent
      set si "Smart indent
      set wrap "Wrap lines

      " Always show the status line
      set laststatus=2

      set number relativenumber


    " Force the cursor to a Block when Vim starts
      let &t_ti = &t_ti . "\e[2 q"
      let &t_te = &t_te . "\e[2 q"
      let &t_EI = "\e[2 q"
      let &t_SI = "\e[2 q"
  '';

  #  programs.neovim = {
  #    enable = true;
  #    defaultEditor = true;
  #    configure = {
  #      customRC = ''
  #        set autoread
  #        au FocusGained,BufEnter * silent! checktime
  #
  #        " Turn on the Wild menu
  #        set wildmenu
  #
  #        " Ignore compiled files
  #        set wildignore=*.o,*~,*.pyc
  #        set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
  #
  #        set ruler
  #
  #        set ignorecase
  #        set smartcase
  #        set hlsearch
  #        set incsearch
  #        set lazyredraw
  #        set magic
  #        set showmatch
  #
  #        syntax enable
  #        set noswapfile
  #
  #        " Use spaces instead of tabs
  #        set expandtab
  #
  #        " Be smart when using tabs ;)
  #        set smarttab
  #
  #        " 1 tab == 4 spaces
  #        set shiftwidth=4
  #        set tabstop=4
  #
  #
  #        set ai "Auto indent
  #        set si "Smart indent
  #        set wrap "Wrap lines
  #
  #        " Always show the status line
  #        set laststatus=2
  #
  #        set number relativenumber
  #
  #      '';
  #    };
  #  };

}
