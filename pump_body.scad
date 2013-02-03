/******************************************************/
/* PLYUMP                                             */
/* file: pump_body.scad                               */
/* author: Luis Rodriguez                             */
/* version: 0.34                                      */
/* w3b: tiny.cc/lyu                                   */
/* info:                                              */
/******************************************************/

include <parameters.scad>
use <gear_peristaltic.scad>

/*Base*/
pump_body_base_thickness = pump_body_lateral_thickness;
pump_body_base_width_clearance = 3;
pump_body_peristaltic_rotor_width = gear_peristaltic_thickness + 2 * ( rollers_width + rollers_holder_thickness + gear_motor_bolt_width) + pump_body_base_width_clearance;

// Pump body peristaltic part dimensions
pump_body_cavity_exterior_radius = rollers_exterior_radius + pinched_tube + pump_body_lateral_thickness;
echo(str("pump_body_cavity_exterior_radius = ", pump_body_cavity_exterior_radius));
pump_body_cavity_exterior_height = pump_body_base_thickness + rollers_width + rollers_holder_thickness + 3 * gear_motor_bolt_width ;

pump_body_cavity_interior_radius = rollers_exterior_radius + pinched_tube;
echo(str("pump_body_cavity_interior_radius = ", pump_body_cavity_interior_radius));
pump_body_cavity_interior_height = rollers_width + rollers_holder_thickness + 3 * gear_motor_bolt_width + pump_body_lateral_thickness;

// Pump body gear part dimensions
pump_body_gear_cavity_interior_radius = gear_peristaltic_outside_radius + pump_body_base_width_clearance;
echo(str("pump_body_gear_cavity_interior_radius = ", pump_body_gear_cavity_interior_radius));
pump_body_gear_cavity_interior_height = gear_peristaltic_thickness/2 + pump_body_base_width_clearance;

pump_body_gear_cavity_exterior_radius = gear_peristaltic_outside_radius + pump_body_lateral_thickness + pump_body_base_width_clearance;
echo(str("pump_body_gear_cavity_exterior_radius = ", pump_body_gear_cavity_exterior_radius));
pump_body_gear_cavity_exterior_height = gear_peristaltic_thickness/2 + pump_body_base_width_clearance + pump_body_lateral_thickness;

pump_body_feet_length = nema_17_height + rollers_position_minimum_radius + rollers_radius + pinched_tube + pump_body_lateral_thickness;
pump_body_wall_width = 45;
pump_body_wall_height = pump_body_cavity_exterior_height + pump_body_base_thickness;

pump_body_short_wall_width = 15;
pump_body_short_wall_height = pump_body_cavity_exterior_height + pump_body_base_thickness;

pump_body_pressure_tube_diameter = 10;
pump_body_tube_screw_holders_distance = 16;

number_screw_holders_exterior = 15;

// Testing
//color("LimeGreen") 
//translate([0, 0, pump_body_shaft_height]) {
//	rotate([0, 90, 0]) {
//		gear_peristaltic();
//	}
//}

//pump_body_motor();
pump_body_legs();

module pump_body_legs(){
	difference(){
		union(){ // Add
			body_exterior();
			central_shaft_support();
			wall();
			foot();
			mirror([1,0,0]){
				foot();
				short_wall();
			}
		}
		union(){ // Subtract
			peristaltic_cavity();
			gear_cavity();
			central_shaft();
			gears_contact();
			screw_holders_exterior();
		}
	}
}

module pump_body_motor(){
	difference(){
		union(){ // Add
			body_exterior();
			central_shaft_support();
			motor_support();
			motor_holder();
			short_wall();
			mirror([1,0,0]){
				wall();
			}
		}
		union(){ // Subtract
			peristaltic_cavity();
			gear_cavity();
			central_shaft();
			screw_holders_exterior();
			#motor_space();
		}
	}
}

module body_exterior(){
	difference(){
		union(){
			translate([0, 0, 3*pump_body_cavity_exterior_height/4 + pump_body_gear_cavity_exterior_height/2]) 
			cylinder(r=pump_body_gear_cavity_exterior_radius, 
			h=pump_body_gear_cavity_exterior_height, center=true);	// top cylinde

			translate([0, 0, pump_body_cavity_exterior_height/2]) 
			cylinder(r1=pump_body_cavity_exterior_radius, r2=pump_body_gear_cavity_exterior_radius, 
			h=pump_body_cavity_exterior_height/2, center=true);	// middle cone

			cylinder(r=pump_body_cavity_exterior_radius, 
			h=pump_body_cavity_exterior_height/2, center=true);	// lower cylinder
		}

		translate([0, pump_body_gear_cavity_exterior_radius, 0]) 
		cube(size=[pump_body_gear_cavity_exterior_radius*2, 
			pump_body_gear_cavity_exterior_radius*2, 
			pump_body_gear_cavity_exterior_radius*2], center=true);

	}
}

