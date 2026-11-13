// cablemess: shared parameters (mm). Every part includes this file.
// Change a number here and every part follows; rebuild with ../build.sh.
$fn = 64;
eps = 0.01;

// --- trays (8 cables each) ---------------------------------------------------
page_t     = 16;    // stacking pitch: one tray, floor to floor
plate_t    = 3;     // tray floor
clear_z    = 0.8;   // air gap between trays (walls stop this short of the next floor)
tray       = 188;   // trays are square; fits a 220 mm bed with room to spare
corner_r   = 12;

// --- spine ------------------------------------------------------------------
rod_d      = 8;     // M8 studding, cut to length: N * page_t + 8 (base) + ~55 (handle)
rod_fit    = 0.4;   // hole = rod_d + rod_fit
nut_af     = 13;    // M8 nut across flats
nut_t      = 6.8;   // M8 nut thickness (+ a little)
nut_fit    = 0.4;
boss_d     = 16;    // centre core of each tray = spacer, carries the rod (rod hole + 3.8 mm wall)

// --- lanes: 9 equal lanes across the tray, the middle one bends round the core ------
lanes_n    = 9;
lane_wall  = 2;     // divider between lanes
lane_w     = (tray - lane_wall * (lanes_n + 1)) / lanes_n;   // inside width: the same for every lane (18.7 at tray 188)
lane_p     = lane_w + lane_wall;
core_lane  = (lanes_n - 1) / 2;   // the lane the core sits in
core_gap   = 3;     // cable room all round the core, inside its lane's bulge
back_wall  = 4;
front_wall = 4;     // front face; every lane has a pill-shaped hole through it (and through the back wall)
conn_w     = lane_w;  // coupon tests this

// cable hole through the cross wall: a sideways pill (two circles side by side, joined)
neck_w     = 11;
neck_h     = 6.5;
neck_r     = neck_h / 2;

module outline(s = tray, r = corner_r) offset(r = r) offset(delta = -r) square(s);
mid = tray / 2;
