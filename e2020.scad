
module s2020(length) {
    color("silver")
    cube([20,20,length]);
}

module e2020(length) {
    color("silver")
    difference() {
        cube([20,20,length]);
        translate([10-5.4/2,-0.1,-0.1])
        cube([5.4,6.2,length+0.2]);
        translate([10-5.4/2,20-6.1,-0.1])
        cube([5.4,6.2,length+0.2]);
        
        translate([20-6.1,10-5.4/2,-0.1])
        cube([6.2,5.4,length+0.2]);
        
        translate([-0.1,10-5.4/2,-0.1])
        cube([6.2,5.4,length+0.2]);
        
        translate([10,10,-0.1])
        cylinder(d=4,h=length+0.2);
    }
}