{ pkgs }:
pkgs.writeShellApplication {
  name = "surf_search";
  runtimeInputs = with pkgs; [
    dmenu
    xprop
    gnused
    coreutils
  ];
  text = builtins.readFile (
    pkgs.replaceVars ../dotfiles/surf/surf.sh {
      dmenu = pkgs.dmenu;
      xprop = pkgs.xprop;
      gnused = pkgs.gnused;
      coreutils = pkgs.coreutils;
    }
  );
}
