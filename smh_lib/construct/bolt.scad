

function CUTTER_V90() = [  // 90º Triangular cut
    [0, 0],
    [2, -2],
    [2, 2]
];


module cutter(shape,length=10){
    rotate([90,0,0]) // Horizontal
    translate([0,0,-length/2])  //Centered
    linear_extrude(height=length)
    polygon(shape);
}


module bolt(bolt_r, bolt_h, cutter_shape, depth, step, spins){
    r_cut = bolt_r-depth;  //Radius of the cut
    inc_angle_z = 360/$fn;
    inc_height = step/$fn;
    inc_angle_x = atan(step/(2*r_cut*PI));
    difference(){
        cylinder(r=bolt_r, h=bolt_h);
        for (spin=[0:spins-1]){
            translate([0,0,spin*step])
            // Rotate cutter for a spin
            for (rot=[0:$fn-1]){
                rotate([0,0,rot*inc_angle_z])
                translate([r_cut,0,rot*inc_height-step]) // Start cutting under the cylinder!
                rotate([inc_angle_x])  //Cutter slope
                cutter(cutter_shape, length=r_cut*3);  
            }
        }
    }
}
