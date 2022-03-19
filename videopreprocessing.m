%MCEN90018 - Advanced Fluid Dynamics - PIV Lab
% This script preprocesses the PIV video into individual frames

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

%% Initial data processing
% Converts .mov video file into individual frames

% DO STUFF








