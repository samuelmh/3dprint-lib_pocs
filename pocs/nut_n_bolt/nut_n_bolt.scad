use <smh_lib/construct/bolt.scad>

$fn = 80; //Resolution


// BOLT
translate([0,0,25])
rotate([180,0,0])
difference(){
    union(){
        translate([0,0,25-3]) cylinder(r=8,h=3);
        bolt(
            bolt_r=5, bolt_h=24,
            cutter_shape=CUTTER_V90(), depth=1.1, step=2, spins=11
        );
    }
    translate([0,0,25]) cube([20,1.5,3], center=true);
}


// NUT
translate([18,0,0])
difference(){
    cylinder(r=7,h=7, $fn=6);
    translate([0,0,-1])
    bolt(
        bolt_r=5.4, bolt_h=24, // Note the tolerance 0.4 mm. It worked for me
        cutter_shape=CUTTER_V90(), depth=1.1, step=2, spins=8
    );
}
