function [data,mtqon,time,enc,acc,gyr,mag,tstep] = processData(raw)
% duplicate raw data
data = raw ;

% crop data
start = find(sum(raw') == 14) ;  % find flag - first reading 
if isempty(start)   
    start = 1 ;
end
mtqon = find(sum(raw') == 1) ;   % find flag - magnetorquer on
data([start:mtqon],:) = [] ;     % crop data

% unit conversion
[time,enc,acc,gyr,mag] = unitConv(data) ;
tstep = diff(time) ;

% gyro bias compensation
gyr = gyr - mean(raw(1:mtqon-10,2:4)/180*pi) ;

end