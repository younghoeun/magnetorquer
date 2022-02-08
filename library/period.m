function T = period(OE)
mu = 398600;

h = OE(5);
e = OE(3);
a = h^2/mu/(1-e^2);

T = 2*pi/sqrt(mu)*a^(3/2);
end