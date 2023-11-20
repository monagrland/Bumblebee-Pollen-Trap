 //Variables
// Select which part you want to create: corpus is the main part of the pollenstripper, corpus_brush is a version of the pollenstripper with angled mounts for brushes, the darkener is a part that sits on top of the plexiglas cube to keep light from getting in and the funnel was meant to collect the pollen after it fell off and through the grid (deprecated)
cube_design = "corpus"; // [corpus, corpus_brush, darkener, funnel]

/* [Acrylic Cube] */
plexi_cube_width = 39; //39 for cube1, 32 for cube2
plexi_cube_length = 35; //35 for cube1, 30 for cube2
plexi_cube_depth_overall = 30;
plexi_cube_depth = 20; //this is for the main corpus
plexi_cube_thickness = 2;
plexi_cube_buffer = 0.5; //1mm room in every direction

/* [Darkener] */
// The length that the darkener overlaps with the corpus
darkener_overhang = 10;

/* [Insert] */
//needs to be the same as in the insert creator
insert_bar_height = 6;
//needs to be the same as in the insert creator
insert_bar_length = 16;
//needs to be the same as "base plate length upper" in the insert creator
insert_base_length = 28;
//needs to be the same as "base plate thickness" in the insert creator
insert_thickness = 2;
// buffer space between corpus and insert
insert_buffer = 1;
// distance of the insert from the end of the tube. CAREFUL: changing this can break the design, default=4
insert_distance_from_tube_end = 4;

/* [Corpus Basics] */
//thickness of the tubes (lower parts of the corpus containing the inserts)
tube_thickness = 2;
//width of the tubes
tube_width = 28;
//length of the tubes
tube_length = 28;
//depth of the tubes, 25.5 for normal corpus design, 32 for brush
tube_depth = 25.5; // was 38.5, for normal design 25.5, increase for brush to 32
//number of tubes
tube_count = 3;

// width of the bar that locks the inserts so that they can't move to the back, CAREFUL: changing this will break the design, default = 4
security_bar_width = 4;
slide_bar_length = tube_depth+2;
// width of the bar the funnel slides on
slide_bar_width = 1.6; //decreased from 2 to 1,6 for buffer
//height of the bar the funnel slides on
slide_bar_height = 2;

/* [Grid Pattern] */
// grid pattern, meant to let the stripped pollen fall through into the funnel
grid_pattern = "None"; //[None, squares, squares2]
//width of the squares
square_width = 5;
//length of the squares
square_length = 4;
//distance between the squares
square_distance = 2;
//number oif squares per row
number_squares_per_row = 4;
//number of squares per column, suggestion for normal corpus 2, for brush 3
number_squares_per_column = 3;

/* [Brush] */
// length of the top part of the brush
brush_head_length = 16;
// length of the bottom part of the brush
brush_bottom_length = 24;
// width of the brush
brush_width = 19.25;
// thickness of the brush
brush_thickness = 5.5;
// distance of the screw holes from the top of the brush
distance_hole_from_top = 1.6;
// distance of the screw holes from the side of the brush
distance_hole_from_side = 2.6;
// diameter of the screw holes
diameter = 3;

/* [Funnel] */
// width of the bars that slide on the corpus
funnel_slide_width = 4;
// height of the bars that slide on the corpus
funnel_slide_height = 7;
// height of the hollow part of the bars that slide on the corpus
funnel_slide_hollow_height = 3;
// buffer between the corpus bar and the funnel slide bar
funnel_slide_buffer_width = 0.2;
// length of the pyramid
funnel_pyramid_length = 32;
// height of the tip of the pyramid part
funnel_pyramid_tip_height = 18;
// width of the cube at the top of the funnel
funnel_tip_cube_width = 14;
// length of the cube at the top of the funnel
funnel_tip_cube_length = 14;
// height of the cube at the top of the funnel
funnel_tip_cube_height = 11;
// height of the cylinder that hollows out the top of the funnel
funnel_hollow_cylinder_height = 20;
// diameter of the cylinder that hollows out the top of the funnel
funnel_hollow_cylinder_diameter = 7;



