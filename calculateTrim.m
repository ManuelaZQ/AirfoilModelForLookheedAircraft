% calculateTrim.m
% function to calculate trim conditions for given aircraft and flight conditions
% usage
%   [alphatrim,ihtrim,deltaetrim,thrustRequired,CLtrim,CDtrim,CLwbtrim,CLttrim,CDwbtrim,CDttrim] = calculateTrim(V,h,Vvert,W,aircraft)
% where
%   V : air speed (m/s)
%   h : altitude (m)
%   Vvert : vertical velocity (m/s)
%   W : aircraft weight (N) 
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
%     * CG position
%       aircraft.xCG : position of aircraft CG respect to aircraft datum (m)
%       aircraft.lw : distance between CG and wing aerodynamic center position, positive if wing aerodynamic center position is behing CG (m)
%       aircraft.lt : distance between CG and horizontal tail aerodynamic center position (m)
%     * downwash model
%       aircraft.epsilond0 : downwash angle when aircraft angle of attact is zero
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
%   alphatrim : angle of attack at trim condition (rad)
%   ihtrim : horizontal tail control at trim condition (rad)
%   deltaetrim : elevator control at trim condition (rad)
%   thrustRequired : thrust required at trim condition (N)
%   CLtrim : lift coefficient at trim condition
%   CDtrim : drag coefficient at trim condition
%   CLwbtrim : wing-body lift coefficient at trim condition
%   CLttrim : horizontal tail lift coefficient at trim condition
%   CDwbtrim : wing-body drag coefficient at trim condition
%   CDttrim : horizontal tail drag coefficient at trim condition
%

function [alphatrim,ihtrim,deltaetrim,thrustRequired,CLtrim,CDtrim,CLwbtrim,CLttrim,CDwbtrim,CDttrim] = calculateTrim(V,h,Vvert,W,aircraft)
    gamma = asin(Vvert/V);
    [rho,P,T,a] = atmosphere(h);

    % trim aerodynamic conditions
    CLtrim = (2*W*cos(gamma))/(rho*V^2*aircraft.Sw);
    Cm0 = 0;

    % Solve system 2x2 as a function of lift and pitch moment slopes for
    % trim condition
    b1 = CLtrim - aircraft.CL0;
    b2 = Cm0 - aircraft.Cm0;
    Y = [aircraft.CLalpha aircraft.CLdeltae; aircraft.Cmalpha aircraft.Cmdeltae]\[b1; b2];

    alphatrim = Y(1,1);
    deltaetrim = Y(2,1);
    ihtrim = 0*pi/180;
    
    % lift coefficient
    CLwbtrim = aircraft.CLwbalpha*(alphatrim - aircraft.alphaL0wb + aircraft.alpha0w);
    CLttrim = aircraft.CLtalpha*((1 - aircraft.epsilondalpha)*alphatrim + aircraft.alpha0t - ...
              aircraft.epsilond0 - aircraft.alphaL0t + aircraft.epsilone*deltaetrim);

    % drag coefficient
    CDwbtrim = aircraft.CDwb0 + (CLwbtrim^2/(pi*aircraft.Aw*aircraft.ewb));
    CDttrim = aircraft.CDt0 + (CLttrim^2/(pi*aircraft.At*aircraft.et));

    CDtrim = CDwbtrim + (aircraft.St*aircraft.etat/aircraft.Sw)*CDttrim;

    % thrustRequiered
    thrustRequired = CDtrim*((1/2)*rho*V^2*aircraft.Sw);

end