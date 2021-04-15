% Set up / initialization
clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g; % Make format Long 
format compact; % Delete empty space between outputs 
fontSize = 15; 

Image = imread('View.jpg');
% Get the dimensions of the image.

% Size Image 
[rows, columns, channels] = size(Image); 
% Channels = layers of matrices; blue, yellow, and red color channels. 
     
    
% GRAYSCALE. Display the INPUT image.
subplot(3, 2, 1); 
% Subplot. Create 3 by 2 Matrix of Slots for images. Images must fall
% within boundaries or they will not display. 
imshow(Image, []);
% This format displays a grayscale image, and scales "PIXEL' Values
% accordingly, with minimum (0)=black and maximum (255)=white. 
axis on;
title('Original Grayscale', 'FontSize', 12);

% Initializing Counter_1
n=1;
% Counter_1 is necessary for indexing the image in subplot grid 

% Initializing blur/ blur_count/ Max iterations 
blur=13;
blur_count= 5;
max_iter=10000;
% Max iterations necessary to automatically stop process in the event that
% the user does not manually stop it after seeing the ERROR message. 

for a=1:1:blur_count

if channels>1
   fprintf('ERROR: Image has %i channels, NOT GRAYSCALE IMAGE; will not render properly', channels)
   break
   % Display ERROR Notification and end program to conserve
   % computer resources. 
end
    

%=================================================================================================
% Initializing Template   
filteredImage = Image;

% Correcting Image, predicting which pixels will be inaccessible for the defined Kernel Matrix based off
% of the blur value 
Correction = floor(blur / 2);
% Floor command always rounds value down to the nearest whole number (necessary for image indexing)
% Since blur will always be an odd number for this code (to help prevent blurred kernels from overlapping),
% Correction will always be even.

%=================================================================================================
% Scanning the template over the image, pixel by pixel.
for j = Correction + 1 : columns - Correction
    % COLUMNS are from INPUT Image 
	for i = Correction + 1 : rows - Correction
        % ROWS are from INPUT Image 
		% The Template/ blurred location in question is located at INPUT IMAGE (i=ROW, j=COLUMN).
		% To BLUR the Image, we'll be scanning the INPUT IMAGE, summing the values in the matrix 
        %(with dimensions based on blur) before averaging them (blur^2).
        % This is similar to applying a kernel. 
        
        % Initializing the sum for the Template/blur matrix.
		pixelSum = 0; 
		for c = 1 : blur
			% Getting the column index of the original image underneath the
			% corresponding pixel in the template image 
			ic = j + c - Correction - 1;
			for r = 1 : blur
				% Getting the row index of the original image underneath the
				% corresponding pixel in the template image 
				ir = i + r - Correction - 1;
				% Summing the pixel values into a running total for the
				% matrix location before averaging 
				pixelSum = pixelSum + double(Image(ir, ic))/blur^2;
			end
		end
		% Assigning the averaged/blurred value to the output image.
		filteredImage(i, j) = pixelSum;
	end
end

n=n+1;
% Counter for subplot 

subplot(3, 2, n);
imshow(filteredImage, []);
caption = sprintf('Image width filter of %d', blur);
title(caption, 'FontSize', 12);
axis on;

blur=blur+2;

end


