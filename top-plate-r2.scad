$fn=50;
include <constants.scad>;
use <functions.scad>

triangle_size=142;
base_height = 5;
brace_offset = 75;
pillar_offset = 95;
m5_hole_diam = 5.3;
m3_hole_diam = 3.3;

top_plate();

module top_plate() {
    difference() {
        union() {
            difference() {
                base_triangle(triangle_size,base_height);
                offset_on_angle(30,pillar_offset)
                translate([0,0,-0.1])
                cylinder(d=m5_hole_diam,h=base_height+0.2);
                
                translate([0,0,-0.1])
                offset_on_angle(330,-0.1)
                offset_on_angle(300,0.1)
                base_triangle(75.2,base_height+0.2);
                
                translate([brace_offset+50,-0.1,-0.1])
                cube([30,40,base_height+0.2]);
                
                offset_on_angle(60,brace_offset+50)
                rotate([0,0,330])
                translate([-0.1,0,-0.1])
                cube([30,40,base_height+0.2]);            
            }
            
            //sleeve for belt tensioner
            offset_on_angle(30,pillar_offset+20+belt_offset_from_column-5-5.75)
            rotate([0,0,30])
            translate([-13,-13,base_height])
            difference() {
                cube([26,26,20]);
                translate([3,3,-0.1])
                cube([20,20,20.2]);
            }
            difference() {
                offset_on_angle(30,pillar_offset+belt_offset_from_column+20-5-5.75)
                rotate([0,0,30])
                translate([-20,-20,0])
                difference() {
                   cube([40,40,base_height]);
                }
            }
            
            // back brace sleeve
            offset_on_angle(60,brace_offset)  // move it back
            offset_on_angle(-30,15) // align it
            rotate([0,0,330])
            translate([0,0,base_height])
            brace_sleeve();

            // front brace sleeve
            rotate([0,0,270])
            translate([-15,brace_offset,base_height])
            brace_sleeve();
            
            // pillar sleeve
            offset_on_angle(30,pillar_offset)
            rotate([0,0,30])
            translate([0,0,base_height])
            pillar_sleeve();
        }
    
        offset_on_angle(30,pillar_offset+belt_offset_from_column+20-5-5.75)
        translate([0,0,-0.1])
        cylinder(d=m5_hole_diam,h=base_height+0.2);
    }
}

module pillar_sleeve() {
    translate([-15,-15,0])
    difference() {
        union() {
            cube([30,30,50]);
            
            translate([25,15,50])
            rotate([0,90,0])
            cylinder(d=30,h=5);
            
            translate([25,2.5,50])
            cube([5,25,15]);
        }
        
        // hollow
        translate([4.8,4.8,5])
        cube([20.4,20.4,80]);
        // bolt hole
        translate([15,15,-0.1])
        cylinder(d=m5_hole_diam,h=5.2);
        
        // side screw holes
        translate([15,-0.1,15])
        rotate([270,0,0])
        cylinder(d=m3_hole_diam,h=40);
        translate([15,-0.1,40])
        rotate([270,0,0])
        cylinder(d=m3_hole_diam,h=40);
        translate([32,15,15])
        rotate([270,0,90])
        cylinder(d=m3_hole_diam,h=40);
        translate([32,15,40])
        rotate([270,0,90])
        cylinder(d=m3_hole_diam,h=40);

        // screw holes for limit switch mount
        translate([25,8,60])
        rotate([0,90,0])
        cylinder(d=3,h=5.2);
        translate([25,22,60])
        rotate([0,90,0])
        cylinder(d=3,h=5.2);
    }
}

module brace_sleeve() {
    translate([-15,0,0])
    difference() {
        cube([30,50,20]);
        translate([5,5,-0.1])
        cube([20,46,36]);
        translate([15,-0.1,10])
        rotate([270,0,0])
        cylinder(d=m5_hole_diam,h=5.2);
        
        translate([-0.1,15,10])
        rotate([0,90,0])
        cylinder(d=m3_hole_diam,h=5.2);
        translate([-0.1,40,10])
        rotate([0,90,0])
        cylinder(d=m3_hole_diam,h=5.2);

        translate([24.9,15,10])
        rotate([0,90,0])
        cylinder(d=m3_hole_diam,h=5.2);
        translate([24.9,40,10])
        rotate([0,90,0])
        cylinder(d=m3_hole_diam,h=5.2);
    }
}


module base_triangle(size, h) {
    linear_extrude(height=h)
    polygon([
        [0,0],
        [size,0],
        [size/2,sqrt(size*size-(size/2)*(size/2))]
    ]);
}
