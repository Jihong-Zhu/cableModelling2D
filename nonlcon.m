function [c, ceq] = nonlcon(x)
ceq = [];
p0 = [0.9, -0.4];
p1 = [0.75, 0.60];
i = 0 : .01 : 1;
i = i';
f = (1 - i) * p0 + i * p1 + i .* (1 - i) * x(1:2) + i.^2 .* (1 - i) * x(3:4) + i.^3 .* (1 - i) * x(5:6);
x = f(:, 1);
y = f(:, 2);
d = x.^2 + y.^2;
d = d - 1;
% to have a fixed number of 
for k = 1 : length(y)
    if y(k) < -0.2 && y(k) > 0.2 
        x(k) = 0.8;
    end
end
x = x -0.8; % geometric constraints
c = [d; x];

     
