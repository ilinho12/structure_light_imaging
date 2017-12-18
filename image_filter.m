function image_filter(Name_image)

if ischar(Name_image)
    image = imread(Name_image);
else
    image = Name_image;
end
image_abs = abs(image); max_abs = max(image_abs);
[row_max_image,column_max_image] = find(image_abs == max_abs);
row_halfmax_image = []; column_halfmax_image = [];
while(size(column_halfmax_image) > 0)
    [row_halfmax_image,column_halfmax_image] = find(image_abs-0.5*max_abs<0.1*max_abs  & image_abs-0.5*max_abs>0);
width_x = mean(abs(row_halfmax_image-row_max_image));
width_y = mean(abs(column_halfmax_image-row_max_image));
image2 = image;
image2(row_max_image-width_x:row_max_image+width_x, column_max_image-width_y:column_max_image+width_y) = 0;
imshow(abs(image2));
end

%{
D_image = gradient(image); % grad of image

[row_max_image,column_max_image] = find(D_image == max(D_image(:)));
g_cross = D_image(row_max_image,:); % g_cross is the Cross section of center
figure;
plot(g_cross);
 
n_g_max1 = find(g_cross == max(g_cross));
n_g_min1 = find(g_cross == min(g_cross));
if n_g_max1 < n_g_min1
    n_g_center = find(min(abs(g_cross(n_g_max1 : n_g_min1))));
else
    n_g_center = find(min(abs(g_cross(n_g_min1 : n_g_max1))));
end

L = length(g_cross);
g_FFT = fft(g_cross);
P2 = abs(g_FFT/L);
P1 = P2(1:L/2+1);
P1(2 : end-1) = 2*P1(2 : end-1);
plot(P1);

[g_sort, ind_g_sort] = sort(g_cross(n_g_center : end));
end
%}
