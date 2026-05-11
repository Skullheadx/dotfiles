curl -sSf -L https://install.lix.systems/lix | sh -s -- install
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
nix --version

mkdir -p ~/src
cd ~/src
git clone https://github.com/Skullheadx/dotfiles.git
cd dotfiles
git fetch origin
git checkout -b new-darwin origin/new-darwin

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo >>/Users/andrewmontgomery/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >>/Users/andrewmontgomery/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv zsh)"

sudo mkdir -p /etc/nix-darwin
sudo chown $(id -nu):$(id -ng) /etc/nix-darwin
cd /etc/nix-darwin

# To use Nixpkgs unstable:
nix flake init -t nix-darwin/master

sed -i '' "s/simple/$(scutil --get LocalHostName)/" flake.nix

sudo nix run nix-darwin/master#darwin-rebuild -- switch

zsh
cd ~/src/dotfiles
sudo darwin-rebuild switch --flake .
