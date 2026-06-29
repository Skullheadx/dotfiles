{
  config,
  pkgs,
  username,
  ...
}: {
  environment.systemPackages = with pkgs; [
    jdk17
    (google-cloud-sdk.withExtraComponents [
      google-cloud-sdk.components.gke-gcloud-auth-plugin
      google-cloud-sdk.components.beta
    ])
    ngrok
  ];

  homebrew = {
    enable = true;
    user = username;

    taps = [
    ];
    brews = [
      "redis"
    ];
    casks = [
    ];
  };
}
