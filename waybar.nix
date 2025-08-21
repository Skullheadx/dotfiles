{ config, pkgs, ... }:
{
  programs.waybar = {
    enable = true;

    settings = [
      {
        output = [ "DP-3" ];
        height = 24; # Waybar height
        spacing = 4; # Gaps between modules

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];

        modules-center = [
          "mpris"
        ];
        modules-right = [
          "tray"
          "idle_inhibitor"
          "wireplumber"
          "battery"
          "clock"
        ];

        "hyprland/workspaces" = {
          all-outputs = true;
          warp-on-scroll = false;
          enable-bar-scroll = true;
          disable-scroll-wraparound = true;
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "4";
            "5" = "5";
	    "6" = "";
	    "7" = "";
	    "8" = "";
            "9" = "9";
          };
        };

        "hyprland/window" = {
          format = "{title}";
          max-length = 40;
          all-outputs = true;
        };

        mpris = {
          format = " {status_icon} {dynamic}";
          interval = 1;
          dynamic-len = 40;
          dynamic-order = [
            "title"
            "artist"
          ];
          ignored-players = [ "firefox" ];
          status-icons = {
            playing = "▶";
            paused = "⏸";
            stopped = "";
          };
        };

        tray = {
          icon-size = 14;
          spacing = 10;
        };

        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-full = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-alt = "{icon} {time}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        wireplumber = {
          scroll-step = 5;
          format = "{icon} {volume}%";
          format-bluetooth = "{icon} {volume}% ";
          format-bluetooth-muted = " {icon}";
          format-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "";
            headset = "";
            phone = "";
            portable = "";
            car = "";
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        };
      }

      # Bar for DP-2 only
      {
        output = [ "DP-2" ];
        height = 24;
        spacing = 4;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];

        modules-center = [ ];
        modules-right = [ "clock" ];

        "hyprland/workspaces" = {
          all-outputs = true;
          warp-on-scroll = true;
          enable-bar-scroll = true;
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "4";
            "5" = "5";
	    "6" = "";
	    "7" = "";
	    "8" = "";
            "9" = "9";
          };
        };

        "hyprland/window" = {
          format = "{title}";
          max-length = 40;
          all-outputs = true;
        };

        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };
      }
    ];
  };
}
