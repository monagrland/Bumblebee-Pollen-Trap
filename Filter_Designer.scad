//Variables
/* [Base Plate] */
//length of the lower part of the base plate
base_plate_length_lower = 26;
//length of the upper part of the base plate
base_plate_length_upper = 28;
//width of the lower part of the base plate
base_plate_width_lower = 34;
//length of the upper part of the base plate
base_plate_width_upper = 18;
//thickness of the baseplate
base_plate_thickness = 2;
// type of bar, newer versions only use "angled"
bar_type = "angled"; // [angled, bar]
// length of the bar
bar_length = 16;
// width of the bar
bar_width = 2;
// height of the bar
bar_height = 6;

//diameter of the hole, also input for the text at the top
diameter_hole = 5.5;
// thickness of the text at the top
diameter_text_thickness = 2;
// size of the text at the top
diameter_text_size = 8;

// additional text at the top
identifier = "a";

// width of the lower bar
lower_bar_width = 2;
// height of the lower bar
lower_bar_height = 2;
// distance from the bottom of the base plate to the lower bar
lower_bar_distance_from_bottom = 6;

/* [Hole Structure] */
// structure of the design around the hole
hole_structure = "triangle2"; //  [None, slides, triangle, triangle2, concentric, brush]

/* [Hole Structure == Slides] */
// width of the outer ring
outer_ring_width_slides = 4.0;
// height of the outer ring
outer_ring_height_slides = 2.0;
// width of the inner ring
inner_ring_width_slides = 1.0;
// height of the outer ring
inner_ring_height_slides = 1.5;
// number of slides, will be automatically oriented around the center of the hole
number_slides = 4;

// multiplier for the width of the slides
slide_width_factor = 0.7;
// multiplier for the length of the slides
slide_length_factor = 1;
// multiplier for the height of the slides
slide_height_factor = 1;
// offset of the slides from the center of the hole
slide_offset_from_center = 0;

/* [Hole Structure == Triangle] */
// width of the outer ring
outer_ring_width_triangle = 4.0;
// height of the outer ring
outer_ring_height_triangle = 2.0;
// width of the inner ring
inner_ring_width_triangle = 1.0;
// height of the inner ring
inner_ring_height_triangle = 1.5;
// number of bars, will be automatically oriented around the center of the hole
number_bars_triangle = 10;
// height of the triangles
triangle_height = 4;
// length of the triangles
triangle_length = 3;
// thickness of the triangles
triangle_thickness = 1;

/* [Hole Structure == Triangle2] */
// width of the outer ring
outer_ring_width_triangle2 = 4.0;
// height of the outer ring
outer_ring_height_triangle2 = 2.0;
// width of the inner ring
inner_ring_width_triangle2 = 1.0;
// height of the inner ring
inner_ring_height_triangle2 = 1.5;
// number of bars, will be automatically oriented around the center of the hole
number_bars_triangle2 = 10;
// height of the triangles
triangle2_height = 4;
// length of the triangles
triangle2_length = 3;
// thickness of the triangles
triangle2_thickness = 1;

/* [Hole Structure == Concentric] */
// height of the cone, careful, cant be higher than the upper bar or it will get stuck!
concentric_height = 6;
// starting point of the concentric rings, 
concentric_ring_height = 1.5;
// distance top to bottom hole
concentric_distance_top_bottom_hole = 6;
// width of the concentric rings
concentric_ring_width = 1;

/* [Misc] */
// Number of Faces: higher number is good for smoother curved areas, lower number significantly decreases rendering time, recommending 25 for playing around and 100 for exporting
$fn = 25;


//module to show points of a polyhedron
module showPoints(v) {
    for (i = [0: len(v)-1]) {
        translate(v[i]) color("red")
        text(str(i), font = "Courier New", size=1.5);

    }
}

