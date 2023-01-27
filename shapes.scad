

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
    for (x = [r, w-r], y = [r, l-r], z = [r, h-r]) {
        translate([x, y, z])
        sphere(r=r);
    }
    for (x = [r, w-r], y = [r, l-r]) {
        translate([x, y, r])
        cylinder(r=r, h = h-r*2);
    }
    for (x = [r, w-r], z = [r, h-r]) {
        translate([x, r, z])
        rotate(-90, [1, 0, 0])
        cylinder(r=r, h=l-r*2);
    }
    for (y = [r, l-r], z = [r, h-r]) {
        translate([r, y, z])
        rotate(90, [0, 1, 0])
        cylinder(r=r, h=w-r*2);
    }
    // sides
    translate([0, r, r])
    cube([w, l-r*2, h-r*2]);
    translate([r, 0, r])
    cube([w-r*2, l, h-r*2]);
    translate([r, r, 0])
    cube([w-r*2, l-r*2, h]);
}
