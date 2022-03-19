function [dpx, dpy] = Q2_PIVlab(imagea, imageb, wsize, xgrid, ygrid)
    %Q1_PIVlab - simple wrapper function for piv package function. Done
    %this way to make the PIV code more portable into the future.
    [dpx, dpy] = piv.calculateDisplacementsSubpixel(imagea, imageb, wsize, xgrid, ygrid);
end