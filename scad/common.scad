// cablemess: shared parameters (mm). Every part includes this file.
// Change a number here and every part follows; rebuild with ../build.sh.
$fn = 64;
eps = 0.01;

// --- trays (8 cables each) ---------------------------------------------------
page_t     = 16;    // stacking pitch: one tray, floor to floor
plate_t    = 3;     // tray floor
clear_z    = 0.8;   // air gap between trays (walls stop this short of the next floor)
tray       = 176;   // trays are square; fits a 220 mm bed with room to spare
corner_r   = 12;

// --- spine ------------------------------------------------------------------
rod_d      = 8;     // M8 studding, cut to length: N * page_t + 8 (base) + ~55 (handle)
rod_fit    = 0.4;   // hole = rod_d + rod_fit
nut_af     = 13;    // M8 nut across flats
nut_t      = 6.8;   // M8 nut thickness (+ a little)
nut_fit    = 0.4;
boss_d     = 26;    // centre boss = tray spacer, carries the rod; sits in the spine between the two lane banks

// --- lanes: 8 per tray, 4 each side of the spine ------------------------------
lanes_side = 4;
lane_w     = 16;    // inside width of a lane = plug pocket width. Test with the coupon.
lane_wall  = 2;     // divider between lanes
front_wall = 14;    // front face: solid, so each lane has a marker hole and a label recess
cross_y    = 134;   // cross wall: the coil lies in front of it, the plug sits behind it
back_wall  = 4;
conn_w     = lane_w;  // coupon tests this
neck_w     = 8;     // slot the cable leaves through, in the cross wall

// --- length / colour marker (front face, one per lane) ----------------------------
pin_d      = 4;     // marker pin shaft
pin_fit    = 0.3;   // hole = pin_d + pin_fit
label_w    = 14;    // tape label recess per lane

module outline(s = tray, r = corner_r) offset(r = r) offset(delta = -r) square(s);
mid = tray / 2;
