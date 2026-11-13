// One tray: the cable is folded in half and wound round the three posts (peg, centre boss, peg),
// both plugs sit in the holders at the back, and a marker pin in the front face says how long it is.
include <common.scad>

wall_h = page_t - clear_z;

module tray_part() {
  difference() {
    union() {
      linear_extrude(plate_t) outline();
      intersection() {
        linear_extrude(page_t) outline();
        union() {
          // front wall: the face you read in the closed stack, solid so the marker holes have somewhere to go
          cube([tray, front_wall, wall_h]);
          // holder blocks
          for (s = [-1, 1]) translate([mid + s * holder_dx - holder_w / 2, holder_y, 0])
            cube([holder_w, tray - holder_y, wall_h]);
        }
      }
      // centre boss: spaces the trays and carries the rod
      translate([mid, mid, 0]) cylinder(d = boss_d, h = page_t);
      // pegs with 45 degree caps
      for (s = [-1, 1]) translate([mid + s * peg_dx, mid, 0]) {
        cylinder(d = peg_d, h = wall_h);
        translate([0, 0, wall_h - cap_flat - cap_cone])
          cylinder(d1 = peg_d, d2 = peg_d + 2 * cap_flare, h = cap_cone);
        translate([0, 0, wall_h - cap_flat]) cylinder(d = peg_d + 2 * cap_flare, h = cap_flat);
      }
    }
    // rod
    translate([mid, mid, -1]) cylinder(d = rod_d + rod_fit, h = page_t + 2);
    // plug pockets and cable slots
    for (s = [-1, 1]) {
      translate([mid + s * holder_dx - conn_w / 2, holder_y + 9, plate_t]) cube([conn_w, tray, page_t]);
      translate([mid + s * holder_dx - neck_w / 2, holder_y - 2, plate_t]) cube([neck_w, 14, page_t]);
    }
    // marker holes and 1 m / 2 m / 3 m numbers on the front face
    for (i = [0 : mark_n - 1]) {
      x = mark_x0 + i * mark_pitch;
      translate([x, -eps, 8]) rotate([-90, 0, 0]) cylinder(d = pin_d + pin_fit, h = front_wall - 2);
      if ((i + 1) * mark_cm % 100 == 0)
        translate([x, 0.6, 13.2]) rotate([90, 0, 0]) linear_extrude(0.7)
          text(str((i + 1) * mark_cm / 100, "m"), size = 3.2, halign = "center");
    }
    // sticker recess for a tape label (cable type)
    translate([110, -eps, 3]) cube([34, 0.8 + eps, 13]);
  }
}

tray_part();
