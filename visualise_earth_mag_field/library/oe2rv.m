function [r_i,v_i] = oe2rv(OE)
mu = 398600;
i = OE(1);
O = OE(2);
e = OE(3);
o = OE(4);
h = OE(5);
theta = OE(6);

% if opt == 2
%     M = orbitalElements(5)/180*pi;
%     n = orbitalElements(6)/60/60/24*2*pi; % rev/day -> rad/s
% 
%     % M = E - esinE
%     syms E
%     E = vpasolve(M == E - e*sin(E));
%     E = double(E);
%     theta = acos((e-cos(E))/(e*cos(E)-1));
%     T = 2*pi/n;
%     a = (mu/n^2)^(1/3);
%     h = sqrt(a*mu*(1-e^2));
% end

% disp(E*180/pi)
% disp(theta*180/pi)
% disp(T)
% disp(a)
% disp(h)

%% Perifocal frame
r_f = h^2/mu*1/(1+e*cos(theta))*[cos(theta);sin(theta);0];
v_f = mu/h*[-sin(theta);e+cos(theta);0];

% disp(r_f)
% disp(v_f)
% disp(DCM(O,i,o))

%% ECI frame          
r_i = dcm(O,i,o)*r_f;
v_i = dcm(O,i,o)*v_f;

% disp(r_i)
% disp(v_i)
end


