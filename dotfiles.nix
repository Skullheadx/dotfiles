{
  config,
  lib,
  ...
}: {
  options = {
    dotfiles = {
      mutable = lib.mkEnableOption "mutable dotfiles";

      path = lib.mkOption {
        type = lib.types.path;
        apply = toString;
        default = "${config.home.homeDirectory}/.dotfiles/";
        example = "${config.home.homeDirectory}/.dotfiles/astronvim-config";
        description = "Location of the dotfiles working copy";
      };
    };
  };
}
