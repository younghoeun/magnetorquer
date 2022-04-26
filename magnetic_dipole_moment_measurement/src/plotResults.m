%% plot results
function plotResults(tn,xn,ta,xa)
    figure(1); hold on
    h(1) = plot(tn,xn(:,1),'-'); h(2) = plot(ta,xa(:,1),'-'); h(3) = plot(locn,peakn,'ob'); h(3) = plot(loca,peaka,'^r');
    ylim([min([min(xn),min(xa)])*1.7 max([max(xn),max(xa)])*1.7])
    xlabel('Time (sec)'); ylabel('Angle (rad)'); legend(h(1:2),'Nonlinear','Approximated')

%     figure(2); hold on
%     plot(fn,'-o'); plot(fa,'-^')
%     ylim([mean([mean(fn),mean(fa)])*0.8 mean([mean(fn),mean(fa)])*1.2])
%     xlabel('Time (sec)'); ylabel('Frequency (Hz)'); legend('Nonlinear','Approximated')
% 
%     figure(3); hold on
%     plot(Mn,'-o'); plot(Ma,'-^')
%     ylim([mean([mean(Mn),mean(Ma)])*0.8 mean([mean(Mn),mean(Ma)])*1.2])
%     xlabel('Time (sec)'); ylabel('Magnetic dipole moment (mT)'); legend('Nonlinear','Approximated')

    fig = findobj('Type', 'figure');
    for i = 1:length(fig)
        set(fig(i).Children,'FontName','Times New Roman','FontSize',10)
    end
end

