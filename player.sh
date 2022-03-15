#!/bin/bash -e

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

sudo apt install mpg321

if [ "$1" = "play" ]; then
   if [ "$2" = "folder" ]; then
      if [ "$3" = "--random" ]; then
         . "$SCRIPTPATH/./function_process_music.sh"
         process_music
         #paplay 
         mpg321 
fi
fi
fi
