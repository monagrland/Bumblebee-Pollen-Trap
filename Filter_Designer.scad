//Variables
base_plate_length_lower = 26;
base_plate_length_upper = 28;
base_plate_width_lower = 34;
base_plate_width_upper = 18;
base_plate_thickness = 2;

bar_length = 16;
bar_width = 2;
bar_height = 6;

diameter_hole = 6.5;
diameter_text_thickness = 2;
diameter_text_size = 8;

lower_bar_width = 2;
lower_bar_height = 2;
lower_bar_distance_from_bottom = 6;


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

//top bar
translate([(base_plate_length_upper-bar_length)/2,base_plate_width_upper,base_plate_thickness])rotate([0,0,270])cube([bar_width, bar_length, bar_height]);

//diameter text
translate([base_plate_length_upper/2,base_plate_width_upper/2,base_plate_thickness])rotate([0,0,180])linear_extrude(diameter_text_thickness)text(str(diameter_hole), size=diameter_text_size,halign="center",valign="center");

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
[0,1,2,3],
[0,1,5,4],
[2,3,4,5],
[0,4,3],
[1,2,5],
];
translate([(base_plate_length_upper-bar_length)/2,base_plate_width_lower+base_plate_width_upper-lower_bar_distance_from_bottom,base_plate_thickness])translate([bar_length,0,0])rotate([0,0,180])polyhedron(bottom_bar_points, bottom_bar_faces);