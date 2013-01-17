/******************************************************/
/* PLYUMP                                             */
/* file: gear_motor.scad                              */
/* author: Luis Rodriguez                             */
/* version: 0.30                                      */
/* w3b: tiny.cc/lyu                                   */
/* info:                                              */
/******************************************************/

include <parameters.scad>
use <involute_gears.scad>

// Testing
gear_motor();

/* MODULES */

module gear_motor(){
	difference(){
		union(){ // Add
			half_gear_motor();
			mirror([0,0,1])
				half_gear_motor();
				gear_motor_neck();
		}
		union(){ // Substract
			gear_motor_shaft();
			gear_motor_screw_holder();
		}
	}
}

// Half herringbone peristaltic gear
module half_gear_motor(){
	gear (number_of_teeth=gear_motor_teeth,
		circular_pitch=circular_pitch,
		pressure_angle=pressure_angle,
		gear_thickness = gear_motor_thickness/2,
		rim_thickness = gear_motor_thickness/2,
		rim_width = rim_width,
		hub_thickness = 0,
		twist=twist/gear_motor_teeth);
}

module gear_motor_neck(){
	translate([0, 0, (gear_motor_thickness + gear_motor_neck_height ) /2 ])
		cylinder( r = gear_motor_neck_diameter/2, h = gear_motor_thickness + gear_motor_neck_height, 
			$fn=birthday_day, center=true);
}

module gear_motor_shaft(){
		cylinder( r = gear_motor_shaft_diameter / 2,  
			h = ( gear_motor_thickness + gear_motor_neck_height ) * 3, 
			$fn = birthday_day,
			center=true);
}

module gear_motor_screw_holder(){
		// Screw hole
		translate([0, gear_motor_neck_height, gear_motor_thickness ] ) {
			rotate([90, 0, 0]) {
				cylinder( r = 3.4 / 2,  
					h =  gear_motor_neck_diameter/2 + gear_motor_shaft_diameter , $fn = birthday_day,
					center=true);
			}	
		}
		// Bolt hole
		translate([0, gear_motor_neck_diameter/2 / (1.65) , gear_motor_thickness + gear_motor_neck_height/3 ]) {
			cube(size=[gear_motor_bolt_length, gear_motor_bolt_width, gear_motor_thickness ], center=true);	
		}
}