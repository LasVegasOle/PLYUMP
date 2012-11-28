// Peristaltic extruder for 3D printing
// File: plyump.scad
// Author: Luis Rodriguez
// version: 0.1
// w3b: tiny.cc/lyu
// Info:

altura = 10;
radio_exterior = 32;
radio_interior = 22;

// -- Bisagra

difference(){
	// Exterior
  	cylinder(r=radio_exterior, altura, $fn=100,center=true); 
	// Interior
	cylinder(r=radio_interior, altura, $fn=100,center=true); 
	}

// Boquilla
color("red")
translate([radio_exterior + altura/2,0,0]) 
cube([altura*2 ,altura*2,altura],center=true); 


// Útil para hacer el path del tubo
// rotate_extrude(convexity = 10)
// translate([50, 0, 0])
// circle(r = 10, $fn = 100);