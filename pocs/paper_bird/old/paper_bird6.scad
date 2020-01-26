use <smh_lib/support/extrude_line.scad>

// VARIABLES

PAPER_SIDE = 80;  // Length of the square paper sheet
TOL = 0.2;  // Actual width of a layer.
LAYERS = 6;  // Number of layer for the paper
LAYERS_FOLD = 2;  // Layers to quit when building a fold



// BETTER DON'T touch


//SHAPE = [  //Shape of the fold
//    [0,0.5],
//    [0,-0.5],
//    [1,-0.5],
//    [1,0.5]
//];

function get_shape(width) = [  //Shape of the fold
    [0, width],
    [0, -width],
    [1, -width],
    [1, width]
];

// The paper sheet can be abstracted in a 4x4 tile
sq = PAPER_SIDE/4;

DOWN_FOLDS = sq*[ // List of points
    [[0,4,0], [3,1,0]],
    [[0,2,0], [2,4,0]],
    [[1,1,0], [2,0,0]],
    [[3,3,0], [4,2,0]],
];

UP_FOLDS = sq*[ // List of points
    [[1,3,0], [1,1,0]],
    [[1,1,0], [3,1,0]],
    [[3,1,0], [3,3,0]],
    [[1,3,0], [3,3,0]],
    [[0,0,0], [1,1,0]],
    [[3,3,0], [4,4,0]],
    [[3,1,0], [4,0,0]],
];



difference(){
    // Base paper
    cube([PAPER_SIDE, PAPER_SIDE, LAYERS*TOL]);
    
    // Downward folds
    translate([0,0,(LAYERS-LAYERS_FOLD)*TOL])
    mirror([0,0,1])
    for (line=DOWN_FOLDS){
        extrude_line(line[0], line[1], get_shape(0.25));
    }
    translate([0,0,TOL])    
    for (line=DOWN_FOLDS){
        extrude_line(line[0], line[1], get_shape(0.5));
    }

    // Upward folds
    translate([0,0,LAYERS_FOLD*TOL])
    for (line=UP_FOLDS){
        extrude_line(line[0], line[1], get_shape(0.25));
    }
    translate([0,0,(LAYERS-1)*TOL])
    mirror([0,0,1])
    for (line=UP_FOLDS){
        extrude_line(line[0], line[1], get_shape(0.5));
    }
}