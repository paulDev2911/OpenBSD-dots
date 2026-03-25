#!/bin/sh
xsetroot -solid black
xset b off

/bin/sh /home/user/.local/bin/barscript.sh | /usr/local/bin/lemonbar -B'#000000' -F'#aaaaaa' -f 'fixed' -g x20+0+0 -p &

exec cwm