#!/bin/sh

xsetroot -solid black
xset b off

~/.local/bin/barscript.sh | lemonbar -B'#000000' -F'#aaaaaa' -f 'fixed' -g x20+0+0 -p &

exec cwm