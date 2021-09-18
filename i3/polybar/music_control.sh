#!/bin/env bash

player=$1
music=$1
pid=`pgrep -f 'polybar example'`
command="$0 $1"
configfile="/tmp/polybar_music_config"


music_status() {
    echo `playerctl --player=$player status 2>&1`
}


parse_arg() {
    if [ -f $configfile ]; then
        player=`cat $configfile | head -n 1`
    fi

    status=$(music_status)
    if [ "$status" = "No players found" ]; then
        player=`playerctl --list-all | head -n 1`
        if [ -z "$player" ]; then
            player=$music
        fi
    fi
}


music_print_status() {
    status=$(music_status)
    if [ "$status" = "Playing" ];
    then
        echo " "
    elif [ "$status" = "Paused" ];
    then
        echo " "
    else
        echo " "
    fi
}

music_play() {
    playerctl --player=$player play
}

music_pause() {
    playerctl --player=$player pause
}

music_stop() {
    playerctl --player=$player stop
}

music_next() {
    playerctl --player=$player next
}

music_previous() {
    playerctl --player=$player previous 
}

music_artist_title() {
    echo `playerctl --player=$player metadata --format "{{ title }} {{ artist }}" 2> /dev/null`
}

music_start() {
    players=`playerctl --list-all | grep $music | wc -l`
    if [ $players = 0 ]; then
        eval $music &
        player=$music
        sleep 1
        music_play
    fi
}

music_playpause() {
    playerctl --player=$player play-pause &> /dev/null
}

music_print() {
    info=$(music_artist_title)
    (( ${#info} > 14 )) && info="${info:0:11}..."
    info=`echo $info`
    status=$(music_print_status)
    s="$info %{A1:$command previous:}   %{A} $status  %{A1:$command next:}   %{A} " 
    player=`echo $player | cut -d'.' -f1 | cut -d'-' -f1`
    s="$s ${player^}"
    echo $s
}

music_shuffle() {
    playerctl --player=$player shuffle toggle
}

music_volume_up() {
    volume=0.05
    if [ $# -ge 1 ]; then
        volume=$1
    fi
    playerctl --player=$player volume $volume+
}

music_volume_down() {
    volume=0.05
    if [ $# -ge 1 ]; then
        volume=$1
    fi
    playerctl --player=$player volume $volume-
}

music_set_next_player() {
    echo $player
    num=`playerctl --list-all | wc -l`
    curr=`playerctl --list-all | grep -n $player | cut -d':' -f1`
    echo $num, $curr
    (( curr++ ))
    if [ $curr -gt $num ]; then
        curr=1
    fi
    player=`playerctl --list-all | head -$curr | tail -1`
    echo $player > $configfile
}

parse_arg $@

case "$2" in
    next)
        music_next
        ;;
    previous)
        music_previous
        ;;
    play)
        music_play
        ;;
    pause)
        music_pause
        ;;
    stop)
        music_stop
        ;;
    playpause)
        music_playpause
        ;;
    status)
        music_print_status
        ;;
    shuffle)
        music_shuffle
        ;;
    volume_up)
        music_volume_up 0.02
        ;;
    volume_down)
        music_volume_down 0.02
        ;;
    start)
        music_start
        ;;
    print)
        music_print
        ;;
    set_next)
        music_set_next_player
        ;;
    *)
        echo "Invalid argument"
        ;;
esac
