{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      lock-screen = import ./lock-screen.nix { pkgs = prev; };
    })
    (final: prev: {
      slstatus  =inputs.my-slstatus.packages.${pkgs.stdenv.hostPlatform.system}.default;
    })
  ];
}
