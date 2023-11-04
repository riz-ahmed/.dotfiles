#!/bin/bash

# from Bugs-writers video https://www.youtube.com/watch?v=cHmJTD9Kt4o

qrencode -t PNG -s 8 -o /tmp/qrcode.png $(xclip -o -sel clip)
feh -Z /tmp/qrcode.png

# use zbarimg to read the contents of the image file
# package on pacman zbar
