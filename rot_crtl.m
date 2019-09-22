function [omegaL, omegaR] = rot_crtl(trotL,trotR,crotL,crotR,lambda)
% Calculate translation based on target and current shape of the DLO
omegaL = lambda * (trotL - crotL);
omegaR = lambda * (trotR - crotR);
end