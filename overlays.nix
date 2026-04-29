{ pkgs, inputs, ... }:
{
  nixpkgs.overlays = [
    (final: prev: {
      lock-screen = import ./lock-screen.nix { pkgs = prev; };
    })
    (final: prev: {
      slstatus = inputs.my-slstatus.packages.${pkgs.stdenv.hostPlatform.system}.default;
    })
    (final: prev: {
      surf = inputs.my-surf.packages.${pkgs.stdenv.hostPlatform.system}.default;
    })
    (final: prev: {
      dwm = inputs.my-dwm.packages.${pkgs.stdenv.hostPlatform.system}.default;
    })
    (final: prev: {
      st = inputs.my-st.packages.${pkgs.stdenv.hostPlatform.system}.default;
    })
  ];
}
