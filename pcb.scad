/*t = 0.05;
tolerance = 0.2;
wall = 1;
$fn = 45;
layer = 0.25;//*/
include <shapes.scad>;

/// CJ-0802
/// https://arduino.ua/prod3850-plata-bloka-pitaniya-5v-2a
module board_5v(positive) {
    w = 64 + tolerance*2;
    d = 32.50 + tolerance*2;
    h = 1 + tolerance;
    glue_space = 3;
    support_l = 8;
    support_w = 0.8;
    // for the solder joints on the bottom side
    rise = 2;
    if (positive) {
        difference() {
            for (x = [0, w - support_l + glue_space], y = [0, d - support_l + glue_space]) {
                translate([x, y, 0])
                color("#443")
                cube([glue_space + support_l, glue_space + support_l, rise + h]);
            }
            color("#443")
            translate([glue_space + support_w, glue_space + support_w, -t])
            cube([w - support_w*2, d - support_w*2, rise + t*2]);
        }
    } else {
        translate([glue_space, glue_space, rise]) {
            color("#EEA")
            difference() {
                rounded_square_prism(w, d, h + tolerance, 3.5);
                translate([-t, 28.7, -t])
                cube([6.2 + t, 3.8 + tolerance*2 + t, h + tolerance + t*2]);
            }
            // markings
            color("black")
            translate([0, 0, h + tolerance])
            linear_extrude(t) {
                translate([6.5, 24.8])
                text("+  –", 4);
                translate([8.8, 1])
                text("LED", 2);
                translate([37.8, 28.5])
                text("N      L", 2);
                translate([34, 1])
                text("CJ-0802", 2);
            }
            // spacer for solder joints
            color([1, 1, 1, 0.5])
            translate([2.5, 0.8, -2])
            difference() {
                cube([w - 2.5 - 3, d - 0.8 - 0.5, 2+t]);
                translate([-t, 26, -t])
                cube([5.7, 6, 2 + t*2]);
            }
            // now some components
            translate([0, 0, h + tolerance]) {
                // transformer
                translate([19, 5, 0]) {
                    color("blue")
                    translate([4.5, 0, 0])
                    cube([4.7, 19.5, 18]);
                    color("#333")
                    translate([0, 3.2, 0])
                    cube([14.3, 13.3, 15.8]);
                }
                // hv cap
                color("#333")
                translate([51.5 + 5, 1.6 + 5, 0])
                cylinder(d = 10.1, h = 14);
                // lv cap
                color("#644")
                translate([3.5 + 4.1, 7 + 4.1, 0])
                cylinder(d = 8.2, h = 16.8);
                // led
                color("#6AE")
                translate([4.7 + 3.8/2, 1.6 + 3/2, 3.5])
                resize([3.8, 3, 6])
                cylinder(d1 = 3.8, d2 = 3.6, h = 6);
            }
        }
    }
}

module nanopi_neo_air(positive, c, mount_h = 0) {
    w = 40;
    l = 40;
    h = 1.2;
    corner_r = 2.0;
    mhole_offset = 2.2;
    mhole_d = 3.2;
    if (positive) {
        // mounts
        for (x = [mhole_offset, w-mhole_offset], y = [mhole_offset, l-mhole_offset]) {
            translate([x, y, -mount_h-6])
            cylinder(d1=10, d2=9, h = 6);
        }
    } else {
        // pcb
        difference() {
            union() {
                color("#269")
                rounded_square_prism(w, l, h, corner_r);
                intersection() {
                    for (x = [mhole_offset, w-mhole_offset], y = [mhole_offset, l-mhole_offset]) {
                        color("gold")
                        translate([x, y, -t])
                        cylinder(d=5, h=h+t*2);
                    }
                    translate([0, 0, -t])
                    rounded_square_prism(w, l, h+t*2, corner_r);
                }
            }
            for (x = [mhole_offset, w-mhole_offset], y = [mhole_offset, l-mhole_offset]) {
                translate([x, y, -t*2])
                cylinder(d=mhole_d, h = h+t*4);
            }
        }
        // mounts
        if (0 < mount_h) {
            nut_h = 2.5+c;
            for (x = [mhole_offset, w-mhole_offset], y = [mhole_offset, l-mhole_offset]) {
                translate([x, y, -mount_h]) {
                    color("#CCC")
                    cylinder(d = 6.5+c*2, h = mount_h, $fn=6);
                    color("#CCC")
                    translate([0, 0, -5+nut_h+layer])
                    cylinder(d = 3.5+c*2, h = 6);
                    // nut
                    color("#CCC")
                    translate([0, 0, -5])
                    cylinder(d = 6.5+c*2, h = nut_h, $fn=6);
                    // opening for nut
                    color([1, 1, 1, 0.5])
                    translate([0, 0, -5-wall])
                    cylinder(d = 6.5+c*2, h = wall+t, $fn=6);
                }
            }
        }
        // top chips
        // mcu
        translate([18.5, 8.8, h]) {
            color("#333")
            cube([14, 14, 1]);
            color("#555")
            translate([4.5, 4.5, 1])
            linear_extrude(t)
            text("H3", size=3);
        }
        // ram
        translate([19.7, 28, h])
        color("#333")
        cube([13.2, 7.5, 1]);
        // bottom parts
        mirror([0, 0, 1]) {
            // usb
            translate([5.8, 0, 0]) {
                color("silver")
                cube([7.5, 5.5, 2.25]);
                color("#333")
                translate([0.7, 1.754, 2.25])
                linear_extrude(t)
                //mirror([1, 0, 0])
                text("uUSB", size=1.8);
            }
            // video
            translate([18.1, 0, 0])
            color("#FFE")
            cube([16.4, 5.4, 2]);
            // antenna
            translate([7, 37.4, 0]) {
                color("gold")
                cube([3, 3.8, 2.25]);
            }
            // uSD
            translate([19, 25.5, 0]) {
                color("silver")
                cube([15, 14.5, 2]);
                color("#333")
                translate([0.6, 14.5, 1])
                cube([11, 2.6, 1]);
            }
        }
        // areas for parts
        color([1, 1, 1, 0.5]) {
            translate([5, 0.5, -2.5])
            cube([30, 39, 2.5+h+1.1]);
            translate([2.5, 6, -2.5])
            cube([2.5, 9, 2.5+h+1.1]);
        }
    }
}

module amplifier_pam8403() {
    c = clearance;
    translate([-c, -c, -c])
    color("green")
    cube([18.6+c*2, 21.6+c*2, 1.2+c]);
    // chip
    color("#333")
    translate([8-c, 7-c, 1.2])
    cube([4+c*2, 10+c*2, 1.5+c]);
    // other components
    color([1, 1, 1, 0.5])
    translate([1.6-c, 5-c, 1.2])
    cube([16.1+c*2, 12+c*2, 0.8+c]);
    // outputs
    color("white")
    translate([0, 18.6, 1.2])
    cube([18.6, 3, t]);
    // input
    color("gray")
    translate([0, 0, 1.2])
    cube([8, 2.54, t]);
    // power
    color("red")
    translate([13.2, 0, 1.2])
    cube([5.4, 2.54, t]);
}

//board_5v(false);
//nanopi_neo_air(false);