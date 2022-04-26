%% numerical comparison between nonlinear and approximated equations of motion for magnetic torsional oscillator
clear all;close all;clc

%% system parameters
M = 1;      % magnetic dipole moment
B = 1;      % external magnetic field
I = 10;     % moment of inertia

%% ode parameters
tspan = [0:1e-3:300];
x0 = [60 0]/180*pi;

%% nonlinear solution
[tn,xn] = ode45(@(t,x) eom(t,x,M,B,I,1), tspan, x0);

%% approximated solution
[ta,xa] = ode45(@(t,x) eom(t,x,M,B,I,2), tspan, x0);

%% validation - find peaks and frequency
[peakn,locn] = findpeaks(xn(:,1),tn);
fn = 1./(locn(2:end) - locn(1:end-1));

[peaka,loca] = findpeaks(xa(:,1),ta);
fa = 1./(loca(2:end) - loca(1:end-1));
% fa = sqrt(M*B/4/pi^2/I); % analytical solution

%% inverse calculation - magnetic dipole moment from nonlinear solution
Mn = fn.^2*4*pi^2*I/B;
Ma = fa.^2*4*pi^2*I/B;

%% plot results
figure(1); hold on
h(1) = plot(tn,xn(:,1),'-'); h(2) = plot(ta,xa(:,1),'-'); h(3) = plot(locn,peakn,'ob'); h(3) = plot(loca,peaka,'^r');
ylim([min([min(xn),min(xa)])*1.7 max([max(xn),max(xa)])*1.7])
xlabel('Time (sec)'); ylabel('Angle (rad)'); legend(h(1:2),'Nonlinear','Approximated')

figure(2); hold on
plot(fn,'-o'); plot(fa,'-^')
ylim([mean([mean(fn),mean(fa)])*0.8 mean([mean(fn),mean(fa)])*1.2])
xlabel('Time (sec)'); ylabel('Frequency (Hz)'); legend('Nonlinear','Approximated')

figure(3); hold on
plot(Mn,'-o'); plot(Ma,'-^')
ylim([mean([mean(Mn),mean(Ma)])*0.8 mean([mean(Mn),mean(Ma)])*1.2])
xlabel('Time (sec)'); ylabel('Magnetic dipole moment (mT)'); legend('Nonlinear','Approximated')

fig = findobj('Type', 'figure');
for i = 1:length(fig)
    set(fig(i).Children,'FontName','Times New Roman','FontSize',10)
end