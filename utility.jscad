//===================================================================================
// Helper functions for Parameteric Spur Gear OpenJSCAD script
//
// Based on Boston Gear design rules https://www.bostongear.com/pdf/gear_theory.pdf
//
// Copyright (c) 2016 Mark Seminatore
//
// Refer to included LICENSE.txt for usage rights and restrictions
//===================================================================================
//

// Calculate the tooth pitch diameter
function pitchDiameter(teeth, diametral_pitch = 24) {
	return teeth / diametral_pitch;
}

//
function rootDiameter(teeth, diametral_pitch = 24) {
	return pitchDiameter(teeth, diametral_pitch) - 2 *((2.2 / diametral_pitch + 0.002) - (1 / diametral_pitch));
}

//
function toothDiameter(teeth, diametral_pitch = 24) {
	return pitchDiameter(teeth, diametral_pitch) + 2 * (1 / diametral_pitch);
}

// Generate a linear sequence from [start..finish]
function sequence(start, finish) {
	var inc = finish > start ? 1 : -1;
	var points = [];
	for (i = start; i <= finish; i += inc) {
		points[i] = i;
	}
}
    
// Compute the involute angle
function involuteIntersectionAngle(base_radius, radius) {
	return sqrt( pow(radius / base_radius,2) - 1);
}

// Convert from polar to cartesian coordinates
function fromPolar(r, theta) {
	return [r * cos(theta), r * sin(theta)];
}

// Return N [x,y] points on the bezier curve that goes through Px
function bezierCurve(p0, p1, p2, n = 10) {
	var points = [];

	for (i = 0; i < n; i++) {
		points[i] = bezierPoint(p0, 2 * p1 - p0/2 - p2/2, p2, i * 1 / n);
	}
	return points;
}
    
// Calculate a point P at location t along the bezier curve going through points p0, p1, p2
function bezierPoint(p0, p1, p2, t) {
	return p2 * pow(t, 2) + p1 * 2 * t * (1 - t) + p0 * pow((1 - t), 2);
}

// Calculate the Tooth Thickness
function toothThickness(diametral_pitch = 24) {
	return 1.5708 / diametral_pitch;
}
