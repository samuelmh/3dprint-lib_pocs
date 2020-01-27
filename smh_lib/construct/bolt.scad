/*
AUTHOR: Samuel M.H. <samuel.mh@gmail.com>
DESCRIPTION:
  This functionality allows to create threaded bolts.
  The idea is to have something like a diestock or a lathe. So we remove material in a circular motion from a piece with a cutter piece.
*/


/* Get the shape of our cutter. In this case a 90º cutter, 45º over and under the vertical. 45º allows to print without support ;) .

Parameters
----------
    r: radius of the helix.
    circle_inc: spin increment.
    h_inc: vertical increment.
    depth: height of the step.
    

Returns
-------
    retval: list of 2d points to create a polygon

*/
function CUTTER_V90() = [  // 90º Triangular cut
    [0, 0],
    [2, -2],
    [2, 2]
];


/* Creates the actual cutter 3d body. It is an auxiliary function.

Parameters
----------
    shape: list of 2d points that define the profile of the cutter piece.
    length: length of the cutter piece.
*/
module _cutter(shape,length=10){
    rotate([90,0,0]) // Horizontal
    translate([0,0,-length/2])  //Centered
    linear_extrude(height=length)
    polygon(shape);
}


/* Create a cylinder and apply the cuter. The result is a threaded rod.
 This can be used to create bolts and nuts (by substraction).
Note: don't worry about the cutter inclination, the module also computes this.

Parameters
----------
    bolt_r: radius of the rod (cylinder).
    bolt_h: height of the rod.
    cutter_shape: list of 2d points with the profile of the cutter.
    depth: distance to push the cutter into the rod.
    step: vertical translation of the cutter per turn around the rod.
    spins: number of turns to perform around the rod.
*/
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
                _cutter(cutter_shape, length=r_cut*3);  
            }
        }
    }
}
