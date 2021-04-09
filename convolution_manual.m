% Set up / initialization
clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear;  % Erase all existing variables. Or clearvars if you want.
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 15;

% Initialize blur_count
blur_count= 5;
b=4;

Image = imread('View.jpg');
% Get the dimensions of the image.
% numberOfColorBands should be = 1 for a gray scale image, and 3 for an RGB color image.
[rows, columns] = size(Image)


% Display the image.
subplot(b, 2, 1);
imshow(Image, []);
axis on;
title('Original Grayscale Image', 'FontSize', 12);

% Initialize Blur/ Window Size 
windowSize=5;

% Initialize Counter 
n=1;

for i=1:1:blur_count;
    
%=================================================================================================
% Set up a filter kernel, a 7 by 7 window that takes the average of everything in the window.
halfWindowSize = floor(windowSize / 2);
kernel = ones(windowSize) / windowSize ^ 2;
% If it's a convolution, flip the kernel
% (Won't make a difference for a symmetric or uniform kernel though.)
kernel = flipud(fliplr(kernel));

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
		for c = 1 : windowSize
			% Get the column index of the original image underneath the corresponding pixel in the filter window
			ic = col + c - halfWindowSize - 1;
			for r = 1 : windowSize
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
caption = sprintf('Image width filter of %d', windowSize);
title(caption, 'FontSize', 12);
axis on;

windowSize=windowSize+4;

end



