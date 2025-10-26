{
  inputs,
  config,
  pkgs,
  ...
}: {
  programs.librewolf = {
    enable = true;
    settings = {
      "browser.startup.page" = 3;
      "privacy.clearOnShutdown.history" = false;
      "privacy.clearOnShutdown.downloads" = false;
      "privacy.resistFingerprinting" = false;
      "browser.sessionstore.resume_from_crash" = true;
      "middlemouse.paste" = false;
      "general.autoScroll" = true;
      "sidebar.verticalTabs" = true;
      "sidebar.position_start" = false; # move to right hand side
      "privacy.clearOnShutdown.cookies" = true;
      "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
    };
    profiles."skull" = {
      extensions = {
        force = true;
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          sponsorblock
          ublock-origin
          vimium-c
          keepassxc-browser
          containerise
        ];
        settings = {
          "uBlock0@raymondhill.net".settings = {
            enabled = true;
          };
          "sponsorBlocker@ajay.app".settings = {
            enabled = true;
          };
          "keepassxc-browser@keepassxc.org".settings = {
            enabled = true;
          };
          "vimium-c@gdh1995.cn".settings = {
            enabled = true;
          };
        };
      };
      containers = {
        Personal = {
          color = "blue";
          icon = "fingerprint";
          id = 1;
        };
        Shopping = {
          color = "turquoise";
          icon = "cart";
          id = 2;
        };
        Banking = {
          color = "green";
          icon = "dollar";
          id = 3;
        };
        Youtube = {
          color = "red";
          icon = "fruit";
          id = 4;
        };
        School = {
          color = "pink";
          icon = "briefcase";
          id = 5;
        };
      };
    };
  };
}