//module to create slides for the filter
module slide (){
    width = 5.5;
    length = 4.5;
    height = 5;
    angle = 30;
difference(){
    render()intersection(){
    union(){
    translate([0,3.1,0.5])
    difference(){
    difference(){
    translate([0,0,height/2])
    rotate([angle,0,0])
    difference(){
    scale([width*1.64,length*2.1,height*1.18]) sphere(d=1);
    translate([0,0,2])rotate([90,0,180])cylinder(h=40,d1=6,d2=6,center=true);
    }
    translate([-(length),6-(width*1.65)/2,0])cube([width*2,length*1.5,height*2]);
}
    union(){
    translate([width*1.05,-length/2,height])cube([width,length*2,height*2],center=true);
    translate([-width*1.05,-length/2,height])cube([width,length*2,height*2],center=true);
    }
    translate([-width,-length*2.7,-height])cube([width*2,length*2,height*2]);
}
    infill_length = 6.05/2;
    infill_width = 1.4;
    infill_height = 4.5;
    infill_points=[
    [1.27,0,0], //0 base
    [infill_length,0,0], //1
    [infill_length,0,infill_height], //2
    [0,0,infill_height], //3
    [infill_length,infill_width,0], //4
    [infill_length,infill_width,infill_height], //5
    [0,infill_width,infill_height], //6
    [0,infill_width,infill_height*1.5/2], //7
    [0,0,infill_height/2] //8
    ];

    infill_faces = [
    [8,3,2,1,0],
    [0,1,4],
    [1,2,5,4],
    [3,6,5,2],
    [3,8,7,6],
    [8,0,7],
    [7,0,4],
    [4,5,6,7]
    ];
    *showPoints(infill_points);
    translate([0,0,0])rotate([90,0,180])polyhedron(infill_points, infill_faces);

    mirror([1,0,0])rotate([90,0,180])polyhedron(infill_points, infill_faces);
}
    translate([(-width*1.1)/2,0,0])cube([width*1.1,length,height*2]);
}
translate([0,0,-0.6])translate([1.5,length/2-3,height/2+0.2])rotate([30,0,0])rotate([0,30,0])cube([2,length*1.5,2]);
translate([0,0,-0.6])translate([-3.5,-((length/2-3)+1),(height/2+0.2)-1])rotate([30,0,0])rotate([0,330,0])cube([2,length*1.5,2]);

}
}

//module to create triangular bars
module triangle_bars(triangle_thickness,triangle_height, triangle_length){
    triangle_points = [
    [0,0,0],
    [triangle_thickness,0,0],
    [triangle_thickness,0,triangle_height],
    [0,0,triangle_height],
    [0,triangle_length,0],
    [triangle_thickness,triangle_length,0]
    ];
    triangle_faces = [
    [0,3,2,1],
    [0,1,5,4],
    [0,4,3],
    [2,3,4,5],
    [1,2,5],
    ];
    translate([triangle_thickness/2,0,0])rotate([0,0,180])polyhedron(triangle_points,triangle_faces);
}
//module to create rings    
module ring(h=1,outside_diameter = 10,cutout_diameter = 5,de = 0.1) {
    difference() {
        cylinder(h=h, r=outside_diameter/2);
        translate([0, 0, -de])
            cylinder(h=h+2*de, r=cutout_diameter/2);
    }
}


//module to create the filter with costumizable slides
module filter(diameter, outer_ring_width, outer_ring_height, inner_ring_width, inner_ring_height, number_slides){
    difference(){
    union(){
    ring(outer_ring_height, diameter + 2*outer_ring_width, diameter);
    translate([0,0,outer_ring_height])ring(inner_ring_height, diameter + 2*inner_ring_width, diameter);
    }
    
    for (i=[0:number_slides-1]){
        X = ((diameter/2)+outer_ring_width+(inner_ring_width/2)+slide_offset_from_center) * cos((360/number_slides)*i);
        Y = ((diameter/2)+outer_ring_width+(inner_ring_width/2)+slide_offset_from_center) * sin((360/number_slides)*i);
        translate([X,Y,outer_ring_height/2])rotate(90,[0,0,1])rotate((360/number_slides)*i,[0,0,1])scale([1,1,10])scale([slide_width_factor, slide_length_factor, slide_height_factor])slide();
    }
}
    for (i=[0:number_slides-1]){
        X = ((diameter/2)+outer_ring_width+(inner_ring_width/2)+slide_offset_from_center) * cos((360/number_slides)*i);
        Y = ((diameter/2)+outer_ring_width+(inner_ring_width/2)+slide_offset_from_center) * sin((360/number_slides)*i);
        translate([X,Y,outer_ring_height/2])rotate(90,[0,0,1])rotate((360/number_slides)*i,[0,0,1])scale([slide_width_factor, slide_length_factor, slide_height_factor])slide();
    }
}

module filter_triangle(diameter, outer_ring_width, outer_ring_height, inner_ring_width, inner_ring_height, number_slides, triangle_thickness,triangle_height, triangle_length){
    difference(){
    union(){
    ring(outer_ring_height, diameter + 2*outer_ring_width, diameter);
    translate([0,0,outer_ring_height])ring(inner_ring_height, diameter + 2*inner_ring_width, diameter);
    }
    
}
    for (i=[0:number_slides-1]){
        X = ((diameter/2)+slide_offset_from_center) * cos((360/number_slides)*i);
        Y = ((diameter/2)+slide_offset_from_center) * sin((360/number_slides)*i);
        translate([X,Y,outer_ring_height])rotate(90,[0,0,1])rotate((360/number_slides)*i,[0,0,1])triangle_bars(triangle_thickness,triangle_height, triangle_length);
    }
}

