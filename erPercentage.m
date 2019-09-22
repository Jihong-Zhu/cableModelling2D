function err = erPercentage(current, target)
% Calculate percentage error bewteen current and target
err = abs((current - target) ./ target);