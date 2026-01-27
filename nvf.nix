{pkgs, ...}: {
  # Add any custom options (and do feel free to upstream them!)
  # options = { ... };
  config.vim = {
    theme.enable = true;
    # and more options as you see fit...
  };
}
