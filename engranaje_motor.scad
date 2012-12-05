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
gear (number_of_teeth=24,
	circular_pitch=400,
	pressure_angle=14,
	twist = 10);
