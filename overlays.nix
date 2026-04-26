{ pkgs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      lock-screen = import ./lock-screen.nix { pkgs = prev; };
    })
  ];
}
