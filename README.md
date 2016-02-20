# mdsSpurGear

Simple OpenSCAD script for parametric spur gear generation.  

Based on Boston Gear design rules https://www.bostongear.com/pdf/gear_theory.pdf

The script has several options including:

1. Number of teeth
2. Diametral pitch (*default is __24__*)
3. Pressure angle (*default is __20__*)
4. Shaft diameter
5. Gear thickness
6. Major holes (*default is __on__*)
7. Minor holes (*default is __on__*)
8. Number of holes (*default is __4__*)
9. Hub thickness (*default is __no hub__*)
10. Smooth teeth (*default is __off__*)

Images of Example gears:

![alt text](https://github.com/mseminatore/mdsSpurGear/blob/master/Examples/Gear24.png "24 tooth gear")

**24 tooth gear, 24 diametral pitch, major holes enabled**

![alt text](https://github.com/mseminatore/mdsSpurGear/blob/master/Examples/Gear24minor.png "24 tooth gear")

**24 tooth gear, 24 diametral pitch, major and minor holes enabled**

![alt text](https://github.com/mseminatore/mdsSpurGear/blob/master/Examples/Gear48.png "48 tooth gear")

**48 tooth gear, 24 diametral pitch, major and minor holes enabled**

![alt text](https://github.com/mseminatore/mdsSpurGear/blob/master/Examples/Stacked Gear.png "Stacked gear")

**10 tooth gear stacked on a 48 tooth gear, 24 diametral pitch, major and minor holes enabled**

## Release Notes

1. If you use a hub thickness ratio of greater than 1.0 you will need to consider printing with supports.
2. The new *experimental* **smooth_teeth** option generates a bezier curve rather than a simple polygon for the tooth profile
3. Unless you need to change the diametral pitch to match a mating gear the default option is a good choice.