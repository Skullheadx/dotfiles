{ pkgs } :
pkgs.writeShellApplication {
	name = "lock-screen";
	runtimeInputs = [ pkgs.betterlockscreen ];
	text = ''
		if [ ! -f "$HOME/.cache/betterlockscreen/current/lock_dimblur.png" ]; then
			betterlockscreen -u "$HOME/Wallpapers/Daniel_in_the_Lions_Den_by_Briton_Riviere.jpg" --fx dimblur
		fi

		betterlockscreen -l dimblur
	'';
}
