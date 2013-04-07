/******************************************************/
/* PLYUMP                                             */
/* file: peristaltic_gear.scad                        */
/* author: Luis Rodriguez                             */
/* version: 0.41                                      */
/* w3b: http://lyulyulyulyu.tumblr.com                */
/* info:                                              */
/******************************************************/

include <parameters.scad>
use <involute_gears.scad>
use <motor_gear.scad>

// Testing
gear_peristaltic();
// translate([gear_peristaltic_outside_radius + gear_motor_outside_radius, 0, 0]) {
// 	gear_motor();
// }
/* MODULES */

module gear_peristaltic(){
	difference(){
		union(){ // Add
			half_up_gear_peristaltic();
			mirror([0,0,1])
			half_down_gear_peristaltic();
		}
		union(){ // Substract
			central_bearings();
			central_shaft();
			rollers_shafts();
			//circles();
		}
	}
}

// Half herringbone peristaltic gear
module half_up_gear_peristaltic(){
	gear (number_of_teeth=gear_peristaltic_teeth,
		circular_pitch=circular_pitch,
		pressure_angle=pressure_angle,
		gear_thickness = gear_peristaltic_thickness/4,
		rim_thickness = gear_peristaltic_thickness/2,
		hub_thickness = 0,
		twist=twist/gear_peristaltic_teeth);
}
module half_down_gear_peristaltic(){
	gear (number_of_teeth=gear_peristaltic_teeth,
		circular_pitch=circular_pitch,
		pressure_angle=pressure_angle,
		gear_thickness = gear_peristaltic_thickness/2,
		rim_thickness = gear_peristaltic_thickness/2,
		hub_thickness = 0,
		twist=twist/gear_peristaltic_teeth);
}

module central_bearings(){
	translate([0, 0, gear_peristaltic_thickness/2 - 608zz_thickness]) 
		#cylinder(r=(608zz_outside_diameter+bearings_clearance)/2, h=608zz_thickness, $fn = birthday_day, center=true);
}

module central_shaft(){
	translate([0, 0, gear_peristaltic_thickness/2 - 608zz_thickness]) 
		#cylinder(r=608zz_inside_diameter/2 + bearings_clearance, h=608zz_thickness*10, $fn = birthday_day, center=true);		
}

module rollers_shafts(){
	for ( i = [ 1 : rollers_number ] ) {
		translate( [ rollers_position_radius * cos( rollers_angle * i ), 
			rollers_position_radius * sin( rollers_angle * i ),  
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