/*tolerance = 0.2;
t = 0.05;
wall = 3;*/

module socket(positive) {
    w = 44.8 + tolerance*2;
    d = 19.5 + tolerance*2;
    h = 18.1 + tolerance;
    clip_d = 1.5; // for how much clip ticks out in released state
    clip_h = 1.5 - tolerance; // basically a wall thickness for a clip
    if (positive) {
    } else {
        color("#333")
        translate([-2 - tolerance, -2.32 - tolerance, -3 - tolerance])
        cube([49.06 + tolerance*2, 24.1 + tolerance*2, 3 + tolerance*2]);
        color("#444")
        translate([-tolerance, -tolerance, 0])
        cube([w, d, h]);
        // wall cutout for clips
        color([1, 1, 1, 0.25])
        translate([-clip_d, -clip_d, clip_h])
        cube([w + clip_d*2, d + clip_d*2, h - clip_h + t]);
    }
}


module fuse(positive) {
    if (positive) {
    } else {
        fuse_m_d = 14.8 + tolerance*2;
        color("#222") {
            translate([0, 0, -14])
            cylinder(d = 18, h = 14-t);
            
            intersection() {
                translate([0, 0, -t])
                cylinder(d = fuse_m_d, h = 11 + t);
                translate([0, 0, 11/2 - t/2])
                cube([12 + tolerance*2, fuse_m_d, 11 + t], center = true);
            }
            cylinder(d = 11, h = 30);
        }        
        color("silver")
        translate([0, 0, wall+t])
        cylinder(d = 20.5, h = 4.5, $fn=6);
    }
}

module socket_5v(positive) {
    sock_wall = 1.8;
    if (positive) {
    } else {
        translate([0, 0, -sock_wall]) {
            // cutout for connector
            color([1, 1, 1, 0.25])
            translate([0, 0, 2.2+1.2])
            cylinder(d = 11 + tolerance*4, h = 6);
            // upper part
            color("silver")
            translate([0, 0, -t])
            cylinder(d = 7.8 + tolerance*2, h = 5.6 + t);
            // nut
            color("silver")
            translate([0, 0, sock_wall])
            cylinder(d = 11, h = 2.2 + 1.2, $fn=6);
            // lower part
            mirror([0, 0, 1]) {
                color("silver")
                cylinder(d = 10.6 + tolerance*2, h = 2.1);
                color("#333")
                translate([0, 0, 2.1 - t])
                cylinder(d = 8.9, h = 8 + t);
                color("silver")
                translate([0, 0, 10.1])
                cylinder(d = 9, h = 8.5);
            }
        }
    }
}
