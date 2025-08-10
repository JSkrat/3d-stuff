/*t = 0.05;
clearance = 0.2;
wall = 1;
$fn = 45;
layer = 0.25;//*/
include <shapes.scad>;

/// CJ-0802
/// https://arduino.ua/prod3850-plata-bloka-pitaniya-5v-2a
module board_5v(positive) {
    w = 64 + clearance*2;
    d = 32.50 + clearance*2;
    h = 1 + clearance;
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
                rounded_square_prism(w, d, h + clearance, 3.5);
                translate([-t, 28.7, -t])
                cube([6.2 + t, 3.8 + clearance*2 + t, h + clearance + t*2]);
            }
            // markings
            color("black")
            translate([0, 0, h + clearance])
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
            translate([0, 0, h + clearance]) {
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

led_stripe_60_l = 10;
led_stripe_60_w = 50;
// led+pcb height
led_stripe_60_h = 1.5;
led_stripe_60_pcb_h = 0.25;
module led_stripe_60(sections, real) {
    c = (real)? 0: clearance;
    // 60 leds per meter, 3 leds per section
    leds_per_section = 3;
    pcb_h = led_stripe_60_pcb_h;
    pcb_l = led_stripe_60_l + c*2;
    pcb_w = led_stripe_60_w;
    solder_h = 1.0;
    for (section = [0:sections-1]) {
        translate([pcb_w*section, 0, 0]) {
            // pcb
            color("#EEE")
            cube([pcb_w, pcb_l, pcb_h]);
            // contacts
            contact_l = 1.8;
            contact_y_offset = 0.2;
            color("gold")
            for (i = [0:3]) {
                translate([0, i*2.5 + contact_y_offset, pcb_h-t])
                cube([2.5-contact_l/2, contact_l, solder_h+t]);
                translate([2.5-contact_l/2, i*2.5 + contact_l/2 + contact_y_offset, pcb_h-t])
                cylinder(d = contact_l, h = solder_h+t);
                translate([pcb_w - 2.5+contact_l/2, i*2.5 + contact_y_offset, pcb_h-t])
                cube([2.5-contact_l/2+t, contact_l, solder_h+t]);
                translate([pcb_w - 2.5+contact_l/2, i*2.5 + contact_l/2 + contact_y_offset, pcb_h-t])
                cylinder(d = contact_l, h = solder_h+t);
            }
            // leds
            led_step = pcb_w/leds_per_section;
            led_w = 5 + c*2;
            led_l = 5 + c*2;
            led_h = 1.3 + c;
            led_solder_l = 6.2 + c*2;
            for (i = [0:leds_per_section-1]) {
                translate([i*led_step + led_step/2 - led_w/2, (pcb_l - led_l)/2, pcb_h-t]) {
                    color("white")
                    cube([led_w, led_l, led_h+t]);
                    color("silver")
                    translate([t, -(led_solder_l - led_l)/2, 0])
                    cube([led_w - t*2, led_solder_l, 1+t]);
                }
            }
            // spacing for resistors
            color([0.5, 0.5, 0.5, 0.5]) {
                translate([12, 1, pcb_h-t])
                rounded_square_prism(8.5, pcb_l-2, 0.8+t, 1);
                translate([29, 1, pcb_h-t])
                rounded_square_prism(8.5, pcb_l-2, 0.8+t, 1);
            }
        }
    }
}


// single, 2.54 step, straight
module pls_254(n, pin_centered = false, with_spacing = true, simplified = true) {
    w = 2.54;
    offset = (pin_centered)? w/2: 0;
    translate([-offset, -offset, 0]) {
        if (simplified) {
            // insulator
            color([0.25, 0.25, 0.25])
            rounded_rectangle_prism([w*n, w, 2.54], 0.5);
            // pin
            d = 0.8;
            translate([w/2-d/2, w/2-d/2, -3.2])
            color("gold")
            cube([2.54*n-w+d, d, 11]); 
        } else {
            for (i = [0:n-1]) {
                translate([w*i, 0, 0]) {
                    // insulator
                    color([0.25, 0.25, 0.25])
                    rounded_rectangle_prism([w, w, 2.54], 0.5);
                    // pin
                    translate([w/2, w/2, -3.2])
                    color("gold")
                    rotate(45, [0, 0, 1])
                    cylinder(d = 0.8, h = 11, $fn=4);
                }
            }
        }
        // spacing
        if (with_spacing) {
            color([1, 1, 1, 0.5])
            translate([-t, -t, -3.2-t])
            cube([2.54*n+t*2, 2.54+t*2, 11+t*2]);
        }
    }
}

module lipo_charger_4056_typec_prot(for_difference) {
    module led(c, color) {
        led_size = [2.4, 1.1, 0.8];
        color(color)
        cube([led_size.x+c*2, led_size.y+c*2, led_size.z+c]);
        color([1, 1, 1, 0.5])
        translate([led_size.x/2+c, led_size.y/2+c, led_size.z+c+t])
        cylinder(d1 = led_size.y+clearance*2, d2 = led_size.y*2+clearance*2, h = 10);
    }
    module pad(h) {
        pad_w = 2.5;
        color("silver")
        translate([-pad_w/2, -pad_w/2, -t-clearance-1.5])
        cube([pad_w, pad_w, h+clearance*2+t*2+1.5*2]);
    }
    c = (for_difference)? clearance: 0;
    pcb_size = [28, 17.2, 1];
    // pcb
    translate([-c, -c, -c])
    color([0, 0.25, 0.5])
    difference() {
        cube([pcb_size.x+c*2, pcb_size.y+c*2, pcb_size.z+c*2]);
        translate([pcb_size.x+c, pcb_size.y/2+c, -t])
        hull() {
            translate([0, -5, 0])
            cylinder(d = 2.5, h = pcb_size.z+t*2+c*2);
            translate([0, 5, 0])
            cylinder(d = 2.5, h = pcb_size.z+t*2+c*2);
        }
    }
    // usb
    usb_h = 3.2;
    translate([6+c, pcb_size.y/2, pcb_size.z + usb_h/2]) 
    color("silver") 
    rotate(-90, [0, 1, 0]) 
    {
        // clearances for this is bigger as we had troubles pushing it
        usb_c = c*1.5;
        hull() {
            translate([0, -5.7/2, 0])
            cylinder(d = usb_h+usb_c*2, h = 7.3+usb_c*2);
            translate([0, 5.7/2, 0])
            cylinder(d = usb_h+usb_c*2, h = 7.3+usb_c*2);
        }
        // fill negative slopes
        translate([-usb_h/2-c, -5.7/2-usb_h/2-usb_c, 0])
        cube([usb_h/2, 5.7 + usb_h + usb_c*2, 7.3+c*2-1.3]);
        // installation slope
        translate([-usb_h/2, -5.7/2-usb_h/2-usb_c, t])
        difference() {
            rotate(-90, [1, 0, 0])
            linear_extrude(5.7+usb_h+usb_c*2) {
                polygon([
                    [0, 0],
                    [usb_h+usb_c, 0],
                    [0, usb_h+usb_c]
                ]);
            }
            // cut sharp corners
            translate([0, 0, -usb_h-usb_c])
            union() {
                difference() {
                    translate([usb_h/2+usb_c, -t, 0])
                    cube([usb_h/2+usb_c, usb_h/2+usb_c+t, usb_h+usb_c*2]);
                    translate([usb_h/2, usb_h/2+usb_c, 0])
                    cylinder(h = usb_h+usb_c, d = usb_h+usb_c*2);
                }
                translate([0, 5.7, 0])
                difference() {
                    translate([usb_h/2+usb_c, usb_h/2+usb_c, 0])
                    cube([usb_h/2+usb_c, usb_h/2+usb_c+t, usb_h+usb_c*2]);
                    translate([usb_h/2, usb_h/2+usb_c, 0])
                    cylinder(h = usb_h+usb_c, d = usb_h+usb_c*2);
                }
            }
        }
    }
    // leds
    translate([7-c, 15-c, pcb_size.z])
    led(c, "red");
    translate([12.5-c, 15-c, pcb_size.z])
    led(c, "blue");
    // pads
    pads = [
        [1.8, 1.7], [1.8, 15.6],
        [24.7, 15.6], [24.7, 12.7], [24.7, 5.5], [24.7, 2]
    ];
    for (p = pads) {
        translate(p)
        pad(pcb_size.z);
    }
    // space for SMDs
    color([1, 1, 1, 0.5])
    translate([3.0-c, 1.5-c, pcb_size.z])
    cube([19.55+c*2, 14.6+c*2, 1.4+c]);
}


module usb_ttl_ch340(positive, light_d = 0) {
    c = (positive)? 0: clearance;
    // pcb
    color([0.2, 0.2, 0.2])
    translate([-c, -c, -1.6-c])
    cube_print_sharp_corners([30+c*2, 15.6+c*2, 1.6+c*2], 1+c*2, true);
    // usb
    color("silver")
    translate([-16-c, 1.8-c, -0.75-c]) {
        cube_print_sharp_corners([19+c*2, 12+c*2, 4.5+c*2], 1+c*2, true);
        // usb-female
        translate([0, -1.5, -1.3])
        cube([10+c*2, 15+c*2, 7.1+c*2]);
        // socket wires
        translate([18.7-c, 2.25-c, 0-c])
        cube([2.1+c*2, 7.5+c*2, 1.8+c*2]);
    }
    // ttl connector (angled)
    translate([27.7-c, 0.3-c, 0-c]) {
        color([0.3, 0.3, 0.3])
        cube([2.54+c*2, 15+c*2, 3+c*2]);
        color("gold")
        translate([0, 0, 3])
        cube([8.2+c*2, 15+c*2, 3+c*2]);
    }    
    // solder on the bottom
    color([1, 1, 1, 0.5])
    translate([-c, -c, -1.6-c])
    mirror([0, 0, 1]) {
        // from usb
        translate([0.5, 0.75, 0])
        cube([5+c*2, 14+c*2, 1+c*2]);
        // from crystal
        translate([14.1, 2.3, 0])
        cube([6.3+c*2, 1.7+c*2, 0.8+c*2]);
        // from pin array
        translate([27.9, 0, 0])
        cube([2.1+c*2, 15.6+c*2, 1.5+c*2]);
    }
    // top components
    color([1, 1, 1, 0.5])
    translate([6.8-c, 1.1-c, -c])
    cube([21+c*2, 14+c*2, 3.2+c*2]);
    if (0 < light_d) {
        lights_pos = [
            [25.3, 5],
            [25.3, 8],
            [25.3, 11]
        ];
        for (pos = lights_pos) {
            color("red")
            translate([pos.x, pos.y, 0])
            cylinder(d1 = 0.7+c*2, d2 = light_d+c*2, h = 10);
        }
    }
}
//board_5v(false);
//nanopi_neo_air(false);
//led_stripe_60(2);
//lipo_charger_4056_typec_prot(false); translate([0, 20, 0]) lipo_charger_4056_typec_prot(true);
//usb_ttl_ch340(true, 3);
//pls_254(28, true);
