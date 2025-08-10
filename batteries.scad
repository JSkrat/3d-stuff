/*t = 0.05;
clearance = 0.2;
wall = 1;
$fn = 45;
layer = 0.25;//*/
include <shapes.scad>;

module lipo_501240(for_difference) {
    c = (for_difference)? clearance: 0;
    translate([-c, -c, -c])
    color("yellow")
    cube([6+c, 12+c*2, 5+c*2]);
    translate([6-t, -c, -c])
    color("silver")
    cube([36.5+c+t, 12+c*2, 5+c*2]);
    // wires
    wire_d = 1;
    translate([wire_d/2, 0, wire_d/2+1.5])
    rotate(90, [1, 0, 0])
    color("black")
    cylinder(d = wire_d+c*2, h = 1);
    translate([wire_d/2, 0, wire_d/2+2.5])
    rotate(90, [1, 0, 0])
    color("red")
    cylinder(d = wire_d+c*2, h = 1);
}


module acc_18650(for_difference) {
    c = (for_difference)? clearance: 0;
    color("gray")
    translate([0, 0, -c])
    cylinder(d = 18.2+c*2, h = 55+c);
    color([0.2, 0.2, 0.2])
    translate([0, 0, 55])
    cylinder(d = 18.2+c*2, h = 9.8+c);
    color("silver")
    translate([0, 0, 64.8])
    cylinder(d = 7.8+c*2, h = 0.2+c);
}