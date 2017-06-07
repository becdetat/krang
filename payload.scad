// Payload
// This is the part that bolts on to the carriage and includes the mount for the effector arms and the belt clamp.
$fn=50;

use <functions.scad>;
include <constants.scad>;

revision = "3";

difference() {
    union() {
        payload_base();
        translate([0,belt_idler_id/2,0])
        belt_loop();
        translate([0,-(payload_x_buffer+payload_curve_diam/2),0])
        payload_arm_socket();
        translate([0,payload_arm_socket_gap+payload_bolt_x+payload_arm_width,0])
        payload_arm_socket();
    }
    payload_bolts();
    revision_text();
}

module revision_text() {
    translate([1,-9,payload_thickness-1])
    rotate([0,0,90])
    linear_extrude(height=1.1)
    text(text=str("r",revision), size=4);
}

module payload_arm_socket() {
    translate([
        payload_bolt_x/2-payload_arm_length/2,
        0,
        payload_thickness
    ]) {
        payload_arm();
        translate([0,payload_arm_width+payload_arm_socket_gap,0])
        payload_arm();
    }
    
}

module payload_arm() {
    difference() {
        union() {
            cube([
                payload_arm_length,
                payload_arm_width,
                payload_arm_height
            ]);
            translate([payload_arm_length/2,payload_arm_width,payload_arm_height])
            rotate([90,0,0])
            cylinder(d=payload_arm_length,h=payload_arm_width);
        }
        translate([payload_arm_length/2,payload_arm_width+0.1,payload_arm_height])
        rotate([90,0,0])
        cylinder(d=3.4,h=payload_arm_width+0.2);
    }
}

module belt_loop() {
    actual_gap = payload_belt_loop_gap + payload_belt_loop_cyl_diam;
    translate([
        payload_bolt_x/2,
        payload_bolt_y/2,
        payload_thickness])
    union() {
        translate([-actual_gap/2,0,0])
        cylinder(d=payload_belt_loop_cyl_diam,h=payload_belt_loop_height);
        translate([actual_gap/2,0,0])
        cylinder(d=payload_belt_loop_cyl_diam,h=payload_belt_loop_height);
        hull() {
            translate([-actual_gap/2,0,payload_belt_loop_height])
            cylinder(d=payload_belt_loop_cyl_diam,h=payload_belt_loop_cap_height);
            translate([actual_gap/2,0,payload_belt_loop_height]) 
            cylinder(d=payload_belt_loop_cyl_diam,h=payload_belt_loop_cap_height);
        }
    }
}

module payload_bolts() {
    translate([0,0,-0.1])
    union() {
        translate([0,0,0])
        cylinder(d=3.4,h=payload_thickness+0.2);
        translate([payload_bolt_x,0,0])
        cylinder(d=3.4,h=payload_thickness+0.2);
        translate([payload_bolt_x,payload_bolt_y,0])
        cylinder(d=3.4,h=payload_thickness+0.2);
        translate([0,payload_bolt_y,0])
        cylinder(d=3.4,h=payload_thickness+0.2);
    }
}

module payload_base() {
    hull() {
        translate([0,-payload_x_buffer,0])
        cylinder(d=payload_curve_diam,h=payload_thickness);
        translate([payload_bolt_x,-payload_x_buffer,0])
        cylinder(d=payload_curve_diam,h=payload_thickness);
        translate([payload_bolt_x,payload_bolt_y+payload_x_buffer,0])
        cylinder(d=payload_curve_diam,h=payload_thickness);
        translate([0,payload_bolt_y+payload_x_buffer,0])
        cylinder(d=payload_curve_diam,h=payload_thickness);
    }
}

