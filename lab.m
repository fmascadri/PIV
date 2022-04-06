%MCEN90018 - Advanced Fluid Dynamics - PIV Lab
% This script answers the assigned questions in the PIV lab sheet. The
% script expects the lab data to be placed in the 'data/out' folder and calls
% functions/classes from the +piv package. This structure was chosen to
% facilitate easier PIV code reuse in future (e.g. in Assignment 1 and PIV 
% lab part 7).

% Author: Francesco Mascadri
% Contact: fmascadri@student.unimelb.edu.au
% April 2022

%% Clear workspace
clear all;
clc;
close all;

%% Flags for generating plots
PLOTTING_ALL = false; % set to true to generate all plots for report and 
                     % override below individual flags

PLOTTING_Q0 = false;
PLOTTING_Q1 = false;
PLOTTING_Q2 = false;
PLOTTING_Q3 = false;
PLOTTING_Q4 = true;
PLOTTING_Q5 = true;
PLOTTING_Q6 = false;

if PLOTTING_ALL == true
    PLOTTING_Q0 = true;
    PLOTTING_Q1 = true;
    PLOTTING_Q2 = true;
    PLOTTING_Q3 = true;
    PLOTTING_Q4 = true;
    PLOTTING_Q5 = true;
    PLOTTING_Q6 = true;
end

%% Setup logging
%%Setup logger to see info in text log and in command window
logsdirectory = [pwd '/PIV/logs/'];
loggerfile = ['PIV_', num2str(year(datetime)), '-', num2str(month(datetime)), '.log'];
loggerpath = [logsdirectory loggerfile];
logger = fx.log4m.getLogger(loggerpath);
logger.setLogLevel(logger.WARN);
logger.setCommandWindowLevel(logger.DEBUG);

%% Tell script where to find processed images
%Remember to run frame_grab.m to convert video to images first
imagedirectory = './PIV/data/out/';

