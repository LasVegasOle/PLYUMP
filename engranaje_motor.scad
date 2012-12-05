/******************************************************/
/* peristaltic extruder for 3d printing     		  */
/* file: engranaje_motor.scad			 			  */
/* author: luis rodriguez				 	          */
/* version: 0.1						 		          */
/* w3b: tiny.cc/lyu     					 		  */
/* info:				    				 		  */
/******************************************************/
// @todo: - 

use <involute_gears.scad>
// Rim = llanta; bore

color("indigo")
union(){
gear (number_of_teeth=24,
	circular_pitch=400,
	hub_thickness=4,
	pressure_angle=20);


translate( [ 0 ,
 0, 
 8/2]) {

cylinder(r=20, h=8, center=true);	
}

}

/*module gear (
	number_of_teeth=15,
	circular_pitch=false, diametral_pitch=false,
	pressure_angle=28,
	clearance = 0.2,
	gear_thickness=5,
	rim_thickness=8,
	rim_width=5,
	hub_thickness=10,
	hub_diameter=15,
	bore_diameter=5,
	circles=0,
	backlash=0,
	twist=0,
	involute_facets=0,
	flat=false)*/