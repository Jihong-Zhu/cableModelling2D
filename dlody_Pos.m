function [dloData, minEn, para_a, thetaEnd, DLOangle] = dlody_Pos(xleft, yleft, xright, yright, Theta1, init)
% The function is based on
% /home/jihong/DLOs_Manpiluation/Latex/Modeling.pdf
% It simulate a 2D DLO based on energy minimum optimization. This program
% use CasaDi to solve the nonlinear optimization problem.
% This function only consider position constraints but not angle
% constraints
% External inputs:
% xleft: left end x poistion
% yleft: left end y position
% xright: right end x position
% yright: right end y position
% Theta1: For single arm the other end's angle is also fixed
% init: initial value for optimization
% Output:
% dloData: data that can be use to draw the cable shape
% minEn: Calculated minimum energy
% para_a: resulting parameters for dlo shape
% thetaEnd: theta at the manipulation end - for single arm planning
% DLOangle: theta along each point of the DLO
% Internal parameter:
% L: The total length of the DLO, is assign to 1. (As a nomial value)
% n: order of the approximation
% numOfData: numofData needed to draw the DLO, set to 100.
% Use casadi 
addpath('/home/jihong/third_party_softs/casadi-linux-matlabR2014b-v3.4.4');
import casadi.* 
% DLO modeling
L = 1; % assume the total length is 1
n = 4;  % use 4th order approximation
opti = casadi.Opti();
a = opti.variable(2 * n +2);
% Opimization function
f = a(2)^2 * L;
for i = 1 : n
    f = f + a(2 * i + 1)^2 * (2 * pi * i / L)^2 * L / 2 + a(2 * i + 2)^2 * (2 * pi * i / L)^2 * L / 2;
end
% Equality constraints
N = 100;
Lx = xright - xleft;      % 
Ly = yright - yleft;
% Theta1 = pi / 6;
% Theta2 = 2 * pi - pi / 6; 
lx = 0;
ly = 0;
for k = 1 : N
    phi = a(1) + a(2) * L * k / N;
    for i = 1 : n
        phi = phi + a(2 * i + 1) * sin(2 * pi * i * k / N) + a(2 * i + 2) * cos(2 * pi * i * k / N);
    end
    lx = lx + cos(phi) * L / N;
    ly = ly + sin(phi) * L / N;
end
theta1 = a(1);
for i = 1 : n
    theta1 = theta1 + a(2 * i + 2);
end
% Solve the optimization problem
opti.minimize(f);
opti.set_initial(a, init);
opti.subject_to(lx == Lx);
opti.subject_to(ly == Ly);
opti.subject_to(theta1 == Theta1);
opti.solver('ipopt');
sol = opti.solve();
para_a = sol.value(a);
minEn = sol.value(f);
% draw the cable based on value of a
% Create data point wrt a
px = xleft;
py = yleft;
DLO = [px,py];  % This gives the position left end
DLOangle = 0;   % This gives the angle of the left end
numOfData = 100;
for k = 1 : numOfData
    phi = para_a(1) + para_a(2) * L * k / numOfData;
    for i = 1 : n
        phi = phi + para_a(2 * i + 1) * sin(2 * pi * i * k / numOfData) + para_a(2 * i + 2) * cos(2 * pi * i * k / numOfData);
    end
    px = px + cos(phi) * L / numOfData;
    py = py + sin(phi) * L / numOfData;
    DLO = [DLO;px, py];
    DLOangle = [DLOangle; phi];
end
dloData = DLO;
% scatter(DLO(:,1), DLO(:,2))
% axis('equal');
thetaEnd = para_a(1) + para_a(2) * L;
for i = 1 : n
    thetaEnd = thetaEnd + para_a(2 * i + 2);
end
end