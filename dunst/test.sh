#!/usr/bin/env bash
title="lorem ipsum dolor sit amet"
body="Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
notify-send --urgency=low "Low: $title" "$body" -h int:value:100
notify-send --urgency=normal "Normal: $title" "$body" -h int:value:42
notify-send --urgency=critical "Critical: $title" "$body" -h int:value:5
