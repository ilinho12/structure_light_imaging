%This function is used to make a IFFT to a Complex matrix
%output is a mat of  the additional phase
function agl_ifft = image_ifft2( input_mat )
im_ifft_d = ifft2(ifftshift(input_mat));
agl_ifft = angle(im_ifft_d);
end
