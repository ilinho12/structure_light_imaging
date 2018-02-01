function img_out = cut_ellipse_Lft( a, b, c_x, c_y, S_image )
[ m, n ] = size( S_image );
image = zeros( m, n );
image( :, c_y : end ) = S_image( :, c_y : end );
img_out = zeros( m, n );
a2 = a^2; b2 = b^2; a2b2 = a2*b2;
for	ii = 1 : m
	for	jj = 1 : n
		if	( ii - c_x )^2*a2 + ( jj - c_y )^2*b2 >= a2b2
			img_out( ii, jj ) = 0;
        else
            img_out( ii, jj ) = image( ii, jj );
		end
	end
end
end