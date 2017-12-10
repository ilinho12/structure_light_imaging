%This function is used to make a FFT or IFFT to a gray image.
%input can be a char or a mat
%output is a mat
function im_FFT = image_fft2(Name_image)

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


im_fft_d = fft2(image);
im_fft = abs(im_fft_d);



%im_FFT is the image through fftshift conversion
im_FFT = fftshift(im_fft_d);
im_FFT_rl = abs(im_FFT);

im_ifft_d = ifft2(ifftshift(im_FFT));
im_ifft = abs(im_ifft_d);

%{
figure;
subplot(221); imshow(image);
title('Source');

subplot(222); imshow(im_fft);
title('FFT');

subplot(223); imshow(im_FFT_rl);
title('FFTshift');

subplot(224); imshow(im_ifft);
title('IFFT');
%}

figure;
surf(im_FFT_rl); shading interp;
title('3D FFT');

%{
figure;
contour3(im_FFT_rl);
title('Contour line');
%}

end
