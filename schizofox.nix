{
  inputs,
  config,
  pkgs,
  ...
}: let
  nur-no-pkgs = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/NUR/archive/main.tar.gz";
    sha256 = "1c3cfyqmqspz93103pcrys4jgsizfzba2440p11bbazmxllpnjv8";
  }) {};
in {
  imports = [inputs.schizofox.homeManagerModule];
  programs.schizofox = {
    enable = true;
    settings = {
    };
    theme = {
      colors = {
        background-darker = "181825";
        background = "1e1e2e";
        foreground = "cdd6f4";
      };

      font = "Lexend";

      extraUserChrome = ''
        body {
          color: red !important;
        }
      '';
    };

    search = {
      defaultSearchEngine = "Brave";
      removeEngines = ["Google" "Bing" "Amazon.com" "eBay" "Twitter" "Wikipedia"];
      searxUrl = "https://searx.be";
      searxQuery = "https://searx.be/search?q={searchTerms}&categories=general";
    };

    security = {
      #sanitizeOnShutdown.enable = true;
      sandbox.enable = true;
      #userAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:106.0) Gecko/20100101 Firefox/106.0";
    };

    misc = {
      drm.enable = true;
      disableWebgl = false;
      #startPageURL = "file://${builtins.readFile ./startpage.html}";
      contextMenu.enable = true;
      bookmarks = [
        {
          Title = "Example";
          URL = "https://example.com";
          Favicon = "https://example.com/favicon.ico";
          Placement = "toolbar";
          Folder = "FolderName";
        }
      ];
    };

    extensions = {
      darkreader.enable = true;
    };

    #    profiles.andrew.extensions.packages = with inputs.firefox-addons.packages.${pkgs.system}; [
    #      ublock-origin
    #      #vimium_c
    #      sponsorblock
    #      darkreader
    #    ];
    #    extensions = {
    #      #ublockorigin.enable = true;
    #      #vimiumc.enable = true;
    #      #sponsorblock.enable = true;
    #      simplefox.enable = true;
    #      darkreader.enable = true;
    #
    #      extraExtensions = {
    #        #"webextension@ublock_origin".install_url = "https://addons.mozilla.org/firefox/downloads/file/4531307/ublock_origin-1.65.0.xpi";
    #        #"webextension@sponsorblock".install_url = "https://addons.mozilla.org/
    #firefox/downloads/file/4541835/sponsorblock-5.14.xpi";
    #        #"webextension@vimium_c".install_url = "https://addons.mozilla.org/firefox/downloads/file/4474326/vimium_c-2.12.3.xpi";
    #
    #        #"webextension@metamask.io".install_url = "https://addons.mozilla.org/firefox/downloads/latest/ether-metamask/latest.xpi";
    #      };
    #    };
  };
}
