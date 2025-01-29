#!/bin/sh
echo -ne '\033c\033]0;Bubble Drop Godot 4\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Bubble Drop Godot 4.x86_64" "$@"
