// One tray holds 9 cables in 9 equal lanes that run the full depth of the tray. A cable lies coiled or stretched in its
// lane, held by small elastic bands hooked across it, and its ends poke out through the pill-shaped holes in the front and back faces.
// The middle lane has the rod core in it: its area bulges round the core, and the neighbouring lanes give way.
include <common.scad>

wall_h  = page_t - clear_z;
bulge_r = boss_d / 2 + core_gap;
lane_y0 = front_wall;
lane_y1 = tray - back_wall;

function lane_x(i) = lane_wall + lane_p * i;

// sideways pill (two circles side by side, joined), cut through a wall along y
module hole(x, y_from, y_to) translate([x + lane_w / 2, y_to, plate_t + neck_h / 2 + 0.6]) rotate([90, 0, 0])
  linear_extrude(y_to - y_from)
    offset(r = neck_r) square([neck_w - 2 * neck_r, max(neck_h - 2 * neck_r, 0.01)], center = true);

module lane(i) {
  x = lane_x(i);
  translate([x, lane_y0, plate_t]) cube([lane_w, lane_y1 - lane_y0, wall_h]);
  hole(x, -1, front_wall + 1);
  hole(x, lane_y1 - 1, tray + 1);
}

// band hooks on every divider (and inside the outer walls)
module hooks() {
  intersection() {
    linear_extrude(wall_h) outline();
    for (k = [0 : lanes_n], f = hook_at)
      translate([lane_x(k) - lane_wall / 2, lane_y0 + (lane_y1 - lane_y0) * f, 0]) {
        cylinder(d = hook_d, h = wall_h - hook_flare - 0.9);
        translate([0, 0, wall_h - hook_flare - 0.9]) cylinder(d1 = hook_d, d2 = hook_d + 2 * hook_flare, h = hook_flare);
        translate([0, 0, wall_h - 0.9]) cylinder(d = hook_d + 2 * hook_flare, h = 0.9);
      }
  }
}

module tray_part() {
  difference() {
    union() {
      linear_extrude(plate_t) outline();
      intersection() {
        linear_extrude(wall_h) outline();
        difference() {
          union() {
            difference() {
              cube([tray, tray, wall_h]);
              for (i = [0 : lanes_n - 1]) lane(i);
              translate([mid, mid, plate_t]) cylinder(r = bulge_r, h = wall_h);
            }
            // ring wall round the bulge keeps the neighbouring lanes separate
            translate([mid, mid, 0]) difference() {
              cylinder(r = bulge_r + lane_wall, h = wall_h);
              translate([0, 0, -1]) cylinder(r = bulge_r, h = wall_h + 2);
            }
          }
          // the core lane itself stays open through the ring
          translate([lane_x(core_lane), lane_y0, plate_t]) cube([lane_w, lane_y1 - lane_y0, wall_h]);
          translate([mid, mid, plate_t]) cylinder(r = bulge_r, h = wall_h);
        }
      }
      hooks();
      // the core: spaces the trays and carries the rod
      translate([mid, mid, 0]) cylinder(d = boss_d, h = page_t);
    }
    translate([mid, mid, -1]) cylinder(d = rod_d + rod_fit, h = page_t + 2);
  }
}

tray_part();
