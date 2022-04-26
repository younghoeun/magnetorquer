%% calculate magnetic dipole moment from experimental data
clear all;close all;clc

%% load raw data
load('2021-11-24.mat')

%% process data
start = find(sum(raw') == 14);  % find flag - first reading 
mtqon = find(sum(raw') == 1);   % find flag - magnetorquer on
raw([start,mtqon],:) = [];      % delete flags

%% unit conversion
[time,enc,acc,gyr,mag] = unitConv(raw);
tstep = diff(time);
disp(['total time: ',num2str(time(end)),' sec']);

%% gyro bias compensation
gyr = gyr - mean(gyr(1:mtqon-1,:));

%% system parameters
I = 367623.6538/1e7;                      % kgm^2
B = norm(mean(mag(1:mtqon - 10,:)))/1e6;  % Tesla

% %% curve fitting (need orientation)
% tspan = [time(1) time(end)]
% x0 = 
% [ta,xa] = ode45(@(t,x) eom(t,x,M,B,I,2), tspan, x0);

%% calculate frequency (FFT)
L = length(gyr(:,3));
Fs = 1/mean(tstep(mtqon:end));

Y = fft(gyr(:,3));
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

f = Fs*(0:(L/2))/L;

[pks, locs]=findpeaks(P1);
[a,b] = max(pks);

figure
plot(f,P1) ; hold on
plot(f(locs(b)), pks(b), 'xr')
xlim([0 0.1])
ylim([-0.02 0.05])
xlabel('frequency (Hz)')
ylabel('|P(f)|')

freq = f(locs(b));                         % Hz
B = norm(mean(mag(1:mtqon - 100,:)))/1e6;  % Tesla

I = 367623.6538/1e7;    % kgm^2
sigma = 16479.9504/1e7;

% freq^2*4*pi^2*I/B
% freq^2*4*pi^2*sigma/B

disp(['Calculated magnetic dipole moment: ',num2str(freq^2*4*pi^2*I/B),' Am^2',', 1-sigma: ', num2str(freq^2*4*pi^2*sigma/B),' Am^2'])

figure;hold on
plot(time,gyr(:,3))
xlim([time(1) time(end)])
ylim([-0.1 0.1])
xlabel('time (sec)')
ylabel('angular velocity (rad/s)')

function [A,b] = calMag()
    fileName = 'magcal.txt';
    fid = fopen(fileName);
    raw = readData(fid);
    
    [time,enc,acc,gyr,mag] = unitConv(raw);
    [A,b,expMFS]  = magcal(mag);
    magC = (mag-b)*A;
    
%     figure
%     plot(raw(:,8:10))
%     hold on
%     plot(magC)

%     plot3(raw(:,8),raw(:,9),raw(:,10),'LineStyle','none','Marker','X','MarkerSize',8)
%     hold on
%     plot3(magC(:,1),magC(:,2),magC(:,3),'LineStyle','none','Marker','X','MarkerSize',8)

    disp(['magnetic field strengh: ',num2str(expMFS),' uT']);
end

function [euler,w] = getEuler(time,acc,gyr,mag,tstep)
    %% ahrs filter
    % for i  = 1:length(time)-1
    %     tstep(i) = time(i+1) - time(i);
    % %     fuse = ahrsfilter('SampleRate',1/tstep(i));
    % %     [q(i),v(i,:)] = fuse(acc(i,:),gyr(i,:),mag(i,:));
    %     fuse = imufilter('SampleRate',1/tstep(i));
    %     q(i) = fuse(acc(i,:),gyr(i,:));    
    %     euler(i,:) = eulerd(q(i),'XYZ','frame');
    % end


    % % imu filter
    % for i  = 1:length(time)-1
    %     tstep(i) = time(i+1) - time(i);
    % %     fuse = ahrsfilter('SampleRate',1/tstep(i));
    % %     [q(i),v(i,:)] = fuse(acc(i,:),gyr(i,:),mag(i,:));
    %     fuse = imufilter('SampleRate',1/tstep(i));
    %     [q(i),v(i,:)] = fuse(acc(i,:),gyr(i,:));    
    %     euler(i,:) = eulerd(q(i),'XYZ','frame');
    % end

    %% Batch filter (ahrs)
    fuse = ahrsfilter('SampleRate',1/mean(tstep),'GyroscopeDriftNoise', 1e-6);
    [q,w] = fuse(acc,gyr,mag);    
    euler = eulerd(q,'XYZ','frame');

%     %% Batch filter (imu)
%     tstep = diff(time);
%     fuse = imufilter('SampleRate',1/mean(tstep),'AccelerometerNoise',max(avar),'GyroscopeDriftNoise',max(gvar),'GyroscopeDriftNoise', 1e-6);
%     [q,w] = fuse(acc,gyr);    
%     euler = eulerd(q,'XYZ','frame');
end

function Cbn = TRIAD(fb, mb, fn, mn)
% Cbn = TRIAD(fb, mb, fn, mn)
% Function implements  TRIAD algorithm using measurements
% from three-component accelerometer with orthogonal axes and vector
% magnetometer
%
%   Input arguments:
%   fb  - Acceleration vector in body frame [3x1]
%   mb  - Magnetic field vector in body frame [3x1]
%   fn  - Gravity vector in navigation frame [3x1]
%   mn  - Magetic field vector in navigation frame [3x1]
%
%   Output arguments:
%   Cbn - estimated Direction Cosines Matrix (DCM)

W1 = fb/norm(fb);
W2 = mb/norm(mb);

V1 = fn/norm(fn);
V2 = mn/norm(mn);

Ou1 = W1;
Ou2 = cross(W1,W2)/norm(cross(W1,W2));
Ou3 = cross(W1,cross(W1,W2))/norm(cross(W1,W2));

R1 = V1;
R2 = cross(V1,V2)/norm(cross(V1,V2));
R3 = cross(V1,cross(V1,V2))/norm(cross(V1,V2));

Mou = [Ou1, Ou2, Ou3];
Mr = [R1, R2, R3];

%TRIAD DCM
Cbn = Mr*Mou';

end