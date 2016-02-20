//===================================================================================
// Helper functions for Parameteric Spur Gear OpenSCAD script
//
// Based on Boston Gear design rules https://www.bostongear.com/pdf/gear_theory.pdf
//
// Copyright (c) 2016 Mark David Seminatore
//
// Refer to included LICENSE.txt for usage rights and restrictions
//===================================================================================
//

//
function pitch_dia(teeth, diametral_pitch = 24) = teeth / diametral_pitch;

//
function root_dia(teeth, diametral_pitch = 24) = pitch_dia(teeth, diametral_pitch) - 2 *((2.2 / diametral_pitch + 0.002) - (1 / diametral_pitch));

//
function tooth_dia(teeth, diametral_pitch = 24) = pitch_dia(teeth, diametral_pitch) + 2 * (1 / diametral_pitch);