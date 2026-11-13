// Picture of the whole tower (not printed). Trays are fanned out so you can see how they leaf.
include <common.scad>
n = 5;
base_t = 8;
color("slategray") translate([-5, -5, 0]) linear_extrude(base_t) outline(tray + 10, corner_r + 5);
for (k = [0 : n - 1])
  color(k % 2 ? "lightsteelblue" : "lightskyblue")
    translate([mid, mid, base_t + k * page_t]) rotate([0, 0, [0, 0, 28, 28, 70][k]])
      translate([-mid, -mid, 0]) import("../stl/tray.stl");
color("silver") translate([mid, mid, 0]) cylinder(d = rod_d, h = base_t + n * page_t + 60);
color("orange") translate([mid, mid, base_t + n * page_t]) import("../stl/handle.stl");
