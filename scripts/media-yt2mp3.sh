#!/usr/bin/env -S pkgx +gum +yt-dlp +jq bash -e
# shellcheck shell=bash

set -o pipefail

# we accept either a full youtube URL, or just the video ID
if [[ $1 =~ ^https?:// ]]; then
    url="$1"
else
    url="https://www.youtube.com/watch?v=$1"
fi

# extract the title
title=$(yt-dlp "$url" --dump-json | jq -r '.title')

# fetch and convert
gum spin --title "Downloading audio..." -- yt-dlp --extract-audio --audio-format mp3 --audio-quality 0 "$url" -o "%(title)s.%(ext)s"

# announce success
gum style --foreground 2 --bold "Download complete! Audio saved as ${title}.mp3"