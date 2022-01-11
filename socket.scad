/*tolerance = 0.2;
t = 0.05;
wall = 3;
$fn=45;//*/
include <hardware.scad>;

module rounded_cube(w, d, h, r) {
    translate([0, r, 0])
    cube([w, d - r*2, h]);
    translate([r, 0, 0])
    cube([w - r*2, d, h]);
    for (x = [r, w - r], y = [r, d - r])
        translate([x, y, 0])
        cylinder(r = r, h = h);
}

module socket(positive) {
    // 220 power socket plus switch on spring clips
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


power_socket_hole_d = 40;
module power_socket(positive) {
    w1 = 30.6;
    w2 = 50 - 12;
    w3 = 26.7 + tolerance*2;
    d1 = 22;
    d2 = 18.4 + tolerance*2;
    screw_pos = [power_socket_hole_d/2, 0, 3];
    pin_pos = [
        [-7, 3],
        [0, -3],
        [7, 3],
    ];
    pin_w = 1.2;
    pin_d = 4.8;
    if (positive) {
        for (x = [-1, 1]) {
            translate([screw_pos.x*x, screw_pos.y, screw_pos.z])
            screw_25_10_h(true);
        }
    } else {
        translate([-w1/2, -d1/2, 0])
        rounded_cube(w1, d1, 4.5, 3.5);
        difference() {
            hull() {
                for (x = [-1, 1]) {
                    translate([w2/2*x, 0, 0])
                    cylinder(d = 12, h = 3);
                }
                translate([-w1/2, -d1/2, 0])
                rounded_cube(w1, d1, 3, 3.5);
            }
            for (x = [-1, 1]) {
                translate([screw_pos.x*x, screw_pos.y, screw_pos.z])
                screw_25_10_h(false);
            }
        }
        for (x = [-1, 1]) {
            translate([screw_pos.x*x, screw_pos.y, screw_pos.z])
            screw_25_10_h(false);
        }
        mirror([0, 0, 1]) {
            translate([-w3/2, -d2/2, 0])
            rounded_cube(w3, d2, 13.6 + tolerance, 3);
            for (pos = pin_pos) {
                translate([pos.x, pos.y, 13.6 + tolerance])
                color("silver")
                translate([-pin_w/2, -pin_d/2, 0])
                cube([pin_w, pin_d, 9 + tolerance]);
            }
        }
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

lamp_socket_w = 44;
lamp_socket_d = 83.5;
module lamp_socket(positive) {
    base_height = 41;
    corner_r = 11;
    if (positive) {
    } else {
        color("#333")
        translate([corner_r, corner_r, 0])
        hull() {
            for (x = [0, lamp_socket_w - corner_r*2], y = [0, lamp_socket_d - corner_r*2]) {
                translate([x, y, 0])
                cylinder(r = corner_r, h = base_height);
            }
        }
        // carbolite nut
        color("#333")
        translate([lamp_socket_w/2, lamp_socket_d/2, base_height])
        cylinder(d = 42.5, h = 13.5);
        // bolt holes
        hole_d = 6.1;
        color([1, 1, 1, 0.5]) {
            for (xy = [
                [5.6 + hole_d/2, 20 + hole_d/2], 
                [lamp_socket_w - 5.6 - hole_d/2, lamp_socket_d - 20 - hole_d/2]
            ]) {
                translate([xy.x, xy.y, -wall-t])
                cylinder(d = hole_d, h = wall + t*2);
            }
        }
    }
}

wago221_w = 13;
wago221_d = 18.1;
wago221_h = 8.1;
module wago221(positive) {
    w = wago221_w;
    d = wago221_d;
    outer_wall = 1.2;
    inner_wall = 0.8;
    hole_w = 4.9;
    hole_h = 4.1;
    flap_wall = 0.9;
    flap_w = 5.6;
    if (positive) {
    } else {
        translate([-tolerance, -tolerance, -tolerance])
        color([0.9, 0.9, 0.9, 0.7])
        difference() {
            cube([w + tolerance*2, d + tolerance*2, wago221_h + tolerance*2]);
            for (x = [outer_wall: hole_w + inner_wall: w - outer_wall]) {
                translate([x + tolerance*2, -t, 0.7 + tolerance*2])
                cube([hole_w - tolerance*2, wall, hole_h - tolerance*2]);
            }
        }
        color("orange")
        for (x = [flap_wall: flap_w + tolerance: w - flap_wall*2]) {
            translate([x - tolerance, -0.2 - tolerance, 7.2])
            difference() {
                cube([flap_w + tolerance*1, 14.7, 1 + tolerance]);
                translate([0.5, 7.9, -t])
                cube([4.6 + tolerance, 6.8 + t*2, 1 + t*2 + tolerance]);
            }
        }
    }
}

//wago221(false);
