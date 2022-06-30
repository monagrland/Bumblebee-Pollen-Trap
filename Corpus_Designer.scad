//Variables
cube_design = 2;
grid_pattern = "squares"; //squares, squares2 (rotated by 45°)
plexi_cube_width = cube_design==1 ? 39:32;
plexi_cube_length = cube_design==1 ? 35:30;
plexi_cube_depth = 20;
plexi_cube_thickness = 2;
plexi_cube_buffer = 0.5; //1mm room in every direction
insert_bar_height = 6; //needs to be the same as in the insert creator
insert_bar_length = 16; //needs to be the same as in the insert creator
insert_base_length = 28; //needs to be the same as "base plate length upper" in the insert creator
insert_thickness = 2; //needs to be the same as "base plate thickness" in the insert creator
insert_buffer = 1;
insert_distance_from_tube_end = 4;

tube_thickness = 2;

tube_width = 28;
tube_length = 28;
tube_depth = 38.5;

security_bar_width = 4;

slide_bar_length = 40.5;
slide_bar_width = 1.6; //decreased from 2 to 1,6 for buffer
slide_bar_height = 2;
//if square grid pattern

square_width = 4;
square_length = 4;
square_distance = 2.5;
number_squares_per_row = 4;
number_squares_per_column = 3;

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
translate([tube_width/2+tube_thickness-grid_width/2,tube_depth+angle_depth-(insert_distance_from_tube_end+insert_thickness+insert_buffer+insert_bar_height),0])
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

//plexi_cube part of the tube
difference(){
    cube([plexi_cube_width + 2*plexi_cube_thickness + 2*plexi_cube_buffer, plexi_cube_depth, plexi_cube_length+2*plexi_cube_thickness + 2*plexi_cube_buffer]);
    translate([plexi_cube_thickness,0,plexi_cube_thickness])cube([plexi_cube_width + 2*plexi_cube_buffer, plexi_cube_depth, plexi_cube_length + 2*plexi_cube_buffer]);
}

//angle
tube_distance_left = (plexi_cube_width/2+plexi_cube_buffer+plexi_cube_thickness-tube_width/2-tube_thickness);
tube_distance_bottom = (plexi_cube_length/2+plexi_cube_buffer+plexi_cube_thickness-tube_length/2-tube_thickness);
angle_depth = max(tube_distance_left, tube_distance_bottom);
outer_cube_width = plexi_cube_width + 2*plexi_cube_thickness + 2*plexi_cube_buffer;
outer_cube_length = plexi_cube_length + 2*plexi_cube_thickness + 2*plexi_cube_buffer;

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

//square_pattern
/*
grid_width = square_width*number_squares_per_row + square_distance*(number_squares_per_row-1);
grid_length = square_length*number_squares_per_column + square_distance*(number_squares_per_column-1);
translate([tube_width/2+tube_thickness-grid_width/2,tube_depth+angle_depth-(insert_distance_from_tube_end+insert_thickness+insert_buffer+insert_bar_height),0])
translate([grid_width,0,0])
rotate([0,0,180])
for (j=[0:number_squares_per_column-1]){
for (i=[0:number_squares_per_row-1]){
    translate([i*(square_distance+square_width),j*(square_distance+square_length),0])cube([square_width,square_length,tube_thickness]);
    }
}
*/

if (grid_pattern == "squares") square_grid();
else if (grid_pattern == "squares2") square_grid2();   
    
}
translate([tube_thickness,tube_depth+angle_depth-insert_distance_from_tube_end,tube_thickness])cube([security_bar_width,insert_distance_from_tube_end,tube_length]);
translate([tube_width-tube_thickness,tube_depth+angle_depth-insert_distance_from_tube_end,tube_thickness])cube([security_bar_width,insert_distance_from_tube_end,tube_length]);
translate([-slide_bar_width,tube_depth+angle_depth-slide_bar_length,0])
color("red"){cube([slide_bar_width,slide_bar_length,slide_bar_height]); 
;
}
translate([tube_width+2*tube_thickness,tube_depth+angle_depth-slide_bar_length,0])
color("red"){cube([slide_bar_width,slide_bar_length,slide_bar_height]); 

}
}