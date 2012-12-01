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
diametro_tornillo = 3;

radio_tubo = 4;

suavizar_salida_tubo = 5;



/* ~~ Pieza ~~ */
/*
	bisagra_extrusor( altura , radio_exterior , radio_interior ,
		ancho_boquilla, largo_boquilla , radio_bisagra ,
		diametro_tornillo , radio_tubo , 
		suavizar_salida_tubo );
*/
color("LightGreen")
cube( [ 57, 30 , altura ] ); 

color("lime")
linear_extrude( height = altura )
polygon( [ [ 0 , 0 ] , [ 57 , 0  ] , [ 57/2 , -57/2 ] ] , convexity = n);