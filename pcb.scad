/*t = 0.05;
tolerance = 0.2;
wall = 1;
$fn = 45;//*/

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
                cube([w, d, h + tolerance]);
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
                cube([w - 2.5 - 3, d - 0.8 - 0.5, 2]);
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

//board_5v(false);
