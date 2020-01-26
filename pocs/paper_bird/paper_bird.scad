use <smh_lib/support/extrude_line.scad>

// VARIABLES

PAPER_SIDE = 80;  // Length of the side for the square paper sheet
LH = 0.12;  // Actual height of a layer in mm
LAYERS = 6;  // Number of layers for the paper
LAYERS_FOLD = 2;  // Layers to quit when building a fold



// BETTER DON'T touch


SHAPE = [  //Shape of the fold
    [0,0.25],
    [0,-0.25],
    [1,-0.25],
    [1,0.25]
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
    cube([PAPER_SIDE, PAPER_SIDE, LAYERS*LH]);
    
    // Downward folds
    translate([0,0,(LAYERS-LAYERS_FOLD)*LH])
    mirror([0,0,1])
    for (line=DOWN_FOLDS){
        extrude_line(line[0], line[1], SHAPE);
    }

    // Upward folds
    translate([0,0,LAYERS_FOLD*LH])
    for (line=UP_FOLDS){
        extrude_line(line[0], line[1], SHAPE);
    }
}