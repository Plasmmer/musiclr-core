#!/bin/bash

# This is an example of choosing random elements of an array.


# Pick a music, any music.

#Music="Bad Romance
#Beat
#Halo
#Poker Face"

Music="$(cat music.txt)"

# Note variables spread over multiple lines.


music=($Music)                # Read into array variable.

num_musics=${#music[*]}        # Count how many elements.

#echo -n "${denomination[$((RANDOM%num_denominations))]} of "
#echo ${suite[$((RANDOM%num_suites))]}

echo ${music[$((RANDOM%num_musics))]}

exit 0
