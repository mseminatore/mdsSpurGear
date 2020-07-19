# mdsSpurGear

Simple OpenSCAD script for parametric involute spur gear generation.  

Based on Boston Gear design rules https://www.bostongear.com/pdf/gear_theory.pdf

The script has several customizable parameterization options including:

1. Number of teeth
2. Diametral pitch (*default is __24__*)
3. Pressure angle (*default is __20__*)
4. Shaft diameter (*default is __0.125__*)
5. Gear thickness (*default is __0.125__*)
6. Major holes (*default is __on__*)
7. Minor holes (*default is __on__*)
8. Number of holes (*default is __4__*)
9. Hub thickness ratio (*default is __1.0__ which means __no hub__*)
10. Smooth teeth (Experimental so *default is __off__*)

## Example images of various gears

![24 tooth gear](https://mseminatore.github.io/mdsSpurGear/images/Gear24.png "24 tooth gear")

**24 tooth gear, 24 diametral pitch, major holes enabled**

![alt text](https://mseminatore.github.io/mdsSpurGear/images/Gear24minor.png "24 tooth gear")

**24 tooth gear, 24 diametral pitch, major and minor holes enabled**

![alt text](https://mseminatore.github.io/mdsSpurGear/images/Gear48.png "48 tooth gear")

**48 tooth gear, 24 diametral pitch, major and minor holes enabled**

![alt text](https://mseminatore.github.io/mdsSpurGear/images/StackedGear.png "Stacked gear")

**10 tooth gear stacked on a 48 tooth gear, 24 diametral pitch, major and minor holes enabled**

![alt text](https://mseminatore.github.io/mdsSpurGear/images/Gear2D.png "2D Gear")

**2D Projection of a 24 tooth gear, 24 diametral pitch, major and minor holes enabled**

![alt text](https://mseminatore.github.io/mdsSpurGear/images/GearVariations.png "Gear varieties")

**Collection of gear designs**

You can view additional examples at [Thingiverse.com](http://thingiverse.com/mseminatore/designs)

## Release Notes

1. If you use a hub thickness ratio of greater than 1.0 you __will__ need to consider printing with supports.
2. The new *experimental* **smooth_teeth** option generates a bezier curve rather than a simple polygon for the tooth profile.
3. Unless you need to change the **diametral_pitch** to match a mating gear the default option is a good choice.
4. The tooth thickness seems to be incorrect.  It appears to be smaller by a few thousandths, investigating.
5. Added !OpenSCAD comment for OpenJSCAD compat
