#!/usr/bin/env bash

# ---------------- CONFIG ----------------
KITTY_CONF="$HOME/.config/kitty/kitty.conf"
KITTY_THEME_DIR="$HOME/.config/kitty/kitty-themes"

WAYBAR_CSS="$HOME/.config/waybar/style.css"
WAYBAR_COLOR_DIR="$HOME/.config/waybar/colors/"

SWAYNC_COLOR_DIR="$HOME/.config/swaync/colors/"

ROFI_COLOR_DIR="$HOME/.config/rofi/rofi-themes-collection/themes/"

dir="$HOME/.config/rofi/rofi-themes-collection/themes/"
theme='current'

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

# ---------------- APPLY SWAYNC----------------
ln -sf "$WAYBAR_COLOR_DIR/$selected.css" "$SWAYNC_COLOR_DIR/current.css"

# ---------------- APPLY WAYBAR ---------------
ln -sf "$WAYBAR_COLOR_DIR/$selected.css" "$WAYBAR_COLOR_DIR/current.css"

./.config/waybar/scripts/launch.sh

# ---------------- APPLY ROFI -----------------
ln -sf "$ROFI_COLOR_DIR/$selected.rasi" "$ROFI_COLOR_DIR/current.rasi"

# ---------------- SENDS NOTIFICATION ---------
notify-send "Theme changed" "$selected applied to Kitty, Waybar & Swaync"
