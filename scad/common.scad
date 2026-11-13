// cablemess: shared parameters (mm). Every part includes this file.
// Change a number here and every part follows; rebuild with ../build.sh.
$fn = 64;
eps = 0.01;

// --- trays (one cable each) -------------------------------------------------
page_t     = 20;    // stacking pitch: one tray, floor to floor
plate_t    = 3;     // tray floor
clear_z    = 0.8;   // air gap between trays (walls stop this short of the next floor)
tray       = 160;   // trays are square; 160 fits a 220 mm bed with room to spare
corner_r   = 12;

// --- spine ------------------------------------------------------------------
rod_d      = 8;     // M8 studding, cut to length: N * page_t + 8 (base) + ~55 (handle)
rod_fit    = 0.4;   // hole = rod_d + rod_fit
nut_af     = 13;    // M8 nut across flats
nut_t      = 6.8;   // M8 nut thickness (+ a little)
nut_fit    = 0.4;

// --- cable winding (three posts: peg, centre boss, peg, all the same diameter) --
boss_d     = 26;    // centre boss = tray spacer = the middle post
peg_d      = 26;
peg_dx     = 47;    // peg centres sit this far either side of the middle
cap_flare  = 6;     // cap is this much wider than the peg (45 degree cone, prints without support)
cap_cone   = 3;
cap_flat   = 1.2;

// --- connector holders (top/back edge) -----------------------------------------
holder_w   = 40;
holder_y   = 110;   // front of the holder block
holder_dx  = 30;    // holder centres sit this far either side of the middle
conn_w     = 22;    // pocket for the plug: USB-A/C, micro, HDMI. Test with the coupon.
neck_w     = 8;     // slot the cable leaves through

// --- length marker (front face) -------------------------------------------------
front_wall = 14;
pin_d      = 4;     // marker pin shaft
pin_fit    = 0.3;   // hole = pin_d + pin_fit
mark_x0    = 16;
mark_pitch = 8;
mark_n     = 12;    // 12 holes x 25 cm = up to 3 m
mark_cm    = 25;

module outline(s = tray, r = corner_r) offset(r = r) offset(delta = -r) square(s);
mid = tray / 2;
