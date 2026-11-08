#!/bin/bash
dstartsAt=145
dendsAt=195
dx=700

#rstartsAt=200
#rendsAt=250
rstartsAt=250
rendsAt=350
rx=435

step=2

mode=$1
diff=$2
[[ -z "$mode" || -z "$diff" ]] && {
    echo -e "Specify a mode\tr|d\nSpecify a diff value\t[int]"
    exit 1
}

[[ "$mode" != 'r' && "$mode" != 'd' ]] && {
    echo -e "Invalid mode\tenter r|d"
    exit 1
}

if [[ "$mode" == 'r' ]]; then
    startAt=$((rstartsAt+10*diff))
    endAt=$((rendsAt+10*diff))
    x=$rx

elif [[ "$mode" == 'd' ]]; then
    startAt=$((dstartsAt+10*diff))
    endAt=$((dendsAt+10*diff))
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