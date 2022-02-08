function R = dcm(O,i,o)
%% rotation from perifocal to eci

R = [-sin(O)*cos(i)*sin(o)+cos(O)*cos(o) -sin(O)*cos(i)*cos(o)-cos(O)*sin(o) sin(O)*sin(i)
     cos(O)*cos(i)*sin(o)+sin(O)*cos(o) cos(O)*cos(i)*cos(o)-sin(O)*sin(o) -cos(O)*sin(i)
     sin(i)*sin(o) sin(i)*cos(o) cos(i)]; 