function [rotL, rotR] = rotFromData(data,k)
dataL = data(1:k, :);
dataR = data(end - k + 1:end, :);
dataL = dataL - dataL(1, :);
dataR = dataR - dataR(1, :);
xL = dataL(:, 1);
yL = dataL(:, 2);
bL = 1 / (xL' * xL) * xL' * yL;
xR = dataR(:, 1);
yR = dataR(:, 2);
bR = 1 / (xR' * xR) * xR' * yR;
rotL = atan(bL);
rotR = atan(bR);
end