#!/bin/env bash
ACTIVE_WINDOW_CLASS=$(hyprctl activewindow -j | jq -r ".class")

if [ "$ACTIVE_WINDOW_CLASS" != "com.mitchellh.ghostty" ]; then
  "$@"
fi
