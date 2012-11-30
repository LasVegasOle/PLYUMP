/**************************************/
/* peristaltic extruder for 3d printing     		  */
/* file: plyump.scad					 		  */
/* author: luis rodriguez				 	  */
/* version: 0.2						 		  */
/* w3b: tiny.cc/lyu					 		  */
/* info:								 		  */
/**************************************/
// todo: - redondear salida del tubo	 		  
//		 - modularizar partes del diseño
//		 - independizar parámetros de largo y ancho de la boquilla


/* ~~ parametros ~~ */

altura = 10;
radio_exterior = 40;
radio_interior = 35;

radio_bisagra = 8;
taladro_tubo = 3.5;

suavizar_salida_tubo = 5;

/* ~~ pieza ~~ */

// -- bisagra
difference(){
    union(){
        difference(){
            difference(){
                union(){
                    difference(){
                        // exterior
                        cylinder( r = radio_exterior, altura, $fn=100); 
                        // interior
                        cylinder(r = radio_interior, altura, $fn=100 ); 
                    }
                    
                    // boquilla
                    color("red")
                            translate([radio_exterior + altura/2,0,altura/2]) 
                            cube([altura*2 ,altura*2,altura],center=true); 
                }
                // taladro boquilla
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
        
        
        // bisagra
        
        difference(){
            color("green")
                    translate( [ - ( radio_exterior + radio_bisagra ) , 0 , 0 ] )
                    cylinder(r = radio_bisagra, altura/2, $fn = 100);
            
            // bisagra taladro
            color("black")
                    translate( [ - ( radio_exterior + radio_bisagra ) , 0 , altura/4 ] )
                    cylinder(r = 3/2, altura, $fn = 100, center = true);
            
            // bisagra taladro tuerca
            color("pink")
                    translate( [ - ( radio_exterior + radio_bisagra ) , 0 , 0 ] )
                    cylinder(r = 3, 3, $fn = 6);
        }
        // enlace entre cuerpo y soporte de bisagra
        color("lime")
                linear_extrude(height=altura/2)
                polygon( [ [ - ( radio_exterior + radio_bisagra ) ,  - radio_bisagra ] , [ -radio_exterior , 0  ] , [ -radio_exterior*0.707 , -radio_exterior*0.707 ] ] , convexity = n);
    }
    
    // toroide para hacer el path del tubo
    rotate_extrude(convexity = 10)
            translate( [ radio_interior , altura/2 , 0 ] )
            circle( r =  taladro_tubo , $fn = 100);
    // toroide para suabizar la salida del tubo de la bomba
    translate( [ radio_interior , 0 , altura/2 ] ) 
		rotate_extrude(convexity = 10)
			translate( [ suavizar_salida_tubo , 0 , 0 ] ) 
            circle( r =  taladro_tubo , $fn = 100);

			
			}


/* ~~ módulos ~~ */

/*
module rueda_simple(grosor, diametro, diam_eje)
{
  //-- construcción de la rueda a partir de
  //-- los parámetros
  difference() {
    //-- base de la rueda
    cylinder(r=diametro/2, h=grosor,$fn=100);
    //-- taladro del eje
    cylinder(r=diam_eje/2, h=3*grosor,$fn=20,center=true);
  }
} 

rueda_simple(diametro=50, grosor=5, diam_eje=8);

translate([50,0,0])
  rueda_simple(diametro=40, grosor=20, diam_eje=10);*/
