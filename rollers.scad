/******************************************************/
/* PLYUMP                                             */
/* file: rollers.scad                                 */
/* author: Luis Rodriguez                             */
/* version: 0.3                                       */
/* w3b: tiny.cc/lyu                                   */
/* info:                                              */
/******************************************************/
include <parameters.scad>

rollers_width = 33;
rollers_clearance = 1;
rollers_easy_printing_inverted_cone_thickness = 624zz_thickness;

// Testing
rollers();

/* MODULES */

module rollers(){
	difference(){
		union(){ // Add
			rollers_body();

			
		}
		union(){ // Substract
			rollers_shaft();
			rollers_bearings();
			mirror([0, 0, 1]) 
				rollers_bearings();
		}
	}
}

module rollers_body(){
	color("Cyan")
		cylinder(r=rollers_radius + rollers_clearance, h=rollers_width, $fn=birthday_day, center=true);
}

module rollers_shaft(){
	color("Red")
		cylinder(r=rollers_shaft_diameter/2 + rollers_clearance, h=rollers_width * 2, $fn=birthday_day, center=true);
}

module rollers_bearings(){
	translate([0, 0, rollers_width/2 - rollers_easy_printing_inverted_cone_thickness/2 ]) 
		cylinder(r=(624zz_outside_diameter+rollers_clearance)/2, h=624zz_thickness, $fn=birthday_day, center=true);

	color("Aqua")	
	translate([0, 0, rollers_width/2 - 624zz_thickness - 624zz_thickness/2 ]) 
		#cylinder(	r2=(624zz_outside_diameter+rollers_clearance)/2,
					r1=rollers_shaft_diameter/2 + rollers_clearance,
					 h=rollers_easy_printing_inverted_cone_thickness, 
					 $fn=birthday_day, center=true);
}