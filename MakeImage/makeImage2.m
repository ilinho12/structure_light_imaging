%%
% This function is used to generate a image for structured light image CCD
% The differnce between function makeImage and makeImage2 is that the makeImage2
% is used to  the method of Pi phase shifting 
%%
function output = makeImage2(n, theta, T_grating, t)
    % Output is a output data with Matlab mat data style
    % Input is the input parameters for this function
    % Input n is the length of maxtrix 
    % Input t is the physical distance of pixel
    % Input theta is the angle of incidence
    % Input T_grating is the period of grating
    % Input frame is the measurement time
    % Output output is the deformation pattern from CCD
    
    %% Initialization
    switch nargin
        case 4
            n = 512; theta = pi/10; T_grating = 80; t = 1;
        case 3
            n = 512; theta = pi/10; T_grating = 80;
        case 2
            n = 512; theta = pi/10;
        case 1
            n = 512;
    
    end
    lambda_eq = T_grating*sin(theta); % lambda_eq is the equivalent
                                      % wave length
    frame = 2; % frame is the measurement time
    
    %% Generating a sphere 3D object
    obj = mSphere;
    hight = obj;
    
    output = zeros(n, n, 2);
    for kk = 1 : frame
        %% Generating a grating
        [~, phase_grating] = mGrating([], [], [], frame);
        
        %% Mixing the image of object and grating
        E_image = zeros(n);
        phase_image = zeros(n);
        angle_phase = zeros(n);
        angle_phase_add = zeros(n);
        for ii = 1 : n
            for jj = 1 : n
                angle_phase_add(ii,jj) = 2*pi*hight(ii,jj)/lambda_eq;
                phase_image(ii,jj) = phase_grating(ii,jj) + angle_phase_add(ii,jj);
                angle_phase(ii,jj) = rem( phase_image(ii,jj), 2*pi ) - pi;
                E_image(ii,jj) = 0.5+0.5*cos(phase_image(ii,jj));
            end
        end
        
        %{
        picture1 = figure('visible','off'); 
        E_image = mat2gray(E_image);
        imshow(E_image); title('Input-image');
        saveas(picture1, [ Path_file '\' num2str(n, '%03.0f') '_InputImage.bmp' ]);
        
        picture2 = figure('visible','off');
        image(phase_image, 'CDataMapping', 'scaled'); caxis([-pi pi]) ;
        colormap(jet); title('Input-phace'); colorbar;
        saveas(picture2, [ Path_file '\' num2str(n, '%03.0f') '_InputPhace.bmp' ]);
        
        picture3 = figure('visible','off');
        image(phase_add, 'CDataMapping', 'scaled'); caxis([-pi pi]) ;
        colormap(jet); title('Input-phace-add'); colorbar;
        saveas(picture3, [ Path_file '\' num2str(n, '%03.0f') '_InputAddingPhace.bmp' ]);
        %}
    
        output(:, :, kk) = E_image;
    end
end
    