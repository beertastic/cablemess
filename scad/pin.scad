// Length marker pin: push it into the hole under the length on the tray's front face. One colour per cable type.
include <common.scad>
cylinder(d = 7.5, h = 2);
cylinder(d = pin_d, h = 2 + front_wall - 4);
