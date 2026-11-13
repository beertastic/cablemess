#!/bin/bash
# Render every part to stl/ (OpenSCAD in a container: nothing to install) and a picture of each to preview/.
# The box's Docker daemon can't bind-mount this folder, so the sources go in as a tar stream and the STLs come back out.
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p stl preview
tar c scad | docker run -i --rm openscad/openscad:bookworm bash -c '
  mkdir -p /w/stl && cd /w && tar x
  for p in tray base handle pin coupon assembly; do openscad -q -o stl/$p.stl scad/$p.scad >&2; done
  tar c stl' | tar x
for p in tray base handle pin coupon assembly; do python3 -I preview.py stl/$p.stl preview/$p.png; done
ls stl preview
