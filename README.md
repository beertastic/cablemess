# cablemess

A portable, modular **cable archive** for the box of spare and obscure cables: a tower of flat trays on one central
rod, like a deck of cards you leaf through. Each tray holds **9 cables** in 9 equal lanes running front to back; the
middle lane bulges round the thin centre core. A cable lies coiled or stretched in its lane and its ends poke out through
pill-shaped holes in the front and back faces. Carry it by the T-handle; it stands in a cupboard or under a desk.

Status: **v3 design (9 open lanes per tray), nothing printed yet.** Print the coupon first and report back.

## Parts (STLs in `stl/`, pictures in `preview/`)

| Part | Count | Notes |
|:---|---:|:---|
| `coupon.stl` | 1 | **Print this first** (5 minutes). Finds the rod-hole and plug-slot sizes that fit your printer |
| `tray.stl` | 1 per 9 cables | 188 x 188 x 16 mm, 9 open lanes, no supports |
| `base.stl` | 1 | Foot with a hex pocket for the lower M8 nut. Print in PETG, it carries the load |
| `handle.stl` | 1 | T-handle with a hex pocket for the upper M8 nut. PETG, 100% infill on the stem |

Not printed: **M8 studding** (or an M8 bolt) cut to `trays x 16 + 8 + 60` mm, **two M8 nuts** (a wing nut on top
lets you tighten the stack for carrying), four rubber feet if you like.

## How it works

- The centre **boss** of each tray is the spacer and carries the rod, so the tower is as tall as you stack it: more
  trays, longer rod, nothing else changes.
- **Lanes:** 9 equal lanes per tray, 18.7 mm wide, open from the front face to the back face. The middle lane bends
  round the 16 mm core, so it suits shorter cables.
- **Elastic bands:** every divider has two small hooked posts (a 45 degree cap, no supports). Stretch a small elastic band
  or hair elastic from one post to the next across the lane, over the cable, to hold the coil down. `hook_at` sets where.
- **Cable ends:** a sideways pill-shaped hole (11 x 6.5 mm) in the front and back face of every lane lets the ends
  of a cable stick out. USB-C, micro and Lightning plugs pass through; USB-A and HDMI plugs stay in the lane.
  Label cables with tape or a cable tag.
- **Finding one:** swing the trays above round the rod and the lanes show.

## Look without printing

`docs/index.html` is a standalone 3D viewer of every part: download it and open it in a browser (needs internet
once, to load three.js). It shows the STLs as of its last rebuild, so `stl/` is the source of truth.

## Print settings (starting point)

PLA or PETG, 0.2 mm layers, 3 walls, 20% infill, no supports. Tray with the floor on the bed. Handle with the stem
up. Base with the nut pocket on the bed.

## Change it

Every dimension is a parameter at the top of `scad/common.scad`: tray size, pitch, lane count, hole size. Edit, then `./build.sh` rebuilds every STL and picture (OpenSCAD runs in a container, nothing to
install). Pictures come from `preview.py`, a small standard-library renderer, because the box has no GPU.

## Open questions for the first print

1. Does the stack turn freely with the nut snug, and hold still when carried?
2. Is the 11 x 6.5 mm hole right for your plugs? `neck_w`, `neck_h`.
3. How much cable does a lane hold at 12 mm height? Taller trays are one number (`page_t`).
4. Do both cable ends sit comfortably in the face holes?
