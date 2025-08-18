{ config, pkgs, ... }:

{
  programs.obsidian = {
    enable = true;
    vaults."Vault" = {
      enable = true;
      settings = {
        app = {
          showLineNumbers = true;
        };
        appearance = {
          zoomLevel = 1.50;
        };
      };

    };
  };
}
