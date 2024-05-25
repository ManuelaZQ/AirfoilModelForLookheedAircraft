% calculateCGlimits.m
% function to calculate center of gravity limits for given aircraft 
% usage
%   aircraft = calculateCGlimits(aircraft,SMmin,ihtrimmin,deltaetrimmin)
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
%       aircraft.alphaL0w : wing-body zero lift angle (rad)
%       aircraft.CDwb0 : wing-body minimum drag coefficient
%       aircraft.ew : wing-body oswald number
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
% The result of the function is the same aircraft data structure with some additional fields
%   aircraft : aircraft data structure with the fields described previously and the following additional fields
%     * CG limits data
%       aircraft.xCGmin : minimum CG position (max forward CG position) (m)
%       aircraft.xCGmax : maximum CG position (max backwards CG position) (m)
%       aircraft.SMmin : minimum static margin, static margin for maximum CG position (max backwards CG position)
%       aircraft.SMmax : maximum static margin, static margin for minimum CG position (max forward CG position)
%       aircraft.ihtrimmin : minimum horizontal tail control for trim (rad)
%       aircraft.deltaetrimmin : minimum elevator control for trim (rad)
%

function aircraft = calculateCGlimits(aircraft,SMmin,ihtrimmin,deltaetrimmin)
    aircraft.SMmin = SMmin;
    
    % for minimum forward CG position
    aircraft.xCGmin = -deltaetrimmin*(aircraft.xACt - aircraft.ct*aircraft.Cmtdeltae/(aircraft.CLtalpha*aircraft.epsilone));% minimum CG position (max forward CG position) (m) XXXX
    aircraft.SMmax = (aircraft.xnp-aircraft.xCGmin)/aircraft.cw;

    % for maximum backwards CG position
    aircraft.xCGmax = aircraft.xnp - aircraft.cw*SMmin;
    aircraft.SMmin = SMmin;

    % minimum control surfaces deflections
    aircraft.ihtrimmin = ihtrimmin;
    aircraft.deltaetrimmin = deltaetrimmin;
    
    % auxiliary function to be optimized to calculate minimum CG position (max forward CG position)
    %function y = fxCGmin(xCG,aircraft,ihtrimmin,deltaetrimmin)
        %[~,~,deltaetrim,~,~,~,~,~,~,~] = calculateTrim(V,h,Vvert,W,aircraft);
        %y = norm(deltaetrim+10*pi/180)^2;
        %aircraft.SMmax = 
    %end
    
    % auxiliary function to be optimized to calculate maximum CG position (max backwards CG position)
    %function y = fxCGmax(xCG,aircraft,SMmin)
        %y = norm(aircraft.SM - 0.05)^2;
    %end

    % options
    %maxiter = 1e4;
    %tol = 1e-9;
    %xCG0 = aircraft.xCG; % pivote value
    
    %lb = -3*xCG0;
    %ub = 3*xCG0;

    %options = optimset('Algorithm','sqp','Display','off','MaxIter',maxiter,'TolX',tol);
    %[xCGmin,fvalmin,flagmin] = fmincon(@(xCG) fxCGmin(V,h,Vvert,W,xCG,aircraft),xCG0,[],[],[],[],lb,ub,[],options);
    %[xCGmax,fvalmax,flagmax] = fmincon(@(xCG) fxCGmax(V,h,Vvert,W,xCG,aircraft),xCG0,[],[],[],[],lb,ub,[],options);

    %aircraft.xCGmin = xCGmin;
    %aircraft.xCGmax = xCGmax;
    %aircraft.SMmax = -;
    
end
