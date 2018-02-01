% This function is used to generate a 3D image about a half ellipsoid
function img = half_ellipsoid( n, a_el, b_el, c_el )
% The image is satisfied to athe function that (x/a)^2+(y/b)^2+(z/c)^2 = 1
% a_el, b_el, c_el are the radius of ellipsoid
%% Generate an ellipsoid
hight = zeros(n, n);

a2_el = a_el^2; b2_el = b_el^2; c2_el = c_el^2;
for ii = 1 : n
    for jj = 1 : n
        if (((ii-ceil(n/2))^2*b2_el+(jj-ceil(n/2))^2*a2_el) <= a2_el*b2_el)
            hight(ii,jj) = sqrt((a2_el*b2_el*c2_el-...
                b2_el*c2_el*(ii-ceil(n/2))^2-a2_el*c2_el*(jj-ceil(n/2))^2)...
                /(a2_el*b2_el));
        end
    end
end
img = hight;
end