module filter_triangle2(diameter, outer_ring_width, outer_ring_height, inner_ring_width, inner_ring_height,bar_width, number_slides, triangle_thickness,triangle_height, triangle_length){
    for (i=[0:number_slides-1]){
        X = ((diameter/2)+triangle_height) * cos((360/number_slides)*i);
        Y = ((diameter/2)+triangle_height) * sin((360/number_slides)*i);
        translate([X,Y,-bar_width])rotate(90,[0,0,1])rotate((360/number_slides)*i,[0,0,1])rotate(270,[1,0,0])triangle_bars(triangle_thickness,triangle_height, triangle_length);
    }
    ring(triangle_length-bar_width, diameter + 2*triangle_height + 2, diameter+2*triangle_height);
}

//module to create concenctric filter model
module concentric(diameter,height,ring_height,distance_top_bottom,ring_width){
    difference(){
    color("blue")cylinder(d1=diameter_hole+14,d2=diameter_hole+distance_top_bottom,h=height);
    cylinder(d1=diameter_hole,d2=diameter_hole+distance_top_bottom,h=height);
    //ringwidth at specific height:
    //diameter_hole + (distance_top_bottom/height) * spec_height
    }
    ring1_height = 1.5;
    ring2_height = 3;
    ring3_height = 4.5;
    ring4_height = 6;
    ring1_outside_diameter = diameter+(distance_top_bottom/height)*ring1_height;
    ring2_outside_diameter = diameter+(distance_top_bottom/height)*ring2_height;
    ring3_outside_diameter = diameter+(distance_top_bottom/height)*ring3_height;
    ring4_outside_diameter = diameter+(distance_top_bottom/height)*ring4_height;
    translate([0,0,ring1_height-ring_height])color("red")ring(h=ring_height,outside_diameter=ring1_outside_diameter, cutout_diameter = ring1_outside_diameter - ring_width);
    translate([0,0,ring2_height-ring_height])color("blue")ring(h=ring_height,outside_diameter=ring2_outside_diameter, cutout_diameter = ring2_outside_diameter - ring_width);
    translate([0,0,ring3_height-ring_height])color("purple")ring(h=ring_height,outside_diameter=ring3_outside_diameter, cutout_diameter = ring3_outside_diameter - ring_width);
    translate([0,0,ring4_height-ring_height])color("orange")ring(h=ring_height,outside_diameter=ring4_outside_diameter, cutout_diameter = ring4_outside_diameter - ring_width);

}


