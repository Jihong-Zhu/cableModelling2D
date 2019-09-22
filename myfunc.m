function d = myfunc(x, i, p0, p1)
% trajectory generation
f = (1 - i) * p0 + i * p1 + i .* (1 - i) * x(1:2) + i.^2 .* (1 - i) * x(3:4) + i.^3 .* (1 - i) * x(5:6);
d = f(:, 1).^2 + f(:, 2).^2;
d = 1 / min(d);
end
