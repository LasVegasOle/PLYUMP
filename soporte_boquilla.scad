/******************************************************/
/* peristaltic extruder for 3d printing     		  */
/* file: soporte_boquilla.scad			 		      */
/* author: luis rodriguez				 	          */
/* version: 0.28						 	          */
/* w3b: tiny.cc/lyu     					 		  */
/* info:				    				 		  */
/******************************************************/
// @todo: - 


ancho = 67;
largo = 30;
altura = 5;

boquilla = 10;

altura_cierre = 20;

diametro_tornillo = 3.4;

difference(){
	union(){
		cube( size = [ ancho , largo , altura ] );	
		// Soporte para el cierre
		translate([ancho / 2 - (ancho / 4), boquilla / 2, altura]) {
			modulo_cierre();
		}
	}
	// Taladro boquilla
	translate( [ ancho / 2, largo / 2, 0]) {
		color("Peru"){
			cylinder(r = boquilla / 2, largo , $fn = 29);
		}
	}
}

translate([0, largo + altura, 0]) {
	difference(){
		modulo_cierre();
		translate( [ ancho / 4 , - boquilla / 4 , 0 ]) {
			cylinder(r = boquilla / 2, largo , $fn = 29);	
		}
	}
	
}


/* MODULOOOOOOOOOOS */
module modulo_cierre() 
difference(){
	color("Blue") {
		cube(size=[ancho / 2, largo / 4, altura_cierre ] );	
	}		
		// Taladros tornillos
		translate( [ ancho / 8 , largo / 2 , altura_cierre / 2 ]) {
			rotate([90, 10, 0]) {
				color("Red"){
					cylinder(r = diametro_tornillo / 2 , largo, $fn = 29);
				}		
			}
		}
		translate( [ 3*ancho / 8 , largo / 2 , altura_cierre / 2 ]) {
			rotate([90, 10, 0]) {
				color("Red"){
					cylinder(r = diametro_tornillo / 2 , largo, $fn = 29);
				}		
			}		
		}
	}