#!/bin/bash
scrot -s -e 'xclip -selection clipboard -t "image/png" < $f'
