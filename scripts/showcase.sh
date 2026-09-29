#!/usr/bin/env bash
# stitches the per-variant showcase screenshots into one composite image,
# same style as catppuccin's all-flavors picture.
#
# usage: scripts/showcase.sh [layout]
#   layout: composite (default, overlapping fanned stack), grid or row
#
# expects in assets/screenshots/:
#   veil-showcase.png obsidian-showcase.png jhujuba-showcase.png radiance-showcase.png
# all shots should be the same size (current: 2838x1554).
# order is deliberate: dark family first, radiance last (catppuccin mocha -> latte order).

set -euo pipefail
cd "$(dirname "$0")/.."

layout="${1:-composite}"
shots=assets/screenshots

for v in veil obsidian jhujuba radiance; do
  [ -f "$shots/$v-showcase.png" ] || { echo "missing $shots/$v-showcase.png"; exit 1; }
done

nix run nixpkgs#catwalk -- \
  "$shots/veil-showcase.png" \
  "$shots/obsidian-showcase.png" \
  "$shots/jhujuba-showcase.png" \
  "$shots/radiance-showcase.png" \
  --layout "$layout" \
  --output "$shots/all-showcase.png"

echo "ok: $shots/all-showcase.png ($layout)"
