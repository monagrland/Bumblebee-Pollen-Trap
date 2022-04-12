//Variables
$fn = 100;
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

outer_ring_width = 4;
outer_ring_height = 2;
inner_ring_width = 1;
inner_ring_height = 1;
number_slides = 4;

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
    height = 4;
    angle = 20;
    
    render()intersection(){
    union(){
    translate([0,3.1,0.5])
    difference(){
    difference(){
    translate([0,0,height/2])
    rotate([angle,0,0])
    difference(){
    scale([width*1.64,length*2.1,height*1.18]) sphere(d=1);
    translate([0,0,2])rotate([90,0,180])cylinder(h=20,d1=10,d2=0,center=true);
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
        X = ((diameter/2)+outer_ring_width+(inner_ring_width/2)) * cos((360/number_slides)*i);
        Y = ((diameter/2)+outer_ring_width+(inner_ring_width/2)) * sin((360/number_slides)*i);
        translate([X,Y,outer_ring_height/2])rotate(90,[0,0,1])rotate((360/number_slides)*i,[0,0,1])scale([1,1,10])slide();
    }
}
    for (i=[0:number_slides-1]){
        X = ((diameter/2)+outer_ring_width+(inner_ring_width/2)) * cos((360/number_slides)*i);
        Y = ((diameter/2)+outer_ring_width+(inner_ring_width/2)) * sin((360/number_slides)*i);
        translate([X,Y,outer_ring_height/2])rotate(90,[0,0,1])rotate((360/number_slides)*i,[0,0,1])slide();
    }
    
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
[3,2,1,0],
[0,1,5,4],
[2,3,4,5],
[0,4,3],
[1,2,5],
];
translate([(base_plate_length_upper-bar_length)/2,base_plate_width_lower+base_plate_width_upper-lower_bar_distance_from_bottom,base_plate_thickness])translate([bar_length,0,0])rotate([0,0,180])polyhedron(bottom_bar_points, bottom_bar_faces);

translate([base_plate_length_upper/2,base_plate_width_lower+base_plate_width_upper-lower_bar_distance_from_bottom-(outer_ring_width+diameter_hole),base_plate_thickness])filter(diameter_hole, outer_ring_width, outer_ring_height, inner_ring_width,inner_ring_height,number_slides);
}
//hole
translate([base_plate_length_upper/2,base_plate_width_lower+base_plate_width_upper-lower_bar_distance_from_bottom-(outer_ring_width+diameter_hole),0])cylinder(h=base_plate_thickness, d=diameter_hole);
}