/* [Misc] */
// Number of Faces: higher number is good for smoother curved areas, lower number significantly decreases rendering time, recommending 25 for playing around and 100 for exporting
$fn = 50;

//angle
tube_distance_left = (plexi_cube_width/2+plexi_cube_buffer+plexi_cube_thickness-tube_width/2-tube_thickness);
tube_distance_bottom = (plexi_cube_length/2+plexi_cube_buffer+plexi_cube_thickness-tube_length/2-tube_thickness);
angle_depth = max(tube_distance_left, tube_distance_bottom);
outer_cube_width = plexi_cube_width + 2*plexi_cube_thickness + 2*plexi_cube_buffer;
outer_cube_length = plexi_cube_length + 2*plexi_cube_thickness + 2*plexi_cube_buffer;

//module to create triangles
module triangle(width,length,height){
    difference(){
        cube([width,length,height]);
        rotate([0,0,45]) cube([width*2.5,length*2.5,height*5]);
    }
}

//module to show points of a polyhedron
module showPoints(v) {
    for (i = [0: len(v)-1]) {
        translate(v[i]) color("red") 
        text(str(i), font = "Courier New", size=1.5);
         
    }
}

//module to create a square grid pattern
module square_grid(){
    grid_width = square_width*number_squares_per_row + square_distance*(number_squares_per_row-1);
    grid_length = square_length*number_squares_per_column + square_distance*(number_squares_per_column-1);
translate([tube_width/2+tube_thickness-grid_width/2,tube_depth+angle_depth-(insert_distance_from_tube_end+insert_thickness+insert_buffer+insert_bar_height)+3,0])
translate([grid_width,0,0])
rotate([0,0,180])
for (j=[0:number_squares_per_column-1]){
for (i=[0:number_squares_per_row-1]){
    translate([i*(square_distance+square_width),j*(square_distance+square_length),0])cube([square_width,square_length,tube_thickness]);
    }
}
}

module square_grid2(){
    grid_width = square_width*number_squares_per_row + square_distance*(number_squares_per_row-1);
    grid_length = square_length*number_squares_per_column + square_distance*(number_squares_per_column-1);
translate([tube_width/2+tube_thickness-grid_width/2,tube_depth+angle_depth-(insert_distance_from_tube_end+insert_thickness+insert_buffer+insert_bar_height),0])
translate([grid_width-square_length/2,0,0])
rotate([0,0,180])
for (j=[0:number_squares_per_column-1]){
for (i=[0:number_squares_per_row-1]){
    translate([i*(square_distance+square_width),j*(square_distance+square_length),0])rotate([0,0,45])cube([square_width,square_length,tube_thickness]);
    }
}
}

//module to create a brush as a standin
module brush (){
difference(){
union(){
color("green")cube([brush_width, brush_thickness, brush_head_length]);
color("brown")translate([0,0,brush_head_length])cube([brush_width, brush_thickness, brush_bottom_length]);
}

union(){
translate([diameter/2+distance_hole_from_side,0,diameter/2 + distance_hole_from_top])rotate([270,0,0])cylinder(h=brush_thickness, d=diameter);
translate([brush_width-diameter/2-distance_hole_from_side,0,diameter/2 + distance_hole_from_top])rotate([270,0,0])cylinder(h=brush_thickness, d=diameter);
}
}
}

//module to create a mount for the brush
module brush_mount (){
difference(){
union(){
color("green")cube([brush_width, brush_thickness, brush_head_length]);
color("brown")translate([0,0,brush_head_length])cube([brush_width, brush_thickness, brush_bottom_length]);
}

union(){
translate([diameter/2+distance_hole_from_side,0,diameter/2 + distance_hole_from_top])rotate([270,0,0])cylinder(h=brush_thickness, d=diameter);
translate([brush_width-diameter/2-distance_hole_from_side,0,diameter/2 + distance_hole_from_top])rotate([270,0,0])cylinder(h=brush_thickness, d=diameter);
}
}
}


