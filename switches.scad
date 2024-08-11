/*$fn = 45;
tolerance = 0.2;
clearance = tolerance;
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

module hss12f15g6(for_difference) {
    c = (for_difference)? clearance: 0;
    body_size = [11.4, 5.6, 5.1];
    mount_w = 19.5;
    translate([-2.25, -body_size.y/2, -0.5]) {
        // mount
        color([0.3, 0.3, 0.3])
        difference() {
            translate([0-c, 0.5-c, 0-c])
            cube([mount_w+c*2, 4.6+c*2, 0.5+c*2]);
            for (x = [2.25, 17.25]) {
                translate([x, body_size.y/2, -t-c])
                cylinder(d = 2.2-c*2, h = 0.5+t*2+c*2);
            }
        }
        // body
        color([0.3, 0.3, 0.3])
        translate([8.1/2-c, 0-c, -body_size.z+0.5-c])
        cube([body_size.x+c*2, body_size.y+c*2, body_size.z+c*2]);
        // switch
        color([1, 1, 1, 0.5])
        translate([6.6-c, body_size.y/2 - 3/2-c, 0])
        cube([6.3+c*2, 3+c*2, 6.1+c]);
        color([0.2, 0.2, 0.2])
        translate([6.6-t-c, body_size.y/2 - 3/2-t-c, 0])
        cube([3.1+t*2+c*2, 3+t*2+c*2, 6.1+t+c]);
    }
    // legs
    leg_size = [1.5, 0.5, 3.1];
    color("silver")
    for (x = [4.5, 7.5, 10.5]) {
        translate([x-leg_size.x/2-c, -leg_size.y/2-c, -body_size.z-leg_size.z-c])
        difference() {
            cube([leg_size.x+c*2, leg_size.y+c*2, leg_size.z+c]);
            translate([leg_size.x/2+c, -t, leg_size.z-1.9])
            rotate(-90, [1, 0, 0])
            cylinder(d = 1-c*2, h = leg_size.y+t*2+c*2);
        }
    }
}

//hss12f15g6(false); translate([0, 10, 0]) hss12f15g6(true); 