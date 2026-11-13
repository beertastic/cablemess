// One tray holds 9 cables in 9 equal lanes. Each cable is coiled flat in its lane, its plug sits behind the cross
// wall (the cable passes through a pill-shaped hole), and a marker pin in the front face shows its length or type.
// The middle lane has the rod core in it: its coil area bulges round the core, and the neighbouring lanes give way.
include <common.scad>

wall_h = page_t - clear_z;
bulge_r = boss_d / 2 + core_gap;

function lane_x(i) = lane_wall + lane_p * i;

// one lane: coil area in front, plug pocket behind the cross wall, a pill-shaped hole between them
module lane(i) {
  x = lane_x(i);
  translate([x, front_wall, plate_t]) cube([lane_w, cross_y - front_wall, wall_h]);
  translate([x, cross_y + lane_wall, plate_t]) cube([lane_w, tray - back_wall - cross_y - lane_wall, wall_h]);
  translate([x + lane_w / 2, cross_y + lane_wall + 1, plate_t + neck_h / 2 + 0.6]) rotate([90, 0, 0])
    linear_extrude(lane_wall + 2) offset(r = neck_r) square([neck_w - 2 * neck_r, neck_h - 2 * neck_r], center = true);
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
          translate([lane_x(core_lane), front_wall, plate_t]) cube([lane_w, cross_y - front_wall, wall_h]);
          translate([mid, mid, plate_t]) cylinder(r = bulge_r, h = wall_h);
        }
      }
      // the core: spaces the trays and carries the rod
      translate([mid, mid, 0]) cylinder(d = boss_d, h = page_t);
    }
    translate([mid, mid, -1]) cylinder(d = rod_d + rod_fit, h = page_t + 2);
    // marker hole and label recess on the front face of every lane
    for (i = [0 : lanes_n - 1]) {
      cx = lane_x(i) + lane_w / 2;
      translate([cx, -eps, 7]) rotate([-90, 0, 0]) cylinder(d = pin_d + pin_fit, h = front_wall - 2);
      translate([cx - label_w / 2, -eps, 10.6]) cube([label_w, 0.8 + eps, 3.4]);
    }
  }
}

tray_part();
