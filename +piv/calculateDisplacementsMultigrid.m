function [dpx, dpy] = calculateDisplacementsMultigrid(imagea, imageb, wsize, xgrid, ygrid, dpx_est, dpy_est)
    %calculateDisplacementsMultigrid Calculates displacements with a
    %multigrid approach

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
        %dpx_est Array of estimates (to the nearest integer) of the
        %x-displacement of particles in each interrogation window
        dpx_est (:,:) {mustBeInteger, mustBeNonempty}
        %dpy_est Array of estimates (to the nearest integer) of the
        %y-displacement of particles in each interrogation window
        dpy_est (:,:) {mustBeInteger, mustBeNonempty}
    end

    % DO STUFF

    %Dummy output
    dpx = 0;
    dpy = 0;

    %Log ouput
    logger = fx.log4m.getLogger;
    logger.trace('PIV:calculateDisplacementsMultigrid',...
        'calculateDisplacementsMultigrid called');
end