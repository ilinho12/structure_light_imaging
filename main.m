clear; close all;

%% Adding all subfolder to the path
addpath(genpath(pwd));
Path = pwd;

%% Generate theoretical images
[ img_s,  phase_grating, phase_add_i ] = makeImage;

%% FFT the input image
img1 = image_fft2( [Path '\Image\InputImage.bmp'] );

%% Filter out the highest peak of input image
[ a1, b1, x1, y1 ] = find_range( img1 );
img2 = cut_ellipse_hft( a1, b1, x1 ,y1, img1);

figure;
surf( abs( img2 ) ); shading interp;
title('3D img after High-pass filter ');

%% Filter out the objective peak of input image
[ a2, b2, x2, y2 ] = find_range( img2 );
img3 = cut_ellipse_lft( a2, b2, x2 ,y2, img2);

figure;
surf( abs( img3 ) ); shading interp;
title('3D img after Low-pass filter ');

%% IFFT the output image
img_out = image_ifft2( img3 );

%% Unwrapped the phase of image
phase_unwrapped = QualityGuidedUnwrap2D( img_out );

%%
phase_out = phase_unwrapped - phase_grating;

save([ Path '\Mat\Im.mat']);

%{
figure;
image(phase_out, 'CDataMapping', 'scaled'); caxis([0 1]) 
colormap(jet); title('Output-phace'); colorbar;
%}