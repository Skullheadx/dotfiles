{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "/home/andrew/.dotfiles/astronvim-config";
  programs.ripgrep.enable = true;
  programs.lazygit.enable = true;
  programs.bottom.enable = true;
  programs.go.enable = true;
  programs.gcc.enable = true;

  # home.persistence."/persist${config.home.homeDirectory}" = {
  #   directories = [
  #     ".local/share/nvim"
  #     ".local/state/nvim"
  #     ".cache/nvim"
  #   ];
  # };

  programs.neovim = {
    enable = true;
    withPython3 = true;
    withNodeJs = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      none-ls-nvim
      nvim-treesitter-parsers.bash
      nvim-treesitter-parsers.cpp
      nvim-treesitter-parsers.c
      nvim-treesitter-parsers.objc
      nvim-treesitter-parsers.cuda
      nvim-treesitter-parsers.proto
      nvim-treesitter-parsers.dockerfile
      nvim-treesitter-parsers.fish
      nvim-treesitter-parsers.go
      nvim-treesitter-parsers.html
      nvim-treesitter-parsers.css
      nvim-treesitter-parsers.json
      nvim-treesitter-parsers.jsonc
      nvim-treesitter-parsers.lua
      nvim-treesitter-parsers.markdown
      nvim-treesitter-parsers.markdown_inline
      nvim-treesitter-parsers.nix
      nvim-treesitter-parsers.python
      nvim-treesitter-parsers.toml
      nvim-treesitter-parsers.sql
      nvim-treesitter-parsers.typescript
      nvim-treesitter-parsers.javascript
      nvim-treesitter-parsers.tsx
      nvim-treesitter-parsers.jsdoc
      nvim-treesitter-parsers.yaml
      nvim-treesitter-parsers.zig

      # formatter
      vim-clang-format
    ];

    # extraPackages = with pkgs; [
    # ];
  };
}
