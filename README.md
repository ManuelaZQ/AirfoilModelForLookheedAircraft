# Dynamic Stability Analysis for a Lockheed P-3 Orion in Cruise
This project for the "Flight Dynamics" course consists of the development of a MATLAB code, based on the calculation of equilibrium conditions in leveled rectilinear flight, for the longitudinal stability analysis of a Lockheed P-3 Orion. 

It was found that the aircraft is stable for the flight conditions as long as the center of gravity is between 2.0815 and 12.3441 *m*.

### Instructions

------------

You just need to run the `staticStabilityAnalysis.m` script to get all the graphs that display the static-longitudinal stability analysis results, which are:

- Aircraft data structure
- Static margin
- Center of Gravity (CG) limits
- Trim conditions

### Functions

------------

The files that contain the functions that are called from the main script are:
+ `calculateAircraftAerodynamics.m` calculates the aircraft aerodynamic coefficients for wing, horizontal tail, and downwash effect
+ `calculateAircraftLongitudinalCoefficientParameters.m` calculates the parameters of dimensionless aircraft longitudinal aerodynamic coefficients
+ `calculateTrim.m` calculates the trim conditions for given aircraft and flight conditions
+  `fxCGmin.m` is an auxiliary function to be optimized to calculate minimum CG position (max forward CG position)
+ `fxCGmax.m` is an auxiliary function to be optimized to calculate maximum CG position (max backwards CG position)
+ `calculateCGlimits.m` calculates the center of gravity limits for given aircraft 
+ `aircraftGeometricData.m` defines the geometric data for a fixed wing aircraft defining aircraft data structure

### Analysis

------------
The analysis of the result can be found in the `Dynamic_Stability_Analysis_for_Lockheed_in_Cruise.pdf` file.
