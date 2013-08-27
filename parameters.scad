/******************************************************/
/* PLYUMP                                             */
/* file: parameters.scad                              */
/* author: Luis Rodriguez                             */
/* version: 0.41                                      */
/* w3b: http://lyulyulyulyu.tumblr.com                */
/* info: This file contains all the shared parameters */
/******************************************************/

birthday_day = 26; // used for cylinders $fn

/* Bearings dimensions (mm) */
bearings_clearance = 0.5; 	// Used to "easily fit bearings into their holes"
// 608zz id=8 od=22 thickness=7
608zz_inside_diameter = 8;
608zz_outside_diameter = 22;
608zz_thickness = 7;

// 624zz id=4 od=13 thickness=5
624zz_inside_diameter = 4;
624zz_outside_diameter = 13;
624zz_thickness = 5;

/* NEMA 17 */
nema_17_length = 47.5;
nema_17_height = 42.2;
nema_17_screw_distance = 31.04;
nema_rollers_clearance = 3;

/* ROLLERS */
rollers_number_total = 10;
rollers_number = rollers_number_total / 2;
rollers_wall = 0; // just in case a plastic roller is used
rollers_diameter = 624zz_outside_diameter + rollers_wall * 2;
rollers_radius = rollers_diameter / 2;
rollers_clearance = rollers_diameter;
rollers_angle = 360 / ( rollers_number );

rollers_shaft_diameter = 624zz_inside_diameter + bearings_clearance;
rollers_bearings_contacts_thickness = 2;
rollers_bearings_contacts_height = 3;

rollers_width = 624zz_thickness * 9;

rollers_holder_thickness = 3;//624zz_thickness/2;
rollers_holder_central_bearing_support_thickness = 3;
rollers_holder_central_bearing_support_height = 624zz_thickness;
rollers_holder_central_bearing_wall_thickness = 1;


roller_interior_angle = ( 180 - rollers_angle ) / 2;
echo(str("roller_interior_angle = ", roller_interior_angle));

roller_inbetween_distance = 1.7 * rollers_diameter; // 1.5 is the oversized distance!
echo(str("roller_inbetween_distance = ", roller_inbetween_distance));
roller_radious_triangle_rectangle_height = roller_inbetween_distance * sin (roller_interior_angle);
echo(str("roller_radious_triangle_rectangle_height = ", roller_radious_triangle_rectangle_height));

rollers_position_radius = roller_radious_triangle_rectangle_height / sin(rollers_angle);
echo(str("rollers_position_radius = ", rollers_position_radius));

rollers_position_exterior_radius= rollers_position_radius + rollers_radius;
echo(str("rollers_position_exterior_radius = ", rollers_position_exterior_radius));

/* Base */

pinched_tube = 2.4;
pump_body_wall_thickness = 10;

pump_body_interior_wall_radius = rollers_position_radius + pinched_tube + rollers_radius; 
echo(str("pump_body_interior_wall_radius = ", pump_body_interior_wall_radius));

/* Gears */
// Common
gear_ratio =3;
gear_motor_teeth = 11;
gear_peristaltic_teeth = gear_ratio*gear_motor_teeth;
gear_peristaltic_thickness = 608zz_thickness * 2; // "*2" due to herringbone!
gear_peristaltic_center_bearing_radius = 608zz_outside_diameter/2;

// Circular pitch is calculate through pitch radius for peristaltic and motor gear
// in order to avoid rollers crashing nema 17 motor
//
// 		nema_17_height/2 + rollers_position_radius + rollers_radius + pinched_tube = 
// 		gear_peristaltic_pitch_radius + gear_motor_pitch_radius
//
//		gear_peristaltic_pitch_radius + gear_motor_pitch_radius =
//		gear_peristaltic_teeth * circular_pitch / 360 + gear_motor_teeth * circular_pitch / 360 =
//		(gear_peristaltic_teeth + gear_motor_teeth)/360 * circular_pitch
//
//		circular_pitch = 
//		360*(nema_17_height/2 + rollers_position_radius + rollers_radius + pinched_tube ) /
//		(gear_peristaltic_teeth + gear_motor_teeth)	
// //circular_pitch = 360*gear_peristaltic_radius/gear_peristaltic_teeth;
// circular_pitch = 360 * (nema_17_height/2 + rollers_position_radius + rollers_radius + pinched_tube ) /
// 		(gear_peristaltic_teeth + gear_motor_teeth);

//		gear_peristaltic_pitch_radius = pump_body_wall_thickness + pinched_tube + rollers_diameter 
//		+ gear_peristaltic_center_bearing_radius
//
//		gear_peristaltic_teeth * circular_pitch / 360 = pump_body_wall_thickness + pinched_tube + rollers_diameter 
//		+ gear_peristaltic_center_bearing_radius
//
circular_pitch = 360 * (nema_17_height/2 + rollers_position_radius + rollers_radius + pinched_tube ) / (gear_peristaltic_teeth + gear_motor_teeth);

echo(str("circular_pitch = ", circular_pitch));
// Pitch diameter: Diameter of pitch circle.
gear_peristaltic_pitch_diameter = gear_peristaltic_teeth * circular_pitch / 180;
gear_peristaltic_pitch_radius = gear_peristaltic_pitch_diameter/2;
echo(str("Pitch radius gear peristaltic= ",gear_peristaltic_pitch_radius));
// Diametrial pitch: Number of teeth per unit length.
gear_peristaltic_pitch_diametrial = gear_peristaltic_teeth / gear_peristaltic_pitch_diameter;
// Addendum: Radial distance from pitch circle to outside circle.
gear_peristaltic_addendum = 1/gear_peristaltic_pitch_diametrial;
//Outer Circle
gear_peristaltic_outside_radius = gear_peristaltic_pitch_radius+gear_peristaltic_addendum;
echo(str("Outside radius gear peristaltic= ",gear_peristaltic_outside_radius));

gear_motor_neck_height = 10;
gear_motor_neck_diameter = 13;
gear_motor_thickness = 608zz_thickness * 2; // "*2" due to herringbone!
gear_motor_shaft_diameter = 5.5;

// Pitch diameter: Diameter of pitch circle.
gear_motor_pitch_diameter = gear_motor_teeth * circular_pitch / 180;
gear_motor_pitch_radius = gear_motor_pitch_diameter/2;
echo(str("Pitch radius gear motor= ",gear_motor_pitch_radius));
// Diametrial pitch: Number of teeth per unit length.
gear_motor_pitch_diametrial = gear_motor_teeth / gear_motor_pitch_diameter;
// Addendum: Radial distance from pitch circle to outside circle.
gear_motor_addendum = 1/gear_motor_pitch_diametrial;
//Outer Circle
gear_motor_outside_radius = gear_motor_pitch_radius+gear_motor_addendum;
echo(str("Outside radius gear motor= ",gear_motor_outside_radius));

pressure_angle=30;
twist=200;

gear_motor_bolt_width = 3;
gear_motor_bolt_length = 5.8;

// this includes tolerance 4 ma printa!
3mm_screw_radius = 3.4/2;
3mm_tight_screw_radius = 3.2/2;
4mm_screw_radius = 5/2;
4mm_screw_head_radius = 7 / 2;
