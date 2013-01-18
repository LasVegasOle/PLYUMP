/******************************************************/
/* PLYUMP                                             */
/* file: pump_body.scad                               */
/* author: Luis Rodriguez                             */
/* version: 0.30                                      */
/* w3b: tiny.cc/lyu                                   */
/* info:                                              */
/******************************************************/

include <parameters.scad>

// Testing
pump_body();

/* MODULES */

module pump_body(){
	difference(){
		union(){ // Add
			base();
			lateral();
			// mirror()lateral();
			motor_screw_holder();
		}
		union(){ // Substract
			base_opening();
			lateral_opening();
			//mirror()  lateral_opening();
		}
	}
}


module base(){

}

module lateral(){
	//http://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language#polyhedron
}

module motor_screw_holder(){

}

module lateral_opening(){

}