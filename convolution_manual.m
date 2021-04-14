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
if channels>1
    Output = 'ERROR; NOT GRAYSCALE IMAGE; will not render properly'
    % Display ERROR Notification to Alert user to end program to conserve
    % computer resources. 
    
else 
    
% GRAYSCALE. Display the image.
subplot(3, 2, 1); 
% Subplot. Create 3 by 2 Matrix of Slots for images. Images must fall
% within boundaries or they will not display. 
imshow(Image, []);
% This format displays grayscale image, and scales "PIXEL' Values
% accordingly, with minimum (0)=black and maximum (255)=white. 
axis on;
title('Original Grayscale', 'FontSize', 12);

% Initialize blur/ blur_count/ Max iterations 
blur=5;
blur_count= 5;
max_iter=10000;
% Max iterations necessary to automatically stop process in the event that
% the user does not manually stop it after seeing the ERROR message. 

% Initialize Counter 
n=1;

for i=1:1:blur_count;
    
%=================================================================================================
% Set up a filter kernel, a 7 by 7 Matrix that takes the average of everything inside.
halfWindowSize = floor(blur / 2)
kernel = ones(blur) / blur ^ 2;

%=================================================================================================
% Scan the image pixel by pixel.  Go down rows first then columns because this will be the fastest direction.
filteredImage = zeros(size(Image)); % Initialize to same size as original.

%=================================================================================================
% HERE IS THE MAIN COMPUTATION ENGINE OF THE WHOLE PROCESS:
% Now scan the window over the image pixel by pixel.
for col = halfWindowSize + 1 : columns - halfWindowSize
	for row = halfWindowSize + 1 : rows - halfWindowSize
		% Now for a window with the center pixel situated at (row, col,
		% scan the filter window, multiplying its values by the values of the original image underneath it.
		localSum = 0; % Initialize sum to zero for this (row, column) location.
		for c = 1 : blur
			% Get the column index of the original image underneath the corresponding pixel in the filter window
			ic = col + c - halfWindowSize - 1;
			for r = 1 : blur
				% Get the row index of the original image underneath the corresponding pixel in the filter window
				ir = row + r - halfWindowSize - 1;
				% Sum up the product into our running total for this window location.
				localSum = localSum + double(Image(ir, ic)) * kernel(r, c);
			end
		end
		% Now we have the filtered value.  Assign it to our output image.
		filteredImage(row, col) = localSum;
	end
end

n=n+1;

subplot(b, 2, n);
imshow(filteredImage, []);
caption = sprintf('Image width filter of %d', blur);
title(caption, 'FontSize', 12);
axis on;

windowSize=windowSize+4;

end

end


