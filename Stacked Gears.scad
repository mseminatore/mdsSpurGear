use <mdsSpurGear.scad>

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

//
function pitch_dia(teeth, diametral_pitch = 24) = teeth / diametral_pitch;

//
function root_dia(teeth, diametral_pitch = 24) = pitch_dia(teeth, diametral_pitch) - 2 *((2.2 / diametral_pitch + 0.002) - (1 / diametral_pitch));

//
function tooth_dia(teeth, diametral_pitch = 24) = pitch_dia(teeth, diametral_pitch) + 2 * (1 / diametral_pitch);