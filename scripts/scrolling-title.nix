{ pkgs }:
pkgs.writeShellApplication {
  name = "scrolling-title";
  runtimeInputs = with pkgs; [ mpc coreutils ];
  text = ''
    WIDTH=16
    PADDING="          "
    
    RAW_STR=$(mpc current)
    
    if [ -z "$RAW_STR" ]; then
      echo "Stopped"
      exit 0
    fi

    STR="$RAW_STR$PADDING"
    LEN=''${#STR} 

    T=$(date +%s)
    INDEX=$(( T % LEN ))

    # Output the scrolled window
    echo "$STR$STR" | cut -c "$((INDEX + 1))-$((INDEX + WIDTH))"'';
}
