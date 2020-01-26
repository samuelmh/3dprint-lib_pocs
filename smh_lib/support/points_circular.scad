 
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