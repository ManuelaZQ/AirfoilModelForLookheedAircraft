% aircraftGeometricData.m
% script to define geometric data for a fixed wing aircraft defining aircraft data structure
% where
%   aircraft : aircraft data structure with the following fields
%     * Aircraft general data:
%       aircraft.aircraftName : aircraft name     
%       aircraft.flightCondition : aircraft flight condition ('cruise')
%       aircraft.type : type=1 for an aircraft with elevator and a fixed horizontal tail
%                       type=2 for an aircraft with elevator and a adjustable horizontal tail
%                       type=3 for an aircraft with adjustable horizontal tail without elevator
%     * flight condition data
%       aircraft.V : cruise speed (m/s)
%       aircraft.h : cruise altitude (m)
%       aircraft.m : aircraft mass (kg)
%       aircraft.g : gravity (9.80665 m/s^2)
%       aircraft.W : aircraft weight (N)
%     * wing geometry
%       aircraft.Sw : wing area (m^2)
%       aircraft.bw : wing span (m)
%       aircraft.cw : wing mean aerodynamic chord (m)
%       aircraft.Aw : wing aspect ratio
%       aircraft.wingRootAirfoil : wing root airfoil
%       aircraft.wingTipAirfoil : wing tip airfoil
%       aircraft.lambdaw : wing taper ratio
%       aircraft.Lambdac4w : wing sweep angle at c/4 (rad)
%       aircraft.Gamaw : wing dihedral angle (rad)
%       aircraft.geometricTwistw : wing geometric twist (rad)
%       aircraft.xACw : wing aerodynamic center position respect to aircraft datum
%       aircraft.alpha0w : wing incidence (rad)
%     * horizontal tail geometry
%       aircraft.St : horizontal tail area (m^2)
%       aircraft.bt : horizontal tail span (m)
%       aircraft.ct : horizontal tail mean aerodynamic chord (m)
%       aircraft.At : horizontal tail aspect ratio
%       aircraft.horizontalTailRootAirfoil : horizontal tail root airfoil
%       aircraft.horizontalTailTipAirfoil : horizontal tail tip airfoil
%       aircraft.lambdat : horizontal tail taper ratio
%       aircraft.Lambdac4t : horizontal tail sweep angle at c/4 (rad)
%       aircraft.Gamat : horizontal tail dihedral angle (rad)
%       aircraft.geometricTwistt : horizontal tail geometric twist (rad)
%       aircraft.xACt : horizontal tail aerodynamic center position respect to aircraft datum
%       aircraft.alpha0t : horizontal tail incidence (rad)
%

  % aircraft general data
  aircraft.aircraftName = 'Lockheed Orion';
  aircraft.flightCondition = 'cruise';
  aircraft.type = 1;
  
  % flight condition data
  aircraft.V = 328*1852/3600;
  aircraft.h = 25000*0.3048;
  aircraft.m = 61234.97;
  aircraft.g = 9.80665;
  aircraft.W = aircraft.m*aircraft.g;

  % wing geometry
  aircraft.Sw = 120.77;
  aircraft.bw = 30.37;
  aircraft.cw = 4.26;
  aircraft.Aw = aircraft.bw^2/aircraft.Sw;
  aircraft.wingRootAirfoil = 'NACA 0014-1.10 40/1.051';
  aircraft.wingTipAirfoil = 'NACA 0012-1.10 40/1.051';
  aircraft.lambdaw = 0.4;
  aircraft.Lambdac4w = 3.25*pi/180;
  aircraft.Gamaw = 5*pi/180;
  aircraft.geometricTwistw = -2.5*pi/180;
  aircraft.xACw = 14.83;
  aircraft.alpha0w = 3*pi/180;

  % horizontal tail geometry
  aircraft.St = 29.9;
  aircraft.bt = 13.06;
  aircraft.ct = 2.5;
  aircraft.At =  aircraft.bt^2/aircraft.St;
  aircraft.horizontalTailRootAirfoil = 'NACA 23011 (inverted)';
  aircraft.horizontalTailTipAirfoill = 'NACA 23011 (inverted)';
  aircraft.lambdat = 0.325;
  aircraft.Lambdac4t = 6.39*pi/180;
  aircraft.Gamat = 8.5*pi/180;
  aircraft.geometricTwistt = 0*pi/180;
  aircraft.xACt = 29.49;
  aircraft.alpha0t = 1.5*pi/180;
  
  
