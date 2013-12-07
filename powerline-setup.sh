#!/bin/bash

# SETS UP POWERLINE ON UBUNTU SYSTEMS

SCRIPT_SOURCE=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)

mkdir -p "$HOME"/.fonts
mkdir -p "$HOME"/.config/fontconfig/conf.d
ln -s "$SCRIPT_SOURCE"/powerline/font/PowerlineSymbols.otf "$HOME"/.fonts/PowerlineSymbols.otf
ln -s "$SCRIPT_SOURCE"/powerline/font/10-powerline-symbols.conf "$HOME"/.config/fontconfig/conf.d/10-powerline-symbols.conf

fc-cache -vf "$HOME"/.fonts

echo "DONE! If things don't work, kill all terminal sessions and try again."
