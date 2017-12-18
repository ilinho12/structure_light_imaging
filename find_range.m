% This function is used to find the range of the highest mountain in the image
% The input must be a Complex matrix
% The target mountain must be symmetrical with the X axis and Y axis
% The half width of target mountain is Trough_x and Trough_y
% The peak's position coordinates is row_max_image and column_max_image
function	[ Trough_x, Trough_y, row_max_image, column_max_image ] = find_range( Name_image )

image = abs( Name_image);

% find max of image
[ row_max_image, column_max_image ] = find( image == max( image(:) ) );
t_row_max_image = mean( row_max_image );
t_column_max_image = mean ( column_max_image );
row_max_image = mean( row_max_image( row_max_image(:) >= t_row_max_image ) );
column_max_image = mean ( column_max_image( column_max_image(:) >= t_column_max_image ) );
[ m_image, n_image ] = size( image );

% Gaussian convolution
operator_gaussian = 1/9*[ 0 1 0; 0 4 0; 0 1 0];
operator_gaussian = operator_gaussian ./ sum(operator_gaussian(:) );
image_new1 = zeros( m_image+2, n_image+2 );
image_new1( 2 : m_image+1, 2 : n_image+1) = image;
image_gaussian = zeros( m_image, n_image );
for ii = 1 : m_image
	for jj = 1 : n_image
        t = operator_gaussian .* image_new1( ii : ii+2, jj : jj+2 );
		image_gaussian ( ii, jj ) = sum( t(:) );
	end
end


% get the peaks and step a0, b0
[ pks_row, locs_pks_row ] = findpeaks( image_gaussian( row_max_image, column_max_image : end ) );
[ pks_column, locs_pks_column ] = findpeaks( image_gaussian( row_max_image : end, column_max_image) );
g_pksXlocs_row =  pks_row .* locs_pks_row;
g_pksXlocs_column =  pks_column .* locs_pks_column;
a0 = floor( locs_pks_row( g_pksXlocs_row(:) == max( g_pksXlocs_row ) )/4 );
b0 = floor( locs_pks_column( g_pksXlocs_column(:) == max( g_pksXlocs_column ) )/4 );

% find the width of the mountain
cut_x = image( row_max_image, column_max_image : end );
cut_y = image( row_max_image : end , column_max_image );
l_cut_x = size( cut_x, 2);
l_cut_y = size( cut_y, 1);

w_opt_h = floor( a0/2 );
operator_h = ones( 1, 2*w_opt_h+1 );
operator_h( w_opt_h+1 ) = w_opt_h+1;
operator_h = operator_h ./ sum( operator_h );
h_x_p = zeros( 1, l_cut_x + 2*w_opt_h );
h_x_p( w_opt_h+1 : end-w_opt_h ) = cut_x( 1: end );
h_x = zeros( 1, l_cut_x );
for ii = w_opt_h+1 : l_cut_x+w_opt_h
	h_x( ii-w_opt_h ) = sum( operator_h .* h_x_p( ii-w_opt_h : ii+w_opt_h) );
end

w_opt_h = floor( b0/2 );
operator_h = ones( 1, 2*w_opt_h+1 );
operator_h( w_opt_h+1 ) = w_opt_h+1;
operator_h = operator_h ./ sum( operator_h );
h_y_p = zeros( 1, l_cut_y + 2*w_opt_h );
h_y_p( w_opt_h+1 : end-w_opt_h ) = cut_y( 1 : end );
h_y = zeros( 1, l_cut_y );
for ii = w_opt_h+1 : l_cut_y+w_opt_h
	h_y( ii-w_opt_h ) = sum( operator_h .* h_y_p( ii-w_opt_h : ii+w_opt_h) );
end

diff_x = [ h_x( 2 : end ) -  h_x( 1 : end-1 ), 0 ];
diff_y = [ h_y( 2 : end ) -  h_y( 1 : end-1 ), 0 ];
diff_tx =zeros( size( diff_x) );
diff_ty =zeros( size( diff_y) );
diff_tx( diff_x(:) > 0) = 1;
diff_tx( diff_x(:) == 0) = 0;
diff_tx( diff_x(:) < 0) = -1;
diff_ty( diff_y(:) > 0) = 1;
diff_ty( diff_y(:) == 0) = 0;
diff_ty( diff_y(:) < 0) = -1;


	
[ ~, locs_peak_difftx, w_peak_difftx ] = findpeaks( diff_tx );
[ ~, locs_peak_diffty, w_peak_diffty ] = findpeaks( diff_ty );
locs_min_x = locs_peak_difftx( w_peak_difftx(:) >= 2 );
locs_min_y = locs_peak_diffty( w_peak_diffty(:) >= 2 );
Trough_x = locs_min_x(1);
Trough_y = locs_min_y(1);
end
