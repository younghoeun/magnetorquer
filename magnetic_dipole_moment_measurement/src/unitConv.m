function [time,enc,acc,gyr,mag] = unitConv(raw)
    %% unit conversion
    time = raw(:,1)/1000;                       % ms    -> sec   
    time = time - time(1);                      % initialise
    gyr = raw(:,2:4)/180*pi;                    % deg/s -> rad/s
    acc = raw(:,5:7)/100;                       % mg     -> m/s^2
    mag = raw(:,8:10)/10;                       % mGauss -> uT (Sydney : 57.0648 uT)
    enc = raw(:,11:14);                         % count (2048/rev)  
    enc = enc - enc(1,:);                       % initialise
end