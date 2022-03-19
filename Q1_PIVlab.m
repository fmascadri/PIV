function [dpx, dpy] = Q1_PIVlab(imagea, imageb, wsize, xgrid, ygrid)
    %Q1_PIVlab - simple wrapper function for piv package function. Lab handout 
    %requires Q1_PIVLab to be a callable function but all logic sits inside 
    %piv package. Done this way to make the PIV code more portable into the future.
    [dpx, dpy] = piv.calculateDisplacements(imagea, imageb, wsize, xgrid, ygrid);
end