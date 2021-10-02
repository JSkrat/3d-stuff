/*t = 0.01;
clearance = 0.2;
//*/

module toy_engine(positive) {
    c = (positive)? 0: clearance;
    head_h = 1.75 + c;
    body_h = 25.5 + c*2;
    body_diameter = 19.9 + c*2;
    body_d = 15 + c*2;
    shaft_diameter = 2 + c*2;
    shaft_h = 42 + c*5;
    tail_diameter = 9.75 + c*2;
    tail_cut_d = 0.95;
    tail_h = 2.5 + c;
    contact_w = 16.5 + c*2;
    contact_d = 2+c;
    contact_h = 5.45 + c*2;
    mirror([0, 0, 1]) {
        // head part
        translate([0, 0, -head_h])
        cylinder(d = 5.95, h = head_h);
        // body
        translate([0, 0, 0]) {
            intersection() {
                cylinder(d = body_diameter, h = body_h);
                cube([body_diameter, body_d, body_h*2], center=true);
            }
        }
        // tail part
        translate([0, 0, body_h]) {
            difference() {
                cylinder(d = tail_diameter, h = tail_h);
                translate([-tail_diameter/2, tail_diameter/2-tail_cut_d, 0])
                cube([tail_diameter, tail_cut_d + t, tail_h + t]);
            }
        }
        // shaft
        translate([0, 0, -11.75 - head_h])
        cylinder(d = shaft_diameter, h = shaft_h);
        // contacts
        translate([-contact_w/2, -body_d/2 - contact_d, body_h - contact_h])
        cube([contact_w, contact_d, contact_h]);
    }
}

//toy_engine(false);