if (cube_design == "corpus"){
union(){

//plexi_cube part of the tube
difference(){
    cube([plexi_cube_width + 2*plexi_cube_thickness + 2*plexi_cube_buffer, plexi_cube_depth, plexi_cube_length+2*plexi_cube_thickness + 2*plexi_cube_buffer]);
    translate([plexi_cube_thickness,0,plexi_cube_thickness])cube([plexi_cube_width + 2*plexi_cube_buffer, plexi_cube_depth, plexi_cube_length + 2*plexi_cube_buffer]);
}

//angle
angle_points = [
    [0,0,0], //0
    [outer_cube_width,0,0],//1
    [outer_cube_width,0,outer_cube_length],//2
    [0,0,outer_cube_length],//3
    [tube_distance_left,0,tube_distance_bottom],//4
    [outer_cube_width-tube_distance_left,0,tube_distance_bottom],//5
    [outer_cube_width-tube_distance_left,0,outer_cube_length-tube_distance_bottom],//6
    [tube_distance_left,0,outer_cube_length-tube_distance_bottom],//7
    [tube_distance_left,angle_depth,tube_distance_bottom],//8
    [outer_cube_width-tube_distance_left,angle_depth,tube_distance_bottom],//9
    [outer_cube_width-tube_distance_left,angle_depth,outer_cube_length-tube_distance_bottom],//10
    [tube_distance_left,angle_depth,outer_cube_length-tube_distance_bottom],//11
    
];

*showPoints(angle_points);
angle_faces = [
    [1,0,4,5],
    [0,1,9,8],
    [5,4,8,9],
    [2,1,5,6],
    [1,2,10,9],
    [6,5,9,10],
    [3,2,6,7],
    [2,3,11,10],
    [7,6,10,11],
    [0,3,7,4],
    [3,0,8,11],
    [4,7,11,8],
];


translate([0,plexi_cube_depth,0])
polyhedron(angle_points, angle_faces);



//tube
translate([plexi_cube_width/2-tube_width/2 + plexi_cube_buffer,plexi_cube_depth ,plexi_cube_length/2-tube_length/2 + plexi_cube_buffer]) 
for(i=[0:tube_count-1]){
if (i==0){
translate([0,tube_depth*i,0])    
union(){
difference(){
    cube([tube_width+2*tube_thickness, tube_depth + angle_depth, tube_length + 2*tube_thickness]);
    translate([tube_thickness,0,tube_thickness])cube([tube_width, tube_depth + angle_depth, tube_length]);
    

insert_slot_upper_points = [
    [0,0,0], //0
    [insert_base_length,0,0],//1
    [insert_base_length,insert_thickness + insert_buffer, 0],//2
    [insert_base_length/2 + insert_bar_length/2,insert_thickness + insert_buffer + insert_bar_height,0],//3
    [insert_base_length/2 - insert_bar_length/2,insert_thickness + insert_buffer + insert_bar_height,0],//4
    [0,insert_thickness + insert_buffer, 0],//5
    [0,0,tube_thickness], //6
    [insert_base_length,0,tube_thickness],//7
    [insert_base_length,insert_thickness + insert_buffer, tube_thickness],//8
    [insert_base_length/2 + insert_bar_length/2,insert_thickness + insert_buffer + insert_bar_height,tube_thickness],//9
    [insert_base_length/2 - insert_bar_length/2,insert_thickness + insert_buffer + insert_bar_height,tube_thickness],//10
    [0,insert_thickness + insert_buffer, tube_thickness],//11
];

*showPoints(insert_slot_upper_points);

insert_slot_upper_faces = [
    [0,1,2,3,4,5],
    [0,5,11,6],
    [5,4,10,11],
    [4,3,9,10],
    [3,2,8,9],
    [2,1,7,8],
    [1,0,6,7],
    [11,10,9,8,7,6]
];

translate([tube_width/2+tube_thickness-insert_base_length/2,tube_depth+angle_depth-(insert_bar_height+insert_thickness+insert_buffer)-insert_distance_from_tube_end,tube_length+tube_thickness])translate([insert_base_length,insert_bar_height + insert_thickness + insert_buffer,0])rotate([0,0,180])polyhedron(insert_slot_upper_points,insert_slot_upper_faces);

translate([tube_width/2+tube_thickness-insert_base_length/2,tube_depth+angle_depth-(insert_thickness+insert_buffer)-insert_distance_from_tube_end,0])cube([insert_base_length,insert_thickness+insert_buffer,tube_thickness]);


if (grid_pattern == "squares") square_grid();
else if (grid_pattern == "squares2") square_grid2();   
    
}

//security_bar
translate([tube_thickness,tube_depth+angle_depth-insert_distance_from_tube_end,tube_thickness])translate([0,insert_distance_from_tube_end,0])rotate([0,0,270])triangle(insert_distance_from_tube_end,security_bar_width,tube_length);
translate([tube_width-tube_thickness,tube_depth+angle_depth-insert_distance_from_tube_end,tube_thickness])triangle(insert_distance_from_tube_end,security_bar_width,tube_length);

//slide bar
translate([-slide_bar_width,tube_depth+angle_depth-slide_bar_length,0])
color("red"){cube([slide_bar_width,slide_bar_length,slide_bar_height]); 
}
translate([tube_width+2*tube_thickness,tube_depth+angle_depth-slide_bar_length,0])
color("red"){cube([slide_bar_width,slide_bar_length,slide_bar_height]); 
}

}
}
else if (i<tube_count-1){
translate([0,tube_depth*i,0])    
union(){
difference(){
    translate([0,angle_depth,0])
    cube([tube_width+2*tube_thickness, tube_depth , tube_length + 2*tube_thickness]);
    translate([tube_thickness,0,tube_thickness])cube([tube_width, tube_depth + angle_depth, tube_length]);
    

insert_slot_upper_points = [
    [0,0,0], //0
    [insert_base_length,0,0],//1
    [insert_base_length,insert_thickness + insert_buffer, 0],//2
    [insert_base_length/2 + insert_bar_length/2,insert_thickness + insert_buffer + insert_bar_height,0],//3
    [insert_base_length/2 - insert_bar_length/2,insert_thickness + insert_buffer + insert_bar_height,0],//4
    [0,insert_thickness + insert_buffer, 0],//5
    [0,0,tube_thickness], //6
    [insert_base_length,0,tube_thickness],//7
    [insert_base_length,insert_thickness + insert_buffer, tube_thickness],//8
    [insert_base_length/2 + insert_bar_length/2,insert_thickness + insert_buffer + insert_bar_height,tube_thickness],//9
    [insert_base_length/2 - insert_bar_length/2,insert_thickness + insert_buffer + insert_bar_height,tube_thickness],//10
    [0,insert_thickness + insert_buffer, tube_thickness],//11
];

*showPoints(insert_slot_upper_points);

insert_slot_upper_faces = [
    [0,1,2,3,4,5],
    [0,5,11,6],
    [5,4,10,11],
    [4,3,9,10],
    [3,2,8,9],
    [2,1,7,8],
    [1,0,6,7],
    [11,10,9,8,7,6]
];

translate([tube_width/2+tube_thickness-insert_base_length/2,tube_depth+angle_depth-(insert_bar_height+insert_thickness+insert_buffer)-insert_distance_from_tube_end,tube_length+tube_thickness])translate([insert_base_length,insert_bar_height + insert_thickness + insert_buffer,0])rotate([0,0,180])polyhedron(insert_slot_upper_points,insert_slot_upper_faces);

translate([tube_width/2+tube_thickness-insert_base_length/2,tube_depth+angle_depth-(insert_thickness+insert_buffer)-insert_distance_from_tube_end,0])cube([insert_base_length,insert_thickness+insert_buffer,tube_thickness]);


if (grid_pattern == "squares") square_grid();
else if (grid_pattern == "squares2") square_grid2();   
    
}

//security_bar
translate([tube_thickness,tube_depth+angle_depth-insert_distance_from_tube_end,tube_thickness])translate([0,insert_distance_from_tube_end,0])rotate([0,0,270])triangle(insert_distance_from_tube_end,security_bar_width,tube_length);
translate([tube_width-tube_thickness,tube_depth+angle_depth-insert_distance_from_tube_end,tube_thickness])triangle(insert_distance_from_tube_end,security_bar_width,tube_length);

//slide bar
translate([-slide_bar_width,tube_depth+angle_depth-slide_bar_length,0])
color("red"){cube([slide_bar_width,slide_bar_length,slide_bar_height]); 
}
translate([tube_width+2*tube_thickness,tube_depth+angle_depth-slide_bar_length,0])
color("red"){cube([slide_bar_width,slide_bar_length,slide_bar_height]); 
}

}
}
else if (i==tube_count-1){
translate([0,tube_depth*i,0])    
union(){
difference(){
    translate([0,angle_depth,0])
    cube([tube_width+2*tube_thickness, tube_depth , tube_length + 2*tube_thickness]);
    translate([tube_thickness,0,tube_thickness])cube([tube_width, tube_depth + angle_depth, tube_length]);
    
//insert_slot
insert_slot_upper_points = [
    [0,0,0], //0
    [insert_base_length,0,0],//1
    [insert_base_length,insert_thickness + insert_buffer, 0],//2
    [insert_base_length/2 + insert_bar_length/2,insert_thickness + insert_buffer + insert_bar_height,0],//3
    [insert_base_length/2 - insert_bar_length/2,insert_thickness + insert_buffer + insert_bar_height,0],//4
    [0,insert_thickness + insert_buffer, 0],//5
    [0,0,tube_thickness], //6
    [insert_base_length,0,tube_thickness],//7
    [insert_base_length,insert_thickness + insert_buffer, tube_thickness],//8
    [insert_base_length/2 + insert_bar_length/2,insert_thickness + insert_buffer + insert_bar_height,tube_thickness],//9
    [insert_base_length/2 - insert_bar_length/2,insert_thickness + insert_buffer + insert_bar_height,tube_thickness],//10
    [0,insert_thickness + insert_buffer, tube_thickness],//11
];

*showPoints(insert_slot_upper_points);

insert_slot_upper_faces = [
    [0,1,2,3,4,5],
    [0,5,11,6],
    [5,4,10,11],
    [4,3,9,10],
    [3,2,8,9],
    [2,1,7,8],
    [1,0,6,7],
    [11,10,9,8,7,6]
];

translate([tube_width/2+tube_thickness-insert_base_length/2,tube_depth+angle_depth-(insert_bar_height+insert_thickness+insert_buffer)-insert_distance_from_tube_end,tube_length+tube_thickness])translate([insert_base_length,insert_bar_height + insert_thickness + insert_buffer,0])rotate([0,0,180])polyhedron(insert_slot_upper_points,insert_slot_upper_faces);

translate([tube_width/2+tube_thickness-insert_base_length/2,tube_depth+angle_depth-(insert_thickness+insert_buffer)-insert_distance_from_tube_end,0])cube([insert_base_length,insert_thickness+insert_buffer,tube_thickness]);


if (grid_pattern == "squares") square_grid();
else if (grid_pattern == "squares2") square_grid2();   
    
}
//security_bar
translate([tube_thickness,tube_depth+angle_depth-insert_distance_from_tube_end,tube_thickness])cube([security_bar_width,insert_distance_from_tube_end,tube_length]);
translate([tube_width-tube_thickness,tube_depth+angle_depth-insert_distance_from_tube_end,tube_thickness])cube([security_bar_width,insert_distance_from_tube_end,tube_length]);
//slide_bar
translate([-slide_bar_width,tube_depth+angle_depth-slide_bar_length,0])
color("red"){cube([slide_bar_width,slide_bar_length,slide_bar_height]); 
}
translate([tube_width+2*tube_thickness,tube_depth+angle_depth-slide_bar_length,0])
color("red"){cube([slide_bar_width,slide_bar_length,slide_bar_height]); 

}
}
}
}
}
}
// -----------------------------------------
if (cube_design == "corpus_brush"){
union(){

//plexi_cube part of the tube
difference(){
    cube([plexi_cube_width + 2*plexi_cube_thickness + 2*plexi_cube_buffer, plexi_cube_depth, plexi_cube_length+2*plexi_cube_thickness + 2*plexi_cube_buffer]);
    translate([plexi_cube_thickness,0,plexi_cube_thickness])cube([plexi_cube_width + 2*plexi_cube_buffer, plexi_cube_depth, plexi_cube_length + 2*plexi_cube_buffer]);
}

//angle
angle_points = [
    [0,0,0], //0
    [outer_cube_width,0,0],//1
    [outer_cube_width,0,outer_cube_length],//2
    [0,0,outer_cube_length],//3
    [tube_distance_left,0,tube_distance_bottom],//4
    [outer_cube_width-tube_distance_left,0,tube_distance_bottom],//5
    [outer_cube_width-tube_distance_left,0,outer_cube_length-tube_distance_bottom],//6
    [tube_distance_left,0,outer_cube_length-tube_distance_bottom],//7
    [tube_distance_left,angle_depth,tube_distance_bottom],//8
    [outer_cube_width-tube_distance_left,angle_depth,tube_distance_bottom],//9
    [outer_cube_width-tube_distance_left,angle_depth,outer_cube_length-tube_distance_bottom],//10
    [tube_distance_left,angle_depth,outer_cube_length-tube_distance_bottom],//11
    
];

*showPoints(angle_points);
angle_faces = [
    [1,0,4,5],
    [0,1,9,8],
    [5,4,8,9],
    [2,1,5,6],
    [1,2,10,9],
    [6,5,9,10],
    [3,2,6,7],
    [2,3,11,10],
    [7,6,10,11],
    [0,3,7,4],
    [3,0,8,11],
    [4,7,11,8],
];


translate([0,plexi_cube_depth,0])
polyhedron(angle_points, angle_faces);



//tube
translate([plexi_cube_width/2-tube_width/2 + plexi_cube_buffer,plexi_cube_depth ,plexi_cube_length/2-tube_length/2 + plexi_cube_buffer]) 

union(){
difference(){
    union(){
    cube([tube_width+2*tube_thickness, tube_depth + angle_depth, tube_length + 2*tube_thickness]);
        
    //Brush mounts
translate([-(plexi_cube_width/2-tube_width/2 + plexi_cube_buffer),-(plexi_cube_depth) ,-(plexi_cube_length/2-tube_length/2 + plexi_cube_buffer)]) translate([0,plexi_cube_width+tube_depth/2,((plexi_cube_length+2*plexi_cube_thickness+2*plexi_cube_buffer)-brush_width)/2])translate([-brush_head_length,0,brush_width])rotate([30,90,0])translate([0,brush_thickness,0])brush_mount();

translate([-(plexi_cube_width/2-tube_width/2 + plexi_cube_buffer),-(plexi_cube_depth) ,-(plexi_cube_length/2-tube_length/2 + plexi_cube_buffer)])translate([0,plexi_cube_width+tube_depth/2,((plexi_cube_length+2*plexi_cube_thickness+2*plexi_cube_buffer)-brush_width)/2])translate([+brush_head_length,0,brush_width])translate([plexi_cube_width+2*plexi_cube_thickness + 2*plexi_cube_buffer,0,-brush_width])rotate([0,180,0])rotate([30,90,0])translate([0,brush_thickness,0])brush_mount();
    }
    insert_slot_upper_points = [
    [0,0,0], //0
    [insert_base_length,0,0],//1
    [insert_base_length,insert_thickness + insert_buffer, 0],//2
    [insert_base_length/2 + insert_bar_length/2,insert_thickness + insert_buffer + insert_bar_height,0],//3
    [insert_base_length/2 - insert_bar_length/2,insert_thickness + insert_buffer + insert_bar_height,0],//4
    [0,insert_thickness + insert_buffer, 0],//5
    [0,0,tube_thickness], //6
    [insert_base_length,0,tube_thickness],//7
    [insert_base_length,insert_thickness + insert_buffer, tube_thickness],//8
    [insert_base_length/2 + insert_bar_length/2,insert_thickness + insert_buffer + insert_bar_height,tube_thickness],//9
    [insert_base_length/2 - insert_bar_length/2,insert_thickness + insert_buffer + insert_bar_height,tube_thickness],//10
    [0,insert_thickness + insert_buffer, tube_thickness],//11
];

*showPoints(insert_slot_upper_points);

insert_slot_upper_faces = [
    [0,1,2,3,4,5],
    [0,5,11,6],
    [5,4,10,11],
    [4,3,9,10],
    [3,2,8,9],
    [2,1,7,8],
    [1,0,6,7],
    [11,10,9,8,7,6]
];

translate([tube_width/2+tube_thickness-insert_base_length/2,tube_depth+angle_depth-(insert_bar_height+insert_thickness+insert_buffer)-insert_distance_from_tube_end,tube_length+tube_thickness])translate([insert_base_length,insert_bar_height + insert_thickness + insert_buffer,0])rotate([0,0,180])polyhedron(insert_slot_upper_points,insert_slot_upper_faces);

translate([tube_width/2+tube_thickness-insert_base_length/2,tube_depth+angle_depth-(insert_thickness+insert_buffer)-insert_distance_from_tube_end,0])cube([insert_base_length,insert_thickness+insert_buffer,tube_thickness]);

    translate([tube_thickness,0,tube_thickness])cube([tube_width, tube_depth + angle_depth, tube_length]);
    
    //Brushes for to get the spacing right
translate([-(plexi_cube_width/2-tube_width/2 + plexi_cube_buffer),-(plexi_cube_depth) ,-(plexi_cube_length/2-tube_length/2 + plexi_cube_buffer)])translate([0,plexi_cube_width+tube_depth/2,((plexi_cube_length+2*plexi_cube_thickness+2*plexi_cube_buffer)-brush_width)/2])translate([-brush_head_length,0,brush_width])rotate([30,90,0])brush();

translate([-(plexi_cube_width/2-tube_width/2 + plexi_cube_buffer),-(plexi_cube_depth) ,-(plexi_cube_length/2-tube_length/2 + plexi_cube_buffer)])translate([0,plexi_cube_width+tube_depth/2,((plexi_cube_length+2*plexi_cube_thickness+2*plexi_cube_buffer)-brush_width)/2])translate([+brush_head_length,0,brush_width])translate([plexi_cube_width+2*plexi_cube_thickness + 2*plexi_cube_buffer,0,-brush_width])rotate([0,180,0])rotate([30,90,0])brush();

    
if (grid_pattern == "squares") square_grid();
else if (grid_pattern == "squares2") square_grid2();   
}

//security_bar
translate([tube_thickness,tube_depth+angle_depth-insert_distance_from_tube_end,tube_thickness])translate([0,insert_distance_from_tube_end,0])rotate([0,0,270])triangle(insert_distance_from_tube_end,security_bar_width,tube_length);
translate([tube_width-tube_thickness,tube_depth+angle_depth-insert_distance_from_tube_end,tube_thickness])triangle(insert_distance_from_tube_end,security_bar_width,tube_length);


//slide bar
translate([-slide_bar_width,tube_depth+angle_depth-slide_bar_length,0])
color("red"){cube([slide_bar_width,slide_bar_length,slide_bar_height]); 
}
translate([tube_width+2*tube_thickness,tube_depth+angle_depth-slide_bar_length,0])
color("red"){cube([slide_bar_width,slide_bar_length,slide_bar_height]); 
}
}
}
}




