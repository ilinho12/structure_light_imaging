%% This function is used to find the frequency of the grating
function fs = FindFrequency( img )
[ row, columns ] = sizes( img );
NFFT_row = 2^nextpow2( row );
NFFT_columns = 2^nextpow2( columns );
img_fft = abs( fftshift( fft2(img,[ NFFT_row,NFFT_columns ]) ) );
N = numel( img_fft );
[ ~, index ] = sort( img_fft(:) );
n = floor( 0.05*N );
img_fft(index)