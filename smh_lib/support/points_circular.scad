/*
AUTHOR: Samuel M.H. <samuel.mh@gmail.com>
DESCRIPTION:
  This functionality eases the process of creating support when the slicer fails to do so.
  The idea is to make small support points that will break with the normal movement of the piece. The best example is the vertical hinge printed as one piece. With the natural movement of the hinge, the suppor points break leaving the piece fully functional.
*/



/* Create a ring of support points

Parameters
----------
    bridge: distance in mm between points that will be a bridge. Keep it small.
    r: radius of the ring.
    tol: tolerance for the printer, usually set as the layer height.
*/
module points_circular(bridge, r, tol){
    //Bridge is the bridging length
    cl = 2*r*PI;
    cn = floor(cl/(tol+bridge));
    ca = 360/cn;
    for (i=[0:cn]){
        rotate([0,0,i*ca])
        translate([r,0,0])
        cube([tol, tol, tol*2], center=true);
    }
}


/* Example:

points_circular(3, 10, 0.2);

*/