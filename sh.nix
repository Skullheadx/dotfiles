{
  config,
  lib,
  pkgs,
  ...
}:
let
  myAliases = {
    ll = "ls -l";
    ".." = "cd ..";
  };
  catppuccin-fish = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "fish";
    rev = "0ce27b518e8ead555dec34dd8be3df5bd75cff8e";
    hash = "sha256-Dc/zdxfzAUM5NX8PxzfljRbYvO9f9syuLO8yBr+R3qg=";
    };
in
{
  programs.bash = {
    enable = true;
    shellAliases = myAliases;
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true; # Enables zsh-completions
    autosuggestion.enable = true; # Enables zsh-autosuggestions
    syntaxHighlighting.enable = true; # Enables zsh-syntax-highlighting
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git" # Git plugin
        "colored-man-pages" # Colored man pages
        "alias-finder" # Find aliases for commands
      ];
      theme = "";
    };
    initContent = ''
            # Powerlevel10k configuration
            source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      	source ${./.p10k.zsh}
            # Initialize zoxide
            eval "$(zoxide init zsh)"

            # Initialize fzf
            source <(fzf --zsh)

            # Source fzf-tab (needs to be after fzf)
            source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh

            # Custom aliases
            alias ll="ls -la"
            alias gs="git status"

      	bindkey '^ ' autosuggest-execute
    '';
  };

	home.packages = with pkgs; [
		zoxide
		fzf
		starship
	];

  programs.fish = {
		enable = true;
		generateCompletions = true;
		shellAbbrs = {
			gco = "git checkout";
			gs = "git status";
		};
		  interactiveShellInit = ''
		    fish_vi_key_bindings
		    set -U fish_greeting
		    zoxide init fish | source
		    starship init fish | source
		    fzf --fish | source
		  '';
		  };

	# hodgepodge of these two themes:https://starship.rs/presets/catppuccin-powerline, https://starship.rs/presets/tokyo-night
	#(#a3aed2)\
	home.file.".config/starship.toml".text = ''
format = """
[](fg:#a3aed2)\
$username\ 
[](bg:#769ff0 fg:#a3aed2)\
$directory\
[](fg:#769ff0 bg:#394260)\
$git_branch\
$git_status\
[](fg:#394260 bg:#212736)\
$nodejs\
$rust\
$golang\
$php\
$c\
$java\
$kotlin\
$haskell\
$python\
[](fg:#212736 bg:#1d2230)\
$time\
[ ](fg:#1d2230)\
\n$character"""


palette = 'colours'

[username]
show_always = true
style_user = "bg:#a3aed2 fg:#090c0c"
style_root = "bg:#a3aed2 fg:#090c0c"
format = '[ $user]($style)'

[directory]
style = "fg:#e3e5e5 bg:#769ff0"
format = "[ $path ]($style)"
truncation_length = 3
truncation_symbol = "…/"

[directory.substitutions]
"Documents" = "󰈙 "
"Downloads" = " "
"Music" = " "
"Pictures" = " "

[git_branch]
symbol = ""
style = "bg:#394260"
format = '[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)'

[git_status]
style = "bg:#394260"
format = '[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)'

[nodejs]
symbol = ""
style = "bg:#212736"
format = '[[ $symbol ](fg:#769ff0 bg:#212736)]($style)'

[rust]
symbol = ""
style = "bg:#212736"
format = '[[ $symbol ](fg:#769ff0 bg:#212736)]($style)'

[golang]
symbol = ""
style = "bg:#212736"
format = '[[ $symbol ](fg:#769ff0 bg:#212736)]($style)'

[php]
symbol = ""
style = "bg:#212736"
format = '[[ $symbol ](fg:#769ff0 bg:#212736)]($style)'

[c]
symbol = ""
style = "bg:#212736"
format = '[[ $symbol ](fg:#769ff0 bg:#212736)]($style)'

[java]
symbol = ""
style = "bg:#212736"
format = '[[ $symbol ](fg:#769ff0 bg:#212736)]($style)'

[kotlin]
symbol = ""
style = "bg:#212736"
format = '[[ $symbol ](fg:#769ff0 bg:#212736)]($style)'

[haskell]
symbol = ""
style = "bg:#212736"
format = '[[ $symbol ](fg:#769ff0 bg:#212736)]($style)'

[python]
symbol = ""
style = "bg:#212736"
format = '[[ $symbol ](fg:#769ff0 bg:#212736)]($style)'


[time]
disabled = false
time_format = "%R" # Hour:Minute Format
style = "bg:#1d2230"
format = '[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)'

[character]
disabled = false
success_symbol = '[❯](bold fg:green)'
error_symbol = '[❯](bold fg:red)'
vimcmd_symbol = '[❮](bold fg:green)'
vimcmd_replace_one_symbol = '[❮](bold fg:lavender)'
vimcmd_replace_symbol = '[❮](bold fg:lavender)'
vimcmd_visual_symbol = '[❮](bold fg:yellow)'

[palettes.colours]
rosewater = "#f5e0dc"
flamingo = "#f2cdcd"
pink = "#f5c2e7"
mauve = "#cba6f7"
red = "#f38ba8"
maroon = "#eba0ac"
peach = "#fab387"
yellow = "#f9e2af"
green = "#a6e3a1"
teal = "#94e2d5"
sky = "#89dceb"
sapphire = "#74c7ec"
blue = "#89b4fa"
lavender = "#b4befe"
text = "#cdd6f4"
subtext1 = "#bac2de"
subtext0 = "#a6adc8"
overlay2 = "#9399b2"
overlay1 = "#7f849c"
overlay0 = "#6c7086"
surface2 = "#585b70"
surface1 = "#45475a"
surface0 = "#313244"
base = "#1e1e2e"
mantle = "#181825"
crust = "#11111b"
	'';
}
