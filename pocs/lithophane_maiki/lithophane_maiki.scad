LH = 0.36;  //Layer height
COLORS = 8;  //Levels of gray
WIDTH = 141.13;
DEPTH = LH*(COLORS+1);

TOL = 0.4;

ANGLE=30;  // Inclination of the whole figure


f_scale = WIDTH/532;

module _table(){
    color("sienna"){
        rotate([ANGLE, 0, 0])
        translate([0,-13,-150])
        cube([200,20,300]);
    }
}

module letters(txt){
    difference(){
        translate([94,0,-5])
        rotate([-15,-15,-2])
        linear_extrude(height=10)
        text(txt, size=7, font = "Liberation Sans:style=Bold Italic");
        translate([0,-50,-199])cube(200);
    }
}

module support(depth){
    translate([71, 13, -12])
    rotate([0,70,0])
    rotate([0,0,30])
    scale([2,1.,1])
    cylinder(d=25, h=depth, center=true);
}

module figure(depth_base){
    translate([0,1,0])
    union(){
        // Litophane
        translate([0,0,LH/2])
        intersection(){  
            scale([f_scale,f_scale,LH*COLORS/100])
            surface("resources/surface.png");
            translate([20*f_scale,30*f_scale,0])
            linear_extrude(height=50)
            offset(r=1)
            import ("resources/shape.dxf");
        }
        // Outer shell
        translate([20*f_scale,30*f_scale,0])
        union(){
            linear_extrude(height=depth_base) // Base
            difference(){
                offset(r=1)
                import ("resources/base.dxf");
                import ("resources/shape.dxf");
            }
            linear_extrude(height=LH) // Fill
            offset(r=.5)
            import ("shape.dxf");
            linear_extrude(height=DEPTH) //Wall
            difference(){
                offset(r=1)
                import ("resources/shape.dxf");
                import ("resources/shape.dxf");
            }
            
            letters("Maiki");
        }        
    }
    
}

module view_all(){
    rotate([-ANGLE+90,0,0]){
        color("white", 1){
            figure(DEPTH/2);
            support(DEPTH/2);
        }
        _table();
    }
}


module final_pieces(){

    difference(){
        figure(DEPTH/2);
        translate([0,-25/4,0]) support(DEPTH/2+TOL);
        _table();
    }      
   
    translate([20,0, DEPTH/4])
    rotate([0,-70,-30])
    translate([-71, -13, 12])
    difference(){
        support(DEPTH/2);
        translate([0,+25/4,0]) figure(DEPTH/2+TOL);
        _table();

    }
}

//view_all();
final_pieces();