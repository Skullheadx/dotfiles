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
    DOUBLE_STR="''$STR''$STR"
    echo "''${DOUBLE_STR:''$INDEX:''$WIDTH}"
'';
}
