/******************************************************/
/* peristaltic extruder for 3d printing     		  */
/* file: bisagra_soporte_motor.scad				 	  */
/* author: luis rodriguez				 	          */
/* version: 0.1						 		          */
/* w3b: tiny.cc/lyu     					 		  */
/* info:				    				 		  */
/******************************************************/
// @todo: - 

use <modulo_bisagra.scad>

/* ~~ Parámetros ~~ */
altura = 10;
radio_exterior = 32;
radio_interior = 24;

ancho_boquilla = 10;
largo_boquilla = 20;

radio_bisagra = 8;
diametro_tornillo = 3.4;

radio_tubo = 4;

suavizar_salida_tubo = 5;

nema_17_distancia_entre_tornillos = 31;
nema_17_diagonal_entre_tornillos = 44;
margen_tornillo_motor = 4;
diametro_tornillo_guia = 5.4;

altura_soporte_motor = 7;

longitud_guia_tornillo_motor = 30;

/* ~~ Pieza ~~ */
/*
	bisagra_extrusor( altura , radio_exterior , radio_interior ,
		ancho_boquilla, largo_boquilla , radio_bisagra ,
		diametro_tornillo , radio_tubo , 
		suavizar_salida_tubo );
*/
union(){
	color("LightGreen")
	cube( [ nema_17_diagonal_entre_tornillos + diametro_tornillo_guia + margen_tornillo_motor , 
		longitud_guia_tornillo_motor + margen_tornillo_motor * 2, 
		altura_soporte_motor ] ); 

	color("Lime")
	linear_extrude( height = altura_soporte_motor )
	polygon( [ [ 0 , 0 ] , 
		[ nema_17_diagonal_entre_tornillos + diametro_tornillo_guia + margen_tornillo_motor , 0  ] , 
		[ ( nema_17_diagonal_entre_tornillos + diametro_tornillo_guia + margen_tornillo_motor ) / 2 , - ( nema_17_diagonal_entre_tornillos + diametro_tornillo_guia + margen_tornillo_motor ) / 2 ] ] , 
		convexity = n);
}

// Guía tornillo motor enmedio
translate( [ nema_17_diagonal_entre_tornillos / 2 + margen_tornillo_motor, 
	- nema_17_diagonal_entre_tornillos / 2 + margen_tornillo_motor , 
	altura_soporte_motor / 2 ] )
rotate(a=[ 0 , 0 , 90 ]) { 
	taladro_tornillo_sujecion_motor();
}

// Guía tornillo motor arriba
translate( [ margen_tornillo_motor, 
	margen_tornillo_motor , 
	altura_soporte_motor / 2 ] )
rotate(a=[ 0 , 0 , 90 ]) { 
	taladro_tornillo_sujecion_motor();
}

// Guía tornillo motor abajo
translate( [ nema_17_diagonal_entre_tornillos + margen_tornillo_motor, 
	margen_tornillo_motor , 
	altura_soporte_motor / 2 ] )
rotate(a=[ 0 , 0 , 90 ]) { 
	taladro_tornillo_sujecion_motor();
}

/*~~ Módulos ~~*/

module taladro_tornillo_sujecion_motor(){
	color("pink")
	union(){
		cylinder( r = diametro_tornillo_guia / 2 , altura_soporte_motor * 2 , $fn = 100, center = true );

		translate( [ longitud_guia_tornillo_motor / 2, 0 , 0 ] )
		cube( [ longitud_guia_tornillo_motor , diametro_tornillo_guia , altura_soporte_motor * 2 ] , center = true);

		translate( [ longitud_guia_tornillo_motor , 0 , 0 ] )
		cylinder( r = diametro_tornillo_guia / 2 , altura_soporte_motor * 2 , $fn = 100, center = true );
	}
}