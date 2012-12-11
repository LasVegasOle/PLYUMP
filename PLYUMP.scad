/******************************************************/
/* peristaltic extruder for 3d printing     		  */
/* file: plyump.scad					 		      */
/* author: luis rodriguez				 	          */
/* version: 0.2						 		          */
/* w3b: tiny.cc/lyu     					 		  */
/* info:				    				 		  */
/******************************************************/
// @todo: - redondear salida del tubo	 		  
//		  - modularizar partes del dise�o
//		  - independizar par�metros de largo y ancho de la boquilla

use <bisagra_entrada_del_tubo.scad>
use <bisagra_soporte_motor.scad>

/* ~~ Par�metros ~~ */



/* ~~ Pieza ~~ */
color("indigo")
    bisagra_entrada_del_tubo();

color("Peru")
    pinza_bisagras();