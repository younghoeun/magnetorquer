function OE = tle2oe(TLE)
    mu = 398600;
    i = TLE(1)/180*pi;        % inclination
    O = TLE(2)/180*pi;        % RAAN
    e = TLE(3);               % eccentricity
    o = TLE(4)/180*pi;        % argument of perigee
%     w = TLE(5)/180*pi;      
%     theta = TLE(6)/180*pi;

    M = TLE(5)/180*pi;        % mean anomaly
    n = TLE(6)/60/60/24*2*pi; % mean motion             [rev/day -> rad/s]

%     M = E - esinE
    syms E
    E = vpasolve(M == E - e*sin(E));
    E = double(E);
    theta = acos((e-cos(E))/(e*cos(E)-1));
    T = 2*pi/n;
    a = (mu/n^2)^(1/3);
    h = sqrt(a*mu*(1-e^2));
    OE = [i O e o h theta];
    
    rp = a*(1-e);
    ra = (2*a - rp);
    
    disp(['classical orbital elements'])
    disp(['    Eccentricity: ',num2str(e)]);
    disp(['    Semimajor axis: ',num2str(a), ' km']);
    disp(['    Inclination: ', num2str(i*180/pi), 'deg']);
    disp(['    Right Ascension of Ascending Node (RAAN): ',num2str(o*180/pi),' deg']);
    disp(['    Argument of perigee: ',num2str(o*180/pi),' deg']);
    disp(['    True anomaly: ',num2str(theta*180/pi),' deg']);  
    fprintf('\n')
    
    disp(['other orbital parameters'])
    disp(['    Period: ',num2str(T),' sec']);
end


