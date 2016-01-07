$fn=18;
grop_offset = 2;
main_width = 28;
main_length = 32.6;
main_height = 7.8;

prong_thick = 5.1;
round_radius_main = 2;
round_radius_intrusion = 3;

module rounded_cube(x, y, height, radius)
{
    module rounded_cylinder(xpos, ypos, height, radius)
    {
        translate([xpos, ypos, radius]) 
        union()
        { 
            cylinder(r=radius, h=height-2*radius);
            sphere(r=radius);
            translate([0,0, height-2*radius]) sphere(r=radius);
        }
    }
    hull()
    {
        rounded_cylinder(radius, radius, height, radius);
        rounded_cylinder(x-radius, radius, height, radius);
        rounded_cylinder(radius, y-radius, height, radius);
        rounded_cylinder(x-radius, y-radius, height, radius);
    }
}

module screw_hole(x, y, inner_d, outer_d, outer_depth, depth)
{
    translate([x,y,depth])
    rotate([0,180,0])
    rotate_extrude()
    union() {
        square([inner_d/2, depth]);
        square([outer_d/2, outer_depth]);
    }
    translate([x, y, -1]) cylinder(r=outer_d/2, h=outer_depth);
}




difference(){
    rounded_cube(main_width, main_length, main_height, 2);
    screw_hole(6.62, 9.6, 3.5, 7, 2, main_height+1);
    screw_hole(6.62+15.3, 9.6, 3.5, 7, 2, main_height+1);
    translate([grop_offset, 14, main_height-1]) rounded_cube(main_width-grop_offset*2, 15, 4, round_radius_intrusion);
    translate([grop_offset, 14, -3]) rounded_cube(main_width-grop_offset*2, 15, 4, round_radius_intrusion);
    }


    

union()
{
translate([0, main_length+6, 0]) rounded_cube(main_width/1.2, prong_thick, main_height, round_radius_main);
translate([(main_width-10)/2,main_length, (main_height-2.0)/2]) cube([10, 1, 2.0]);

translate([0, main_length-4.0, 0]) rounded_cube(9.1, 14.4, main_height, round_radius_main);
translate([(main_width/1.2+prong_thick/2-5.3), main_length+6+1.2, round_radius_main]) 
cylinder(r=prong_thick/2, h=main_height-2*round_radius_main);  
}



//#cube([]);