function [vL, vR] = transl_crtl(tL,tR,currentshape,lambda)
% Calculate translation based on target and current shape of the DLO
cL = currentshape(1, :);
cR = currentshape(end, :);
vL = lambda * (tL - cL);
vR = lambda * (tR - cR);
end