close all;
clear all;
clc;

% cd 'C:\Users\mogengl\Pictures\digiCamControl\Session1\'

filepathin = './PIV/data/in/';
filepathout = './PIV/data/out/';
videoname = 'aoa_20_1_200_shutter_speed(Friday).mov';
xyloObj = VideoReader([filepathin videoname]);
filename = 'aoa20';
imnum = [1,101];

nFrames = xyloObj.NumberOfFrames;
vidHeight = xyloObj.Height;
vidWidth = xyloObj.Width;

% Preallocate movie structure.
mov(1:nFrames) = ...
    struct('cdata', zeros(vidHeight, vidWidth, 3, 'uint8'),...
           'colormap', []);

% Read one frame at a time.
for k = imnum
    mov(k).cdata = read(xyloObj, k);
    imwrite(rgb2gray(mov(k).cdata),[filepathout, filename,'_',num2str(k,'%04.0f'),'.tiff']);
end

% Size a figure based on the video's width and height.
% hf = figure;
% set(hf, 'position', [150 150 vidWidth vidHeight])

% imwrite(rgb2gray(mov(1).cdata),'ipad movie clean tunnel\a=0\1.tiff');
% imwrite(rgb2gray(mov(2).cdata),'ipad movie clean tunnel\a=0\2.tiff');

% Play back the movie once at the video's frame rate.
% movie(hf, mov, 1, xyloObj.FrameRate);