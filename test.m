% This function is a test script in the programming of author;

img = E_image;
%% Initialization
close all;
imgS = 0; gratingS = 0;

%% Adding all subfolder to the path
addpath(genpath(pwd));
Path = pwd;

%% Reading image
if ischar(img)
    path_img = img;
    imgS = read(path_img);
else
    imgS = img;
end

if ~imgS 
    disp('the img is fault!');
    return
end

if ischar(grating)
    path_grating = grating;
    gratingS = read(grating);
else
    gratingS = grating;
end

if ~gratingS 
    disp('the grating is fault!');
    return
end

%% FFT the input image
img1 = image_fft2(imgS);
grating1 = image_fft2(gratingS);

figure;
surf(abs(img1)); shading interp;
title('Input 3D Image  of FFT');

%% Filter out the highest peak of input image
[a1, b1, x1, y1] = find_range(img1);
[~, J1] = image_snake(a1, b1, x1, y1, img1);
figure; 
imshow(J1);
img2 = cut_hft(a1, b1, x1 ,y1, img1.*J1, 6);

figure;
surf( abs( img2 ) ); shading interp;
title('3D Image after High-pass filter');

%% Filter out the objective peak of input image
[a2, b2, x2, y2] = find_range(img2);
[~, J2] = image_snake(a2, b2, x2, y2, img2);
img3 = cut_lft(a2, b2, x2 ,y2, img2.*J2, 6);

figure;
surf(abs(img3)); shading interp;
title('3D img after Low-pass filter ');

%% IFFT the output image
img_out = image_ifft2( img3 );

%% Unwrapped the phase of image
phase_unwrapped = QualityGuidedUnwrap2D(img_out);

figure;
surf(phase_unwrapped); shading interp;
title('Unwarped Image');

%% Calculate the phase image
%phase_out = phase_unwrapped - phase_grating;

%{
figure;
image(phase_out, 'CDataMapping', 'scaled'); caxis([0 1]) 
colormap(jet); title('Output-phace'); colorbar;
%}