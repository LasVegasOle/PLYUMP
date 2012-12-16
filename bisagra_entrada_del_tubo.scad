/******************************************************/
/* peristaltic extruder for 3d printing          		  */
/* file: bisagra_entrada_del_tubo.scad			      	  */
/* author: luis rodriguez				 	                    */
/* version: 0.2						 		                        */
/* w3b: tiny.cc/lyu     					              		  */
/* info:				    				 		                      */
/******************************************************/
// @todo: - 

use <modulo_bisagra.scad>

// Bisagra

altura = 10;
radio_exterior = 36;
radio_interior = 24;

radio_tubo = 3.5  ;

radio_entrada_tubo = 3.5;

ancho_boquilla = 10;
largo_boquilla = 30;

radio_bisagra = 8;
diametro_tornillo = 3.4;

suavizar_salida_tubo = 10;

a_tubo_entrada = 20;

// Pinza
grosor_pared_pinza = 2;
altura_pinza = 6;
holgura_pinza = 0.3;

grosor_pared_exterior_tubo_boquilla = 1;

/* Pieza */

/*bisagra_entrada_del_tubo( altura = altura, radio_exterior = radio_exterior , radio_interior = radio_interior ,
  ancho_boquilla = ancho_boquilla, largo_boquilla = largo_boquilla, radio_bisagra = radio_bisagra,
  diametro_tornillo = diametro_tornillo, radio_tubo = radio_tubo , 
  suavizar_salida_tubo = suavizar_salida_tubo, radio_entrada_tubo = radio_entrada_tubo );*/

//pinza_bisagras( grosor_pared_pinza = grosor_pared_pinza, altura_pinza = altura_pinza, holgura_pinza = holgura_pinza,
//  ancho_boquilla = ancho_boquilla, largo_boquilla = largo_boquilla );
//bisagra_extrusor();

//pinza_doble_bisagras(ancho_boquilla = ancho_boquilla, grosor_pared_exterior_tubo_boquilla = grosor_pared_exterior_tubo_boquilla);

pinza_cuadrada_bisagras();

/* ~~ Módulos ~~ */

module bisagra_entrada_del_tubo( altura = 10, radio_exterior = 36 , radio_interior = 24 ,
  ancho_boquilla = 10, largo_boquilla = 20, radio_bisagra = 8,
  diametro_tornillo = 3.4, radio_tubo = 3 , 
  suavizar_salida_tubo = 10, largo_boquilla = 20, radio_entrada_tubo = 4 )
{
  difference(){
   bisagra_extrusor( altura , radio_exterior , radio_interior ,
    ancho_boquilla, largo_boquilla , radio_bisagra ,
    diametro_tornillo , radio_tubo );
    // Taladro entrada del tubo
    color("LightSlateGray")
    translate( [ radio_exterior * cos ( a_tubo_entrada ), - radio_exterior * sin ( a_tubo_entrada ) , altura / 2 ] )
    rotate( a = [ 0 , 90 , - a_tubo_entrada ] ) { 
      cylinder( r = radio_entrada_tubo , largo_boquilla * 2 , $fn = 100, center = true );
    }
  }
}
// Pinza entre bisagras
module pinza_bisagras( grosor_pared_pinza = 2, altura_pinza = 6, holgura_pinza = 0.3,
  ancho_boquilla = 10, largo_boquilla = 20 ){
  difference(){
    // Exterior
    cube( [ altura + ( holgura_pinza + grosor_pared_pinza ) * 2 ,
      ( ancho_boquilla + holgura_pinza + grosor_pared_pinza ) * 2, 
      altura_pinza + grosor_pared_pinza ]);
  // Interior
  translate([ grosor_pared_pinza , grosor_pared_pinza, grosor_pared_pinza]){
    cube( [ altura + holgura_pinza * 2 ,
      ( ancho_boquilla + holgura_pinza ) * 2, 
      altura_pinza  ]);  }
  // Agujero tubo out
  translate([ (altura + ( holgura_pinza + grosor_pared_pinza ) * 2 ) / 2,
      ancho_boquilla + holgura_pinza + grosor_pared_pinza,
      0]){
      cylinder( r = radio_entrada_tubo , largo_boquilla , $fn = 100, center = true );
    }
  }
}

// Pinza con agujero de entrada y salida entre bisagras
module pinza_doble_bisagras( grosor_pared_pinza = 2, altura_pinza = 6, holgura_pinza = 0.3,
  ancho_boquilla = 10, largo_boquilla = 20, grosor_pared_exterior_tubo_boquilla = 1 ){
  difference(){
    // Exterior
    cube( [ altura + ( holgura_pinza + grosor_pared_pinza ) * 2 ,
      ( ancho_boquilla + holgura_pinza + grosor_pared_pinza ) * 2, 
      altura_pinza + grosor_pared_pinza ]);
  // Interior
  translate([ grosor_pared_pinza , grosor_pared_pinza, grosor_pared_pinza]){
    cube( [ altura + holgura_pinza * 2 ,
      ( ancho_boquilla + holgura_pinza ) * 2, 
      altura_pinza  ]);  }
  // Agujero tubo out
  translate([ (altura + ( holgura_pinza + grosor_pared_pinza ) * 2 ) / 2,
      ( ancho_boquilla + grosor_pared_pinza ) - ( radio_tubo + grosor_pared_exterior_tubo_boquilla ),
      0]){
      cylinder( r = radio_entrada_tubo , largo_boquilla , $fn = 100, center = true );
    }
  // Agujero tubo in
  translate([ (altura + ( holgura_pinza + grosor_pared_pinza ) * 2 ) / 2,
      ( ancho_boquilla + grosor_pared_pinza ) + ( radio_tubo + grosor_pared_exterior_tubo_boquilla ),
      0]){
      cylinder( r = radio_entrada_tubo , largo_boquilla , $fn = 100, center = true );
    }
  }
}

// Pinza entre bisagras
module pinza_cuadrada_bisagras( grosor_pared_pinza = 2, altura_pinza = 10, holgura_pinza = 0.3,
  ancho_boquilla = 10, largo_boquilla = 30 ){
  difference(){
    // Exterior
    cube( [ altura + ( holgura_pinza + grosor_pared_pinza ) * 2 ,
      ( ancho_boquilla + holgura_pinza + grosor_pared_pinza ) * 2, 
      altura_pinza + grosor_pared_pinza ]);
  // Interior
  translate([ grosor_pared_pinza , grosor_pared_pinza, grosor_pared_pinza]){
    cube( [ altura + holgura_pinza * 2 ,
      ( ancho_boquilla + holgura_pinza ) * 2, 
      altura_pinza  ]);  }
  // Agujero tubo out
  translate([ (altura + ( holgura_pinza + grosor_pared_pinza ) * 2 ) / 2,
      ancho_boquilla + holgura_pinza + grosor_pared_pinza,
      0]){
      cube(size=[radio_entrada_tubo * 2, radio_entrada_tubo * 4, radio_entrada_tubo * 8 ], center=true);
    }
  }
}