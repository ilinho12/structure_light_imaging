%%
% This function is used to make a IFFT to a Complex matrix
% output is a mat of  the additional phase
%%
function im_ifft_d = image_ifft2( Name_image )

%% Initialization
if isreal(Name_image)
    fprintf('The input data type is wrong! The input data type must be complex matrix.');
    stop
end
input_mat = Name_image;
%% Main
im_ifft_d = ifft2(ifftshift(input_mat));

end
