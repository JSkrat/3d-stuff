/*t = 0.01;
clearance = 0.2;
//*/

toy_engine_body_h = 25.5;
// all casing without the shaft
toy_engine_h = 29.25;
toy_engine_head_h = 1.75;
toy_engine_h_below = 29;
toy_engine_h_above = 14;
toy_engine_width = 19.9;
toy_engine_depth = 15;
module toy_engine(positive) {
    c = (positive)? 0: clearance;
    head_h = toy_engine_head_h + c;
    body_h = toy_engine_body_h + c*2;
    body_diameter = toy_engine_width + c*2;
    body_d = toy_engine_depth + c*2;
    shaft_diameter = 2 + c*2;
    shaft_h = 42 + c*3;
    tail_diameter = 9.75 + c*2;
    tail_cut_d = 0.95;
    tail_h = 2.5;
    contact_w = 16.5 + c*2;
    contact_d = 2+c;
    contact_h = 5.45 + c*2;
    mirror([0, 0, 1]) {
        // head part
        translate([0, 0, -head_h + t])
        cylinder(d = 5.95, h = head_h);
        // body
        translate([0, 0, 0]) {
            intersection() {
                cylinder(d = body_diameter, h = body_h);
                cube([body_diameter, body_d, body_h*2], center=true);
            }
        }
        // tail part
        translate([0, 0, body_h - t]) {
            difference() {
                cylinder(d = tail_diameter, h = tail_h);
                translate([-tail_diameter/2, tail_diameter/2-tail_cut_d, 0])
                cube([tail_diameter, tail_cut_d + t, tail_h + t]);
            }
        }
        // shaft
        color("silver")
        translate([0, 0, -11.75 - head_h])
        cylinder(d = shaft_diameter, h = shaft_h);
        // contacts
        color("#CCC")
        translate([-contact_w/2, -body_d/2 - contact_d + t, body_h - contact_h])
        cube([contact_w, contact_d + body_d/2, contact_h]);
    }
}

//toy_engine(false);