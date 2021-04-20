% Sim Methods Project: Grayscale Image Blurring 
% Team 6: Benjamins Avants, Brennon Broussard, Bailey Smoorenburg, Cameron
% Cage, Donovan Gegg 
% 4/22/2021 
% Script to Give INPUT OPTIONS

clc;
clear;

Option_1= 'GSlsu.png'
Option_1_read = imread(Option_1);
[rows, columns, channels] = size(Option_1_read); 
subplot(1, 3, 1); 
imshow(Option_1_read, []);
title('Option 1', 'FontSize', 12);

%%%%%%%%%%%%%%%%%%%%%%%

Option_2= 'GSmike2.png'
Option_2_read = imread(Option_2);
[rows, columns, channels] = size(Option_2_read); 
subplot(1, 3, 2); 
imshow(Option_2_read, []);
title('Option 2', 'FontSize', 12);

%%%%%%%%%%%%%%%%%%%%%%%%

Option_3= 'GStigers.png'
Option_3_read = imread(Option_3);
[rows, columns, channels] = size(Option_3_read); 
subplot(1, 3, 3); 
imshow(Option_3_read, []);
title('Option 3', 'FontSize', 12);

%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('Which of the previous options would you like to Blur?  \n')

option=input('Which image will you select?')

Image_Blurring(option);
