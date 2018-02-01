% Generate an striping with object
function [ E_image, phase_grating, phase_add ] = makeImage( object, phase_grating, T_grating, theta, Path, n)
% Object is 3D mat
% T_frating is the space period of the sinusoidal grating ( pi/2,-pi/2 )
% The negative number representes that incidenting from the left side, 
% and the positive number representes that incidenting from the right side
% theta is the angle of incidence
%% Confirm file catalog

Path_file = Path;
%%
% theta is the angle of incidence
% lambda is the equivalent length
hight = object;
m = size( hight, 1 );
lambda_eq = T_grating*sin(theta);

% E_angle_add is the additional phase's angle of image from object
E_image = zeros(size(hight));
E_phase = zeros(size(hight));
angle_phase = zeros(size(hight));
phase_add = zeros(size(hight));
for ii = 1 : m
    for jj = 1 : m
        phase_add(ii,jj) = 2*pi*hight(ii,jj)/lambda_eq;
        E_phase(ii,jj) = phase_grating(ii,jj) + phase_add(ii,jj);
        angle_phase(ii,jj) = rem( E_phase(ii,jj), 2*pi ) - pi;
        E_image(ii,jj) = 0.5+0.5*cos(E_phase(ii,jj));
    end
end

save( [ Path_file '\' num2str(n, '%03.0f') '_img.mat' ],  'E_image', 'E_phase', 'angle_phase', 'phase_add' );

picture1 = figure('visible','off'); 
E_image = mat2gray(E_image);
imshow(E_image); title('Input-image');
saveas(picture1, [ Path_file '\' num2str(n, '%03.0f') '_InputImage.bmp' ]);

picture2 = figure('visible','off');
image(angle_phase, 'CDataMapping', 'scaled'); caxis([-pi pi]) ;
colormap(jet); title('Input-phace'); colorbar;
saveas(picture2, [ Path_file '\' num2str(n, '%03.0f') '_InputPhace.bmp' ]);

picture3 = figure('visible','off');
image(phase_add, 'CDataMapping', 'scaled'); caxis([-pi pi]) ;
colormap(jet); title('Input-phace-add'); colorbar;
saveas(picture3, [ Path_file '\' num2str(n, '%03.0f') '_InputAddingPhace.bmp' ]);

close all

end
