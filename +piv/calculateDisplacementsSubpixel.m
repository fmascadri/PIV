function [dpx, dpy] = calculateDisplacementsSubpixel(imagea, imageb, wsize, xgrid, ygrid)
    %calculateDisplacementsSubpixel Calculates displacements to subpixel
    %accuracy by fitting a Gaussian curve in x and y.

    arguments
        %imagea The first image at time t
        imagea (:,:) double {mustBeNumeric, mustBeNonempty}
        %imageb The second image at time t+dt
        imageb (:,:) double {mustBeNumeric, mustBeNonempty}
        %wsize x,y interrogation window size [pixels]
        wsize (1,2)  {mustBeInteger, mustBeNonempty, mustBeNonzero}
        %xgrid Array of x positions dictating the centrepoints of all
        %interrogation windows
        xgrid (:,:) {mustBeNumeric, mustBeNonempty}
        %ygrid Array of y positions dictating the centerpoints of all
        %interrogation windows
        ygrid (:,:) {mustBeNumeric, mustBeNonempty}
    end

    % 1. crossCorrelation
    % 2. fitGaussian

    %Dummy output
    dpx = 0;
    dpy = 0;

    %Log ouput
    logger = fx.log4m.getLogger;
    logger.trace('PIV:calculateDisplacementsSubpixel',...
        'calculateDisplacementsSubpixel called');
end