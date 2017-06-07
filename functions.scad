$fn=50;

module offset_on_angle(angle,offset){
    x = offset * cos(angle);
    y = offset * sin(angle);
    translate([x,y,0])
    children();
}

module toroidic_skirt(id,od) {
    difference() {
        cylinder(d=od,h=(od-id)/2);
        translate([0,0,(od-id)/2])
        torus(id,id+(od-id)*2);
    }
}

module torus(id, od) {
    rotate_extrude(convexity=10)
    translate([id/2+(od - id)/4, 0, 0])
    circle(d = (od-id)/2);
}
