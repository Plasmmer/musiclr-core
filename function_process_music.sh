#!/bin/bash -e

if [ "$(jq -r '.items' musiclist.json)" = "null" ] || [ "$(jq -r '.items' musiclist.json)" = "" ]; then
   echo "Its your first time using player.sh!"
   echo "Initializing..."
   #touch musiclist.json
   #tmp="$(mktemp)"; cat musiclist.json | jq ". += {\"total\": \"\",\"items\": [{}]}" >"$tmp" && mv "$tmp" musiclist.json
   cat > musiclist.json << ENDOFFILE
{
	"total": "",
        "items": [{}]
}
ENDOFFILE
fi

process_music () {
echo "Function worked"
#tmp="$(find . -name '*.mp3' -type f -printf "%-.22T+ %p\n" | sort | cut -f 2- -d ' ')" #- credits: https://superuser.com/a/1416194/1619518
#echo "$tmp" > tmp.txt.tmp

loopmile="0"

#while IFS="" read -r p || [ -n "$p" ]
#do
#  cd ..
#  formated="${p%.*}"
#  echo "$formated"
#  tmp="$(mktemp)"; cat musiclist.json | jq ".items[] += {\"$loopmile\":\"$formated\"}" >"$tmp" && mv "$tmp" musiclist.json
#  #printf '%s\n' "$p"
#  loopmile="$(($loopmile + 1))"
#  echo "Loop: $loopmile"
#  cd "$currenttype"
#done < tmp.txt.tmp
#rm tmp.txt.tmp

#while IFS="" read -r p || [ -n "$p" ]
#do
#  cd ..
#  formated="${p%.*}"
#  echo "$formated"
#  tmp="$(mktemp)"; cat musiclist.json | jq ".items[] += {\"$loopmile\":\"$formated\"}" >"$tmp" && mv "$tmp" musiclist.json
#  #printf '%s\n' "$p"
#  loopmile="$(($loopmile + 1))"
#  echo "Loop: $loopmile"
#  cd "$currenttype"
#done < find . -name '*.mp3' -type f -printf "%-.22T+ %p\n" | sort | cut -f 2- -d ' '

find . -name '*.mp3' -type f -printf "%-.22T+ %p\n" | sort | cut -f 2- -d ' ' > tmp.txt.tmp

while IFS="" read -r p || [ -n "$p" ]
do
  cd ..
  formated="${p%.*}"
  echo "$formated"
  tmp="$(mktemp)"; cat musiclist.json | jq ".items[] += {\"$loopmile\":\"$formated\"}" >"$tmp" && mv "$tmp" musiclist.json
  #printf '%s\n' "$p"
  loopmile="$(($loopmile + 1))"
  echo "Loop: $loopmile"
  cd "$currenttype"
done < tmp.txt.tmp

cd ..
contents="$(jq ".total = \"$loopmile\"" musiclist.json)" && \
echo "${contents}" > musiclist.json
}
