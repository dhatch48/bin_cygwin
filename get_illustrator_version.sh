#!/bin/bash

for f in "$@"; do
    version=$(grep -ao '%%Creator: Adobe Illustrator(R) [0-9]\+' "$f" | cut -d' ' -f4)
    echo -e "v.$version\t$f"
done
