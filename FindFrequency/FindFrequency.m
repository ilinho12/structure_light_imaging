%% This function is used to find the frequency of the grating
function fs = FindFrequency( img )
img_fft = abs( fftshift( fft2( img ) ) );
N = numel( img_fft );
sort()