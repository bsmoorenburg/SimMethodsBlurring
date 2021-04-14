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
blur=5;
blur_count= 5;
max_iter=10000;
% Max iterations necessary to automatically stop process in the event that
% the user does not manually stop it after seeing the ERROR message. 

for a=1:1:blur_count
    
%=================================================================================================
% Setting up/ initializing a filter kernel, a matrix with dimensions based on blur value 
% that takes the average of everything inside. Multiplying by this average later "blurs" the image. 
kernel = ones(blur) / blur ^ 2;

%=================================================================================================
% Initializing Template   
filteredImage = zeros(size(Image));
% Size(Image) was used earlier to determing if the image was grayscale. Now
% it's being used to initialize a template of the blurred image, overlaying
% on the original image with values being overwritten by a later loop. 

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
		% The Template/ blurred location in question is located at INPUT IMAGE (row, col).
		% We'll be scanning the INPUT IMAGE, multiplying the indexed values
		% by the kernel, before summing the matrix (with dimensions based on blur, just like the Kernel value) 
        % together 
        
        % Initializing the sum for the Template/blurred location.
		pixelSum = 0; 
		for c = 1 : blur
			% Get the column index of the original image underneath the corresponding pixel in the filter window
			ic = j + c - Correction - 1;
			for r = 1 : blur
				% Get the row index of the original image underneath the corresponding pixel in the filter window
				ir = i + r - Correction - 1;
				% Sum up the product into our running total for this window location.
				pixelSum = pixelSum + double(Image(ir, ic)) * kernel(r, c);
			end
		end
		% Now we have the filtered value.  Assign it to our output image.
		filteredImage(i, j) = pixelSum;
	end
end

n=n+1;

subplot(3, 2, n);
imshow(filteredImage, []);
caption = sprintf('Image width filter of %d', blur);
title(caption, 'FontSize', 12);
axis on;

blur=blur+4;

end

end