module peristaltic_cavity(){
	translate([0, 0, 
		pump_body_cavity_interior_height/2 - pump_body_cavity_exterior_height/4 + pump_body_base_thickness]) 
	cylinder(r=pump_body_cavity_interior_radius, h=pump_body_cavity_interior_height, center=true);
}

module gear_cavity(){
	translate([0, 0, 
		3*pump_body_cavity_exterior_height/4 + pump_body_gear_cavity_interior_height/2 + pump_body_lateral_thickness]) 
	cylinder(r=pump_body_gear_cavity_interior_radius, h=pump_body_gear_cavity_interior_height, center=true);
}

module central_shaft(){
	translate([0, 0, pump_body_base_thickness/2 - pump_body_cavity_exterior_height/4])
	cylinder(r=(608zz_inside_diameter+bearings_clearance)/2, h=pump_body_base_thickness, center=true);
}

module central_shaft_support(){
	translate([0, 0, pump_body_base_thickness/2 - pump_body_cavity_exterior_height/4])
	cylinder(r=608zz_outside_diameter/1.5, h=pump_body_base_thickness, center=true);
}
module pressure_tube_guide(){
	translate([-pump_body_lateral_thickness, 
		0,
		pump_body_wall_height/2 - rollers_width/2 - gear_motor_bolt_width])
	rotate([90, 0, 0])
		cylinder(r=pump_body_pressure_tube_diameter/2, h=pump_body_wall_width, center=true);
}

module screw_holders(){
	translate([0, pump_body_wall_width/3, 
		pump_body_wall_height/2  - rollers_width/2 - gear_motor_bolt_width + pump_body_tube_screw_holders_distance/2])
		rotate([0,90,0])
		cylinder( r = 3mm_screw_radius , h = pump_body_wall_width, $fn = birthday_day , center=true);
		translate([0, pump_body_wall_width/3, 
				pump_body_wall_height/2  - rollers_width/2 - gear_motor_bolt_width - pump_body_tube_screw_holders_distance/2])
		rotate([0,90,0])
		cylinder( r = 3mm_screw_radius , h = pump_body_wall_width, $fn = birthday_day , center=true);
}

module wall(){
	translate([pump_body_cavity_interior_radius + pump_body_lateral_thickness/2, 
		pump_body_wall_width/2 - 0.5, 
		pump_body_cavity_exterior_height/2- pump_body_cavity_exterior_height/4 + pump_body_base_thickness/2]){
		difference(){
			cube(size=[pump_body_lateral_thickness, 
				pump_body_wall_width, 
				pump_body_wall_height], center=true);
				screw_holders();
		}
	}
}

module short_wall(){
	translate([pump_body_cavity_interior_radius + pump_body_lateral_thickness/2, 
		pump_body_short_wall_width/2 - 0.5, 
		pump_body_cavity_exterior_height/2- pump_body_cavity_exterior_height/4 + pump_body_base_thickness/2]){
			cube(size=[pump_body_lateral_thickness, 
				pump_body_short_wall_width, 
				pump_body_short_wall_height], center=true);
	}	
}

module foot(){
	translate([pump_body_cavity_interior_radius + pump_body_lateral_thickness/2, 
		-pump_body_feet_length/2, 
		pump_body_base_thickness/2 - pump_body_cavity_exterior_height/4]) 
	cube(size=[pump_body_lateral_thickness, pump_body_feet_length, pump_body_base_thickness], center=true);
}

module gears_contact(){
	#translate([0,-pump_body_cavity_exterior_radius - gear_motor_outside_radius*1.5, 0])
		cylinder(r=gear_motor_outside_radius*1.5, h=150, center=true);
}

// Dirty dirtyyyyyyyyyyyyyyyyy 608zz_thickness*5¿??¿ what jajajaj
module screw_holders_exterior(){
	rotate([0,0,-6])
	translate([0, 0, 608zz_thickness*5]) 
	for ( i = [ 1 : number_screw_holders_exterior ] ) {
		translate( [ (pump_body_gear_cavity_interior_radius + pump_body_lateral_thickness/2) * cos( 360/number_screw_holders_exterior * i ), 
			(pump_body_gear_cavity_interior_radius + pump_body_lateral_thickness/2) * sin( 360/number_screw_holders_exterior * i ),  
			0])
		cylinder( r = 3mm_screw_radius , h = 608zz_thickness*6, $fn = birthday_day , center=true);
	}
}

