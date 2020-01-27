/*
AUTHOR: Samuel M.H. <samuel.mh@gmail.com>
DESCRIPTION:
  This functionality was created to ease the process of FDM 3d printing without supports.
  The idea is to make 45º spiral cuts or the max angle the printer supports.
  This module can create helices with the user-definded parameters.
*/


/* Create a segment of the helix. It focuses on the external (lateral) face to build the piece.

Parameters
----------
    r: radius of the helix.
    circle_inc: spin increment.
    h_inc: vertical increment.
    depth: height of the step.
*/
module _segment(r, circle_inc, h_inc, depth=0.01){
    rotate([-90,0,0])
    rotate([0,-90,0])
    translate([0,0,-r])
    linear_extrude(height=r, center=false, convexity=10, scale=[0,1])
    polygon([    
        [0,depth],
        [0,0],
        [circle_inc, -h_inc],
        [circle_inc, -h_inc+depth],
    ]);
}


/* Main functionality, create a helix.

Parameters
----------
    r: radius of the helix.
    angle_rot: how much to rotate.
    angle_inc: maximum angle the helix will contain, angle of the external border.
    depth: height of the step. Very small=>surface. Too big=>cylinder
*/
module helix(r, angle_rot, angle_inc=45, depth=0.01){
    circle_inc =  (2*r*PI)/$fn;
    h_inc = tan(angle_inc)*(2*PI*r)/$fn;
    n_pieces = (angle_rot/360)*$fn;
    angle_rot_inc = angle_rot/n_pieces;
    
    for (i=[0:n_pieces]){
        rotate([0,0, i*angle_rot_inc])
        translate([0,0,i*h_inc])
        _segment(r, circle_inc, h_inc, depth);
    }
    
    
}

/* Example:
$fn=40*4;
helix(r=100, angle_rot=90, angle_inc=45, depth=10);
*/



