//===================================================================================
// Parameteric Spur Gear SCAD script
//
// Based on Boston Gear design rules https://www.bostongear.com/pdf/gear_theory.pdf
//
// Copyright (c) 2016 Mark David Seminatore
//
// Refer to included LICENSE.txt for usage rights and restrictions
//===================================================================================
//

$fs = 0.01;

// Create a gear with all default options
mdsSpurGear();

//
//
//
module mdsSpurGear(teeth = 24, diametral_pitch = 24, pressure_angle = 20, shaft_dia = 0.125, thickness = 0.125, major_holes = true, minor_holes = true, num_holes = 4, hub_thickness_ratio = 1, debug_echo = false) {

    // calculate basic gear parameters
    pitch_dia   = teeth / diametral_pitch;
    pitch_radius = pitch_dia / 2;
    
    addendum = 1 / diametral_pitch;
    
    outer_dia = pitch_dia + 2 * addendum;
    outer_radius = outer_dia / 2;
    
    whole_depth = 2.2 / diametral_pitch + 0.002;
    dedendum = whole_depth - addendum;
    
    root_dia = pitch_dia - 2 * dedendum;
    root_radius = root_dia / 2;
    
    base_dia = pitch_dia * cos(pressure_angle);
    base_radius = base_dia / 2;
    
    r_mid_point = root_radius / 2 + shaft_dia / 4;
   
    if (debug_echo) {
        echo(root_dia=root_dia,base_dia=base_dia,pitch_dia=pitch_dia,outer_dia=outer_dia,whole_depth=whole_depth, addendum=addendum,dedendum=dedendum);
        echo(r_mid_point = r_mid_point);
    }
    
    // draw rim if present
    linear_extrude(height = hub_thickness_ratio * thickness)
    union() {
        difference() {
            circle($fn = teeth*3, d = root_dia);
            circle($fn = teeth*3, d = 0.9 * root_dia);
        }
        
        pitch_to_base_angle = involuteIntersectionAngle( base_radius, pitch_radius );
        outer_to_base_angle = involuteIntersectionAngle( base_radius, outer_radius );
        
        half_angle = 360 / (4 * teeth);
        
        base_angle = pitch_to_base_angle + half_angle;
        
        if (debug_echo)
            echo(half_angle=half_angle,pitch_to_base_angle=pitch_to_base_angle,base_angle=base_angle);

        // draw teeth
        for (i = [1 : teeth]) {
            
            // pitch_angle = 
            
            // coordinates of tooth base
            b1 = fromPolar(root_radius, base_angle);
            b2 = fromPolar(root_radius, -base_angle);

            // coordinates of tooth at pitch diameter
            p1 = b1 + fromPolar(dedendum, pitch_to_base_angle);
            p2 = b2 + fromPolar(dedendum, pitch_to_base_angle);
            
            // coordinates of tooth at outer diameter
            o1 = p1 + fromPolar(addendum, -pressure_angle);
            o2 = p2 + fromPolar(addendum, pressure_angle);
            
            rotate([0, 0, i * 360 / teeth])
            polygon([b1, p1, o1, o2, p2, b2]);
        }        
    }
    
    // draw the main disc
    translate([0, 0, (hub_thickness_ratio * thickness - thickness)/2])
    linear_extrude(height = thickness)
    union() {
       
        difference() {
            // draw root circle
            circle($fn = teeth*3, d = root_dia);
            
            // subtract shaft
            circle(d = shaft_dia);
            
            // draw major holes
            if (major_holes && r_mid_point >= 0.125) {
                echo("Draw major holes");
                angle_inc = 360 / num_holes;
                
                for (i = [1 : num_holes]) {
                    rotate([0, 0, i * angle_inc])
                    translate([r_mid_point, 0, 0])
                    circle(d = 0.85 * r_mid_point);
                }
            }
            
            // draw minor hollows
            if (minor_holes && r_mid_point >= 0.25) {
                echo("Draw minor holes");
                angle_inc = 360 / num_holes;

                inner_minor_dia = r_mid_point / 4;
                inner_minor_ctr = r_mid_point / 3;
                outer_minor_dia = r_mid_point / 2;
                outer_minor_ctr = r_mid_point * 1.2;
                
                for (i = [1 : num_holes]) {
                    rotate([0, 0, i * angle_inc + angle_inc / 2]) {
                        // selectively draw inner minor holes
                        if (inner_minor_ctr - inner_minor_dia / 2 > shaft_dia / 2 + 0.125)
                        {
                            translate([inner_minor_ctr, 0, 0])
                            circle(d = inner_minor_dia);
                        }                    
                        
                        // selectively draw outer minor holes
                        translate([outer_minor_ctr, 0, 0])
                        circle(d = outer_minor_dia);
                    }
                }
            }
        }
    }
}

//
function involuteIntersectionAngle(base_radius, radius) = sqrt( pow(radius / base_radius,2) - 1);

//
function fromPolar(r, theta) = [r * cos(theta), r * sin(theta)];