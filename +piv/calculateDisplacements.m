% calulateDisplacements
% PIV package
% Author: Francesco Mascadri
% Contact: fmascadri@student.unimelb.edu.au
% April 2022

function [dpx, dpy] = calculateDisplacements(imagea, imageb, wsize, xgrid, ygrid)
    %calculateDisplacements

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

    %Intialise displacement grid
    dpx = zeros(size(xgrid,1),size(xgrid,2));
    dpy = zeros(size(ygrid,1),size(ygrid,2));

    %Cross-correlation
    for i = 1:size(ygrid,1)
        m = ygrid(i,1);
        for j = 1:size(xgrid,2)
            n = xgrid(1,j);

            x1 = n - wsize(1)/2;
            x2 = n + wsize(1)/2 - 1;
            y1 = m - wsize(2)/2;
            y2 = m + wsize(2)/2 - 1;

            %normalisation
            image1 = imagea(y1:y2,x1:x2);
            image2 = imageb(y1:y2,x1:x2);
            image1n = image1 - mean(mean(image1));
            sigma_1 = sqrt(mean(mean(image1n.^2)));
            image2n = image2 - mean(mean(image2));
            sigma_2 = sqrt(mean(mean(image2n.^2)));
            image1n = image1n./sigma_1;
            image2n = image2n./sigma_2;

            % cross-correlation of image pairs
            C = xcorr2(image2n, image1n)./(wsize(1)*wsize(2));
            [ymax, xmax] = find(C==(max(max(C))));

            ymax = ymax(1);
            xmax = xmax(1);

            dpx(i,j) = xmax - wsize(1);
            dpy(i,j) = ymax - wsize(2);
        end
    end

    %Log ouput
    logger = fx.log4m.getLogger;
    logger.trace('PIV:calculateDisplacements','calculateDisplacements called');
end