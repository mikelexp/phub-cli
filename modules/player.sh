#!/usr/bin/env bash

#spinner 
spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'

    while kill -0 "$pid" 2>/dev/null; do
        for i in $(seq 0 3); do
            printf "\r   %s Fetching stream... " "${spinstr:$i:1}" > /dev/tty
            sleep "$delay"
        done
    done
    printf "\r" > /dev/tty
}

play_video() {
    viewkey="$1"
    page_url="https://www.pornhub.com/view_video.php?viewkey=$viewkey"

    start_time=$(date +%s)

    #pre play
    clear

    messages=(
        "🔥 Preparing your video..."
        "💋 Unwrapping forbidden packets..."
        "💭 Please wait, lust takes time..."
        "😈 Negotiating with the content gods..."
        "📡 Tapping into the pleasure servers..."
        "🧠 Calibrating dopamine receptors..."
        "🍑 Warming up the pixels..."
        "🔓 Bypassing moral firewalls..."
        "💦 Hydrating the stream pipeline..."
        "📦 Extracting premium sensations..."
        "🕯 Lighting candles in the data center..."
        "🎥 Aligning sinful frames..."
    )
    pick1=${messages[RANDOM % ${#messages[@]}]}
    pick2=${messages[RANDOM % ${#messages[@]}]}
    pick3=${messages[RANDOM % ${#messages[@]}]}

    echo "" > /dev/tty
    echo "  $pick1" > /dev/tty
    sleep 0.3
    echo "  $pick2" > /dev/tty
    sleep 0.3
    echo "  $pick3" > /dev/tty
    echo "" > /dev/tty


    #bg
    (
        yt-dlp \
            --cookies-from-browser=firefox \
            -f "best[protocol=m3u8]/best" \
            --get-url \
            "$page_url" 2>/dev/null | head -n 1
    ) > /tmp/phub_stream.$$ &

    ytdlp_pid=$!

    #anim
    spinner "$ytdlp_pid"

    wait "$ytdlp_pid"
    stream_url=$(cat /tmp/phub_stream.$$)
    rm -f /tmp/phub_stream.$$

    #if failed
    if [ -z "$stream_url" ]; then
        echo "" > /dev/tty
        echo "  ❌ Failed to fetch stream." > /dev/tty
        echo "  😞 Video might be unavailable or restricted." > /dev/tty
        sleep 2
        return 1
    fi

    #final
    echo "" > /dev/tty
    echo "  ▶ Launching player..." > /dev/tty
    sleep 0.6

    #play
    mpv \
        --really-quiet \
        --no-ytdl \
        --profile=fast \
        --hwdec=auto \
        --cache=yes \
        --cache-secs=10 \
        "$stream_url"

    end_time=$(date +%s)
    duration=$((end_time - start_time))

    #failure
    [ "$duration" -lt 5 ] && return 1

    return 0
}
