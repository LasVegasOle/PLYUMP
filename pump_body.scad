/******************************************************/
/* PLYUMP                                             */
/* file: pump_body.scad                               */
/* author: Luis Rodriguez                             */
/* version: 0.35                                      */
/* w3b: tiny.cc/lyu                                   */
/* info:                                              */
/******************************************************/

include <parameters.scad>

/*Base*/
pump_body_base_thickness = pump_body_lateral_thickness;
pump_body_clearance = 5;
pump_body_peristaltic_rotor_width = gear_peristaltic_thickness + 2 * ( rollers_width + rollers_holder_thickness + 4*gear_motor_bolt_width + pump_body_base_width_clearance);

pump_body_width = gear_peristaltic_thickness + 2 * ( rollers_width + rollers_holder_thickness + 4*gear_motor_bolt_width + pump_body_clearance + pump_body_lateral_thickness);

echo(str("Rotor width = ", gear_peristaltic_thickness + 2 * ( rollers_width + rollers_holder_thickness + 4*gear_motor_bolt_width ) ));

pump_body_length = 2 * (gear_peristaltic_outside_radius + pump_body_lateral_thickness + pump_body_clearance);
pump_body_shaft_height = gear_peristaltic_pitch_radius + gear_motor_pitch_radius + nema_17_height/2 + pump_body_base_thickness;
echo(str("pump_body_shaft_height = ", pump_body_shaft_height));

pump_body_height = pump_body_shaft_height - rollers_exterior_radius * cos(360/rollers_number);
echo(str("pump_body_height = ", pump_body_height));

pump_body_int_width = pump_body_width - 2*pump_body_lateral_thickness;
pump_body_int_length = pump_body_length - 2*pump_body_lateral_thickness;

pump_body_motor_support_width = (pump_body_int_width - gear_peristaltic_thickness) / 2 - gear_motor_neck_height;
echo(str("pump_body_motor_support_width = ", pump_body_motor_support_width));
motor_wall_support_thickness = pump_body_lateral_thickness + 1;

pump_body_cartridges_offset = (rollers_width - 4mm_screw_radius) / 3;
echo(str("pump_body_cartridges_offset = ", pump_body_cartridges_offset));


pump_body();
//lateral_walls_art();

module pump_body(){
	difference(){
		union(){ // Add
			body();
			bearing_support();
			mirror([1, 0, 0])
			bearing_support();
			
		}
		union(){ // Subtract
			cavity();

			bearing_hole();
			mirror([1, 0, 0])
			bearing_hole();

			cartridges_screws();
			mirror([1, 0, 0])
			cartridges_screws();
			mirror([0, 1, 0])
			cartridges_screws();
			mirror([1, 0, 0]) 
			mirror([0, 1, 0])
			cartridges_screws();

		}
	}
}

module body(){
	cube(size=[pump_body_width, pump_body_length, pump_body_height], center=true);
}

module cavity(){
	difference(){
		cube(size=[pump_body_int_width, pump_body_int_length, pump_body_height * 2], center=true);	
		motor_support();
	}
}

module motor_support(){
	translate([ (pump_body_int_width - pump_body_motor_support_width)/ 2, 0, 
			( - pump_body_height + pump_body_base_thickness ) / 2 ]) 
		color("Red")
		cube(size=[pump_body_motor_support_width, pump_body_length, pump_body_base_thickness], center=true);

	motor_wall_support();
	mirror([0, 1, 0])
	motor_wall_support();
}

module motor_wall_support(){
	color("LimeGreen")
	translate([pump_body_int_width / 2 + nema_17_height/2 - pump_body_motor_support_width , 
		( motor_wall_support_thickness + nema_17_height ) / 2, 
		(nema_17_height - pump_body_height)/2 ]) 
	cube(size=[nema_17_height, motor_wall_support_thickness, nema_17_height], center=true);
}

module bearing_support(){
	//color('Red');
	hull() {
		translate([( pump_body_width - pump_body_lateral_thickness ) / 2, 0, pump_body_shaft_height/2])
		//body	
		rotate([0, 90, 0]) 		
		cylinder(r=rollers_position_minimum_radius + rollers_radius/2, h=pump_body_lateral_thickness, center=true);
		// hull support
		translate([( pump_body_width - pump_body_lateral_thickness ) / 2, 0, pump_body_height/2])
		cube(size=[pump_body_lateral_thickness, pump_body_length, 1], center=true);
	}
}

module bearing_hole(){
	translate([( pump_body_width - pump_body_lateral_thickness ) / 2, 0, pump_body_shaft_height/2])
			rotate([0, 90, 0])
				union(){
					//central shaft
					cylinder(r=608zz_inside_diameter/2 + bearings_clearance * 4, 
						h=rollers_holder_thickness + rollers_holder_central_bearing_support_height * 2, center=true);
					// bearing hole
					translate([0, 0, pump_body_lateral_thickness/2 - 608zz_thickness/2])
					#cylinder(r=608zz_outside_diameter/2 + bearings_clearance/2, 
						h=608zz_thickness, center=true);	
				}
}

module central_shaft(){
	cylinder(r=608zz_inside_diameter/2 + bearings_clearance * 4, h=rollers_holder_thickness + rollers_holder_central_bearing_support_height * 2, center=true);
}

module central_bearing_support(){
	translate([0, 0, rollers_holder_thickness/2])
	#cylinder(r=608zz_outside_diameter/2 + bearings_clearance/2, h=608zz_thickness, center=true);
}

module cartridges_screws(){
	translate([gear_peristaltic_thickness/2 + 2 * gear_motor_bolt_width + 624zz_thickness/2, 
		(pump_body_length - pump_body_lateral_thickness ) / 2, 
		0])
	for ( i = [ 0 : 3 ] ) {
		translate([ pump_body_cartridges_offset * i, 0, 0]) 
		cylinder(r=4mm_screw_radius, h=pump_body_shaft_height, $fn = birthday_day, center=true);
		translate([ pump_body_cartridges_offset * i, 0, -pump_body_height/4]) 
		cylinder(r=4mm_screw_head_radius, h=pump_body_height, $fn = birthday_day, center=true);
			
	}
}

module lateral_walls_art(){
	translate([( pump_body_width- pump_body_lateral_thickness) / 2, 
		-4*20*sin(45), 0]) 
	rotate([90,45,90])
	for ( i = [ 0 : 4 ] ) {
		for ( j = [ 0 : 4 ] ) {
			translate([i*20, j*20, 0]) 
			if(i!=0 || j !=4)
			cylinder(r=6.5, h=pump_body_lateral_thickness*1.5, $fn = birthday_day, center=true);
		}

	}
}

module lateral_void(){
	translate([0, 0, 0])
		translate([( pump_body_width- pump_body_lateral_thickness) / 2, 
		0, 0])
		rotate([0,90,0])
	#cylinder(r=30, h=pump_body_lateral_thickness*2, center=true);
}