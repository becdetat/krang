// Top plate
$fn=100;
use <e2020.scad>;
use <functions.scad>;

triangle_size=150;
base_height = 25;
pillar_offset = 90;
pillar_sleeve_thickness = 5;
pillar_sleeve_height = 20;

top_plate();


module top_plate() {
    difference() {
        union() {
            base_triangle();
            pillar_sleeve();
        }

        pillar();        

        // back arm
        offset_on_angle(0,80-2.5)
        translate([0,5,25.1])
        rotate([0,90,0])
        s2020(200);

        // trim behind back arm
        color("red")
        offset_on_angle(0,110)
        translate([0,-10,-0.1])
        cube([40,100,base_height+0.2]);

        // bottom arm
        offset_on_angle(-30,5)
        offset_on_angle(60,80-2.5)
        offset_on_angle(-30,20)
        translate([0,0,25.1])
        rotate([-60,90,0])
        s2020(200);

        //trim behind bottom arm
        color("red")
        offset_on_angle(60,110)
        offset_on_angle(-30,90)
        translate([0,0,-0.1])
        rotate([0,0,60])
        cube([40,100,base_height+0.2]);

        // trim back
        color("red")
        offset_on_angle(30,105)
        offset_on_angle(120,50)
        translate([0,0,5])
        rotate([0,0,-60])
        cube([100,40,base_height+0.2]);

        color("teal")
        offset_on_angle(120,15)
        translate([0,0,-0.1])
        rotate([0,0,-60])
        cube([30,75,base_height+0.2]);

        color("lime")
        translate([0,25-0.1,-0.1])
        rotate([0,0,-90])
        cube([25,72.5,base_height+0.2]);

        color("lime")
        offset_on_angle(-30,12.5)
        translate([0,25.1,-0.1])
        rotate([0,0,-30])
        cube([25,52.5-2,base_height+0.2]);

        offset_on_angle(30, pillar_offset)
        rotate([0,0,30])
        translate([0,0,-0.1])
        cylinder(d=5,h=5.2);
    
        translate([72,15,15])
        rotate([0,90,0])
        cylinder(d=5,h=6);
        
        translate([0,0,15])
        offset_on_angle(-30,15)
        offset_on_angle(60,72)
        rotate([-60,90,0])
        cylinder(d=5,h=6);
    }
}

module pillar() {
    offset_on_angle(30, pillar_offset)
    rotate([0,0,30])
    translate([-10,-10,10])
    s2020(200);        
}

module pillar_sleeve() {
    offset_on_angle(30, pillar_offset)
    rotate([0,0,30])
    translate([-10-pillar_sleeve_thickness,-10-pillar_sleeve_thickness,base_height])
    cube([20+pillar_sleeve_thickness*2,20+pillar_sleeve_thickness*2,pillar_sleeve_height]); 
}

module base_triangle() {
    linear_extrude(height=base_height)
    polygon([
        [0,0],
        [triangle_size,0],
        [triangle_size/2,sqrt(triangle_size*triangle_size-(triangle_size/2)*(triangle_size/2))]
    ]);
}


