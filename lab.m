%MCEN90018 - Advanced Fluid Dynamics - PIV Lab
% This script answers the assigned questions in the PIV lab sheet. The
% script expects the lab data to be placed in the 'data' folder and calls
% functions/classes from the +piv package. This structure was chosen to
% facilitate PIV code reuse in future.

% Author: Francesco Mascadri
% Contact: fmascadri@student.unimelb.edu.au
% March 2022

%% Setup logging
%%Setup logger to see DEBUG info in logs and ALL in command window
logsdirectory = [pwd '/PIV/logs/'];
loggerfile = ['PIV_', num2str(year(datetime)), '-', num2str(month(datetime)), '.log'];
loggerpath = [logsdirectory loggerfile];
logger = fx.log4m.getLogger(loggerpath);
logger.setLogLevel(logger.DEBUG);
logger.setCommandWindowLevel(logger.ALL);

%% Tell script where to find images

%% Define inputs for Q1-5
%Dummy inputs
imagea = 0;
imageb = 0;
wsize = [1,2];
xgrid = 0;
ygrid = 0;

%% Question 1
% Answers Q1 of the lab handout

%Instantiates a DisplacementGrid object
Q1 = piv.DisplacementGrid;

[Q1.dpx, Q1.dpy] = Q1_PIVlab(imagea, imageb, wsize, xgrid, ygrid);

%% Question 2
% Answers Q2 of the lab handout

%Instantiates a DisplacementGrid object
Q2 = piv.DisplacementGrid;

[Q2.dpx, Q2.dpy] = Q2_PIVlab(imagea, imageb, wsize, xgrid, ygrid);

%% Question 3
% Answers Q3 of the lab handout

%plotting code for Q1
figure(1)
Q1.plot();
%plotting code for Q2
figure(2)
Q2.plot();

%% Question 4
% Answers Q4 of the lab handout

%Estimated displacement grid
est = piv.DisplacementGrid;
[est.dpx, est.dpy] = Q2_PIVlab(imagea,imageb,wsize,xgrid,ygrid);

%Final displacementgrid
Q5 = piv.DisplacementGrid;
[Q5.dpx, Q5.dpy] = Q5_PIVlab(imagea,imageb,wsize,xgrid,ygrid,est.dpx,est.dpy);

%plotting code for Q4
figure(3)
Q5.plot();

%% Question 5
% Answers Q5 of the lab handout

% DO CALIBRATION

%plotting code for Q5

%% Question 6
% Answers Q6 of the lab handout







