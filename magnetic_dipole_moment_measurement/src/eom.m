function dxdt = eom(t,x,M,B,I,type)
    dxdt = zeros(2,1);
    dxdt(1) = x(2);
    if type == 1
        dxdt(2) = -M*B*sin(x(1))/I - 0*0.0005*x(2);
    else
        dxdt(2) = -M*B*x(1)/I - 0.0005*x(2);
    end
end
