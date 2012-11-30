/**************************************/
/* Peristaltic extruder for 3D printing     		  */
/* File: plyump.scad					 		  */
/* Author: Luis Rodriguez				 	  */
/* version: 0.2						 		  */
/* w3b: tiny.cc/lyu					 		  */
/* Info:								 		  */
/**************************************/
// ToDo: - Redondear salida del tubo	 		  
//		 - Modularizar partes del diseño
//		 - Unir cuerpo y bisagra antes de tubo interior
//		 - Independizar parámetros de largo y ancho de la boquilla


/* ~~ PARAMETROS ~~ */

altura = 10;
radio_exterior = 40;
radio_interior = 35;

radio_bisagra = 8;
taladro_tubo = 3.5;

/* ~~ PIEZA ~~ */

// -- Bisagra
difference(){
union(){
difference(){
    difference(){
        union(){
            difference(){
                // Exterior
                cylinder( r = radio_exterior, altura, $fn=100); 
                // Interior
                cylinder(r = radio_interior, altura, $fn=100 ); 
            }
            
            // Boquilla
            color("red")
                    translate([radio_exterior + altura/2,0,altura/2]) 
                    cube([altura*2 ,altura*2,altura],center=true); 
        }
        // Taladro boquilla
        color("blue")
                translate( [ radio_exterior , 0 , altura/2 ] )
                rotate(a=[0,90,0]) { 
            cylinder( r = taladro_tubo , altura*4, $fn = 100, center = true );
        }
    }
    color("brown")
            translate([-radio_exterior,0,0]) 
            cube( [ ( radio_exterior + altura ) * 2, radio_exterior , altura ] ); 
}


// Bisagra

difference(){
color("green")
translate( [ - ( radio_exterior + radio_bisagra ) , 0 , 0 ] )
cylinder(r = radio_bisagra, altura/2, $fn = 100);

// Bisagra taladro
color("black")
translate( [ - ( radio_exterior + radio_bisagra ) , 0 , altura/4 ] )
cylinder(r = 3/2, altura, $fn = 100, center = true);

// Bisagra taladro tuerca
color("pink")
translate( [ - ( radio_exterior + radio_bisagra ) , 0 , 0 ] )
cylinder(r = 3, 3, $fn = 6);
}
}

// til para hacer el path del tubo
rotate_extrude(convexity = 10)
translate( [ radio_interior , altura/2 , 0 ] )
circle( r =  taladro_tubo , $fn = 100);
}

// Enlace entre cuerpo y soporte de bisagra
color("Lime")
linear_extrude(height=altura/2)
polygon( [ [ - ( radio_exterior + radio_bisagra ) ,  - radio_bisagra ] , [ -radio_exterior , 0  ] , [ -radio_exterior*0.707 , -radio_exterior*0.707 ] ] , convexity = N);

/* ~~ MÓDULOS ~~ */

/*
module rueda_simple(grosor, diametro, diam_eje)
{
  //-- Construcción de la rueda a partir de
  //-- los parámetros
  difference() {
    //-- Base de la rueda
    cylinder(r=diametro/2, h=grosor,$fn=100);
    //-- Taladro del eje
    cylinder(r=diam_eje/2, h=3*grosor,$fn=20,center=true);
  }
} 

rueda_simple(diametro=50, grosor=5, diam_eje=8);

translate([50,0,0])
  rueda_simple(diametro=40, grosor=20, diam_eje=10);*/
