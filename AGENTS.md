# cablemess: project notes

A 3D-printable, modular cable archive (a tower of trays on a rod, like leafing through cards). Made by the launchpad
(11-13 Nov 2026). No app, no container, no deploy: the product is the STL files, printed by Tris and friends. The
design is OpenSCAD in `scad/`, every dimension a parameter in `scad/common.scad`. `README.md` explains the design and
the first-print questions.

- Edit only this folder and the wiki page `~/web/homeLabDocs/cablemess.md` (commit by path, push,
  `./publish.py cablemess.md`, never bare).
- Rebuild with `./build.sh` (OpenSCAD in a container; the box's Docker daemon can't bind-mount folders, so sources are
  streamed in as tar and STLs streamed out). It also renders a picture of each part with `preview.py` into `preview/`:
  open the PNG with the Read tool to check a change. Commit `stl/` and `preview/` with the source so friends can download.
- Tris reports how prints fit; adjust the numbers in `common.scad` (`rod_fit`, `neck_w`, `neck_h`, `page_t`) rather
  than the geometry, then rebuild and push.
- Don't use `rm -rf` or shell patterns that delete (the harness holds them); use the Write/Edit tools.
- Push to GitHub as soon as a change is checked (the box's rule).
