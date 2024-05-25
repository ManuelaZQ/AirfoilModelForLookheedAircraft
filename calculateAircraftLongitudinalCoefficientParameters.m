% calculateAircraftLongitudinalCoefficientParameters.m
% function to calculate parameters of dimensionless aircraft longitudinal aerodynamic coefficients
% usage
%   aircraft = calculateAircraftLongitudinalCoefficients(aircraft,xCG)
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
%       aircraft.xACw : wing aerodynamic center position respect to aircraft datum
%       aircraft.alpha0w : wing incidence (rad)
%     * horizontal tail geometry
%       aircraft.St : horizontal tail area (m^2)
%       aircraft.bt : horizontal tail span (m)
%       aircraft.ct : horizontal tail mean aerodynamic chord (m)
%       aircraft.At : horizontal tail aspect ratio
%       aircraft.xACt : horizontal tail aerodynamic center position respect to aircraft datum
%       aircraft.alpha0t : horizontal tail incidence (rad)
%     * wing aerodynamic coefficients
%       aircraft.CLwbalpha : wing-body lift coefficient slope
%       aircraft.alphaL0wb : wing-body zero lift angle (rad)
%       aircraft.CDwb0 : wing-body minimum drag coefficient
%       aircraft.ewb : wing-body oswald number
%       aircraft.Cmwb0 : wing-body moment coefficient respect to wing aerodynamic center
%     * horizontal tail aerodynamic coefficients
%       aircraft.CLtalpha : horizontal tail lift coefficient slope
%       aircraft.alphaL0t : horizontal tail zero lift angle (rad) 
%       aircraft.epsilone : elevator effectiveness
%       aircraft.CDt0 : horizontal tail minimum drag coefficient
%       aircraft.et : horizontal tail oswald number
%       aircraft.Cmt0 : horizontal tail moment coefficient respect to horizontal tail aerodynamic center
%       aircraft.Cmtdeltae : elevator moment respect to horizontal tail aerodynamic center derivative 
%     * downwash effect
%       aircraft.Kd : downwash constant
%       aircraft.etat : tail efficiency
%   xCG : position of aircraft CG respect to aircraft datum
% The result of the function is the same aircraft data structure with some additional fields
%   aircraft : aircraft data structure with the fields described previously and the following additional fields
%     * CG position
%       aircraft.xCG : position of aircraft CG respect to aircraft datum (m)
%       aircraft.lw : distance between CG and wing aerodynamic center position, positive if wing aerodynamic center position is behing CG (m)
%       aircraft.lt : distance between CG and horizontal tail aerodynamic center position (m)
%     * downwash model
%       aircraft.epsilond0 : downwash angle when aircraft angle of attack is zero
%       aircraft.epsilondalpha : downwash derivative respect to aircraft angle of attact
%     * aircraft lift coefficient model
%       aircraft.CL0 : aircraft lift coefficient when alpha=0, ih=0, and deltae=0
%       aircraft.CLalpha : aircraft lift coefficient slope
%       aircraft.CLih : derivative of aircraft lift coefficient respect to horizontal tail deflection
%       aircraft.CLdeltae : derivative of aircraft lift coefficient respect to elevator deflection
%     * aircraft moment coefficient model
%       aircraft.Cm0 : aircraft moment coefficient when alpha=0, ih=0, and deltae=0
%       aircraft.Cmalpha : aircraft pitch stability derivative
%       aircraft.Cmih : derivative of aircraft moment coefficient respect to horizontal tail deflection
%       aircraft.Cmdeltae : derivative of aircraft moment coefficient respect to elevator deflection
%     * static pitch stability parameters
%       aircraft.SM : static margin
%       aircraft.lnp : distance between CG and neutral point (m)
%       aircraft.xnp : position of neutral point respect to aircraft datum (m)
%

function aircraft = calculateAircraftLongitudinalCoefficientParameters(aircraft,xCG)
    % CG position
    aircraft.xCG = xCG;
    aircraft.lw = aircraft.xACw - aircraft.xCG;
    aircraft.lt = aircraft.xACt - aircraft.xCG;

    % downwash position
    aircraft.epsilond0 = (aircraft.Kd*aircraft.CLwbalpha*(aircraft.alpha0w - aircraft.alphaL0wb))/aircraft.Aw;
    aircraft.epsilondalpha = aircraft.Kd*aircraft.CLwbalpha/aircraft.Aw;

    % aircraft lift coefficient model
    aircraft.CL0 = aircraft.CLwbalpha*(aircraft.alpha0w - aircraft.alphaL0wb) + ...
                   (aircraft.etat*aircraft.St/aircraft.Sw)*aircraft.CLtalpha*(aircraft.alpha0t - ...
                   aircraft.epsilond0 - aircraft.alphaL0t);
    aircraft.CLalpha = aircraft.CLwbalpha + (aircraft.etat*aircraft.St/aircraft.Sw)*aircraft.CLtalpha*(1 - ...
                       aircraft.epsilondalpha);
    aircraft.CLih = 0;
    aircraft.CLdeltae = (aircraft.etat*aircraft.St/aircraft.Sw)*aircraft.CLtalpha*aircraft.epsilone;

    % aircraft moment coefficient model
    aircraft.Cm0 = aircraft.Cmwb0 + ((aircraft.etat*aircraft.St*aircraft.ct)/(aircraft.Sw*aircraft.cw))*aircraft.Cmt0 - ...
                   (aircraft.lw*aircraft.CLwbalpha/aircraft.cw)*(aircraft.alpha0w - aircraft.alphaL0wb) - ...
                   ((aircraft.etat*aircraft.St*aircraft.lt)/(aircraft.Sw*aircraft.cw))*aircraft.CLtalpha*(aircraft.alpha0t - ...
                   aircraft.epsilond0 - aircraft.alphaL0t);
    aircraft.Cmalpha = -(aircraft.lw*aircraft.CLwbalpha/aircraft.cw) - ((aircraft.etat*aircraft.St*aircraft.lt)/...
                        (aircraft.Sw*aircraft.cw))*aircraft.CLtalpha*(1 - aircraft.epsilondalpha);
    aircraft.Cmih = 0;
    aircraft.Cmdeltae = ((aircraft.etat*aircraft.St*aircraft.ct)/(aircraft.Sw*aircraft.cw))*aircraft.Cmtdeltae - ...
                        ((aircraft.etat*aircraft.St*aircraft.lt)/(aircraft.Sw*aircraft.cw))*aircraft.CLtalpha*aircraft.epsilone;
    
    % static pitch stability parameters
    aircraft.SM = -aircraft.Cmalpha/aircraft.CLalpha;
    aircraft.lnp = aircraft.cw*aircraft.SM;
    aircraft.xnp = aircraft.lnp + aircraft.xCG;

end
