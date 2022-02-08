function main()
%% simulation
re = 6378; % earth radius (km)
g0 = 9.81; % gravitaional acceleration (m/s2)
mu = 398600; % gravitational parameter (km3/s2)

tle = [78.3205, 328.6010, 0138867, 40.3797, 320.7624, 14.93098502];
oe = tle2oe(tle);

[ri,vi] = oe2rv(oe);

T = [0 period(oe)];
opts = odeset('RelTol',1e-10,'AbsTol',1e-10);

[t,x] = ode45(@twobody,T,[ri,vi],opts);

plot3(x(:,1),x(:,2),x(:,3))
grid on
hold on
plot3(x(1,1),x(1,2),x(1,3),'o')
plot3(x(end,1),x(end,2),x(end,3),'x')
[X,Y,Z] = sphere;
surf(6378*X,6378*Y,6378*Z,'FaceColor','w')

xlim([-10000 10000])
ylim([-10000 10000])
axis equal


end

