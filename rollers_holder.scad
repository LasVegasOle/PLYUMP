/******************************************************/
/* PLYUMP                                             */
/* file: rollers_holder.scad                         */
/* author: Luis Rodriguez                             */
/* version: 0.30                                      */
/* w3b: tiny.cc/lyu                                   */
/* info:                                              */
/******************************************************/

include <parameters.scad>
use <gear_peristaltic.scad>

// Testing
rollers_holder();

/* MODULES */

module rollers_holder(){
	difference(){
		union(){ // Add
			rollers_holder_body();
			rollers__holder_bearings_contacts();
			rollers_holder_central_bearing_support();
		}
		union(){ // Substract
			rollers_holder_central_bearing();
			rollers_shafts();
		}
	}
}

module rollers_holder_body(){
	cylinder(r=rollers_position_minimum_radius + rollers_radius/2, h=rollers_holder_thickness, center=true);
}

module rollers__holder_bearings_contacts(){
	for ( i = [ 1 : rollers_number ] ) {
		translate( [ rollers_position_minimum_radius * cos( rollers_angle * i ), 
			rollers_position_minimum_radius * sin( rollers_angle * i ),  
			rollers_holder_thickness/2])
		cylinder( r = ( rollers_shaft_diameter + rollers_bearings_contacts_thickness)/2 , 
			h = rollers_bearings_contacts_height, $fn = birthday_day , center=true);
	}
}

module rollers_holder_central_bearing_support(){
	translate([0, 0, rollers_holder_central_bearing_support_height/2 + rollers_holder_thickness/2]) {
		difference(){
			cylinder(r=(608zz_outside_diameter+bearings_clearance+rollers_holder_central_bearing_support_thickness)/2,
				h=rollers_holder_central_bearing_support_height, $fn = birthday_day, center=true);
			cylinder(r=(608zz_outside_diameter+bearings_clearance)/2, 
				h=rollers_holder_central_bearing_support_height, $fn = birthday_day, center=true);	
		}
	}
	
}

module rollers_holder_central_bearing(){
	cylinder(r=608zz_inside_diameter/2 + bearings_clearance * 4, h=rollers_holder_thickness, center=true);
}