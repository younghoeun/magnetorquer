function state_dot = twobody(t,state)
% Keplerian orbit
x = state(1);
y = state(2);
z = state(3);
vx = state(4);
vy = state(5);
vz = state(6);

r_vec = [x;y;z];
v_vec = [vx;vy;vz];

r = norm(r_vec);
mu = 398600;

r_ddot = -mu/r^3*r_vec;

state_dot = [v_vec;r_ddot];
end

