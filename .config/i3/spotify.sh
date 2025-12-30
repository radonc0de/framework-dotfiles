#!/bin/bash

song=$(playerctl -p spotify metadata title | head -c 50)
artist=$(playerctl -p spotify metadata artist | head -c 50)

if [[ -n "$song" && -n "$artist" ]]; then
  echo "♫ $song by $artist ♫"
else
  echo ""
fi
