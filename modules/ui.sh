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
    printf "%s\n" \
        "watch|Watch video" \
        "download|Download video" \
        "browser|Open in browser" \
        "back|Back to results" \
        | _fzf_menu "Action"
}

quality_menu() {
    printf "%s\n" \
        "1|Best quality (1080p+)" \
        "2|720p" \
        "3|480p" \
        "4|360p" \
        "back|Back" \
        | _fzf_menu "Quality"
}

post_download_menu() {
    printf "%s\n" \
        "another|Download another quality" \
        "results|Back to results" \
        "home|Back to home" \
        "quit|Quit" \
        | _fzf_menu "Download complete!"
}

