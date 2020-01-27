use <smh_lib/math/convertions.scad>

/*
AUTHOR: Samuel M.H. <samuel.mh@gmail.com>
DESCRIPTION:
  Utilities to create extrusions between points.
*/



/* Extrude a polygon from a 3D point to another.

Parameters
----------
    pt_a: 3d point [x,y,z] origin of the extrusion.
    pt_b: 3d point [x,y,z] destination of the extrusion.
    shape: [ [x,y], [x,y], ... ] list of 2d points that define the polygon to extrude.
*/
module extrude_line(pt_a, pt_b, shape){
    ria = cartesian2spherical(pt_a-pt_b); //r, inc, azim
    translate(pt_b)
    rotate([0,ria[1],ria[2]])
    linear_extrude(height=ria[0])
    polygon(shape);
}




/* EXAMPLE

SHAPE = [  //Shape that will be extruded
    [0,0],
    [1,1],
    [1,-1]
];
A = [2,0,1];
B = [3,2,2];

extrude_line(A,B,SHAPE);

//Check: cube diagonal is the same as extruded object 0 point extruded.
translate(A)
cube(B-A);

*/