#!/bin/env bash

player=$1
music=$1
pid=`pgrep -f 'polybar example'`
module=""
hook=
command="$0 $1"

PLAYING=0
PAUSED=1
STOPPED=2
NOT_FOUND=3

PLAYING_STR=" "
PAUSED_STR=" "
STOPPED_STR=" "


music_status() {
    status=`playerctl --player=$1 status 2>&1`
    if [ "$status" = "Playing" ];
    then
        echo $PLAYING
    elif [ "$status" = "Paused" ];
    then
        echo $PAUSED
    elif [ "$status" = "Stopped" ];
    then
        echo $STOPPED
    else
        echo $NOT_FOUND
    fi
}

parse_arg() {
    if [ "$#" -ge 4 ]; then
        module=$3
        hook=$4
    fi

    status=$(music_status)

    if [ "$status" = "No players found" ]; then
        player=`playerctl --list-all | head -n 1`
    fi
}


music_print_status() {
    status=$(music_status) $1
    case "$status" in
        $PLAYING)
            echo $STOPPED_STR
            ;;
        $STOPPED)
            echo $PLAYING_STR
            ;;
        *)
            echo $STOPPED_STR
            ;;
    esac
}

music_play() {
    playerctl --player=$1 play
}

music_pause() {
    playerctl --player=$1 pause
}

music_stop() {
    playerctl --player=$1 stop
}

music_next() {
    playerctl --player=$1 next
}

music_previous() {
    playerctl --player=$1 previous 
}

music_artist_title() {
    echo `playerctl --player=$player metadata --format "{{ title }} {{ artist }}" 2> /dev/null`
}

music_start() {
    players=`playerctl --list-all | grep $1 | wc -l`
    if [ $players = 0 ]; then
        eval $1 &
        player=$1
        sleep 1
        music_play $1
    fi
}

music_playpause() {
    playerctl --player=$1 play-pause &> /dev/null
}

music_print() {
    info=$(music_artist_title) $1
    (( ${#info} > 14 )) && info="${info:0:11}..."
    info=`echo $info`
    status=$(music_print_status) $1
    s="$info %{A1:$command previous:}   %{A} $status  %{A1:$command next:}   %{A} " 
    echo $s
}

music_shuffle() {
    playerctl --player=$1 shuffle toggle
}

music_volume_up() {
    volume=0.05
    if [ $# -ge 2 ]; then
        volume=$2
    fi
    playerctl --player=$1 volume $volume+
}

music_volume_down() {
    volume=0.05
    if [ $# -ge 2 ]; then
        volume=$2
    fi
    playerctl --player=$1 volume $volume-
}

music_loop() {
    if [ -e /tmp/music_control_loop ];
        rm /tmp/music_control_loop
    fi

    mkfifo /tmp/music_control_loop

    while true;  do
        # read -t 0.5 line < /tmp/music_control_loop;
        read -t 1 line 
        if [ -n $line ]; then
            case "$line" in
                next)
                    music_next $1
                    ;;
                previous)
                    music_previous $1
                    ;;
                play)
                    music_play $1
                    ;;
                pause)
                    music_pause $1
                    ;;
                stop)
                    music_stop $1
                    ;;
                playpause)
                    music_playpause $1
                    ;;
                status)
                    music_print_status $1
                    ;;
                shuffle)
                    music_shuffle $1
                    ;;
                volume_up)
                    music_volume_up $1 0.02
                    ;;
                volume_down)
                    music_volume_down $1 0.02
                    ;;
                start)
                    music_start $1
                    ;;
            esac
        fi
    done <> /tmp/music_control_loop
}

parse_arg $@

case "$2" in
    next)
        music_next $1
        ;;
    previous)
        music_previous $1
        ;;
    play)
        music_play $1
        ;;
    pause)
        music_pause $1
        ;;
    stop)
        music_stop $1
        ;;
    playpause)
        music_playpause $1
        ;;
    status)
        music_print_status $1
        ;;
    shuffle)
        music_shuffle $1
        ;;
    volume_up)
        music_volume_up $1 0.02
        ;;
    volume_down)
        music_volume_down $1 0.02
        ;;
    start)
        music_start $1
        ;;
    print)
        music_print $1
        ;;
    loop)
        music_loop $1
        ;;
    *)
        echo "Invalid argument"
        ;;
esac
