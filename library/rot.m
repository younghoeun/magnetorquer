function R = rot(lat,lon)
R3 = [cos(lon) sin(lon) 0
     -sin(lon) cos(lon) 0
     0 0 1];
R2 = [cos(lat) 0 sin(lat)
      0 1 0
      -sin(lat) 0 cos(lat)];

R = R2*R3;

% R = [-sin(lon) -sin(lat)*cos(lon) cos(lat)*cos(lat)
%     cos(lon) -sin(lat)*sin(lon) cos(lat)*sin(lon)
%     0 cos(lat) sin(lat)];
% 
% R = [-sin(lat)*cos(lon) -sin(lat)*sin(lon) cos(lat)
%      -sin(lon) cos(lon) 0
%      -cos(lat)*cos(lon) -cos(lat)*sin(lon) -sin(lat)];

end
