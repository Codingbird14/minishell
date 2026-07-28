#!/bin/bash

# Usage:
# walset /path/to/wallpaper
if [ -z "$1" ]; then
	echo "Usage: walset <wallpaper>"
	exit 1
fi

wal=$(which wal)
pywalfox=$(which pywalfox)

# Generate pywal colors
wal -n -i "$1" --backend colorz --cols16 lighten
$HOME/.local/bin/pywalfox update
# Grab pywal accent color (color4 works well for folders)
HEX=$(sed -n '3p' ~/.cache/wal/colors | tr -d '#')

# RGB from pywal
R=$((16#${HEX:0:2}))
G=$((16#${HEX:2:2}))
B=$((16#${HEX:4:2}))

# Papirus preset colors
# name:R:G:B
COLORS=(
	"adwaita:147:149:152"
	"black:0:0:0"
	"blue:82:148:226"
	"bluegrey:96:125:139"
	"breeze:61:174:233"
	"brown:172:120:96"
	"carmine:150:0:24"
	"cyan:0:188:212"
	"darkcyan:0:131:143"
	"deeporange:255:87:34"
	"green:76:175:80"
	"grey:158:158:158"
	"indigo:63:81:181"
	"magenta:233:30:99"
	"nordic:143:188:187"
	"orange:255:152:0"
	"palebrown:188:170:164"
	"paleorange:255:204:128"
	"pink:255:105:180"
	"red:244:67:54"
	"teal:0:150:136"
	"violet:156:39:176"
	"white:255:255:255"
	"yaru:233:84:32"
	"yellow:255:235:59"
)

BEST_NAME="blue"
BEST_DISTANCE=999999999

for ENTRY in "${COLORS[@]}"; do
	IFS=':' read -r NAME CR CG CB <<<"$ENTRY"

	DR=$((R - CR))
	DG=$((G - CG))
	DB=$((B - CB))

	# Euclidean RGB distance
	DIST=$((DR * DR + DG * DG + DB * DB))

	if [ "$DIST" -lt "$BEST_DISTANCE" ]; then
		BEST_DISTANCE=$DIST
		BEST_NAME=$NAME
	fi
done
echo "Pywal accent: #$HEX"
echo "Closest Papirus color: $BEST_NAME"

$HOME/.local/bin/papirus-folders -C "$BEST_NAME" -t "Papirus-Dark" >"$HOME/walset_debug.log"
# Force the system icon cache to rebuild right now
gtk-update-icon-cache -f -t ~/.local/share/icons/Papirus-Dark/ &>/dev/null
gtk-update-icon-cache -f -t /usr/share/icons/Papirus-Dark/ &>/dev/null

# Force GTK apps to instantly redraw their assets by quickly toggling the theme
CURRENT_THEME=$(gsettings get org.gnome.desktop.interface icon-theme | tr -d "'")
# gsettings set org.gnome.desktop.interface icon-theme "Adwaita"
gsettings set org.gnome.desktop.interface icon-theme "$CURRENT_THEME"

theme=$(gsettings get org.gnome.desktop.interface gtk-theme) && gsettings set org.gnome.desktop.interface gtk-theme '' && sleep 0.5 && gsettings set org.gnome.desktop.interface gtk-theme "$theme"
