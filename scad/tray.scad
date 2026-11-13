// One tray holds 8 cables, 4 lanes either side of the central spine (boss + rod). Each cable is coiled flat
// in its lane, its plug sits behind the cross wall (cable leaves through the neck), and a marker pin in the
// front face of the lane shows its length or type.
include <common.scad>

wall_h  = page_t - clear_z;
lane_p  = lane_w + lane_wall;
spine_x = lane_wall + lane_p * lanes_side;
spine_w = tray - 2 * spine_x;

// one lane: coil area in front, plug pocket behind the cross wall, a rounded-rectangle hole between them
// (two circles side by side, squared off) that the cable passes through
module lane(x, w, nw) {
  translate([x, front_wall, plate_t]) cube([w, cross_y - front_wall, wall_h]);
  translate([x, cross_y + lane_wall, plate_t]) cube([w, tray - back_wall - cross_y - lane_wall, wall_h]);
  translate([x + w / 2, cross_y + lane_wall + 1, plate_t + neck_h / 2 + 0.6]) rotate([90, 0, 0])
    linear_extrude(lane_wall + 2) offset(r = neck_r) square([nw - 2 * neck_r, neck_h - 2 * neck_r], center = true);
}

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
          for (i = [0 : 2 * lanes_side - 1])
            lane(lane_x(i), lane_w, neck_w);
          // the spine is a wide lane for short cables, coiled round the boss; both plugs share its pocket
          lane(spine_x, spine_w, spine_neck_w);
        }
      }
      // centre boss: spaces the trays and carries the rod
      translate([mid, mid, 0]) cylinder(d = boss_d, h = page_t);
    }
    translate([mid, mid, -1]) cylinder(d = rod_d + rod_fit, h = page_t + 2);
    // marker hole and label recess on the front face of every lane
    for (cx = concat([for (i = [0 : 2 * lanes_side - 1]) lane_x(i) + lane_w / 2], [mid])) {
      translate([cx, -eps, 7]) rotate([-90, 0, 0]) cylinder(d = pin_d + pin_fit, h = front_wall - 2);
      translate([cx - label_w / 2, -eps, 10.6]) cube([label_w, 0.8 + eps, 3.4]);
    }
  }
}

tray_part();
