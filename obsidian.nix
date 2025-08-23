{ config, pkgs, ... }:
{
  programs.obsidian = {
    enable = true;
    defaultSettings = {
      app = {
        showLineNumber = true;
        vimMode = true;
      };
      cssSnippets = [
        ./zoom.css
      ];

    };
    vaults."Vault" = {
      enable = true;
      settings = {
      };
    };
  };

}
