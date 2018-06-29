%%
% This function is used to make a FFT or IFFT to a gray image.
% input can be a char or a mat
% output is a mat
%%
function im_FFT = image_fft2(Name_image)
    
%% Initialization
if ischar(Name_image)
    S_image = imread(Name_image);
else
    S_image = Name_image;
end

if length(size(S_image)) == 3
    image = mat2gray(rgb2gray(S_image));
else
    image = mat2gray(S_image);
end

%% Main
im_fft_d = fft2(image);
im_FFT = fftshift(im_fft_d);

end