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
    };
  };
}
