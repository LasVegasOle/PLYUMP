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
// a_ ... angulo
// r_ ... radio
// d_ ... diametro
// n_ ... numero

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
relacion_engranaje = 1.5;
radio_engranaje_peristaltico = 70 / 2;
dientes_engranaje_motor = 20;
dientes_engranaje_peristaltico = relacion_engranaje * dientes_engranaje_motor;
circular_pitch = radio_engranaje_peristaltico / dientes_engranaje_peristaltico * 360;

altura_llanta_engranaje = 12;
ancho_llanta_engranaje = 5;
altura_interior_engranaje = 5;

altura_engranaje_motor = 8;
altura_cuello_g_motor = 8;
radio_cuello_g_motor = 10;

diametro_shaft_motor = 5.5;

n_de_cojinetes = 8;
a_entre_cojinetes = 360 / ( n_de_cojinetes );
d_cojinetes = 13;
r_cojinetes = d_cojinetes / 2;
holgura_entre_cojinetes = 0;
d_interior_cojinetes = 4.5;

r_cojinetes_con_holgura = r_cojinetes + holgura_entre_cojinetes / 2;
r_posicion_cojinetes = ( r_cojinetes_con_holgura - sin( a_entre_cojinetes / 2 ) * r_cojinetes_con_holgura ) 
/ sin( a_entre_cojinetes / 2 ) ;


// Copias en circulo del taladro que hace de eje para los cojinetes

/* ~~ Engranaje peristaltico ~~ */
difference(){
	gear (circular_pitch=circular_pitch,
		gear_thickness = altura_interior_engranaje,
		rim_thickness = altura_llanta_engranaje,
		rim_width = ancho_llanta_engranaje,
		hub_thickness = 0,
		number_of_teeth = dientes_engranaje_peristaltico
	);
	union(){
		for ( i = [ 1 : n_de_cojinetes ] ) {
			translate( [ ( r_posicion_cojinetes + r_cojinetes ) * cos( a_entre_cojinetes * i ), 
				( r_posicion_cojinetes + r_cojinetes )* sin( a_entre_cojinetes * i ),  
				0])
			cylinder( r = d_interior_cojinetes / 2 , h = 10, $fn = 20 );
		}
		// El "3" es a ojo para no dejar los taladros de las linias de arriba muy pegadas al
		// diametro interior ;)
		cylinder( r = r_posicion_cojinetes + r_cojinetes / 3, h=10, center=true);	
	}
}

/* ~~ Engranaje Motor ~~*/
translate([radio_engranaje_peristaltico * 1.9, 0 , 0 ] ){
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