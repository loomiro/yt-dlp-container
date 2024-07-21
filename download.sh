#!/bin/bash

DOWNLOAD_DIR="/app/download"

# Check parameter count
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <video|audio> <url>"
    exit 1
fi

TYPE=$1
URL=$2

# Check parameter values
if [[ "$TYPE" != "video" && "$TYPE" != "audio" ]]; then
    echo "Invalid type. Use 'video' or 'audio'."
    exit 1
fi

# Create Download Directory
mkdir -p "$DOWNLOAD_DIR"

# Download Media
if [ "$TYPE" == "video" ]; then
    yt-dlp --merge-output-format mkv \
           -f "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4] / bv*+ba/b" \
           --embed-thumbnail \
           --add-metadata \
           --all-subs \
           --embed-subs \
           -o "$DOWNLOAD_DIR/%(title)s.%(ext)s" \
           "$URL"
elif [ "$TYPE" == "audio" ]; then
    yt-dlp -f bestaudio \
           --extract-audio \
           --audio-format best \
           --audio-quality 0 \
           -o "$DOWNLOAD_DIR/%(title)s.%(ext)s" \
           "$URL"
fi
