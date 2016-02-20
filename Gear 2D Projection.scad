//===================================================================================
// Example of 2D Gear Generation
//
// Based on Boston Gear design rules https://www.bostongear.com/pdf/gear_theory.pdf
//
// Copyright (c) 2016 Mark David Seminatore
//
// Refer to included LICENSE.txt for usage rights and restrictions
//===================================================================================
//

use <mdsSpurGear.scad>

// generate 2D projection of gear design ready for DXF export
projection(cut = false)
    mdsSpurGear();