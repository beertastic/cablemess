// T-handle: stem on the top tray's boss, grip bar above it, M8 nut in the pocket on top.
include <common.scad>
stem_h = 34;
bar_l = 130;
bar_w = 26;
bar_t = 16;
difference() {
  union() {
    cylinder(d = 26, h = stem_h);
    translate([0, 0, stem_h]) hull() {
      for (s = [-1, 1]) translate([s * (bar_l - bar_w) / 2, 0, 0]) cylinder(d = bar_w, h = bar_t);
    }
  }
  translate([0, 0, -1]) cylinder(d = rod_d + rod_fit, h = stem_h + bar_t + 2);
  translate([0, 0, stem_h + bar_t - nut_t]) cylinder(d = nut_af / cos(30) + nut_fit, h = nut_t + 1, $fn = 6);
}
