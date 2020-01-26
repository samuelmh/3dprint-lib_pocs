use <smh_lib/support/points_circular.scad>

$fn= 40;

R_BOLT = 2;
R_EXT = 10;
H = 20;
TOL = 0.5;

FRAME_DEPTH = 10;
FRAME_WIDTH =  R_EXT*2;

// Basic shape
module basic_shape(height){
    union(){
        translate([-(FRAME_DEPTH+R_EXT)/2,0,H/2])
        cube([FRAME_DEPTH+R_EXT, FRAME_WIDTH, H], center = true);
        cylinder(r=R_EXT, h=height);
    }
}

h_small = (H/4) + (TOL/2);


// Female
rotate([0,0,0])
union(){
    difference(){
        basic_shape(height=H);
        translate([0,0,H/2])
        cylinder(r=R_EXT+TOL, h=h_small*2, center=true);
    }
    cylinder(r=R_BOLT, h=H);
}


// Male
difference(){
    rotate([0,0,180]) basic_shape(height=H);
    translate([0,0,-1]) cylinder(r=R_EXT+TOL, h=h_small+1);
    translate([0,0,H-h_small]) cylinder(r=R_EXT+TOL, h=h_small+1);
    cylinder(r=R_BOLT+TOL, h=H);
    
}




//Support points, these must break

module supports(){
    points_circular(1.5, R_BOLT+TOL*1.5, TOL); // Inner cylinder
    points_circular(3, R_EXT-TOL/2, TOL);  // Outer cylinder
    rotate([0,0,45]) points_circular(4, (R_EXT+R_BOLT)/2, TOL); // Middle support
}

translate([0,0,h_small-TOL/2]) supports();  //Lower layer
translate([0,0,H-(h_small-TOL/2)]) supports();  // Upper layer