// darkener
else if (cube_design == "darkener"){
darkener_top_width = plexi_cube_width+2*plexi_cube_thickness+2*plexi_cube_buffer;
darkener_top_depth = plexi_cube_depth_overall-plexi_cube_depth+plexi_cube_thickness;
darkener_top_length = plexi_cube_length+2*plexi_cube_thickness+2*plexi_cube_buffer;
darkener_bottom_width = plexi_cube_width+4*plexi_cube_thickness+4*plexi_cube_buffer;
darkener_bottom_depth = darkener_overhang+2*plexi_cube_thickness;
darkener_bottom_length = plexi_cube_length+4*plexi_cube_thickness+4*plexi_cube_buffer;

difference(){
cube([darkener_bottom_width,darkener_top_depth,darkener_bottom_length]);
translate([2*plexi_cube_thickness+2*plexi_cube_buffer,plexi_cube_thickness,2*plexi_cube_thickness+2*plexi_cube_buffer])cube([darkener_top_width-2*plexi_cube_thickness,darkener_top_depth-plexi_cube_thickness,darkener_top_length - 2*plexi_cube_thickness]);
}
    

translate([0,darkener_top_depth,0])difference(){
cube([darkener_bottom_width,darkener_bottom_depth,darkener_bottom_length]);
translate([plexi_cube_thickness+plexi_cube_buffer,0,plexi_cube_thickness+plexi_cube_buffer]) cube([plexi_cube_width+2*plexi_cube_thickness+3*plexi_cube_buffer,darkener_overhang+2*plexi_cube_thickness,plexi_cube_length+2*plexi_cube_thickness+3*plexi_cube_buffer]);

}
}

