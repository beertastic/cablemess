# cablemess

A portable, modular **cable archive** for the box of spare and obscure cables: a tower of flat trays on one central
rod, like a deck of cards you leaf through. Each tray holds one cable folded in half and wound round three posts, both
plugs sit in holders at the back, and a marker pin in the front face says how long the cable is, so you can read the
whole stack without opening it. Carry it by the T-handle; it stands in a cupboard or under a desk.

Status: **v1 design, nothing printed yet.** Print the coupon first and report back.

## Parts (STLs in `stl/`, pictures in `preview/`)

| Part | Count | Notes |
|:---|---:|:---|
| `coupon.stl` | 1 | **Print this first** (5 minutes). Finds the pin-hole, rod-hole and plug-slot sizes that fit your printer |
| `tray.stl` | 1 per cable | 160 x 160 x 20 mm. Fits a 220 mm bed, no supports |
| `base.stl` | 1 | Foot with a hex pocket for the lower M8 nut. Print in PETG, it carries the load |
| `handle.stl` | 1 | T-handle with a hex pocket for the upper M8 nut. PETG, 100% infill on the stem |
| `pin.stl` | 1 per tray | Length marker. Print one colour per cable type |

Not printed: **M8 studding** (or an M8 bolt) cut to `trays x 20 + 8 + 60` mm, **two M8 nuts** (a wing nut on top
lets you tighten the stack for carrying), four rubber feet if you like.

## How it works

- The centre **boss** of each tray is the spacer and carries the rod, so the tower is as tall as you stack it: more
  trays, longer rod, nothing else changes.
- **Winding:** fold the cable in half, hold the fold against the front-left peg, and wind both strands round the
  peg, the centre boss and the right peg. The 45 degree caps keep it on. Leave the plugs free.
- **Plugs** drop into the two pockets at the back, the cable leaves through the slot in the pocket's front wall.
- **Length:** a hole every 25 cm along the front face (1 m, 2 m and 3 m are engraved). Push the pin in under the
  cable's length, rounded up. A sticker recess beside the holes takes a tape label (the cable type).
- **Finding one:** swing the trays above it round the rod and the plugs show. The front face reads like a book's
  spine: pin position is the length, label is the type.

## Print settings (starting point)

PLA or PETG, 0.2 mm layers, 3 walls, 20% infill, no supports. Tray with the floor on the bed. Handle with the stem
up. Base with the nut pocket on the bed.

## Change it

Every dimension is a parameter at the top of `scad/common.scad`: tray size, pitch, peg spacing, plug pocket width,
marker spacing. Edit, then `./build.sh` rebuilds every STL and picture (OpenSCAD runs in a container, nothing to
install). Pictures come from `preview.py`, a small standard-library renderer, because the box has no GPU.

## Open questions for the first print

1. Does the stack turn freely with the nut snug, and hold still when carried?
2. Is the plug pocket (22 mm) right for USB-A, USB-C, HDMI? Thicker plugs (power, DisplayPort) may need a wider one.
3. Does a 2 m cable fit three posts and 12 mm of height? Taller trays are one number (`page_t`).
4. Are the marker pins a firm push-fit, or loose?
