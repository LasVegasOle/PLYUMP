/******************************************************/
/* peristaltic extruder for 3d printing     		  */
/* file: bisagra_soporte_motor.scad				 	  */
/* author: luis rodriguez				 	          */
/* version: 0.29					 		          */
/* w3b: tiny.cc/lyu     					 		  */
/* info:				    				 		  */
/******************************************************/
// @todo: Decidir como ajustar la distancia del taladro en el soporte del motor para su engranaje 

use <modulo_bisagra.scad>

/* ~~ Parámetros ~~ */
altura = 30;
radio_exterior = 36;
radio_interior = 24;

ancho_boquilla = 10;
largo_boquilla = 25;

radio_bisagra = 8;
diametro_tornillo = 3.4;

radio_tubo = 2;
radio_tubo_real = 3.25;

nema_17_distancia_entre_tornillos = 31;
nema_17_diagonal_entre_tornillos = 44;

diametro_tornillo_guia = 3.7;
// Lo diferencio para permitir que el eje ("shaft") del motor se desplace a través de la guía central abierta
diametro_tornillo_guia_central = 3.7;

margen_tornillo_motor = 4;

altura_soporte_motor = 7;

longitud_guia_tornillo_motor = 35;

dimaetro_agujero_engranaje_motor = 31;

/* ~~ Pieza ~~ */

color("Plum")
// Parte A
mirror([0, 1, 0]) {
    media_bisagra_sin_eje(  radio_interior = radio_interior, radio_exterior = radio_exterior, 
        largo_boquilla = largo_boquilla, ancho_boquilla = ancho_boquilla, 
        altura = altura / 2 , radio_tubo = radio_tubo, radio_tubo_real = radio_tubo_real );
}

// Parte B
translate([0, - radio_interior/4, 0]) 
union(){
	    media_bisagra_con_eje(  radio_interior = radio_interior, radio_exterior = radio_exterior, 
        largo_boquilla = largo_boquilla, ancho_boquilla = ancho_boquilla, 
        altura = altura / 2 , radio_tubo = radio_tubo, radio_tubo_real = radio_tubo_real);
	// El ángulo de 26 esta hecho a ojímetro ajustando la piezas hasta que "encaja"
	// Taladramos un cilindro al soporte del motor para que no sobresalga en el interior de la bisagra
	difference(){
		translate([ - ( nema_17_diagonal_entre_tornillos + diametro_tornillo_guia + margen_tornillo_motor * 2 ) / 2, 
			- ( radio_exterior * sin(26) + longitud_guia_tornillo_motor + margen_tornillo_motor * 3 ) , 
			0]) {
			soporte_motor();
		}	
	cylinder(r= ( radio_interior + ( radio_exterior - radio_interior ) / 1.5 ), h=altura*2, center=true);
	}
}

/*~~ Módulos ~~*/

module soporte_motor(){

	difference(){

		solido_soporte_motor();

		3_taladros_guias_motor();

		agujero_engranaje_motor();
	}
}


// Agujero para engranaje del motor
module agujero_engranaje_motor(){
	union(){
// Parte redonda del agujero
color("Red")
translate([( nema_17_diagonal_entre_tornillos + diametro_tornillo_guia + margen_tornillo_motor * 2 ) / 2,

	(longitud_guia_tornillo_motor + margen_tornillo_motor * 3) / 4,

	altura_soporte_motor / 2 ] ) {

	cylinder(r = dimaetro_agujero_engranaje_motor / 2, h= altura_soporte_motor * 2, center = true);
	
}
// Parte cuadrada
color("yellow")
translate([( nema_17_diagonal_entre_tornillos + diametro_tornillo_guia + margen_tornillo_motor * 2 ) / 2, 

	( longitud_guia_tornillo_motor + margen_tornillo_motor * 3 ) / 2  , 

	altura_soporte_motor / 2]) {
	cube(size=[ dimaetro_agujero_engranaje_motor , 
		(longitud_guia_tornillo_motor + margen_tornillo_motor * 3) / 2, 
		altura_soporte_motor * 2 ], center = true);
}
}
}

module solido_soporte_motor(){
	union(){
		color("LightGreen")
		cube( [ nema_17_diagonal_entre_tornillos + diametro_tornillo_guia + margen_tornillo_motor * 2, 
			longitud_guia_tornillo_motor + margen_tornillo_motor * 3, 
			altura_soporte_motor ] ); 

		color("Lime")
		linear_extrude( height = altura_soporte_motor )
		polygon( [ [ 0 , 0 ] , 
			[ nema_17_diagonal_entre_tornillos + diametro_tornillo_guia + margen_tornillo_motor * 2 , 0  ] , 
			[ ( nema_17_diagonal_entre_tornillos + diametro_tornillo_guia + margen_tornillo_motor * 2 ) / 2 , - ( nema_17_diagonal_entre_tornillos + diametro_tornillo_guia + margen_tornillo_motor ) / 2 ] ] , 
			convexity = n);
	}
}

module 3_taladros_guias_motor(){
	union(){
// Guía tornillo motor enmedio
translate( [ ( nema_17_diagonal_entre_tornillos + diametro_tornillo_guia + margen_tornillo_motor * 2 ) / 2 , 
	- nema_17_diagonal_entre_tornillos / 2 + margen_tornillo_motor , 
	altura_soporte_motor / 2 ] )
rotate(a=[ 0 , 0 , 90 ]) { 
	taladro_tornillo_sujecion_motor( diametro_tornillo_guia_central );
}

// Guía tornillo motor arriba
translate( [ margen_tornillo_motor + diametro_tornillo_guia / 2 , 
	margen_tornillo_motor , 
	altura_soporte_motor / 2 ] )
rotate(a=[ 0 , 0 , 90 ]) { 
	taladro_tornillo_sujecion_motor();
}

// Guía tornillo motor abajo
translate( [ nema_17_diagonal_entre_tornillos + margen_tornillo_motor + diametro_tornillo_guia / 2 , 
	margen_tornillo_motor , 
	altura_soporte_motor / 2 ] )
rotate(a=[ 0 , 0 , 90 ]) { 
	taladro_tornillo_sujecion_motor();
}
}
}

module taladro_tornillo_sujecion_motor( diametro_tornillo_guia_v = diametro_tornillo_guia ){
	color("pink")
	union(){
		cylinder( r = diametro_tornillo_guia_v / 2 , altura_soporte_motor * 2 , $fn = 100, center = true );

		translate( [ longitud_guia_tornillo_motor / 2, 0 , 0 ] )
		cube( [ longitud_guia_tornillo_motor , diametro_tornillo_guia_v , altura_soporte_motor * 2 ] , center = true);

		translate( [ longitud_guia_tornillo_motor , 0 , 0 ] )
		cylinder( r = diametro_tornillo_guia_v / 2 , altura_soporte_motor * 2 , $fn = 100, center = true );
	}
}