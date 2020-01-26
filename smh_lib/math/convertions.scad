
// DESCRIPTION: convert from polar coordinates to cartesian.
// RETVAL: [radius, angle]
function polar2cartesian(r,angle) = [r*cos(angle), r*sin(angle)];

// DESCRIPTION: convert from cartesian coordinates to polar.
// RETVAL: [x, y]
function cartesian2polar(x,y) = [sqrt(x*x+y*y), atan(y/x)];
 

// DESCRIPTION: convert from cartesian 3d coordinates to spherical.
// RETVAL: [radius, inclination, azimuth]
// See: https://en.wikipedia.org/wiki/Spherical_coordinate_system#Cartesian_coordinates 
function spherical_radius(point) = sqrt( pow(point.x,2) +  pow(point.y,2) + pow(point.z,2));  
function cartesian2spherical(point) = [
    spherical_radius(point), // Radius
    acos(point.z/spherical_radius(point)), // Inclination
    atan2(point.y, point.x), // Azimuth
];