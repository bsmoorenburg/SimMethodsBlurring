% Sim Methods Project: Grayscale Image Blurring 
% Team 6: Benjamins Avants, Brennon Broussard, Bailey Smoorenburg, Cameron
% Cage, Donovan Gegg 
% 4/22/2021 
% Function called by script to blur selected photo

function []=Blur_Image(option)

format compact % Delete empty space between outputs
close all;  % Closes all figures

Image = imread(option);
% Get the dimensions of the image.

% Size Image 
[rows, columns, channels] = size(Image); 
% Channels = layers of matrices; blue, yellow, and red color channels.
    
% Display the INPUT image. If NOT grayscale, the later FOR LOOP will BREAK.

subplot(3, 2, 1); 
% Subplot. Create 3 by 2 Matrix of Slots for images. Images must fall
% within boundaries or they will not display. 
imshow(Image, []);
% This format displays a grayscale image, and scales "PIXEL' Values
% accordingly, with minimum (0)=black and maximum (255)=white. 
axis on;
title('Original Grayscale', 'FontSize', 12);

% Index Counter
n=1;
% Counter_1 is necessary for indexing the image in subplot grid 

% Initializing  blur/ blur_count/ Max iterations 
blur=13;
blur_count= 5;

for a=1:1:blur_count

if channels>1
    fprintf('ERROR: Image has %i channels, NOT GRAYSCALE IMAGE; will not render properly', channels)
    % Display ERROR Notification to Alert user that program CANNOT run.
    break
end

%=================================================================================================
% Initializing Template   
filteredImage = Image;
% Overlaying the original image on itself with 2 layers with top Template layer values being overwritten by a later loop. 


Correction = floor(blur / 2);
% Correcting Image, predicting which pixels will be inaccessible for the defined Kernel Matrix based off
% of the blur value 

% Floor command always rounds value down to the nearest whole number (necessary for image indexing)
% Since blur will always be an odd number for this code (to help prevent blurred kernels from overlapping),
% Correction will always be even.

kernel = ones(blur) / blur ^ 2;
% Kernel is the actual filter. In this code, it will be averaging the
% values of the pixels

%=================================================================================================
% Scanning the template over the image, pixel by pixel.
for j = Correction + 1 : columns - Correction
    % COLUMNS are from INPUT Image 
	for i = Correction + 1 : rows - Correction
        % ROWS are from INPUT Image 
		% The Template/ blurred location in question is located at INPUT IMAGE (i=ROW, j=COLUMN).
		% To BLUR the Image, we'll be scanning the INPUT IMAGE, summing the values in the matrix 
        %(with dimensions based on blur) before multiplying them by the kernel
        
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
				pixelSum = pixelSum + double(Image(ir, ic))*kernel(r,c);
                % Multiplying by the "kernel" filter. Again, in this case, it's
                % averaging the values of the pixels in the submatrix.
			end
		end
		% Assigning the averaged/blurred value to the output image.
		filteredImage(i, j) = pixelSum;
	end
end

n=n+1;
% Counter for subplot 

subplot(3, 2, n);
% Plots on subplot grid, with position based on the counter.
imshow(filteredImage, []);
caption = sprintf('Image width filter of %d', blur);
title(caption, 'FontSize', 12);
axis on;

blur=blur+10;% Increasing the blur for each subsequent image

end
disp('SUCCESS. CHECK OUTPUT IMAGE.');
end
