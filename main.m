clear; close all;

%%
[ img_s,  phase_grating, phase_add_i ] = makeImage;

%%
img1 = image_fft2( 'test2.bmp' );
[ a1, b1, x1, y1 ] = find_range( img1 );
img2 = cut_ellipse_hft( a1, b1, x1 ,y1, img1);

figure;
surf( abs( img2 ) ); shading interp;
title('3D img after High-pass filter ');

%%
[ a2, b2, x2, y2 ] = find_range( img2 );
img3 = cut_ellipse_lft( a2, b2, x2 ,y2, img2);

%img3 = zeros( size( img2 ) ); img3( :, x1 : end ) = img2( :, x1 : end );

figure;
surf( abs( img3 ) ); shading interp;
title('3D img after Low-pass filter ');

%%
agl_ifft = image_ifft2( img3 );
phase_out = agl_ifft/2/pi+0.5;
phase_add_o = abs( phase_out - phase_grating ) ;

figure;
image(phase_out, 'CDataMapping', 'scaled'); caxis([0 1]) 
colormap(jet); title('Output-phace'); colorbar;

%{
figure;
image(phase_add_o, 'CDataMapping', 'scaled'); caxis([0 1]) 
colormap(jet); title('Output-phace-add'); colorbar;
%}