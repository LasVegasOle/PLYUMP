/******************************************************/
/* PLYUMP                                             */
/* file: gear_peristaltic.scad                        */
/* author: Luis Rodriguez                             */
/* version: 0.35                                      */
/* w3b: tiny.cc/lyu                                   */
/* info:                                              */
/******************************************************/

include <parameters.scad>
use <involute_gears.scad>

// Testing
gear_peristaltic();

/* MODULES */

module gear_peristaltic(){
	difference(){
		union(){ // Add
			half_gear_peristaltic();
			mirror([0,0,1])
			half_gear_peristaltic();
		}
		union(){ // Substract
			central_bearings();
			rollers_shafts();
			rotate([0, 0, 90]) 
			rollers_shafts();
			circles();
		}
	}
}

// Half herringbone peristaltic gear
module half_gear_peristaltic(){
	gear (number_of_teeth=gear_peristaltic_teeth,
		circular_pitch=circular_pitch,
		pressure_angle=pressure_angle,
		gear_thickness = gear_peristaltic_thickness/2,
		rim_thickness = gear_peristaltic_thickness/2,
		hub_thickness = 0,
		twist=twist/gear_peristaltic_teeth);
}

module central_bearings(){
	cylinder(r=(608zz_outside_diameter+bearings_clearance)/2, h=608zz_thickness*4, $fn = birthday_day, center=true);
}

module rollers_shafts(){
	for ( i = [ 1 : rollers_number ] ) {
		translate( [ rollers_position_minimum_radius * cos( rollers_angle * i ), 
			rollers_position_minimum_radius * sin( rollers_angle * i ),  
			0])
		cylinder( r = rollers_shaft_diameter/2 , h = 608zz_thickness*4, $fn = birthday_day , center=true);
	}
}

module circles(){
	for ( i = [ 1 : rollers_number*2 ] ) {
		translate( [ ( rollers_position_minimum_radius + (gear_peristaltic_pitch_radius-rollers_position_minimum_radius)/2 ) * cos( rollers_angle/2 * i ), 
			( rollers_position_minimum_radius + (gear_peristaltic_pitch_radius-rollers_position_minimum_radius)/2 ) * sin( rollers_angle/2 * i ),  
			0])
		cylinder( r = 5 , h = 608zz_thickness*4, $fn = birthday_day , center=true);
	}	
}