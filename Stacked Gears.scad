//===================================================================================
// Example of Stacked Gears
//
// Based on Boston Gear design rules https://www.bostongear.com/pdf/gear_theory.pdf
//
// Copyright (c) 2016 Mark David Seminatore
//
// Refer to included LICENSE.txt for usage rights and restrictions
//===================================================================================
//

use <mdsSpurGear.scad>
use <utility.scad>

//
//
//
union() {
    mdsSpurGear(teeth = 48, smooth_teeth = true);

    translate([0, 0, 0.0625])
        disc(dia = tooth_dia(10));
    
    translate([0, 0, 0.1875])
        mdsSpurGear(teeth = 10, smooth_teeth = true, major_holes = false, minor_holes = false);
}

//
//
//
module disc(dia, shaft_dia = 0.125, thickness = 0.125) {
    linear_extrude(height = thickness) {
        difference() {
            circle($fn=50, d = dia);
            circle($fn=50, d = shaft_dia);
        }
    }
}
