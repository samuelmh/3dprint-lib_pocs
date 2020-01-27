/*
AUTHOR: Samuel M.H. <samuel.mh@gmail.com>
DESCRIPTION:
  Utilities to deal with space coordinate conversion.
*/


/*AUXILIAR FUNCTION: get the distance from the origin to a 3D point.

Parameters
----------
    point3d: [x, y, z] cartesian coordinates of the 3D point.

Returns
-------
    retval: float radius.
*/
function _spherical_radius(point3d) = sqrt( pow(point3d.x,2) +  pow(point3d.y,2) + pow(point3d.z,2));



/* Convert from polar coordinates to 2D cartesian.

Parameters
----------
    r: radius or length of the origin-centered vector.
    angle: angle over the X axis.

Returns
-------
    retval: [x coordinate, y coordinate]
*/
function polar2cartesian(r,angle) = [r*cos(angle), r*sin(angle)];



/* Convert from 2D cartesian coordinates to polar.

Parameters
----------
    point2d: [x, y] cartesian coordinates of the 2D point.

Returns
-------
    retval: [polar radius, polar angle]
*/
function cartesian2polar(point2d) = [
    _spherical_radius(point2d.x, point2d.y, 0)
    atan2(point3d.y, point3d.x)
];



/* Convert from cartesian 3D coordinates to spherical.
See: https://en.wikipedia.org/wiki/Spherical_coordinate_system#Cartesian_coordinates

Parameters
----------
    point3d: [x, y, z] cartesian coordinates of the 3D point.

Returns
-------
    retval: [radius, inclination, azimuth]
        radius: length of the vector.
        inclination: angle to the z axis.
        azimuth: angle to the x axis.
*/
function cartesian2spherical(point3d) = [
    _spherical_radius(point3d), // Radius
    acos(point3d.z/_spherical_radius(point3d)), // Inclination
    atan2(point3d.y, point3d.x) // Azimuth
];