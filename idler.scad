// Belt idler holder and tensioner
$fn = 100;
use <functions.scad>;
include <constants.scad>;

revision = "3";

difference() {
    union() {
        cube([20,20,35]);
        
        rotate([-90,0,0])
        translate([10,-35,0])
        cylinder(d=20,h=20);
    }
    
    // main slot
    translate([-0.1,3,7.5])
    cube([20.2, 14, 50]);
    // captive nut    
    translate([10,10,5.5])
    hexagon(8.3,5);
    // bottom bolt
    translate([10,10,-0.1])
    cylinder(d=5.3,h=5.2);
    // idler bolt
    rotate([-90,0,0])
    translate([10,-35,-0.1])
    cylinder(d=5.3,h=20.2);

    revision_text();
}
rib();
translate([17,0,0])
rib();

translate([10,2.9,35])
rotate([180,0,0])
idler_sleeve();
translate([10,17.1,35])
idler_sleeve();


module revision_text() {
    translate([1,1,10])
    rotate([90,0,0])
    linear_extrude(height=1.1)
    text(text=str("r",revision), size=4, font="Liberation Sans:style=Bold");
}

module idler_sleeve() {
    rotate([90,0,0])
    difference() {
        cylinder(d1=20,d2=7,h=2.9);
        translate([0,0,-0.1])
        cylinder(d=5.3,h=5);
    }
}

module rib() {
    translate([0,10,14.5])
    difference() {
        translate([0,-7,-7])
        cube([3,14,16.8]);
        translate([0,0,10])
        rotate([0,90.1,0])
        cylinder(d=14,h=3.2);
    }
}
