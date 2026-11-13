# cablemess

A portable, modular **cable archive** for the box of spare and obscure cables: a tower of flat trays on one central
rod, like a deck of cards you leaf through. Each tray holds **9 cables** in 9 equal lanes; the middle lane bulges round the thin centre core; each
cable is coiled flat in its lane with its plug in a pocket at the back, and a marker pin in the lane's front face says
how long or what type it is. Carry it by the T-handle; it stands in a cupboard or under a desk.

Status: **v2 design (9 cables per tray), nothing printed yet.** Print the coupon first and report back.

## Parts (STLs in `stl/`, pictures in `preview/`)

| Part | Count | Notes |
|:---|---:|:---|
| `coupon.stl` | 1 | **Print this first** (5 minutes). Finds the pin-hole, rod-hole and plug-slot sizes that fit your printer |
| `tray.stl` | 1 per 9 long cables | **Long-cable tray**, 188 x 188 x 16 mm. Both plugs in the pocket at the back, cable coiled in front of it |
| `tray_short.stl` | 1 per 9 short cables | **Short-cable tray**, same size. A plug pocket at each end of the lane, cable between. Mix both types in one tower |
| `base.stl` | 1 | Foot with a hex pocket for the lower M8 nut. Print in PETG, it carries the load |
| `handle.stl` | 1 | T-handle with a hex pocket for the upper M8 nut. PETG, 100% infill on the stem |
| `pin.stl` | 1 per cable | Marker for a lane. Print one colour per cable type |

Not printed: **M8 studding** (or an M8 bolt) cut to `trays x 16 + 8 + 60` mm, **two M8 nuts** (a wing nut on top
lets you tighten the stack for carrying), four rubber feet if you like.

## How it works

- The centre **boss** of each tray is the spacer and carries the rod, so the tower is as tall as you stack it: more
  trays, longer rod, nothing else changes.
- **Lanes:** 9 equal lanes per tray, 18.7 mm wide. Coil the cable flat in the lane (long tray: about 0.5-1 m of thin cable; short tray: about 0.5 m, plugs at both ends). The
  middle lane bends round the 16 mm core, so it suits shorter cables.
- **Plugs** drop into the pocket at the back of the lane; the cable passes through a pill-shaped hole (15 x 9 mm) in the
  cross wall. Pocket is 18.7 mm wide: fine for USB-A, USB-C, micro, Lightning, HDMI; wider plugs do not fit.
- **Marker:** a hole and a tape-label recess in the front face of each lane. A coloured pin = cable type or length.
- **Finding one:** swing the trays above round the rod and the lanes show.

## Print settings (starting point)

PLA or PETG, 0.2 mm layers, 3 walls, 20% infill, no supports. Tray with the floor on the bed. Handle with the stem
up. Base with the nut pocket on the bed.

## Change it

Every dimension is a parameter at the top of `scad/common.scad`: tray size, pitch, lane width, cross-wall position,
label size. Edit, then `./build.sh` rebuilds every STL and picture (OpenSCAD runs in a container, nothing to
install). Pictures come from `preview.py`, a small standard-library renderer, because the box has no GPU.

## Open questions for the first print

1. Does the stack turn freely with the nut snug, and hold still when carried?
2. Is the 16 mm pocket right for your plugs (USB-A, HDMI)? One number: `tray` (lane width follows).
3. How much cable does a lane hold at 12 mm height? Taller trays are one number (`page_t`).
4. Are the marker pins a firm push-fit, or loose?
