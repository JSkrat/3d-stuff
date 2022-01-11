/*t = 0.01;
tolerance = 0.2;
wall = 1; 
$fn = 45; //*/
/// screw naming is
/// screw_diameter_length
/// diameter is in 1/10 mm, 
///   it is the outer diameter of a thread
/// length is in mm, 
///   it is a screw length for conical headed screw
///   or a length of a threaded part of a screw for non-conical headed screws
/// suffix _h means it has conical head, flat to the surface
///
/// bolt naming is
/// bolt_threadD_headD_headH
/// threadD is thread diameter, in mm (for M4 it is just 4)
/// headD is head diameter, in 1/10mm
/// headH is head height, in 1/10mm, from inner flat surface to the upper most part

module screw_40_15(positive) {
    if (positive) {
        color("#444")
        translate([0, 0, t])
        cylinder(d = 10, h = 17);
    } else {
        color("silver") {
            cylinder(d1 = 3.3, d2 = 3, h = 15);
            translate([0, 0, -t])
            cylinder(d1 = 5, d2 = 4, h = 2 + t);
            mirror([0, 0, 1])
            translate([0, 0, t])
            cylinder(d = 10.5, h = 2);
        }
    }
}

screw_25_10_h_bushing_d = 8;
screw_25_10_h_bushing_h = 11 - wall-tolerance*0;
module screw_25_10_h(positive) {
    if (positive) {
        mirror([0, 0, 1])
        color("#444")
        translate([0, 0, wall+tolerance*0])
        cylinder(d = screw_25_10_h_bushing_d, h = screw_25_10_h_bushing_h);
    } else {
        color("#DE8") {
            mirror([0, 0, 1]) {
                translate([0, 0, -t])
                cylinder(d1 = 4.8, d2 = 4.72, h = t*2);
                cylinder(d1 = 4.8, d2 = 2.8, h = 1.4 + t*2);
                translate([0, 0, 1.4])
                cylinder(d1 = 2.8, d2 = 2.0, h = 1.11);
                cylinder(h = 10, d = 1.5 + tolerance*2);        
            }
        }
    }
}

module bolt_M5_114_30(positive, length) {
    if (positive) {
    } else {
        color("silver") {
            mirror([0, 0, 1])
            translate([0, 0, -t])
            cylinder(d = 5 + tolerance*2, h = length + tolerance);
            cylinder(d = 11.4 + tolerance*2, h = 3 + tolerance);
        }
    }
}

// a single electrode from cheap 220 connector
// has a screw to connect a wire into it
module socket_pin_220(positive) {
    d = 4.5 + tolerance*2;
    if (positive) {
    } else {
        translate([0, 0, -19.7]) {
            // rounded tip
            translate([0, 0, 1.125])
            scale([1, 1, 0.5])
            sphere(d = d);
            // pin body
            translate([0, 0, 1.125])
            cylinder(d = d, h = 27.5 - 1.125 - 6.8);
            // wire socket
            difference() {
                translate([0, 0, 20.7])
                intersection() {
                    cylinder(d = 5.7 + tolerance*2, h = 6.8 + tolerance);
                    cube([4.7 + tolerance*2, 5.7 + tolerance*2+t*2, (6.8 + tolerance)*2], center=true);
                }
                translate([0, 0, 20.7])
                cylinder(d = 3.2, h = 6.8 + tolerance+t);
            }
            // screw
            translate([0, 0, 25.2])
            rotate(90, [1, 0, 0]) {
                cylinder(d = 2.7, h = 6.6);
                translate([0, 0, 4.7])
                cylinder(d = 5, h = 2.2);
            }
        }
    }
}

//socket_pin_220(false);
//screw_25_10_h(false);
//bolt_M5_114_30(false, 10);