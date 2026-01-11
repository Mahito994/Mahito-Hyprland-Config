#!/usr/bin/env bash

# ---------------- CONFIG ----------------
KITTY_CONF="$HOME/.config/kitty/kitty.conf"
KITTY_THEME_DIR="$HOME/.config/kitty/kitty-themes"

WAYBAR_CSS="$HOME/.config/waybar/style.css"
WAYBAR_COLOR_DIR="$HOME/.config/waybar/colors/"

dir="$HOME/.config/rofi/rofi-themes-collection/themes/"
theme='AtomOneDark'

## Run
ROFI_CMD="rofi -dmenu -theme ${dir}/${theme}.rasi -i -p Theme "
# ----------------------------------------

# Get available themes from kitty theme directory
themes=$(ls "$KITTY_THEME_DIR" | sed 's/\.conf$//')

# Rofi selection
selected=$(echo "$themes" | $ROFI_CMD)

# Exit if nothing selected
[ -z "$selected" ] && exit 0

# ---------------- APPLY KITTY ----------------
sed -i \
  "s|^include .*kitty-themes/.*\.conf|include kitty-themes/$selected.conf|" \
  "$KITTY_CONF"

# Reload kitty
pkill -USR1 kitty

# ---------------- APPLY WAYBAR ---------------
ln -sf "$WAYBAR_COLOR_DIR/$selected.css" "$WAYBAR_COLOR_DIR/current.css"

./.config/waybar/scripts/launch.sh

# ---------------- SENDS NOTIFICATION ---------
notify-send "Theme changed" "$selected applied to Kitty & Waybar"
