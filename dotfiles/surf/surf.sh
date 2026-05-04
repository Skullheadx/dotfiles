#!/bin/sh
# v. 2.0 - upgrade ba@gnused@/bin/sed on surf 4.0
# Creative Commons License.  Peter John Hartman (http://individual.utoronto.ca/peterjh)
# Much thanks to nibble and pancake who have a different surf.sh script available which
# doesn't do the history bit.
#
# this script does:
# * stores history of: (1) successful uri entries; (2) certain smart prefix entries, e.g., "g foobar"; (3) find entries
# * direct bookmark (via ^b)
# * information debug (via ^I)
# * smart prefixes e.g. g for google search, t for tinyurl, etc.
# * delete (with smart prefix x)
#
# $1 = $xid
# $2 = $p = _SURF_FIND _SURF_BMARK _SURF_URI (what SETPROP sets in config.h)
#
# // replace default setprop with this one
# #define SETPROP(p) { .v = (char *[]){ "/bin/sh", "-c", "surf.sh $0 $1 $2", p, q, winid, NULL } }
#
# { MODKEY, GDK_b, spawn, SETPROP("_SURF_BMARK") },
# { MODKEY|GDK_SHIFT_MASK, GDK_i, spawn, SETPROP("_SURF_INFO") },
# { MODKEY|GDK_SHIFT_MASK, GDK_g, spawn, SETPROP("_SURF_URI_RAW") },
font='Terminus:size=12'
normbgcolor='#181818'
normfgcolor='#e9e9e9'
selbgcolor=$normbgcolor
selfgcolor='#dd6003'

bmarks="$HOME/.local/share/surf/history.txt"
ffile="$HOME/.local/share/find.txt"

mkdir -p "$HOME/.local/share/surf"


pid=$1
# fid=$2
xid=$3


dmenu_cmd () {

    @dmenu@/bin/dmenu -nb "$normbgcolor" -nf "$normfgcolor" \
           -sb "$selbgcolor" -sf "$selfgcolor" "$@"
}

s_get_prop() { # "@xprop@/bin/xprop
	@xprop@/bin/xprop -id "$xid" "$1" | cut -d '\"' -f 2
}
s_set_prop() { # @xprop@/bin/xprop value
	[ -n """$2""" ] && @xprop@/bin/xprop -id """$xid""" -f """$1""" 8u -set """$1""" """$2"""
}
s_write_f() { # file value
	[ -n "$2" ] && (@gnused@/bin/sed -i "\|$2|d" "$1"; echo "$2" >> "$1")
}
s_set_write_proper_uri() { # uri
	s_set_prop _SURF_GO "$1"
     s_write_f "$bmarks" "$1"
}

case "$pid" in
"_SURF_INFO")
	@xprop@/bin/xprop -id "$xid" | @gnused@/bin/sed 's/\t/    /g' | dmenu_cmd -fn "$font" -b -l 20
	;;
"_SURF_FIND")
    find="$(@coreutils@/bin/tac "$ffile" 2>/dev/null | dmenu_cmd -fn "$font" -b -p find:)"
	s_set_prop _SURF_FIND "$find"
	s_write_f "$ffile" "$find"
	;;
"_SURF_BMARK")
    uri=$(s_get_prop _SURF_URI)
	s_write_f "$bmarks" "$uri"
	;;
"_SURF_URI_RAW")
    uri=$(s_get_prop _SURF_URI | dmenu_cmd -fn "$font" -b -p "uri:")
	s_set_prop _SURF_GO "$uri"
	;;
"_SURF_URI")
	sel=$(@coreutils@/bin/tac "$bmarks" 2> /dev/null | dmenu_cmd -fn "$font" -b -l 5 -p "uri [gynbwasx*]:")
	[ -z "$sel" ] && exit
	opt=$(echo "$sel" | cut -d ' ' -f 1)
	arg=$(echo "$sel" | cut -d ' ' -f 2-)
	save=0
	case "$opt" in
	"g") # google for it
		uri="http://www.google.com/search?q=""$arg"""
		save=1
		;;
	"y") # youtube
		uri="http://www.youtube.com/results?search_query=""$arg""&aq=f"
		save=1
		;;
	"n") # mynixos.org 
		uri="https://mynixos.com/search?q=""$arg"""
		save=1
		;;
    "b") # Brave Search
        uri="https://search.brave.com/search?q=$arg"
        save=1
        ;;
    "w") # Wiby 
        uri="https://wiby.me/?q=$arg"
        save=1
        ;;
    "a") # Anna's Archive
        uri="https://annas-archive.gl//search?q=$arg"
        save=1
        ;;
    "s") # SteamDB
        uri="https://steamdb.info/search/?a=all&q=$arg"
        save=1
        ;;

	"x") # delete
		@gnused@/bin/sed -i "\|$arg|d" "$bmarks"
		exit;
		;;
	*)
		uri="$sel"
		save=2
		;;
	esac
	# only set the uri; don't write to file
	[ "$save" -eq 0 ] && s_set_prop _SURF_GO "$uri"
	# set the url and write exactly what the user inputed to the file
	[ "$save" -eq 1 ] && (s_set_prop _SURF_GO "$uri"; s_write_f "$bmarks" "$sel")
	# try to set the uri only if it is a success
	[ "$save" -eq 2 ] && s_set_write_proper_uri "$uri"
	;;
*)
	echo Unknown @xprop@/bin/xprop
	;;
esac
