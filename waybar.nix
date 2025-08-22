{ config, pkgs, ... }:
{
  programs.waybar = {
    enable = true;

    settings = [
      {
        output = [ "DP-3"];
       #height = 24; # Waybar height
        spacing = 4; # Gaps between modules
	fixed-center = true;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];

        modules-center = [
          "mpris"
        ];
        modules-right = [
          "tray"
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
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "󰡈";
	    "6" = "";
	    "7" = "7";
	    "8" = "";
            "9" = "󰠮";
	    "10" = "10";
          };
        };

        "hyprland/window" = {
          format = "{title}";
          max-length = 40;
          all-outputs = true;
        };

        mpris = {
          format = "  {status_icon} {dynamic}";
          interval = 1;
          dynamic-len = 40;
          dynamic-order = [
            "title"
            "artist"
          ];
          ignored-players = [ "brave" ];
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
          #on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          on-click = "pavucontrol";
        };
      }

      # Bar for DP-2 only
      {
        output = [ "DP-2" ];
        #height = 24;
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
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "󰡈";
	    "6" = "";
	    "7" = "7";
	    "8" = "";
            "9" = "󰠮";
	    "10" = "10";
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
    style = ''
* {
    font-size: 14px;
    border-radius: 5px;
}

window#waybar {
    /* `otf-font-awesome` is required to be installed for icons */
    font-family: jetbrains-mono, monospace;
    background-color: transparent;
    border-bottom: 0px;
    color: #ebdbb2;
    transition-property: background-color;
    transition-duration: .5s;
}

window#waybar.hidden {
    opacity: 0.2;
}

window#waybar.empty #window {
    background-color: transparent;
}

/*
window#waybar.empty {
    background-color: transparent;
}
window#waybar.solo {
    background-color: #FFFFFF;
}
*/

.modules-right {
    margin: 10px 10px 0 0;
}
.modules-center {
    margin: 10px 0 0 0;
}
.modules-left {
    margin: 10px 0 0 10px;
}

button {
    /* Use box-shadow instead of border so the text isn't offset */
    /* box-shadow: inset 0 -3px transparent; */
    border: none;
}

/* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
/*
button:hover {
    background: inherit;
    box-shadow: inset 0 -3px #ebdbb2;
} */

#workspaces {
    background-color: #282828;
}

#workspaces button {
    padding: 0 5px;
    background-color: transparent;
    color: #ebdbb2;
    border-radius: 0;
}

#workspaces button:first-child {
    border-radius: 5px 0 0 5px;
}

#workspaces button:last-child {
    border-radius: 0 5px 5px 0;
}

#workspaces button:hover {
    color: #d79921;
}

#workspaces button.focused {
    background-color: #665c54;
    /* box-shadow: inset 0 -3px #ffffff; */
}

#workspaces button.urgent {
    background-color: #b16286;
}

#idle_inhibitor,
#cava,
#scratchpad,
#mode,
#window,
#clock,
#battery,
#backlight,
#wireplumber,
#tray,
#mpris,
#load {
    padding: 0 10px;
    background-color: #282828;
    color: #ebdbb2;
}

#mode {
    background-color: #689d6a;
    color: #282828;
    /* box-shadow: inset 0 -3px #ffffff; */
}

/* If workspaces is the leftmost module, omit left margin */
.modules-left > widget:first-child > #workspaces {
    margin-left: 0;
}

/* If workspaces is the rightmost module, omit right margin */
.modules-right > widget:last-child > #workspaces {
    margin-right: 0;
}

#cava {
    padding: 0 5px;
}

#battery.charging, #battery.plugged {
    background-color: #98971a;
    color: #282828;
}

@keyframes blink {
    to {
        background-color: #282828;
        color: #ebdbb2;
    }
}

/* Using steps() instead of linear as a timing function to limit cpu usage */
#battery.critical:not(.charging) {
    background-color: #cc241d;
    color: #ebdbb2;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: steps(12);
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

label:focus {
    background-color: #000000;
}

#wireplumber.muted {
    background-color: #458588;
}

#tray > .passive {
    -gtk-icon-effect: dim;
}

#tray > .needs-attention {
    -gtk-icon-effect: highlight;
}

#mpris.playing {
    background-color: #d79921;
    color: #282828;
}

#tray menu {
    font-family: sans-serif;
}

#scratchpad.empty {
    background: transparent;
}

    '';
  };
}
