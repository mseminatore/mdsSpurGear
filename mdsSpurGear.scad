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

// Create an example gear with all default options
mdsSpurGear(smooth_teeth = true);

//
//
//
module mdsSpurGear(
        teeth = 24, 
        diametral_pitch = 24, 
        pressure_angle = 20, 
        shaft_dia = 0.125, 
        thickness = 0.125, 
        major_holes = true, 
        minor_holes = true, 
        num_holes = 4, 
        smooth_teeth = false, 
        hub_thickness_ratio = 1,
        debug_echo = false
    ) 
{
    // calculate some of the basic basic gear parameters
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
            
            // coordinates of tooth base
            b1 = fromPolar(root_radius, base_angle);
            b2 = fromPolar(root_radius, -base_angle);

            // coordinates of tooth at pitch diameter
            p1 = b1 + fromPolar(dedendum, pitch_to_base_angle);
            p2 = b2 + fromPolar(dedendum, -pitch_to_base_angle);
            
            // coordinates of tooth at outer diameter
            o1 = p1 + fromPolar(addendum, -pressure_angle);
            o2 = p2 + fromPolar(addendum, pressure_angle);
            
            rotate([0, 0, i * 360 / teeth]) {
                if (smooth_teeth) {
                    // eight seems to work best in most cases
                    pointCount = 8;
                    
                    curve1 = bezierCurve(b1, p1, o1, n = pointCount);
                    curve2 = bezierCurve(b2, p2, o2, n = pointCount);
    
                    // join the two curves into a tooth profile
                    points = concat(curve1, curve2);
                    
                    // create indices for the two tooth 
                    seq1 = sequence(0, pointCount);
                    seq2 = sequence(2 * pointCount + 1, pointCount + 1);

                    path = concat(seq1, seq2);

                    polygon(points, paths=[path], convexity=10);
                } else
                {
                    p = [b1, p1, o1, o2, p2, b2];
                    polygon(p);
                }
            }
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
                if (debug_echo)
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
                if (debug_echo)                
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

// Generate a linear sequence from [start..finish]
function sequence(start, finish) = [for (i = [start : finish > start ? 1 : -1 :finish] ) i];
    
// Compute the involute angle
function involuteIntersectionAngle(base_radius, radius) = sqrt( pow(radius / base_radius,2) - 1);

// Convert from polar to cartesian coordinates
function fromPolar(r, theta) = [r * cos(theta), r * sin(theta)];

// Return N [x,y] points on the bezier curve that goes through Px
function bezierCurve(p0, p1, p2, n=10) =[
    for (i = [0 : n]) bezierPoint(p0, 2 * p1 - p0/2 - p2/2, p2, i * 1 / n)
];
    
// Calculate a point P at location t along the bezier curve going through points p0, p1, p2
function bezierPoint(p0, p1, p2, t) = p2 * pow(t, 2) + p1 * 2 * t * (1 - t) + p0 * pow((1 - t), 2);