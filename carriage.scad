// Carriage
// NOTE Customize the constants (constants.scad) to tweak the carriage
$fn=100;

use <e2020.scad>;
use <functions.scad>;
include <constants.scad>;

revision = "7";

outer_bearing_sleeve_skirt_od = carriage_bearing_bolt_diam+carriage_inner_bearing_sleeve_thickness*2+carriage_outer_bearing_sleeve_height*2;
carriage_mid_x = carriage_bearing_space_x/2;
carriage_mid_y = (carriage_bearing_space_y_adj)/2;

difference() {
    union() {
        carriage_base();
        inner_bearing_sleeves();
        outer_bearing_sleeves();
    }
    bearing_bolts();
    payload_bolts();
    cutout();
    revision_text();
}

module revision_text() {
    translate([-6,0,-0.1])
    rotate([0,0,90])
    linear_extrude(height=1.1)
    mirror([1,0,0])
    text(text=str("r",revision), size=4);
}

module cutout() {
    translate([0,0,-0.1])
    difference() {
        translate([-3,-3,0])
        cube([carriage_bearing_space_x+6,carriage_bearing_space_y+6,carriage_thickness+0.2]);
        
        translate([0,0,-0.15])
        union() {
            translate([0,0,0])
            cylinder(d=outer_bearing_sleeve_skirt_od+4,h=carriage_thickness+0.4);
            translate([carriage_bearing_space_x,0,0])
            cylinder(d=outer_bearing_sleeve_skirt_od+4,h=carriage_thickness+0.4);
            translate([carriage_bearing_space_x,carriage_bearing_space_y_adj,0])
            cylinder(d=outer_bearing_sleeve_skirt_od+4,h=carriage_thickness+0.4);
            translate([0,carriage_bearing_space_y_adj,0])
            cylinder(d=outer_bearing_sleeve_skirt_od+4,h=carriage_thickness+0.4);

            translate([carriage_mid_x+payload_bolt_x/2,carriage_mid_y-payload_bolt_y/2,0])
            cylinder(d=14,h=carriage_thickness+0.4);
            translate([carriage_mid_x-payload_bolt_x/2,carriage_mid_y-payload_bolt_y/2,0])
            cylinder(d=14,h=carriage_thickness+0.4);
            translate([carriage_mid_x+payload_bolt_x/2,carriage_mid_y+payload_bolt_y/2,0])
            cylinder(d=14,h=carriage_thickness+0.4);
            translate([carriage_mid_x-payload_bolt_x/2,carriage_mid_y+payload_bolt_y/2,0])
            cylinder(d=14,h=carriage_thickness+0.4);
        }
    }
}

module payload_bolts() {
    translate([carriage_mid_x+payload_bolt_x/2,carriage_mid_y-payload_bolt_y/2,-0.1])
    cylinder(d=3,h=carriage_thickness+0.2);
    translate([carriage_mid_x-payload_bolt_x/2,carriage_mid_y-payload_bolt_y/2,-0.1])
    cylinder(d=3,h=carriage_thickness+0.2);
    translate([carriage_mid_x+payload_bolt_x/2,carriage_mid_y+payload_bolt_y/2,-0.1])
    cylinder(d=3,h=carriage_thickness+0.2);
    translate([carriage_mid_x-payload_bolt_x/2,carriage_mid_y+payload_bolt_y/2,-0.1])
    cylinder(d=3,h=carriage_thickness+0.2);
}

module outer_bearing_sleeves() {
    translate([0,0,carriage_thickness])
    outer_bearing_sleeve();
    translate([carriage_bearing_space_x,0,carriage_thickness])
    outer_bearing_sleeve();
    translate([carriage_bearing_space_x,carriage_bearing_space_y_adj,carriage_thickness])
    outer_bearing_sleeve();
    translate([0,carriage_bearing_space_y_adj,carriage_thickness])
    outer_bearing_sleeve();
}

module outer_bearing_sleeve() {
    toroidic_skirt(
        carriage_bearing_bolt_diam+carriage_inner_bearing_sleeve_thickness*2,
        outer_bearing_sleeve_skirt_od);
}

module inner_bearing_sleeves() {
    translate([0,0,carriage_thickness])
    cylinder(d=carriage_bearing_bolt_diam+carriage_inner_bearing_sleeve_thickness*2,h=carriage_bearing_spacer_height);
    translate([carriage_bearing_space_x,0,carriage_thickness])
    cylinder(d=carriage_bearing_bolt_diam+carriage_inner_bearing_sleeve_thickness*2,h=carriage_bearing_spacer_height);
    translate([carriage_bearing_space_x,carriage_bearing_space_y_adj,carriage_thickness])
    cylinder(d=carriage_bearing_bolt_diam+carriage_inner_bearing_sleeve_thickness*2,h=carriage_bearing_spacer_height);
    translate([0,carriage_bearing_space_y_adj,carriage_thickness])
    cylinder(d=carriage_bearing_bolt_diam+carriage_inner_bearing_sleeve_thickness*2,h=carriage_bearing_spacer_height);
}

module carriage_base() {
    hull() {
        translate([0,0,0])
        cylinder(d=carriage_curve_diam,h=carriage_thickness);
        translate([carriage_bearing_space_x,0,0])
        cylinder(d=carriage_curve_diam,h=carriage_thickness);
        translate([carriage_bearing_space_x,carriage_bearing_space_y_adj,0])
        cylinder(d=carriage_curve_diam,h=carriage_thickness);
        translate([0,carriage_bearing_space_y_adj,0])
        cylinder(d=carriage_curve_diam,h=carriage_thickness);
    }
}

module bearing_bolts() {
    carriage_bolt_height = carriage_thickness + carriage_bearing_spacer_height + 0.2;
    
    translate([0,0,-0.1])
    cylinder(d=carriage_bearing_bolt_diam,h=carriage_bolt_height);
    translate([carriage_bearing_space_x,0,-0.1])
    cylinder(d=carriage_bearing_bolt_diam,h=carriage_bolt_height);
    translate([carriage_bearing_space_x,carriage_bearing_space_y_adj,-0.1])
    cylinder(d=carriage_bearing_bolt_diam,h=carriage_bolt_height);
    translate([0,carriage_bearing_space_y_adj,-0.1])
    cylinder(d=carriage_bearing_bolt_diam,h=carriage_bolt_height);
}


