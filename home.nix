{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./sh.nix
    ./hyprland/hyprland.nix
    ./ghostty.nix
    ./obsidian.nix
    ./fastfetch.nix
    ./udiskie.nix
    ./mpd.nix
    ./rofi.nix
    ./stylix.nix
    ./brave-config.nix
    ./rmpc-theme.nix
    ./rmpc-config.nix

  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "andrew";
  home.homeDirectory = "/home/andrew";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello':wq command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    discord
    neovim
    catppuccin-gtk
    inter
    prismlauncher
    nixfmt-rfc-style
    p7zip
    github-desktop
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  # # Building this configuration will create a copy of 'dotfiles/screenrc' in
  # # the Nix store. Activating the configuration will then make '~/.screenrc' a
  # # symlink to the Nix store copy.
  # ".screenrc".source = dotfiles/screenrc;

  # # You can also set the file content immediately.
  # ".gradle/gradle.properties".text = ''
  #   org.gradle.console=verbose
  #   org.gradle.daemon.idletimeout=3600000
  # '';
  home.file = {
#    ".config/BraveSoftware/Brave-Browser/Local State" = {
#      source = ./brave-config/Local-State;
#      force = true;
#    };
#    ".config/BraveSoftware/Brave-Browser/Default/Preferences" = {
#      source = ./brave-config/Preferences;
#      force = true;
#    };
#    ".local/share/PrismLauncher/prismlauncher.cfg" = {
#      source = ./prismlauncher/prismlauncher.cfg;
#      force = true;
#    };
#    ".config/rmpc/themes/theme.ron".text =
#      ''#![enable(implicit_some)] #![enable(unwrap_newtypes)] #![enable(unwrap_variant_newtypes)] ( default_album_art_path: None, draw_borders: false, show_song_table_header: false, symbols: (song: "🎵", dir: "📁", playlist: "🎼", marker: "\u{e0b0}"), layout: Split( direction: Vertical, panes: [ ( pane: Pane(Header), size: "1", ), ( pane: Pane(TabContent), size: "100%", ), ( pane: Pane(ProgressBar), size: "1", ), ], ), progress_bar: ( symbols: ["", "", "⭘", " ", " "], track_style: (bg: "#1e2030"), elapsed_style: (fg: "#c6a0f6", bg: "#1e2030"), thumb_style: (fg: "#c6a0f6", bg: "#1e2030"), ), scrollbar: ( symbols: ["│", "█", "▲", "▼"], track_style: (), ends_style: (), thumb_style: (fg: "#b7bdf8"), ), browser_column_widths: [20, 38, 42], text_color: "#cad3f5", background_color: "#24273a", header_background_color: "#1e2030", modal_background_color: None, modal_backdrop: false, tab_bar: (active_style: (fg: "black", bg: "#c6a0f6", modifiers: "Bold"), inactive_style: ()), borders_style: (fg: "#6e738d"), highlighted_item_style: (fg: "#c6a0f6", modifiers: "Bold"), current_item_style: (fg: "black", bg: "#b7bdf8", modifiers: "Bold"), highlight_border_style: (fg: "#b7bdf8"), song_table_format: [ ( prop: (kind: Property(Artist), style: (fg: "#b7bdf8"), default: (kind: Text("Unknown"))), width: "50%", alignment: Right, ), ( prop: (kind: Text("-"), style: (fg: "#b7bdf8"), default: (kind: Text("Unknown"))), width: "1", alignment: Center, ), ( prop: (kind: Property(Title), style: (fg: "#7dc4e4"), default: (kind: Text("Unknown"))), width: "50%", ), ], header: ( rows: [ ( left: [ (kind: Text("["), style: (fg: "#b7bdf8", modifiers: "Bold")), (kind: Property(Status(State)), style: (fg: "#b7bdf8", modifiers: "Bold")), (kind: Text("]"), style: (fg: "#b7bdf8", modifiers: "Bold")) ], center: [ (kind: Property(Song(Artist)), style: (fg: "#eed49f", modifiers: "Bold"), default: (kind: Text("Unknown"), style: (fg: "#eed49f", modifiers: "Bold")) ), (kind: Text(" - ")), (kind: Property(Song(Title)), style: (fg: "#7dc4e4", modifiers: "Bold"), default: (kind: Text("No Song"), style: (fg: "#7dc4e4", modifiers: "Bold")) ) ], right: [ (kind: Text("Vol: "), style: (fg: "#b7bdf8", modifiers: "Bold")), (kind: Property(Status(Volume)), style: (fg: "#b7bdf8", modifiers: "Bold")), (kind: Text("% "), style: (fg: "#b7bdf8", modifiers: "Bold")) ] ) ], ), ) '';
#    ".config/rmpc/config.ron".text =
#      ''#![enable(implicit_some)] #![enable(unwrap_newtypes)] #![enable(unwrap_variant_newtypes)] ( address: "127.0.0.1:6600", password: None, theme: None, cache_dir: None, on_song_change: None, volume_step: 5, max_fps: 30, scrolloff: 0, wrap_navigation: false, enable_mouse: true, enable_config_hot_reload: true, status_update_interval_ms: 1000, rewind_to_start_sec: None, reflect_changes_to_playlist: false, select_current_song_on_change: false, browser_song_sort: [Disc, Track, Artist, Title], directories_sort: SortFormat(group_by_type: true, reverse: false), album_art: ( method: Auto, max_size_px: (width: 1200, height: 1200), disabled_protocols: ["http://", "https://"], vertical_align: Center, horizontal_align: Center, ), keybinds: ( global: { ":": CommandMode, ",": VolumeDown, "s": Stop, ".": VolumeUp, "<Tab>": NextTab, "<S-Tab>": PreviousTab, "1": SwitchToTab("Queue"), "2": SwitchToTab("Directories"), "3": SwitchToTab("Artists"), "4": SwitchToTab("Album Artists"), "5": SwitchToTab("Albums"), "6": SwitchToTab("Playlists"), "7": SwitchToTab("Search"), "q": Quit, ">": NextTrack, "p": TogglePause, "<": PreviousTrack, "f": SeekForward, "z": ToggleRepeat, "x": ToggleRandom, "c": ToggleConsume, "v": ToggleSingle, "b": SeekBack, "~": ShowHelp, "u": Update, "U": Rescan, "I": ShowCurrentSongInfo, "O": ShowOutputs, "P": ShowDecoders, "R": AddRandom, }, navigation: { "k": Up, "j": Down, "h": Left, "l": Right, "<Up>": Up, "<Down>": Down, "<Left>": Left, "<Right>": Right, "<C-k>": PaneUp, "<C-j>": PaneDown, "<C-h>": PaneLeft, "<C-l>": PaneRight, "<C-u>": UpHalf, "N": PreviousResult, "a": Add, "A": AddAll, "r": Rename, "n": NextResult, "g": Top, "<Space>": Select, "<C-Space>": InvertSelection, "G": Bottom, "<CR>": Confirm, "i": FocusInput, "J": MoveDown, "<C-d>": DownHalf, "/": EnterSearch, "<C-c>": Close, "<Esc>": Close, "K": MoveUp, "D": Delete, "B": ShowInfo, }, queue: { "D": DeleteAll, "<CR>": Play, "<C-s>": Save, "a": AddToPlaylist, "d": Delete, "C": JumpToCurrent, "X": Shuffle, }, ), search: ( case_sensitive: false, ignore_diacritics: false, mode: Contains, tags: [ (value: "any", label: "Any Tag"), (value: "artist", label: "Artist"), (value: "album", label: "Album"), (value: "albumartist", label: "Album Artist"), (value: "title", label: "Title"), (value: "filename", label: "Filename"), (value: "genre", label: "Genre"), ], ), artists: ( album_display_mode: SplitByDate, album_sort_by: Date, album_date_tags: [Date], ), tabs: [ ( name: "Queue", pane: Split( direction: Horizontal, panes: [(size: "60%", pane: Pane(Queue)), (size: "40%", pane: Pane(AlbumArt))], ), ), ( name: "Directories", pane: Pane(Directories), ), ( name: "Artists", pane: Pane(Artists), ), ( name: "Album Artists", pane: Pane(AlbumArtists), ), ( name: "Albums", pane: Pane(Albums), ), ( name: "Playlists", pane: Pane(Playlists), ), ( name: "Search", pane: Pane(Search), ), ],) '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/andrew/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "neovim";
  };

  programs.brave.enable = true;

  programs.rmpc = {
    enable = true;
  };

  #notifcations
  services.dunst.enable = true;
  services.mpd-mpris.enable = true;

  services.playerctld.enable = true;

  programs.git = {
    enable = true;
    userEmail = "admonty1@protonmail.com";
  };

  programs.keepassxc = {
    enable = true;
    #  settings = {
    #    Browser = {
    #    	Enabled = true;
    #	UseCustomBrowser = true;
    #	CustomBrowserType = 1;
    #
    #};
    #    GUI = {
    #      ShowTrayIcon = true;
    #      ApplicationTheme = "dark";
    #    };
    #  };
  };

	programs.waybar = {
		enable = true;

settings = [
    {
      output = [ "DP-3"];
      height = 37; # Waybar height
      spacing = 4; # Gaps between modules

      modules-left = [
        "hyprland/workspaces"
	"hyprland/window"
      ];

      modules-center = [ 
        "mpris"
 	];
      modules-right = [
        "idle_inhibitor"
        "load"
        "wireplumber"
        "clock"
        "battery"
        "tray"
      ];

      "hyprland/workspaces" = {
        all-outputs = true;
        warp-on-scroll = false;
        enable-bar-scroll = true;
        disable-scroll-wraparound = true;
        format = "{icon}";
        format-icons = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "5" = "";
          "9" = "";
          "10" = "";
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
        dynamic-order = [ "title" "artist" ];
        ignored-players = [ "firefox" ];
        status-icons = {
          playing = "▶";
          paused = "⏸";
          stopped = "";
        };
      };

      idle_inhibitor = {
        format = "{icon}";
        format-icons = {
          activated = "";
          deactivated = "";
        };
      };

      tray = {
        icon-size = 14;
        spacing = 10;
      };

      load = {
        format = " {}";
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
        format-icons = [ "" "" "" "" "" ];
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
          default = [ "" "" "" ];
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
      modules-right = [  "clock" ];

      "hyprland/workspaces" = {
        all-outputs = true;
        warp-on-scroll = true;
        enable-bar-scroll = true;
        format = "{icon}";
        format-icons = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "5" = "";
          "9" = "";
          "10" = "";
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
    font-family: "JetBrainsMono Nerd Font", "Noto Color Emoji", monospace;
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

 xdg.portal = {
  enable = true;
  extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
};


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
