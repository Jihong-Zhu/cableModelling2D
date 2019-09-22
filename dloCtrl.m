function dloFinal = dloCtrl(dloCurrent, dloTarget, lambdaTranl, lambdaRot, threshold, initPara)
% This function generate local control strategy for single arm DLO
% manipulation and draw the figure for the manipulation process.
% Inputs-------------------------------------------------------------------
% dloCurrent: current dlo shape data (generated using dlody_Pos or dlodynamics
% dloTarget: target dlo shape data
% lambdaTranl: translational gain
% lambdaRot: rotational gain
% threshold: threshold to stop manipulation
% initPara: initial parameter to start simulation
% Outputs------------------------------------------------------------------
% dloFinal: Final obtained shape
% draw current and target shape
currentshape = plot(dloCurrent(:, 1), dloCurrent(:, 2), 'k', 'LineWidth',3);
plot(dloTarget(:, 1), dloTarget(:, 2), '--k', 'LineWidth',3);
% The current pos and rot
cL = [0, 0];
cR = dloCurrent(end, :);
k = 4;  % select k data around the end
[crotL, crotR] = rotFromData(dloCurrent,k);
% The target pos and rot
tL = [0, 0];
tR = dloTarget(end, :);
k = 4;  % select k data around the end
[trotL, trotR] = rotFromData(dloTarget,k);
% Error in translation & rotation
errT = erPercentage(cR, tR);
errR = erPercentage(crotR, trotR);
err = [errT, errR];
while max(err) > threshold
    % do control
    [~, vR] = transl_crtl(tL,tR,dloCurrent,lambdaTranl);
    [~, omegaR] = rot_crtl(trotL, trotR, crotL, crotR, lambdaRot);
    % update the new shape
    cR(1) = cR(1) + vR(1);
    cR(2) = cR(2) + vR(2);
    crotR = crotR + omegaR;
    dloCurrent = dlody_Pos(cL(1), cL(2), cR(1), cR(2), 0.0, initPara);
    set(currentshape, 'xdata', dloCurrent(:,1), 'ydata', dloCurrent(:,2));
    drawnow;
    pause(0.1);
    % update error
    errT = erPercentage(cR, tR);
    errR = erPercentage(crotR, trotR);
    err = [errT, errR];
end
dloFinal = dloCurrent;
    
    

