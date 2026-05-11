{
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.andrew = {
    isNormalUser = true;

    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [];
  };

  hjem.users.andrew = {
    directory = "/home/andrew";
    files = {
    };

    packages = with pkgs; [
      lazygit
      btop
      zathura
      lf
      librewolf
    ];
  };
}
