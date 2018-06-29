%% This function is used to find the frequency of the grating
function fs = FindFrequency( Name_img, Fs_row, Fs_columns)
if nargin == 1 
    Fs_row = 1;
    Fs_columns = 1;
elseif nargin == 3;
else
    fprintf("The number of parameters is wrong!");
    return;
end

if ischar( Name_img )
    img = doubole( imread( Name_img ) );
else img = Name_img;
end

[ row, columns ] = size( img );
NFFT_row = 2^nextpow2( row );
NFFT_columns = 2^nextpow2( columns );
img_fft1 = abs( fft2(img, NFFT_row, NFFT_columns ) )/( row*columns );
img_fft2 = img_fft1( 1:row/2+1, 1:columns/2+1 );
N = numel( img_fft2 );
[ ~, index ] = sort( img_fft2(:) );
n = floor( 0.01*N );
img_fft2( 1:n ) = -1;
f_row = Fs_row*( 0:( row/2 ) )/row;
f_columns = Fs_columns*( 0:( columns/2 ) )/columns;
[ ind_row, ind_colums ] = find( img_fft2(:) == -1 );
filter = zeros( size( img_fft2 ) );
filter( ind_row, ind_colums ) = 1;

fs_row = filter;
fs_coluns = mean( f_columns( ind_colums ) );
fs = sqrt( fs_coluns+fs_row );
end