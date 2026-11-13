// One tray holds 9 cables in 9 equal lanes. Each cable is coiled flat in its lane, its plug sits behind a cross
// wall (the cable passes through a pill-shaped hole), and the cable ends poke out through pill-shaped holes in the front and back faces.
// both_ends = false: LONG-cable tray, both plugs in the pocket at the back, cable coiled in front of it.
// both_ends = true:  SHORT-cable tray, a plug pocket at each end of the lane, cable stretched or coiled between.
// The middle lane has the rod core in it: its coil area bulges round the core, and the neighbouring lanes give way.
include <common.scad>
both_ends = false;
mix       = false;   // true: mixed tray, short-cable lanes (plug pockets at both ends) alternating with long-cable lanes

function is_both(i) = mix ? i % 2 == 0 : both_ends;
function coil_y0(i) = is_both(i) ? front_wall + pocket_d + lane_wall : front_wall;

wall_h = page_t - clear_z;
bulge_r = boss_d / 2 + core_gap;

function lane_x(i) = lane_wall + lane_p * i;

// one lane: coil area in front, plug pocket behind the cross wall, a pill-shaped hole between them
// y_from..y_to along the lane
module hole(x, y_from, y_to) translate([x + lane_w / 2, y_to, plate_t + neck_h / 2 + 0.6]) rotate([90, 0, 0])
  linear_extrude(y_to - y_from) offset(r = neck_r) square([neck_w - 2 * neck_r, max(neck_h - 2 * neck_r, 0.01)], center = true);

module lane(i) {
  x = lane_x(i);
  y0 = coil_y0(i);
  translate([x, y0, plate_t]) cube([lane_w, cross_y - y0, wall_h]);
  if (is_both(i)) {
    translate([x, front_wall, plate_t]) cube([lane_w, pocket_d, wall_h]);
    hole(x, front_wall + pocket_d - 1, front_wall + pocket_d + lane_wall + 1);
  }
  translate([x, cross_y + lane_wall, plate_t]) cube([lane_w, tray - back_wall - cross_y - lane_wall, wall_h]);
  hole(x, cross_y - 1, cross_y + lane_wall + 1);
  // pill-shaped holes through the front and back faces: the cable ends poke out of them
  hole(x, -1, front_wall + 1);
  hole(x, tray - back_wall - 1, tray + 1);
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
          translate([lane_x(core_lane), coil_y0(core_lane), plate_t]) cube([lane_w, cross_y - coil_y0(core_lane), wall_h]);
          translate([mid, mid, plate_t]) cylinder(r = bulge_r, h = wall_h);
        }
      }
      // the core: spaces the trays and carries the rod
      translate([mid, mid, 0]) cylinder(d = boss_d, h = page_t);
    }
    translate([mid, mid, -1]) cylinder(d = rod_d + rod_fit, h = page_t + 2);
  }
}

tray_part();
