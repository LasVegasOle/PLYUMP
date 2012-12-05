/******************************************************/
/* peristaltic extruder for 3d printing     		  */
/* file: bisagra_entrada_del_tubo.scad			 	  */
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

//suavizar_salida_tubo = 5;



/* ~~ Pieza ~~ */

difference(){
	bisagra_extrusor( altura , radio_exterior , radio_interior ,
		ancho_boquilla, largo_boquilla , radio_bisagra ,
		diametro_tornillo , radio_tubo , 
		suavizar_salida_tubo );

// Taladro entrada del tubo
color("LightSlateGray")
translate( [ radio_exterior*0.707 , -radio_exterior*0.707 , altura/2 ] )
rotate(a=[0,90,-45]) { 
	cylinder( r = radio_tubo , largo_boquilla , $fn = 100, center = true );
}
}