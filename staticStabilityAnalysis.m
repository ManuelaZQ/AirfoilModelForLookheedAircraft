% staticStabilityAnalysis.m
% script to analyze static stability for given aircraft

% recall aircraft geometric data
aircraftGeometricData

% calculate aerodynamic coefficients for wing and horizontal tail, and downwash parameters
aircraft = calculateAircraftAerodynamics(aircraft);

% calculate aircraft longitudinal aerodynamic coefficients for selected CG position
xCG = 14.62;
aircraft = calculateAircraftLongitudinalCoefficientParameters(aircraft,xCG);

% calculate trim conditions for given aircraft at specified airspeed, altitude, vertical velocity, and weight
Vvert = 0*0.3048/60;
[alphatrim,ihtrim,deltaetrim,thrustRequired,CLtrim,CDtrim,CLwbtrim,CLttrim,CDwbtrim,CDttrim] = calculateTrim(aircraft.V,aircraft.h,Vvert,aircraft.W,aircraft);

% calculate CG limits
SMmin = 0.1;
ihtrimmin = -10*0.2*pi/180;
deltaetrimmin = -20*0.2*pi/180;
aircraft = calculateCGlimits(aircraft,SMmin,ihtrimmin,deltaetrimmin);

% display results
disp('Aircraft data structure')
aircraft
disp(' ')
disp(['Results for ',aircraft.aircraftName,' aircraft at ',aircraft.flightCondition])
disp(' Static margin')
disp(['  SM = ',num2str(aircraft.SM*100,'%5.1f'),'%'])
disp(['    for xCG = ',num2str(aircraft.xCG/0.3048),' ft = ',num2str(aircraft.xCG),' m'])
disp(' ')
disp(' CG limits')
disp(['  xCGmin = ',num2str(aircraft.xCGmin/0.3048),' ft = ',num2str(aircraft.xCGmin),' m'])
if aircraft.Cmih~=0
  disp(['    for ihtrimmin = ',num2str(aircraft.ihtrimmin*180/pi,'%5.2f'),' deg'])
  if aircraft.Cmdeltae~=0
    disp('        and deltae = 0 deg')
  end
else
  disp(['    for deltaetrimmin = ',num2str(aircraft.deltaetrimmin*180/pi,'%5.2f'),' deg'])
end
disp(['    with SMmax = ',num2str(aircraft.SMmax*100,'%5.2f'),'%'])
disp(['  xCGmax = ',num2str(aircraft.xCGmax/0.3048),' ft = ',num2str(aircraft.xCGmax),' m'])
disp(['    for SMmin = ',num2str(aircraft.SMmin*100,'%5.2f'),'%'])
disp(' ')
disp('Trim conditions')
disp(['  V = ',num2str(aircraft.V*3600/1852,'%5.1f'),' kn = ',num2str(aircraft.V,'%5.1f'),' m/s'])
disp(['  h = ',num2str(aircraft.h/0.3048),' ft = ',num2str(aircraft.h),' m'])
disp(['  Vvert = ',num2str(Vvert*60/0.3048),' ft/min = ',num2str(Vvert),' m/s'])
disp(['  W = ',num2str(aircraft.W/4.448222),' lbf = ',num2str(aircraft.W/aircraft.g,'%5.1f'),' kgf'])
disp(['  xCG = ',num2str(aircraft.xCG/0.3048),' ft = ',num2str(aircraft.xCG),' m'])
disp(['  alphatrim = ',num2str(alphatrim*180/pi,'%6.2f'),' deg = ',num2str(alphatrim),' rad'])
if aircraft.Cmih~=0
  disp(['  ihtrim = ',num2str(ihtrim*180/pi,'%6.2f'),' deg = ',num2str(ihtrim),' rad'])
  if aircraft.Cmdeltae~=0
    disp('        and deltae = 0 deg = 0 rad')
  end
else
  disp(['  deltaetrim = ',num2str(deltaetrim*180/pi,'%6.2f'),' deg = ',num2str(deltaetrim),' rad'])
end
disp(['  thrustRequired = ',num2str(thrustRequired/4.448222),' lbf = ',num2str(thrustRequired/aircraft.g,'%5.1f'),' kgf'])
disp(['  CLtrim = ',num2str(CLtrim,'%6.4f')])
disp(['  CDtrim = ',num2str(CDtrim,'%6.4f')])
disp(['  CLwbtrim = ',num2str(CLwbtrim,'%6.4f')])
disp(['  CLttrim = ',num2str(CLttrim,'%6.4f')])
disp(['  CDwbtrim = ',num2str(CDwbtrim,'%6.4f')])
disp(['  CDttrim = ',num2str(CDttrim,'%6.4f')])





