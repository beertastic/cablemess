// Tolerance coupon: print this first. Find the pin hole, rod hole and plug pocket that fit YOUR printer
// and set pin_fit / rod_fit / conn_w in common.scad.
include <common.scad>
module label(t) text(t, size = 2.6, halign = "center");
difference() {
  cube([112, 74, 3]);
  for (i = [0 : 5]) {  // pin holes 4.0 .. 4.5
    translate([10 + i * 18, 62, -1]) cylinder(d = 4 + i * 0.1, h = 5);
    translate([10 + i * 18, 53, 2.4]) linear_extrude(1) label(str(4 + i * 0.1));
  }
  for (i = [0 : 5]) {  // rod holes 8.0 .. 8.5
    translate([10 + i * 18, 38, -1]) cylinder(d = 8 + i * 0.1, h = 5);
    translate([10 + i * 18, 28, 2.4]) linear_extrude(1) label(str(8 + i * 0.1));
  }
  for (i = [0 : 3]) {  // plug slots 20 .. 26 wide
    translate([6 + i * 26 + 1.5, 4, -1]) cube([20 + i * 2, 4, 5]);
    translate([6 + i * 26 + 11.5, 11, 2.4]) linear_extrude(1) label(str(20 + i * 2));
  }
}
