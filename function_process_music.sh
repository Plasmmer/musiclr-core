#!/bin/bash -e

process_music () {
cd "$currenttype"

tmp="$(find . -name '*.mp3' -type f -printf "%-.22T+ %p\n" | sort | cut -f 2- -d ' ')" #- credits: https://superuser.com/a/1416194/1619518
echo "$tmp" > tmp.txt.tmp

loopmile="0"

while IFS="" read -r p || [ -n "$p" ]
do
  cd ..
  formated="${p%.*}"
  echo "$formated"
  tmp="$(mktemp)"; cat data.json | jq ".\"$currenttype\"[].items[] += {\"$loopmile\":\"$formated\"}" >"$tmp" && mv "$tmp" data.json
  #printf '%s\n' "$p"
  loopmile="$(($loopmile + 1))"
  echo "Loop: $loopmile"
  cd "$currenttype"
done < tmp.txt.tmp
rm tmp.txt.tmp

cd ..
contents="$(jq ".\"$currenttype\"[].total = \"$loopmile\"" data.json)" && \
echo "${contents}" > data.json
}
