// Payload
// This is the part that bolts on to the carriage and includes the mount for the effector arms and the belt clamp.
$fn=50;

use <functions.scad>;
include <constants.scad>;

revision = "5";

beltloop_actual_gap = payload_belt_loop_gap + payload_belt_loop_cyl_diam;


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
    text(
        text=str("r",revision), 
        size=4, 
        font="Liberation Sans:style=Bold");
}

module payload_arm_socket() {
    translate([
        payload_bolt_x/2-payload_arm_length/2,
        0,
        payload_thickness
    ]) {
        payload_arm();
        translate([payload_arm_length,payload_arm_width*2+payload_arm_socket_gap,0])
        rotate([0,0,180])
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
            
            // brace
            difference() {
                translate([payload_arm_length/2,payload_arm_width,0])
                cylinder(d1=payload_arm_length,d2=0,h=payload_arm_height*0.7);
                translate([0,-payload_arm_length+0.1,-0.1])
                cube([
                    payload_arm_length+1,
                    payload_arm_length,
                    payload_arm_height+1
                ]);
            }
        }
        translate([payload_arm_length/2,payload_arm_width+0.1,payload_arm_height])
        rotate([90,0,0])
        cylinder(d=3.4,h=payload_arm_width+0.2);
    }
}

module belt_loop() {
    translate([
        payload_bolt_x/2,
        payload_bolt_y/2,
        payload_thickness])
    union() {
        belt_loop_bridge();
        translate([0,0,payload_belt_loop_cap_height]) union() {
            translate([-beltloop_actual_gap/2,0,0])
            cylinder(d=payload_belt_loop_cyl_diam,h=payload_belt_loop_height);
            translate([beltloop_actual_gap/2,0,0])
            cylinder(d=payload_belt_loop_cyl_diam,h=payload_belt_loop_height);
            translate([0,0,payload_belt_loop_height])
            belt_loop_bridge();
        }
    }
}

module belt_loop_bridge() {
    hull() {
        translate([-beltloop_actual_gap/2,0,0])
        cylinder(d=payload_belt_loop_cyl_diam,h=payload_belt_loop_cap_height);
        translate([beltloop_actual_gap/2,0,0]) 
        cylinder(d=payload_belt_loop_cyl_diam,h=payload_belt_loop_cap_height);
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

