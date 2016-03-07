//===================================================================================
// Variety of gears generated from mdsSpurGear OpenSCAD script
//
// Based on Boston Gear design rules https://www.bostongear.com/pdf/gear_theory.pdf
//
// Copyright (c) 2016 Mark Seminatore
//
// Refer to included LICENSE.txt for usage rights and restrictions
//===================================================================================
//

use <mdsSpurGear.scad>

// compute center distance for 24/48 gears
cd1 = (24 + 48) / (2 * 24);
cd2 = (24 + 12) / (2 * 24);

// Example 24 tooth gear with no minor holes
mdsSpurGear(teeth = 24, minor_holes = false);

// Example 48 tooth gear with default options
translate([1.1 * cd1, 0, 0])
    mdsSpurGear(teeth = 48);

// Example 12 tooth gear with no major holes
translate([-cd2 * 1.2, 0, 0])
    mdsSpurGear(teeth = 12, major_holes = false);

// Example 12 tooth gear with a hub thickness and no major holes
translate([0, -cd2 * 1.2, 0])
    mdsSpurGear(teeth = 12, major_holes = false, hub_thickness_ratio = 1.3);
    
