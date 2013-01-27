/******************************************************/
/* PLYUMP                                             */
/* file: pump_body.scad                               */
/* author: Luis Rodriguez                             */
/* version: 0.32                                      */
/* w3b: tiny.cc/lyu                                   */
/* info:                                              */
/******************************************************/

include <parameters.scad>
use <gear_peristaltic.scad>

/*Base*/
pump_body_base_thickness = 7;
pump_body_lateral_thickness = pump_body_base_thickness ;//* 2; 
pump_body_base_width_clearance = 3;
pump_body_peristaltic_rotor_width = gear_peristaltic_thickness + 2 * ( rollers_width + rollers_holder_thickness + gear_motor_bolt_width) + pump_body_base_width_clearance;

// Pump body peristaltic part dimensions
pump_body_cavity_exterior_radius = rollers_exterior_radius + pinched_tube + pump_body_lateral_thickness;
echo(str("pump_body_cavity_exterior_radius = ", pump_body_cavity_exterior_radius));
pump_body_cavity_exterior_height = pump_body_base_thickness + rollers_width + rollers_holder_thickness + 3 * gear_motor_bolt_width ;

pump_body_cavity_interior_radius = rollers_exterior_radius + pinched_tube;
echo(str("pump_body_cavity_interior_radius = ", pump_body_cavity_interior_radius));
pump_body_cavity_interior_height = rollers_width + rollers_holder_thickness + 3 * gear_motor_bolt_width + pump_body_base_thickness;

// Pump body gear part dimensions
pump_body_gear_cavity_interior_radius = gear_peristaltic_outside_radius + pump_body_base_width_clearance;
echo(str("pump_body_gear_cavity_interior_radius = ", pump_body_gear_cavity_interior_radius));
pump_body_gear_cavity_interior_height = gear_peristaltic_thickness/2 + pump_body_base_width_clearance;

pump_body_gear_cavity_exterior_radius = gear_peristaltic_outside_radius + pump_body_lateral_thickness + pump_body_base_width_clearance;
echo(str("pump_body_gear_cavity_exterior_radius = ", pump_body_gear_cavity_exterior_radius));
pump_body_gear_cavity_exterior_height = gear_peristaltic_thickness/2 + pump_body_base_width_clearance + pump_body_lateral_thickness;



// Testing
//color("LimeGreen") 
//translate([0, 0, pump_body_shaft_height]) {
//	rotate([0, 90, 0]) {
//		gear_peristaltic();
//	}
//}

pump_body();
//rotate([90, 0, 0]) 
//tube_holder_free();


/* MODULES */

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


/* WARNING~~~ this module is d************rty as heeeeeeeeeeell loco*/
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