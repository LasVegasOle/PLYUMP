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
pump_body_clearance = 10;
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
motor_wall_support_lenght = 10;
motor_wall_support_height = nema_17_height + pump_body_base_thickness;
motor_holder_thickness = 5;

pump_body_lateral_screws_offset = 17;
pump_body_cartridges_offset = (rollers_width - 4mm_screw_radius) / 3;
echo(str("pump_body_cartridges_offset = ", pump_body_cartridges_offset));

//rotate([0, -90, 0])
//lateral();
//rotate([90, 0, 0])
//front();
motor_holder();

module motor_holder(){
	difference(){
		union(){
			motor_holder_body();
			motor_wall_support();
			mirror([0, 1, 0])
			motor_wall_support();
		}
		union(){
			motor_lateral_screws();
			motor_holder_hole();
		}
	}
}

module motor_holder_hole(){
	cube(size=[pump_body_motor_support_width - 2*pump_body_lateral_thickness, 
		nema_17_height - 2*pump_body_lateral_thickness, 
		pump_body_base_thickness*2], center=true);
}

module motor_holder_body(){
			translate([ 0, 0, 
			0 ]) 
		color("Red")
		cube(size=[pump_body_motor_support_width, 
			nema_17_height,
		 	pump_body_base_thickness], center=true);
}

module motor_wall_support(){
	difference(){
	union(){
		color("LimeGreen")
		translate([ (pump_body_motor_support_width + motor_holder_thickness)/2 , 
			( -motor_wall_support_lenght + nema_17_height ) / 2, 
			(motor_wall_support_height - pump_body_base_thickness)/2 ]) 
		cube(size=[motor_holder_thickness, 
			motor_wall_support_lenght, 
			motor_wall_support_height], center=true);
	}
	union(){
		motor_holder_screws();
	}
}
}

module motor_holder_screws(){
		translate([(pump_body_motor_support_width + motor_holder_thickness)/2 , 
			( -motor_wall_support_lenght + nema_17_height ) / 2, 
			(nema_17_height - nema_17_screw_distance + pump_body_base_thickness) / 2]) 
		rotate([0, 90, 0])
		cylinder(r=3mm_screw_radius, h=10, center=true);

		translate([(pump_body_motor_support_width + motor_holder_thickness)/2 , 
			( -motor_wall_support_lenght + nema_17_height ) / 2, 
			(nema_17_height - nema_17_screw_distance + pump_body_base_thickness) / 2 + nema_17_screw_distance]) 
		rotate([0, 90, 0])
		cylinder(r=3mm_screw_radius, h=10, center=true);
}

module front(){
	color("Red")
	difference(){
		union(){
			cube(size=[pump_body_width, pump_body_lateral_thickness, pump_body_height], center=true);
		}
		union(){
			front_hole();
			cartridges_screws();
			front_screws();
			mirror([1, 0, 0]){
			cartridges_screws();
			front_screws();}
		}
	}
}

module motor_lateral_screws(){
	translate([-pump_body_motor_support_width/2, nema_17_height/4, 0])
	rotate([0,90,0]) 
	#cylinder(r=3mm_screw_radius, h=40, center=true);

	translate([-pump_body_motor_support_width/2, -nema_17_height/4, 0])
	rotate([0,90,0]) 
	#cylinder(r=3mm_screw_radius, h=40, center=true);

}

module front_hole(){
	translate([0, 0, -pump_body_height/8])
	#cube(size=[pump_body_width -4*pump_body_lateral_thickness, pump_body_lateral_thickness*2, 
		3*pump_body_height/4], center=true);
}

module lateral(){
	color("LimeGreen")
	difference(){
		union(){
			cube(size=[pump_body_lateral_thickness, pump_body_int_length, pump_body_height], center=true);
			bearing_support();
		}
		union(){
			bearing_hole();	
			lateral_center_hole();
			#lateral_screws();
			translate([20, 0, (pump_body_base_thickness-pump_body_height)/2]) // guarrada
			motor_lateral_screws();
		}
	}
}

module lateral_screws(){
	translate([0, 0, 3*pump_body_lateral_screws_offset/2]) 
	rotate([0, 90, 90]) 	
		for ( i = [ 0 : 3 ] ) {
		translate([ pump_body_lateral_screws_offset * i, 0, 0]) 
		cylinder(r=3mm_tight_screw_radius, h=pump_body_shaft_height*2, $fn = birthday_day, center=true);
	}
}

module front_screws(){
	translate([(pump_body_width - pump_body_lateral_thickness )/2, 0, 0]) 
	lateral_screws();
}
module lateral_center_hole(){
	// center hole
	translate([0, 0, 0]) 
	cube(size=[10, 
		pump_body_int_length - 2* pump_body_lateral_thickness, 
		pump_body_height - 2*pump_body_lateral_thickness], center=true);
}

module bearing_support(){
	//color('Red');
	hull() {
		translate([ 0, 0, pump_body_shaft_height/2])
		//body	
		rotate([0, 90, 0]) 		
		cylinder(r=rollers_position_minimum_radius + rollers_radius/2, h=pump_body_lateral_thickness, center=true);
		// hull support
		translate([ 0, 0, pump_body_height/2])
		cube(size=[pump_body_lateral_thickness, pump_body_int_length, 1], center=true);
	}
}

module bearing_hole(){
	translate([ 0, 0, pump_body_shaft_height/2])
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
		0, 
		0])
	for ( i = [ 0 : 3 ] ) {
		translate([ pump_body_cartridges_offset * i, 0, 0]) 
		cylinder(r=4mm_screw_radius, h=pump_body_shaft_height, $fn = birthday_day, center=true);
	}
}