else if (cube_design == "funnel"){
    funnel_slide_length = tube_count * tube_depth - 8;
    translate([0,funnel_pyramid_length+funnel_slide_width,0])
    difference(){
    cube([funnel_slide_length, funnel_slide_width, funnel_slide_height]);
    translate([0,0,2])cube([funnel_slide_length,funnel_slide_width/2, funnel_slide_hollow_height]);
    cube([funnel_slide_length, funnel_slide_buffer_width,2]);
    }
    translate([0,funnel_slide_width,0])mirror([0,1,0])difference(){
    cube([funnel_slide_length, funnel_slide_width, funnel_slide_height]);
    translate([0,0,2])cube([funnel_slide_length,funnel_slide_width/2, funnel_slide_hollow_height]);
    cube([funnel_slide_length, funnel_slide_buffer_width,2]);
    }
    
    
    funnel_pyramid_points = [
    [funnel_slide_length, funnel_pyramid_length,0],
    [funnel_slide_length,0,0],
    [0,0,0],
    [0,funnel_pyramid_length,0],
    [funnel_slide_length/2,funnel_pyramid_length/2,funnel_pyramid_tip_height]];
    
    funnel_pyramid_faces = [
    [0,1,4],
    [1,2,4],
    [2,3,4],
    [3,0,4],
    [1,0,3],
    [2,1,3]];
    
    funnel_pyramid_points_hollow = [
    [funnel_slide_length, funnel_pyramid_length,-2],
    [funnel_slide_length,0,-2],
    [0,0,-2],
    [0,funnel_pyramid_length,-2],
    [funnel_slide_length/2,funnel_pyramid_length/2,funnel_pyramid_tip_height-1]];
    
    funnel_pyramid_faces_hollow = [
    [0,1,4],
    [1,2,4],
    [2,3,4],
    [3,0,4],
    [1,0,3],
    [2,1,3]];
    
    difference(){
    union(){translate([0,funnel_slide_width,funnel_slide_height-2])cube([funnel_slide_length,funnel_pyramid_length, 2]);
    translate([0,funnel_slide_width,funnel_slide_height])polyhedron(funnel_pyramid_points, funnel_pyramid_faces);
    translate([funnel_slide_length/2-funnel_tip_cube_length/2,(funnel_pyramid_length+2*funnel_slide_width)/2-funnel_tip_cube_width/2,funnel_pyramid_tip_height+funnel_slide_height-funnel_tip_cube_height-1])cube([funnel_tip_cube_width, funnel_tip_cube_length, funnel_tip_cube_height]);
    }
    union(){
    color("red")translate([0,funnel_slide_width,funnel_slide_height])polyhedron(funnel_pyramid_points_hollow, funnel_pyramid_faces_hollow);
    
    translate([funnel_slide_length/2,funnel_pyramid_length/2 + funnel_slide_width,10])color("turquoise")cylinder(h=funnel_hollow_cylinder_height, d=funnel_hollow_cylinder_diameter);
    }
}
}
