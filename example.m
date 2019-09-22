xleft = 0;
yleft = 0;
xright = 0.7;
yright = - 0.1;
Theta1 = - pi / 6;
Theta2 = - pi / 6;

shape = dlodynamics(xleft, yleft, xright, yright,Theta1, Theta2, 1);
plot(shape(:, 1), shape(:, 2));