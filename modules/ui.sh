#!/usr/bin/env bash

_fzf_menu() {
    local prompt="$1"
    fzf \
        --prompt="$prompt ❯ " \
        --height=100% \
        --border \
        --layout=reverse \
        --cycle \
        --delimiter="|" \
        --with-nth=2 \
        | awk -F'|' '{print $1}'
}

show_home() {
cat << "EOF"

   ██████╗ ██╗  ██╗██╗   ██╗██████╗        ██████╗ ██╗     ██╗
   ██╔══██╗██║  ██║██║   ██║██╔══██╗      ██╔════╝ ██║     ██║
   ██████╔╝███████║██║   ██║██████╔╝      ██║      ██║     ██║
   ██╔═══╝ ██╔══██║██║   ██║██╔══██╗      ██║      ██║     ██║
   ██║     ██║  ██║╚██████╔╝██████╔╝      ╚██████╔╝███████╗██║
   ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═════╝        ╚═════╝ ╚══════╝╚═╝

              terminal video browser
          lust-driven streaming experience

                   version v0.1.1

EOF
}




pre_play_menu() {
    local video_title="$1"
    local channel_name="$2"
    local prompt="Action"

    [ -n "$channel_name" ] && prompt="$prompt - $channel_name"
    [ -n "$video_title" ] && prompt="$prompt - $video_title"

    printf "%s\n" \
        "watch|Watch video" \
        "download|Download video" \
        "browser|Open in browser" \
        "back|Back to results" \
        "home|Back to home" \
        "quit|Quit" \
        | _fzf_menu "$prompt"
}

quality_menu() {
    local video_title="$1"
    local channel_name="$2"
    local prompt="Quality"

    [ -n "$channel_name" ] && prompt="$prompt - $channel_name"
    [ -n "$video_title" ] && prompt="$prompt - $video_title"

    printf "%s\n" \
        "1|Best quality (1080p+)" \
        "2|720p" \
        "3|480p" \
        "4|360p" \
        "back|Back" \
        "home|Back to home" \
        "quit|Quit" \
        | _fzf_menu "$prompt"
}

post_download_menu() {
    local video_title="$1"
    local channel_name="$2"
    local prompt="Download complete!"

    [ -n "$channel_name" ] && prompt="$prompt - $channel_name"
    [ -n "$video_title" ] && prompt="$prompt - $video_title"

    printf "%s\n" \
        "another|Download another quality" \
        "results|Back to results" \
        "home|Back to home" \
        "quit|Quit" \
        | _fzf_menu "$prompt"
}