difference(){
union(){
//base plate
base_plate_points = [
[0,0,0], //0, start
[0,base_plate_width_upper,0], //1, links oben
[(base_plate_length_upper - base_plate_length_lower)/2,base_plate_width_upper,0], //2 linke kante untere platte
[(base_plate_length_upper - base_plate_length_lower)/2,base_plate_width_upper+base_plate_width_lower, 0],//3
[((base_plate_length_upper - base_plate_length_lower)/2)+base_plate_length_lower,base_plate_width_upper+base_plate_width_lower, 0],//4
[((base_plate_length_upper - base_plate_length_lower)/2)+base_plate_length_lower,base_plate_width_upper, 0],//5
[base_plate_length_upper,base_plate_width_upper, 0],//6
[base_plate_length_upper,0, 0],//7
[0,0,base_plate_thickness], //8, start
[0,base_plate_width_upper,base_plate_thickness], //9, links oben
[(base_plate_length_upper - base_plate_length_lower)/2,base_plate_width_upper,base_plate_thickness], //10 linke kante untere platte
[(base_plate_length_upper - base_plate_length_lower)/2,base_plate_width_upper+base_plate_width_lower, base_plate_thickness],//11
[((base_plate_length_upper - base_plate_length_lower)/2)+base_plate_length_lower,base_plate_width_upper+base_plate_width_lower, base_plate_thickness],//12
[((base_plate_length_upper - base_plate_length_lower)/2)+base_plate_length_lower,base_plate_width_upper, base_plate_thickness],//13
[base_plate_length_upper,base_plate_width_upper, base_plate_thickness],//14
[base_plate_length_upper,0, base_plate_thickness]//15
];

base_plate_faces = [
[7,6,5,4,3,2,1,0],//bottom
[0,1,9,8],
[1,2,10,9],
[2,3,11,10],
[3,4,12,11],
[4,5,13,12],
[5,6,14,13],
[6,7,15,14],
[7,0,8,15],
[8,9,10,11,12,13,14,15]
];
polyhedron(base_plate_points, base_plate_faces);

if (bar_type=="bar"){
//top bar
translate([(base_plate_length_upper-bar_length)/2,base_plate_width_upper,base_plate_thickness])rotate([0,0,270])cube([bar_width, bar_length, bar_height]);
}
else if (bar_type=="angled"){
//top bar angled
insert_base_length = base_plate_length_upper;
insert_bar_length = bar_length;
insert_thickness = base_plate_thickness;
insert_bar_height = bar_height;
tube_thickness = base_plate_thickness;

insert_slot_upper_points = [
    [0,0,0], //0
    [insert_base_length,0,0],//1
    [insert_base_length,insert_thickness, 0],//2
    [insert_base_length/2 + insert_bar_length/2,insert_thickness + insert_bar_height,0],//3
    [insert_base_length/2 - insert_bar_length/2,insert_thickness + insert_bar_height,0],//4
    [0,insert_thickness, 0],//5
    [0,0,tube_thickness], //6
    [insert_base_length,0,tube_thickness],//7
    [insert_base_length,insert_thickness, tube_thickness],//8
    [insert_base_length/2 + insert_bar_length/2,insert_thickness + insert_bar_height,tube_thickness],//9
    [insert_base_length/2 - insert_bar_length/2,insert_thickness + insert_bar_height,tube_thickness],//10
    [0,insert_thickness, tube_thickness],//11
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
translate([0,base_plate_width_upper,0])rotate([90,0,0])polyhedron(insert_slot_upper_points,insert_slot_upper_faces);
}
//diameter text
translate([base_plate_length_upper/2,base_plate_width_upper/2,base_plate_thickness])rotate([0,0,180])linear_extrude(diameter_text_thickness)text(str(diameter_hole,identifier), size=diameter_text_size,halign="center",valign="center");

//bottom bar/triangle
bottom_bar_points=[
[0,0,0], //0 base
[bar_length,0,0], //1
[bar_length,0,lower_bar_height], //2
[0,0,lower_bar_height], //3
[0,lower_bar_width,0], //4
[bar_length,lower_bar_width,0], //5
[0,lower_bar_width,lower_bar_height] //6
];

bottom_bar_faces = [
[3,2,1,0],
[0,1,5,4],
[2,3,4,5],
[0,4,3],
[1,2,5],
];
translate([(base_plate_length_upper-bar_length)/2,base_plate_width_lower+base_plate_width_upper-lower_bar_distance_from_bottom,base_plate_thickness])translate([bar_length,0,0])rotate([0,0,180])polyhedron(bottom_bar_points, bottom_bar_faces);
}
//hole
if (hole_structure == "triangle2"){
translate([base_plate_length_upper/2,base_plate_width_lower+base_plate_width_upper-lower_bar_distance_from_bottom-(diameter_hole/2+14/2)-lower_bar_width,0])cylinder(h=base_plate_thickness, d=diameter_hole+2*triangle_height);
}
else if (hole_structure == "brush"){
    translate([(base_plate_length_upper-base_plate_length_lower)/2 +3,base_plate_width_upper,0])cube([base_plate_length_lower-6,base_plate_width_lower-lower_bar_distance_from_bottom-lower_bar_width,2]);
}

else{
translate([base_plate_length_upper/2,base_plate_width_lower+base_plate_width_upper-lower_bar_distance_from_bottom-(diameter_hole/2+14/2)-lower_bar_width,0])cylinder(h=base_plate_thickness, d=diameter_hole);
}

}
if (hole_structure == "slides"){
translate([base_plate_length_upper/2,base_plate_width_lower+base_plate_width_upper-lower_bar_distance_from_bottom-(diameter_hole/2+14/2)-lower_bar_width,base_plate_thickness])filter(diameter_hole, outer_ring_width_slides, outer_ring_height_slides, inner_ring_width_slides,inner_ring_height_slides,number_slides);
}
else if (hole_structure == "triangle"){
translate([base_plate_length_upper/2,base_plate_width_lower+base_plate_width_upper-lower_bar_distance_from_bottom-(diameter_hole/2+14/2)-lower_bar_width,base_plate_thickness])filter_triangle(diameter_hole, outer_ring_width_triangle, outer_ring_height_triangle, inner_ring_width_triangle,inner_ring_height_triangle,number_bars_triangle,triangle_thickness,triangle_height, triangle_length);
}

else if (hole_structure == "triangle2"){
translate([base_plate_length_upper/2,base_plate_width_lower+base_plate_width_upper-lower_bar_distance_from_bottom-(diameter_hole/2+14/2)-lower_bar_width,base_plate_thickness])filter_triangle2(diameter_hole, outer_ring_width_triangle2, outer_ring_height_triangle2, inner_ring_width_triangle2,inner_ring_height_triangle2,bar_width, number_bars_triangle2,triangle2_thickness,triangle2_height, triangle2_length);
}

else if (hole_structure == "concentric"){
translate([base_plate_length_upper/2,base_plate_width_lower+base_plate_width_upper-lower_bar_distance_from_bottom-(diameter_hole/2+14/2)-lower_bar_width,base_plate_thickness])concentric(diameter_hole,concentric_height,concentric_ring_height,concentric_distance_top_bottom_hole,concentric_ring_width);
}

