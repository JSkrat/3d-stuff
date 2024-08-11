

module rounded_square_prism(w, l, h, r) {
    for (x = [r, w-r], y = [r, l-r]) {
        translate([x, y, 0])
        cylinder(r=r, h=h);
    }
    translate([r, 0, 0])
    cube([w-r*2, l, h]);
    translate([0, r, 0])
    cube([w, l-r*2, h]);
}

module rounded_square(w, l, h, r) {
    // corners
    min_size = [max(w, r*2), max(l, r*2), max(h, r*2)];
    module _rounded_square(size, r) {
        for (x = [r, size.x-r], y = [r, size.y-r], z = [r, size.z-r]) {
            translate([x, y, z])
            sphere(r=r);
        }
        for (x = [r, size.x-r], y = [r, size.y-r]) {
            translate([x, y, r])
            cylinder(r=r, h = size.z-r*2);
        }
        for (x = [r, size.x-r], z = [r, size.z-r]) {
            translate([x, r, z])
            rotate(-90, [1, 0, 0])
            cylinder(r=r, h=size.y-r*2);
        }
        for (y = [r, size.y-r], z = [r, size.z-r]) {
            translate([r, y, z])
            rotate(90, [0, 1, 0])
            cylinder(r=r, h=size.x-r*2);
        }
        // sides
        translate([0, r, r])
        cube([size.x, size.y-r*2, size.z-r*2]);
        translate([r, 0, r])
        cube([size.x-r*2, size.y, size.z-r*2]);
        translate([r, r, 0])
        cube([size.x-r*2, size.y-r*2, size.z]);
    }
    if (w >= r*2 && l >= r*2 && h >= r*2) _rounded_square(min_size, r);
    else resize([w, l, h]) _rounded_square(min_size, r);
}

module cube_print_sharp_corners(size, d, draw_body=false) {
    for (x = [0, size.x], y = [0, size.y]) {
        translate([x, y, 0])
        cylinder(d = d, h = size.z);
    }
    if (draw_body) {
        cube(size);
    }
}

module cube_print_negative_sharp_corners(size, r) {
    translate([-r, 0, 0])
    difference() {
        cube([size.x+r*2, size.y, size.z]);
        for (x = [0, size.x+r*2], y = [r*2, size.y-r*2]) {
            translate([x, y, 0]) cylinder(r=r, h = size.z);
        }
    }
}
/*$fn=30;
rounded_square(100, 100, 2.2, 2);
/*translate([110, 0, 0])
rounded_square(100, 100, 10, 2);//*/
