{ config, pkgs, ... }:

{
  services.hyprsunset = {
    enable = true;

    settings = {
      sunrise = {
        calendar = "*-*-* 06:00:00";
        requests = [
          "temperature 6500"
          "gamma 100"
        ];
      };
      sunset = {
        calendar = "*-*-* 22:00:00";
        requests = [
          "temperature 3500"
        ];
      };
    };
  };

}
