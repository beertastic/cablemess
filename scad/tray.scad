// One tray holds 8 cables, 4 lanes either side of the central spine (boss + rod). Each cable is coiled flat
// in its lane, its plug sits behind the cross wall (cable leaves through the neck), and a marker pin in the
// front face of the lane shows its length or type.
include <common.scad>

wall_h  = page_t - clear_z;
lane_p  = lane_w + lane_wall;
// x of the left edge of lane i (0..7, left to right)
function lane_x(i) = i < lanes_side
  ? lane_wall + lane_p * i
  : tray - lane_wall - lane_w - lane_p * (2 * lanes_side - 1 - i);

module tray_part() {
  difference() {
    union() {
      linear_extrude(plate_t) outline();
      intersection() {
        linear_extrude(wall_h) outline();
        difference() {
          cube([tray, tray, wall_h]);
          // lane cavities: coil area, then plug pocket behind the cross wall
          for (i = [0 : 2 * lanes_side - 1]) {
            translate([lane_x(i), front_wall, plate_t]) cube([lane_w, cross_y - front_wall, wall_h]);
            translate([lane_x(i), cross_y + lane_wall, plate_t]) cube([lane_w, tray - back_wall - cross_y - lane_wall, wall_h]);
            // neck: the cable passes through the cross wall
            // (U-shaped so both strands of a folded cable sit in it side by side)
            hull() {
              translate([lane_x(i) + lane_w / 2, cross_y - 1, plate_t + neck_w / 2]) rotate([-90, 0, 0]) cylinder(d = neck_w, h = lane_wall + 2);
              translate([lane_x(i) + (lane_w - neck_w) / 2, cross_y - 1, wall_h - eps]) cube([neck_w, lane_wall + 2, 2]);
            }
          }
        }
      }
      // centre boss: spaces the trays and carries the rod
      translate([mid, mid, 0]) cylinder(d = boss_d, h = page_t);
    }
    translate([mid, mid, -1]) cylinder(d = rod_d + rod_fit, h = page_t + 2);
    // marker hole and label recess on the front face of every lane
    for (i = [0 : 2 * lanes_side - 1]) {
      cx = lane_x(i) + lane_w / 2;
      translate([cx, -eps, 7]) rotate([-90, 0, 0]) cylinder(d = pin_d + pin_fit, h = front_wall - 2);
      translate([cx - label_w / 2, -eps, 10.6]) cube([label_w, 0.8 + eps, 3.4]);
    }
  }
}

tray_part();