module motor_support(){
	translate([0, -pump_body_cavity_exterior_radius/2, pump_body_cavity_exterior_height/4])
		cube(size=[nema_17_height, pump_body_cavity_exterior_radius, pump_body_cavity_exterior_height], center=true);
}
module motor_space(){
	translate([0, -nema_17_height/2 - pump_body_cavity_exterior_radius , 0])
		cube(size=[nema_17_height, nema_17_height, pump_body_cavity_exterior_height*4], center=true);	
}

module motor_holder(){
	translate([0, 
		-nema_17_height + pump_body_lateral_thickness,
		3*pump_body_base_thickness/2 - pump_body_cavity_exterior_height/4])
		cube(size=[nema_17_height + 2*pump_body_lateral_thickness, 
			nema_17_height + pump_body_lateral_thickness, 
			pump_body_base_thickness*3], center=true);
}
////////////////////////////////////////////////////////////////////
// OOOOOOOOOOOOOOOOOOOOOOLLLLLLLLLLLLLLLLLLLLDDDDDDDDDDDDDDDDDDDDDDD
////////////////////////////////////////////////////////////////////
/* MODULES 

module pump_body(){
	difference(){
		union(){ // Add
			peristaltic_cavity_exterior();
			gear_cavity_exterior();
			easy_printing_transition();
		}
		union(){ // Subtract
			peristaltic_cavity_interior();
			gear_cavity_interior();
			central_bearing_shaft();
			screw_holders();
		}
	}
}

module peristaltic_cavity_exterior(){
	color("LimeGreen")
	lateral_shape(r = pump_body_cavity_exterior_radius, h = pump_body_cavity_exterior_height);

}

module gear_cavity_exterior(){
	color("Indigo")
	translate([0, 0, pump_body_cavity_exterior_height/2 + pump_body_gear_cavity_exterior_height/2]) 
	lateral_shape( r = pump_body_gear_cavity_exterior_radius, h = pump_body_gear_cavity_exterior_height );
}

module peristaltic_cavity_interior(){
	color("Green")
	translate([0, 0, pump_body_base_thickness/2 + pump_body_base_thickness/2]) 
	lateral_shape(r = pump_body_cavity_interior_radius, h = pump_body_cavity_interior_height);

}

module gear_cavity_interior(){
	color("Purple")
	translate([0, 0, pump_body_cavity_exterior_height/2 + pump_body_gear_cavity_exterior_height/2 + pump_body_base_thickness/2]) 
	lateral_shape( r = pump_body_gear_cavity_interior_radius, h = pump_body_gear_cavity_interior_height );
}

module central_bearing_shaft(){
	color("Peru")
	cylinder(r = (608zz_inside_diameter+bearings_clearance)/2, h = pump_body_base_thickness * 8 , center=true);
}


/* WARNING~~~ this module is d************rty as heeeeeeeeeeell loco
module easy_printing_transition(r = pump_body_cavity_exterior_radius -1,
	bt = 2*pump_body_base_thickness+1,
	lt = 2*pump_body_lateral_thickness ){
	color("Red")
	translate([0, 0, pump_body_cavity_exterior_height/2 +1]) 
	union(){
		difference(){
			rotate_extrude(convexity = 10, $fn = birthday_day)
			translate([r, 0, 0])
			polygon(points=[[0,0],[bt,0],[0,-2*lt]], paths=[[0,1,2]]);
			translate([0, r/2 + lt/2, -bt/2]) 
			cube(size=[r*4, r + lt, lt*4], center=true);
		}	

		translate([r, 0, 0])
		rotate([270,0,0])
		linear_extrude( height = 608zz_outside_diameter , $fn = birthday_day)
		polygon(points=[[0,0],[bt,0],[0,2*lt]], paths=[[0,1,2]]);

		mirror([1, 0, 0]) {

			translate([r, 0, 0])
			rotate([270,0,0])
			linear_extrude( height = 608zz_outside_diameter , $fn = birthday_day) 
			polygon(points=[[0,0],[bt,0],[0,2*lt]], paths=[[0,1,2]]);

		}
	}

}

module lateral_shape(r = 10, h = 5, square_length = 608zz_outside_diameter){
	union(){
		difference(){
			cylinder(r=r, h=h, center=true);
			translate([0, r/2, 0]) 
			cube(size=[r*4, r, h], center=true);
		}
		translate([0, square_length/2, 0])cube(size=[r*2, square_length, h], center=true);
	}
}

module screw_holders(){
	for ( i = [ 1 : rollers_number ] ) {
		translate( [ (pump_body_gear_cavity_interior_radius + pump_body_lateral_thickness/2) * cos( rollers_angle * i ), 
			(pump_body_gear_cavity_interior_radius + pump_body_lateral_thickness/2) * sin( rollers_angle * i ),  
			0])
		cylinder( r = 3mm_screw_radius , h = 608zz_thickness*20, $fn = birthday_day , center=true);
	}
}