function OE = tle2oe(TLE)
    mu = 398600;
    i = TLE(1)/180*pi;
    O = TLE(2)/180*pi;
    e = TLE(3)/1e7;
    o = TLE(4)/180*pi;
    % h = TLE(5);
    % theta = TLE(6)/180*pi;

    M = TLE(5)/180*pi;
    n = TLE(6)/60/60/24*2*pi; % rev/day -> rad/s

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
    
    disp(['Period: ',num2str(T),' sec']);
    disp(['Semimajor axis: ',num2str(a),' km']);
    disp(['Perigee altitude: ',num2str(rp - 6378),' km']);
    disp(['Apogee altitude: ',num2str(ra - 6378),' km']);    
end


