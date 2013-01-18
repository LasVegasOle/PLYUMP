/******************************************************/
/* PLYUMP                                             */
/* file: rollers_holders.scad                         */
/* author: Luis Rodriguez                             */
/* version: 0.30                                      */
/* w3b: tiny.cc/lyu                                   */
/* info:                                              */
/******************************************************/

include <parameters.scad>
use <gear_peristaltic.scad>

// Testing
rollers_holders();

/* MODULES */

module rollers_holders(){
	difference(){
		union(){ // Add
			rollers_holders_body();
		}
		union(){ // Substract
			#central_bearings();
			#rollers_shafts();
		}
	}
}

module rollers_holders_body(){
	cylinder(r=rollers_position_minimum_radius + rollers_radius, h=608zz_thickness/2, center=true);
}