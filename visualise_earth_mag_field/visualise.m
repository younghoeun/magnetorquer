clear all;close all;clc

earth = referenceSphere('Earth');

[X,Y,Z] = sphere(15);
r = earth.Radius*0.8;
surf(X*r,Y*r,Z*r,'FaceColor','w','FaceAlpha',0)
axis equal
hold on

i = 1;
j = 1;

idx = 13;
% lat = linspace(-pi/2,pi/2,idx);
% lon = linspace(-pi,pi,idx);
% [X,Y] = meshgrid(lat,lon);
alt = 1000;
dec = [];
for lat = linspace(-pi/2,pi/2,idx)
    for lon = linspace(-pi,pi,idx)
        [XYZ,H,D,I,F] = igrfmagm(alt,lat*180/pi,lon*180/pi,decyear(2015,7,4),12);
        a = isnan(XYZ);
        XYZ(a) = 0;  
        ecef = rot(lat,lon)*XYZ';
        vec(1) = -ecef(3);
        vec(2) = ecef(2);
        vec(3) = ecef(1);
        vec = -vec*50;
        
        [x,y,z] = geodetic2ecef(earth,lat*180/pi,lon*180/pi,alt);
        quiver3(x,y,z,vec(1),vec(2),vec(3),'k','MaxHeadSize',10)
        j = j+1;
    end
    j = 1;
    i = i+1;
end

view(0,0)
xlabel('x')
ylabel('y')
zlabel('z')