%% Define inputs for Q1-5
imagea = imread([imagedirectory 'aoa0_0020.tiff']);
imageb = imread([imagedirectory 'aoa0_0021.tiff']);
imagea = flipud(imagea');
imageb = flipud(imageb');

% Plots for report - Q0 - images
if PLOTTING_Q0 == true
    figure(1)
    subplot(1,2,1)
    imshow(imagea);
    title({'Image A','(time t)'});
    xlabel('x');
    ylabel('y');
    
    subplot(1,2,2)
    imshow(imageb);
    title({'Image B', '(time t+1)'});
    xlabel('x');
    ylabel('y');
end

%% Question 1
% Answers Q1 of the lab handout

%Interrogation window inputs
width = 64;
height = 64;
wsize = [width, height];
[xgrid, ygrid] = meshgrid(100:32:964,100:32:1796);

%Instantiates a DisplacementGrid object
Q1 = piv.DisplacementGrid();

%Cross-correlation to determine displacements
[Q1.dpx, Q1.dpy] = Q1_PIVlab(imagea, imageb,wsize, xgrid, ygrid);

%Remove spurious vectors
Q1.removeSpuriousVectors();

%Log
logger.info('Q1','Completed Q1 processing.')

%Plotting Q1
if PLOTTING_Q1 == true
    figure(3)
    Q1.plotField(xgrid,ygrid,{'Displacement field', '(window size=[64px,64px])'},[100 964 0 1968]);
    figure(4)
    subplot(1,2,1)
    Q1.plotXContour(xgrid,ygrid,{'x-displacement contour plot', '(window size=[64px,64px])'},[100 964 0 1968]);
    caxis([9,13])
    h1 = get(gca, 'ColorBar');
    h1.Label.String = 'Displacement (pixels)';
    subplot(1,2,2)
    Q1.plotYContour(xgrid,ygrid,{'y-displacement contour plot', '(window size=[64px,64px])'},[100 964 0 1968]);
    caxis([0,0.02])
    h2 = get(gca, 'ColorBar');
    h2.Label.String = 'Displacement (pixels)';
end

%% Question 2
% Answers Q2 of the lab handout

%Interrogation window inputs
width = 64;
height = 64;
wsize = [width, height];
[xgrid, ygrid] = meshgrid(100:32:964,100:32:1796);

%Instantiates a DisplacementGrid object
Q2 = piv.DisplacementGrid();

%Cross-correlation to determine displacements
[Q2.dpx, Q2.dpy] = Q2_PIVlab(imagea, imageb, wsize, xgrid, ygrid);

%Remove spurious vectors
Q2.removeSpuriousVectors();

%Log
logger.info('Q2','Completed Q2 processing.')

%Plotting Q2
if PLOTTING_Q2 == true
    figure(6)
    Q2.plotField(xgrid,ygrid,{'Displacement field', '(sub-pixel fit, window size=[64px,64px])'},[100 964 0 1968]);
    figure(7)
    subplot(1,2,1)
    Q2.plotXContour(xgrid,ygrid,{'x-displacement contour plot', '(sub-pixel fit, window size=[64px,64px])'},[100 964 0 1968]);
    h1 = get(gca, 'ColorBar');
    h1.Label.String = 'Displacement (pixels)';
    subplot(1,2,2)
    Q2.plotYContour(xgrid,ygrid,{'y-displacement contour plot', '(sub-pixel fit, window size=[64px,64px])'},[100 964 0 1968]);
    h2 = get(gca, 'ColorBar');
    h2.Label.String = 'Displacement (pixels)';
end
%% Question 3
% Answers Q3 of the lab handout
% Interrogation window inputs
width = 32;
height = 32;
wsize = [width, height];
[xgrid, ygrid] = meshgrid(100:16:980,100:16:1812);

%Instantiates a DisplacementGrid object
Q1_32px = piv.DisplacementGrid();
Q2_32px = piv.DisplacementGrid();

%Cross-correlation to determine displacements
[Q1_32px.dpx, Q1_32px.dpy] = Q1_PIVlab(imagea, imageb, wsize, xgrid, ygrid);
[Q2_32px.dpx, Q2_32px.dpy] = Q2_PIVlab(imagea, imageb, wsize, xgrid, ygrid);

%Remove spurious vectors
Q1_32px.removeSpuriousVectors();
Q2_32px.removeSpuriousVectors();

%Log
logger.info('Q3','Completed Q3 processing.')

%Plotting Q3
if PLOTTING_Q3 == true
    figure(9)
    Q1_32px.plotField(xgrid,ygrid,{'Displacement field', '(window size=[32px,32px])'},[100 964 0 1968]);

    figure(10)
    subplot(1,2,1)
    Q1_32px.plotXContour(xgrid,ygrid,{'x-displacement contour plot', '(window size=[32px,32px])'},[100 964 0 1968]);
    h1 = get(gca, 'ColorBar');
    h1.Label.String = 'Displacement (pixels)';
    caxis([9 13])
    subplot(1,2,2)
    Q1_32px.plotYContour(xgrid,ygrid,{'y-displacement contour plot', '(window size=[32px,32px])'},[100 964 0 1968]);
    h2 = get(gca, 'ColorBar');
    h2.Label.String = 'Displacement (pixels)';
    caxis([-0.1 0.7])

    figure(12)
    Q2_32px.plotField(xgrid,ygrid,{'Displacement field', '(subpixel fitting, window size=[32px,32px])'},[100 964 0 1968]);
    
    figure(13)
    subplot(1,2,1)
    Q2_32px.plotXContour(xgrid,ygrid,{'x-displacement contour plot', '(subpixel fitting, window size=[32px,32px])'},[100 964 0 1968]);
    h1 = get(gca, 'ColorBar');
    h1.Label.String = 'Displacement (pixels)';
    caxis([9 13])
    subplot(1,2,2)
    Q2_32px.plotYContour(xgrid,ygrid,{'y-displacement contour plot', '(subpixel fitting, window size=[32px,32px])'},[100 964 0 1968]);
    h2 = get(gca, 'ColorBar');
    h2.Label.String = 'Displacement (pixels)';
    caxis([-0.1 0.7])
end
%% Question 4
% Answers Q4 of the lab handout

%Interrogation window inputs
width = 64;
height = 64;
wsize = [width, height];
[xgrid, ygrid] = meshgrid(100:32:964,100:32:1796);

%Estimated displacement grid
est = piv.DisplacementGrid;
[est.dpx, est.dpy] = Q2_PIVlab(imagea,imageb,wsize,xgrid,ygrid);

%Intermediate processing of dpx and dpy estimates
est.dpx = round(est.dpx);
est.dpy = round(est.dpy);

est.dpx = repelem(est.dpx, 2, 2); %scale dpx by factor 2 (64px/32px = 2)
est.dpy = repelem(est.dpy, 2, 2); %scale dpy by factor 2 (64px/32px = 2)

%Interrogation window inputs
width = 32;
height = 32;
wsize = [width, height];
[xgrid, ygrid] = meshgrid(100:16:980,100:16:1812);

%Final displacementgrid
secondpass = piv.DisplacementGrid;
[secondpass.dpx, secondpass.dpy] = Q5_PIVlab(imagea,imageb,wsize,xgrid,ygrid,est.dpx,est.dpy);

Q4 = piv.DisplacementGrid;
Q4.dpx = est.dpx + secondpass.dpx;
Q4.dpy = est.dpy + secondpass.dpy;

%Remove spurious vectors
Q4.removeSpuriousVectors();

%Log
logger.info('Q4','Completed Q4 processing.')

%Plotting Q4
if PLOTTING_Q4 == true
    figure(15)
    Q4.plotField(xgrid, ygrid, {'Displacement field', '(multigrid)'},[100 964 0 1968])
    figure(16)
    subplot(1,2,1)
    Q4.plotXContour(xgrid, ygrid, {'x-displacement contour plot', '(multigrid)'},[100 964 0 1968])
    h1 = get(gca, 'ColorBar');
    h1.Label.String = 'Displacement (pixels)';
    caxis([9 13])
    subplot(1,2,2)
    Q4.plotYContour(xgrid,ygrid, {'y-displacement contour plot', '(multigrid)'},[100 964 0 1968])
    h2 = get(gca, 'ColorBar');
    h2.Label.String = 'Displacement (pixels)';
    caxis([-0.1 0.7])
end


%% Question 5
% Answers Q5 of the lab handout

% Calibration
calibration_image = imread([imagedirectory 'RULER_0001.tiff']);
calibration_image = flipud(calibration_image');
image(calibration_image);
[x,y] = ginput(2);

pixels_per_cm = sqrt((x(2)-x(1))^2 + (y(2)-y(1))^2);
fps = 50; % frames per second of video
SI_m_per_s_conversion_factor = fps * (0.01/pixels_per_cm);

% Unit conversion to SI
Q4.dpx = Q4.dpx.*SI_m_per_s_conversion_factor;
Q4.dpy = Q4.dpy.*SI_m_per_s_conversion_factor;
xgrid_m = 0.01*xgrid./(pixels_per_cm);
ygrid_m = 0.01*ygrid./(pixels_per_cm);

%Log
logger.info('Q5','Completed Q5 processing.')

%Plotting Q5
if PLOTTING_Q5 == true
    figure(18)
    Q4.plotField(xgrid_m,ygrid_m,'Velocity field [m/s]', [0 0.045, 0, 0.075])
    xlabel('x-direction [m]')
    ylabel('y-direction [m]')

    figure(19)
    subplot(1,2,1)
    Q4.plotXContour(xgrid_m, ygrid_m, 'x-velocity contour plot [m/s]', [0 0.045, 0, 0.075])
    xlabel('x-direction [m]')
    ylabel('y-direction [m]')
    h1 = get(gca, 'ColorBar');
    h1.Label.String = 'Velocity [m/s]';
    caxis([0.02,0.028])

    subplot(1,2,2)
    Q4.plotYContour(xgrid_m, ygrid_m, 'y-velocity contour plot [m/s]', [0 0.045, 0, 0.075])
    xlabel('x-direction [m]')
    ylabel('y-direction [m]')
    h2 = get(gca, 'ColorBar');
    h2.Label.String = 'Velocity [m/s]';
end

%% Question 6
% Answers Q6 of the lab handout
iterations = 100; % set to 100 for final answer

% ======================== Case = AOA0 ==========================
% Intialise displacement grids
dpx_aoa0_all = zeros(size(100:16:1812, 2), size(100:16:980, 2), iterations);
dpy_aoa0_all = zeros(size(100:16:1812, 2), size(100:16:980, 2), iterations);

% Read images
filename = "aoa0";
for i = 1:iterations
    imagea = imread(filename + "_" + pad(string(i),4,'left','0') + ".tiff");
    imageb = imread(filename + "_" + pad(string(i+1),4,'left','0') + ".tiff");

    imagea = flipud(imagea');
    imageb = flipud(imageb');
    
    % First pass of multigrid approach with [64px, 64px] window
    width = 64;
    height = 64;
    wsize = [width,height];
    [xgrid,ygrid] = meshgrid(100:32:964,100:32:1796);

    %Estimated displacement grid
    est = piv.DisplacementGrid;
    [est.dpx, est.dpy] = Q2_PIVlab(imagea,imageb,wsize,xgrid,ygrid);
    
    %Intermediate processing of dpx and dpy estimates
    est.dpx = round(est.dpx);
    est.dpy = round(est.dpy);
    
    est.dpx = repelem(est.dpx, 2, 2); %scale dpx by factor 2 (64px/32px = 2)
    est.dpy = repelem(est.dpy, 2, 2); %scale dpy by factor 2 (64px/32px = 2)

    %Interrogation window inputs
    width = 32;
    height = 32;
    wsize = [width, height];
    [xgrid, ygrid] = meshgrid(100:16:980,100:16:1812);
    
    %Final displacementgrid
    secondpass = piv.DisplacementGrid;
    [secondpass.dpx, secondpass.dpy] = Q5_PIVlab(imagea,imageb,wsize,xgrid,ygrid,est.dpx,est.dpy);
    
    final = piv.DisplacementGrid;
    final.dpx = est.dpx + secondpass.dpx;
    final.dpy = est.dpy + secondpass.dpy;
    
    %Remove spurious vectors
    final.removeSpuriousVectors();
    
    %Conversion to SI units
    final.dpx = final.dpx.*SI_m_per_s_conversion_factor;
    final.dpy = final.dpy.*SI_m_per_s_conversion_factor;
    xgrid_m = 0.01*xgrid./(pixels_per_cm);
    ygrid_m = 0.01*ygrid./(pixels_per_cm);

    %Add to result array
    dpx_aoa0_all(:,:,i) = final.dpx;
    dpy_aoa0_all(:,:,i) = final.dpy;

    %Logging
    logger = fx.log4m.getLogger();
    logger.debug('Q6',['Processed image number ' num2str(i) '.']);
end

%Log
logger.info('Q6','Completed AoA 0 processing.')

% ======================== Case = AOA20 ==========================
% Intialise displacement grids
dpx_aoa20_all = zeros(size(100:16:1812, 2), size(100:16:980, 2), iterations);
dpy_aoa20_all = zeros(size(100:16:1812, 2), size(100:16:980, 2), iterations);

% Read images
filename = "aoa20";
for i = 1:iterations
    imagea = imread(filename + "_" + pad(string(i),4,'left','0') + ".tiff");
    imageb = imread(filename + "_" + pad(string(i+1),4,'left','0') + ".tiff");

    imagea = flipud(imagea');
    imageb = flipud(imageb');
    
    % First pass of multigrid approach with [64px, 64px] window
    width = 64;
    height = 64;
    wsize = [width,height];
    [xgrid,ygrid] = meshgrid(100:32:964,100:32:1796);

    %Estimated displacement grid
    est = piv.DisplacementGrid;
    [est.dpx, est.dpy] = Q2_PIVlab(imagea,imageb,wsize,xgrid,ygrid);
    
    %Intermediate processing of dpx and dpy estimates
    est.dpx = round(est.dpx);
    est.dpy = round(est.dpy);
    
    est.dpx = repelem(est.dpx, 2, 2); %scale dpx by factor 2 (64px/32px = 2)
    est.dpy = repelem(est.dpy, 2, 2); %scale dpy by factor 2 (64px/32px = 2)

    %Interrogation window inputs
    width = 32;
    height = 32;
    wsize = [width, height];
    [xgrid, ygrid] = meshgrid(100:16:980,100:16:1812);
    
    %Final displacementgrid
    secondpass = piv.DisplacementGrid;
    [secondpass.dpx, secondpass.dpy] = Q5_PIVlab(imagea,imageb,wsize,xgrid,ygrid,est.dpx,est.dpy);
    
    final = piv.DisplacementGrid;
    final.dpx = est.dpx + secondpass.dpx;
    final.dpy = est.dpy + secondpass.dpy;
    
    %Remove spurious vectors
    final.removeSpuriousVectors();
    
    %Conversion to SI units
    final.dpx = final.dpx.*SI_m_per_s_conversion_factor;
    final.dpy = final.dpy.*SI_m_per_s_conversion_factor;
    xgrid_m = 0.01*xgrid./(pixels_per_cm);
    ygrid_m = 0.01*ygrid./(pixels_per_cm);

    %Add to result array
    dpx_aoa20_all(:,:,i) = final.dpx;
    dpy_aoa20_all(:,:,i) = final.dpy;

    %Logging
    logger = fx.log4m.getLogger();
    logger.debug('Q6',['Processed image number ' num2str(i) '.']);
end

%Log
logger.info('Q6','Completed AoA 20 processing.')

% Averages
aoa0mean = piv.DisplacementGrid();
aoa0mean.dpx = mean(dpx_aoa0_all,3);
aoa0mean.dpy = mean(dpy_aoa0_all,3);

aoa20mean = piv.DisplacementGrid();
aoa20mean.dpx = mean(dpx_aoa20_all,3);
aoa20mean.dpy = mean(dpy_aoa20_all,3);

%% Plotting Q6
if PLOTTING_Q6 == true
    figure(21)
    aoa0mean.plotField(xgrid_m,ygrid_m,'Velocity field [m/s]',[0, 0.045, 0, 0.075])
    xlabel('x-direction [m]')
    ylabel('y-direction [m]')
    figure(22)
    aoa20mean.plotField(xgrid_m,ygrid_m,'Velocity field [m/s]',[0,0.045,0,0.075])
    xlabel('x-direction [m]')
    ylabel('y-direction [m]')

    figure(23)
    subplot(1,2,1)
    aoa0mean.plotXContour(xgrid_m,ygrid_m,'x-velocity contour plot [m/s]',[0, 0.045, 0, 0.075])
    xlabel('x-direction [m]')
    ylabel('y-direction [m]')
    h1 = get(gca, 'ColorBar');
    h1.Label.String = 'Velocity [m/s]';
    subplot(1,2,2)
    aoa0mean.plotYContour(xgrid_m,ygrid_m,'y-velocity contour plot [m/s]',[0, 0.045, 0, 0.075])
    xlabel('x-direction [m]')
    ylabel('y-direction [m]')
    h1 = get(gca, 'ColorBar');
    h1.Label.String = 'Velocity [m/s]';

    figure(24)
    subplot(1,2,1)
    aoa20mean.plotXContour(xgrid_m,ygrid_m,'x-velocity contour plot [m/s]',[0, 0.045, 0, 0.075])
    xlabel('x-direction [m]')
    ylabel('y-direction [m]')
    h1 = get(gca, 'ColorBar');
    h1.Label.String = 'Velocity [m/s]';
    subplot(1,2,2)
    aoa20mean.plotYContour(xgrid_m,ygrid_m,'y-velocity contour plot [m/s]',[0, 0.045, 0, 0.075])
    xlabel('x-direction [m]')
    ylabel('y-direction [m]')
    h1 = get(gca, 'ColorBar');
    h1.Label.String = 'Velocity [m/s]';
end








