% Sim Methods Project: Grayscale Image Blurring 
% Team 6: Benjamins Avants, Brennon Broussard, Bailey Smoorenburg, Cameron
% Cage, Donovan Gegg 
% 4/22/2021 
% Function called by script to blur selected photo

function [] = Image_Blurring(option)

Image = imread(option);

[rows, columns, channels] = size(Image);  

subplot(3, 2, 1); 
imshow(Image, []);
axis on;
title('Original Grayscale', 'FontSize', 12);
n=1;
blur=13;
blur_count= 5;

for a=1:1:blur_count
    if channels>1
       fprintf('ERROR: Image has %i channels, NOT GRAYSCALE IMAGE; will not render properly', channels)
       break
    end

    filteredImage = Image;
    Correction = floor(blur / 2);

    for j = Correction + 1 : columns - Correction 
        for i = Correction + 1 : rows - Correction
            pixelSum = 0; 
            for c = 1 : blur
                ic = j + c - Correction - 1;
                for r = 1 : blur
                    ir = i + r - Correction - 1;
                    pixelSum = pixelSum + double(Image(ir, ic))/blur^2;
                end
            end
            filteredImage(i, j) = pixelSum;
        end
    end

    n=n+1;

    subplot(3, 2, n);
    imshow(filteredImage, []);
    caption = sprintf('Image width filter of %d', blur);
    title(caption, 'FontSize', 12);
    axis on;

    blur=blur+10;

end
disp('SUCCESS. CHECK OUTPUT IMAGE.');
end