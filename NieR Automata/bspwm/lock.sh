#!/bin/bash

# Stop dunst
pkill -u $USER -USR1 dunst

scrot /tmp/screen.png
convert /tmp/screen.png -scale 5% -blur 0x4 -resize 2000% /tmp/screen.png

if [[ -f $HOME/Pictures/lock.png ]]
then
	convert /tmp/screen.png $HOME/Pictures/lock.png -composite /tmp/screen.png
fi

i3lock -e -n -i /tmp/screen.png \
	--insidevercolor=2e2e2e6f --insidewrongcolor=ff79687d --insidecolor=ffffff00 \
	--ringvercolor=b9b4aa8f --ringwrongcolor=cd89688f --ringcolor=ffffff00 \
	--line-uses-ring --keyhlcolor=c9c4baff --bshlcolor=ff7968ff \
	--separatorcolor=2e2e2edf --verifcolor=efefefff --wrongcolor=efefefff \
	--veriftext="verifying" --wrongtext="incorrect" --noinputtext="none"

pkill -u $USER -USR2 dunst

rm /tmp/screen.png
