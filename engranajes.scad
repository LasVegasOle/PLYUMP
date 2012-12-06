/*****************************************************/
/* peristaltic extruder for 3d printing     		  */
/* file: engranaje_motor.scad			 			  */
/* author: luis rodriguez				 	          */
/* version: 0.1						 		          */
/* w3b: tiny.cc/lyu     					 		  */
/* info:				    				 		  */
/******************************************************/
// @todo: - 

use <involute_gears.scad>

// Rim = llanta

/*gear (number_of_teeth = numero_de_dientes,
	circular_pitch = distancia_entre_dientes * 180,
	hub_thickness=4,
	pressure_angle=20);


translate( [ 0 ,
 0, 
 8/2]) {
color("indigo")
cylinder( r = radio, h = 8, center = true );	
}

}*/
relacion_engranaje = 2;
radio_engranaje_peristaltico = 70 / 2;
dientes_engranaje_motor = 15;
dientes_engranaje_peristaltico = relacion_engranaje * dientes_engranaje_motor;
circular_pitch = radio_engranaje_peristaltico / dientes_engranaje_peristaltico * 360;

altura_engranaje = 10;

altura_engranaje_motor = 7;
altura_cuello_g_motor = 8;
radio_cuello_g_motor = 10;

diametro_shaft_motor = 5.2;

/* ~~ Pieza ~~ */

gear (circular_pitch=circular_pitch,
	gear_thickness = altura_engranaje,
	rim_thickness = altura_engranaje,
	rim_width = 3,
	hub_thickness = 6,
	number_of_teeth = dientes_engranaje_peristaltico
);


// Engranaje Motor
translate([radio_engranaje_peristaltico * 2, 0 , 0 ] ){
	difference(){
		union(){
			gear (circular_pitch=circular_pitch,
				gear_thickness = altura_engranaje_motor,
				rim_thickness = altura_engranaje_motor,
				hub_thickness = 0,
				bore_diameter = 3,
				number_of_teeth = dientes_engranaje_motor);

	// Cuello engranaje motor
	translate([0, 0, (altura_engranaje_motor + altura_cuello_g_motor ) /2 ]){
		cylinder( r = radio_cuello_g_motor, h = altura_engranaje_motor + altura_cuello_g_motor, center=true);
	}
}
union(){
// Eje central (shaft)
cylinder( r = diametro_shaft_motor / 2,  
	h = ( altura_engranaje_motor + altura_cuello_g_motor ) * 3, 
	$fn = 20,
	center=true);
}

// Tornillo sujeción engranaje
translate([0, altura_cuello_g_motor , altura_engranaje_motor + altura_cuello_g_motor/2]) {
	rotate([90, 0, 0]) {
		cylinder( r = 3.4 / 2,  
			h =  radio_cuello_g_motor + diametro_shaft_motor , $fn = 20,
			center=true);
	}
}
// Agujero para tuerca del tornillo de sujeción
translate([0,radio_cuello_g_motor/2, altura_engranaje_motor + altura_cuello_g_motor/2 ]) {
	cube(size=[5.2, 2.5, altura_cuello_g_motor], center=true);	
}
}
}
