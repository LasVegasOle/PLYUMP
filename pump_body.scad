/******************************************************/
/* PLYUMP                                             */
/* file: pump_body.scad                               */
/* author: Luis Rodriguez                             */
/* version: 0.31                                      */
/* w3b: tiny.cc/lyu                                   */
/* info:                                              */
/******************************************************/

include <parameters.scad>

/*Base*/
pump_body_base_thickness = 5;
pump_body_base_width_clearance = 10;
pump_body_base_width = gear_peristaltic_thickness + 2 * ( rollers_width + rollers_holder_thickness + 2*pump_body_base_thickness + 2*gear_motor_bolt_width ) + pump_body_base_width_clearance;
pump_body_base_length = gear_peristaltic_pitch_diameter;
pump_body_motor_holder_length = 4;
pump_body_motor_holder_width = 4;
echo(str("base_width = ", pump_body_base_width));
echo(str("base_length = ", pump_body_base_length));
pump_body_shaft_height = nema_17_height + rollers_position_minimum_radius + rollers_radius + nema_rollers_clearance;
echo(str("Pump body shaft height = ", pump_body_shaft_height));

pump_body_base_lateral_height = pump_body_shaft_height + 608zz_outside_diameter*3/2;
echo(str("base_lateral_height = ", pump_body_base_lateral_height));

pump_base_lateral_opening_height = pump_body_shaft_height;

// Testing
pump_body();

/* MODULES */

module pump_body(){
	difference(){
		union(){ // Add
			base();
			lateral();
			mirror(1,0,0)
			lateral();
			//motor_screw_holder();
			// translate([pump_body_base_width/2, 0, nema_17_height/2 + pump_body_base_thickness/2]) 
			// cube(size=[100, nema_17_height, nema_17_height], center=true);
		}
		union(){ // Subtract
			base_opening();
			lateral_opening();
			pump_body_shaft();
			pump_body_bearings();
			mirror(){
				pump_body_bearings();
				lateral_opening();
			}
		}
	}
}

module base(){
	color("Cyan")
	cube(size=[pump_body_base_width, pump_body_base_length, pump_body_base_thickness], center=true);
}

module base_opening(){
	color("Orange")
	difference(){
		cube(size=[pump_body_base_width - pump_body_base_thickness*4 , 
			pump_body_base_length - pump_body_base_thickness*4, 
			pump_body_base_thickness], center=true);

		translate([pump_body_base_width/2 - nema_17_height/2, 0, 0]) 
			cube(size=[nema_17_height, 
				nema_17_height, 
				pump_body_base_thickness], center=true);


		}
	}

	module lateral(){
		color("Peru")
		translate([pump_body_base_width/2, 0, pump_body_base_thickness/2]) 
		polyhedron(
			points=[ 	[0,-pump_body_base_length/2,0],
			[0,0,pump_body_base_lateral_height],
			[0,pump_body_base_length/2,0],
			[-pump_body_base_thickness*2,-pump_body_base_length/2,0],
			[-pump_body_base_thickness*2,0,pump_body_base_lateral_height],
			[-pump_body_base_thickness*2,pump_body_base_length/2,0],  ],                                 
			triangles=[ 	[0,1,2],
			[5,4,3],
			[2,1,4],
			[2,4,5],
			[0,3,4],
			[0,4,1],
			[0,2,5],
			[0,5,3] ]                         
		);
	//http://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language#polyhedron
}

module motor_screw_holder(){
	color("Green")
	translate([gear_motor_thickness - pump_body_motor_holder_width/2, 
		- pump_body_motor_holder_length/2, 
		nema_17_height/4 + pump_body_base_thickness/2])
	cube(size=[pump_body_motor_holder_width, pump_body_motor_holder_length, nema_17_height/2], center=true);

}

module pump_body_shaft(){
	color("Indigo")
	translate([0, 0, pump_body_shaft_height + pump_body_base_thickness / 2])
	rotate([0, 90, 0]) 	
	cylinder(r=608zz_inside_diameter/2 + bearings_clearance * 4, h=pump_body_base_width*2, center=true);
}

module pump_body_bearings(){
	color("SpringGreen")
	translate([	pump_body_base_width/2 - 608zz_thickness, 0, 
		pump_body_shaft_height + pump_body_base_thickness / 2])
	rotate([0, 90, 0]) 	
	cylinder(r=( 608zz_outside_diameter+ bearings_clearance)/2 , h=608zz_thickness, center=true);
}

module lateral_opening(){
	color("Red")
	translate([pump_body_base_width/2, 0, pump_body_base_thickness/2]) 
	polyhedron(
		points=[ 	[0,-pump_body_base_length/2 + pump_body_base_thickness*2, 0],
		[ 0, 0, pump_base_lateral_opening_height],
		[0,pump_body_base_length/2 - pump_body_base_thickness*2,0],
		[-pump_body_base_thickness*2,-pump_body_base_length/2 + pump_body_base_thickness*2,0],
		[-pump_body_base_thickness*2,0, pump_base_lateral_opening_height],
		[-pump_body_base_thickness*2,pump_body_base_length/2 - pump_body_base_thickness*2,0],  ],                                 
		triangles=[ 	[0,1,2],
		[5,4,3],
		[2,1,4],
		[2,4,5],
		[0,3,4],
		[0,4,1],
		[0,2,5],
		[0,5,3] ]                         
	);
}