function main()
%% CUAVA-1
% 1 49275U 98067SU  22038.85422300  .00038560  00000-0  56171-3 0  9991
% 2 49275  51.6401 254.1730 0005941 193.8362 257.3518 15.55314769 19376

%% setup
% Determine where your m-file's folder is.
folder = pwd; 
% Add that folder plus all subfolders to the path.
addpath(genpath(folder));

%% simulation
re = 6378; % earth radius (km)
g0 = 9.81; % gravitaional acceleration (m/s2)
mu = 398600; % gravitational parameter (km3/s2)

tle = [51.6401 254.1730 0005941 193.8362 257.3518 15.55314769];
oe = tle2oe(tle);

[ri,vi] = oe2rv(oe);

T = [0 period(oe)];

% generate orbit
opts = odeset('RelTol',1e-10,'AbsTol',1e-10);
[t,x] = ode45(@twobody,T,[ri,vi],opts);

plot3(x(:,1),x(:,2),x(:,3))
grid on
hold on
plot3(x(1,1),x(1,2),x(1,3),'o')
plot3(x(end,1),x(end,2),x(end,3),'x')

% visualise earth
[ex,ey,ez] = sphere;
surf(6378*ex,6378*ey,6378*ez,'FaceColor','w')

xlim([-10000 10000])
ylim([-10000 10000])
axis equal


end

