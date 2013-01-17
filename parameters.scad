/******************************************************/
/* PLYUMP                                             */
/* file: parameters.scad				 			  */
/* author: Luis Rodriguez                             */
/* version: 0.30                                      */
/* w3b: tiny.cc/lyu                                   */
/* info: This file contains all the shared parameters */
/******************************************************/

birthday_day = 26;

/* bearings dimensions (mm) */
bearings_clearance = 0.4; 	// Used to "easily fit bearings into their holes"
// 608zz id=8 od=22 thickness=7
608zz_inside_diameter = 8;
608zz_outside_diameter = 22;
608zz_thickness = 7;

// 624zz id=4 od=13 thickness=5
624zz_inside_diameter = 4;
624zz_outside_diameter = 13;
624zz_thickness = 5;

/* Gears */
// Common
gear_ratio = 3;
gear_motor_teeth = 11;
gear_peristaltic_thickness = 608zz_thickness * 2; // "*2" due to herringbone!
gear_peristaltic_teeth = gear_ratio*gear_motor_teeth;
gear_peristaltic_radius = 80/2;

circular_pitch = 360*gear_peristaltic_radius/gear_peristaltic_teeth;

// Pitch diameter: Diameter of pitch circle.
pitch_diameter_gear_peristaltic  =  gear_peristaltic_teeth * circular_pitch / 180;
pitch_radius_gear_peristaltic = pitch_diameter_gear_peristaltic/2;
// Diametrial pitch: Number of teeth per unit length.
pitch_diametrial_gear_peristaltic = gear_peristaltic_teeth / pitch_diameter_gear_peristaltic;
// Addendum: Radial distance from pitch circle to outside circle.
addendum_gear_peristaltic = 1/pitch_diametrial_gear_peristaltic;
//Outer Circle
outside_diameter_gear_peristaltic = pitch_radius_gear_peristaltic+addendum_gear_peristaltic;
echo(str("Outside diameter gear peristaltic= ",outside_diameter_gear_peristaltic));

gear_motor_height = 8;
gear_motor_neck_height = 8;
gear_motor_neck_diameter = 18;
gear_motor_thickness = 608zz_thickness * 2; // "*2" due to herringbone!
gear_motor_shaft_diameter = 5.5;

rollers_number = 12;
rollers_clearance = 0;
rollers_angle = 360 / ( rollers_number );
rollers_diameter = 624zz_outside_diameter;
rollers_radius = rollers_diameter / 2;
rollers_shaft_diameter = 624zz_inside_diameter;

rollers_radius_plus_clearance = rollers_radius + rollers_clearance / 2;
rollers_position_minimum_radius_minus_roller_radius = ( rollers_radius_plus_clearance - sin( rollers_angle / 2 ) 
	* rollers_radius_plus_clearance ) / sin( rollers_angle / 2 ) ;
rollers_position_minimum_radius = rollers_position_minimum_radius_minus_roller_radius + rollers_radius;
echo(str("Rollers position radius = ", rollers_position_minimum_radius ) );

pressure_angle=30;
twist=200;

gear_motor_bolt_width = 3;
gear_motor_bolt_length = 5.8;
