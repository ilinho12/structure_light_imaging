%% This function is used to find the frequency of the grating
function fs = FindFrequency( img )
[ row, columns ] = sizes( img );
NFFT_row = 2^nextpow2( row );
NFFT_columns = 2^nextpow2( columns );
img_fft1 = abs( fft2(img,[ NFFT_row,NFFT_columns ]) )/( row*columns );
img_fft2 = img_fft1( 1:row/2+1, 1:columns+1 );
N = numel( img_fft2 );
[ ~, index ] = sort( img_fft2(:) );
n = floor( 0.05*N );
img_fft2( 1:n ) = -1;
f_row = Fs*( 0:( row/2 ) )/row;
f_columns = Fs*( 0:( columns/2 ) )/columns;
[ ind_row, ind_colums ] = find( img_fft2(:) == -1 );
fs_row = mean( f_row( ind_row ) );
fs_coluns = mean( f_columns( ind_colums ) );
fs = sqrt( fs_coluns+fs_row );
end