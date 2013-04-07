/******************************************************/
/* PLYUMP                                             */
/* file: rollers_holder.scad                          */
/* author: Luis Rodriguez                             */
/* version: 0.35                                      */
/* w3b: tiny.cc/lyu                                   */
/* info:                                              */
/******************************************************/

include <parameters.scad>
use <peristaltic_gear.scad>

// Testing
rollers_holder();

/* MODULES */

module rollers_holder(){
	difference(){
		union(){ // Add
			body();
			central_bearing_wall();
		}
		union(){ // Substract
			central_bearing_support();
			central_shaft();
			rollers_shafts(); // this comes from gear_peristaltic.scad
		}
	}
}

module body(){
	cylinder(r=rollers_position_radius + rollers_radius/2, h=rollers_holder_thickness, center=true);
}

module central_shaft(){
	cylinder(r=608zz_inside_diameter/2 + bearings_clearance * 4, h=rollers_holder_thickness + rollers_holder_central_bearing_support_height * 2, center=true);
}

module central_bearing_support(){
	translate([0, 0, 608zz_thickness/2 ])
		#cylinder(r=608zz_outside_diameter/2 + bearings_clearance/2, h=608zz_thickness, center=true);
}

module central_bearing_wall(){
	translate([0, 0, 608zz_thickness/4 ])
		#cylinder(r=608zz_outside_diameter/2 + bearings_clearance/2 + rollers_holder_central_bearing_wall_thickness, h=608zz_thickness/2, center=true);	
}