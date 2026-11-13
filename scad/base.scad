// Foot: the rod's lower nut sits in the hex pocket underneath.
include <common.scad>
base_t = 8;
difference() {
  translate([-5, -5, 0]) linear_extrude(base_t) outline(tray + 10, corner_r + 5);
  translate([mid, mid, -1]) cylinder(d = rod_d + rod_fit, h = base_t + 2);
  translate([mid, mid, -eps]) cylinder(d = nut_af / cos(30) + nut_fit, h = nut_t + eps, $fn = 6);
}
