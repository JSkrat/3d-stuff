/*tolerance = 0.2;
t = 0.05;
wall = 3;//*/

t120_w = 26.2;
t120_d = 34.4;
module t120(positive) {
    l_w = 21.5;
    l_d = 32;
    h_w = t120_w;
    h_d = t120_d;
    if (positive) {
    } else {
        // bottom part
        mirror([0, 0, 1]) {
            color("#333")
            cube([l_w + tolerance*2, l_d + tolerance*2, 28.5]);
        }
        // top part
        color("#333")
        translate([l_w/2 - h_w/2 + tolerance, l_d/2 - h_d/2 + tolerance, -t])
        cube([h_w, h_d, 2]);
    }
}
