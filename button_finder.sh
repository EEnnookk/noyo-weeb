#!/bin/bash
dstartsAt=127
dendsAt=196
dx=700

rstartsAt=225
rendsAt=270
rx=435

step=2

mode=$1

[[ -z "$mode" ]] && {
    echo -e "Specify a mode\tr|d"
    exit 1
}
[[ "$mode" != 'r' && "$mode" != 'd' ]] && {
    echo -e "Invalid mode\tenter r|d"
    exit 1
}

if [[ "$mode" == 'r' ]]; then
    startAt=$rstartsAt
    endAt=$rendsAt
    x=$rx

elif [[ "$mode" == 'd' ]]; then
    startAt=$dstartsAt
    endAt=$dendsAt
    x=$dx
fi
sleep 2
mapfile -t colorArray < <(
    for ((i=startAt;i<endAt;i+=$step));do 
        ydotool mousemove -a -x $x -y $i.195
        hyprpicker -z --format=rgb --output-format='{0}{1}{2}' & sleep 0.1
        ydotool click 0xC0>/dev/null;wait;done)

for j in ${colorArray[@]}; do echo $j;done
echo -e "$step\n$startAt"