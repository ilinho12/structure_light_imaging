%%
% This function is used to generate a sine grating
%%
function [grating, phase_grating] = mGrating(frame, n, T_grating, t)
    % Output grating is a 2D matrix of Matlab mat data about sin grating
    % Output T_grating is the space period of the sinusoidal grating
    % Input frame is the measurement time
    % Input is the physical distance of matrix
    % Input n is the size of matrix of grating
    % Input T_grating is the period of grating

    %% Initialization
    switch nargin
        case 0
            frame = 1; n = 512; T_grating = 80; t =1;
        case 1
            n = 512; T_grating = 80; t =1;
        case 2
            T_grating = 80; t =1;
        case 3
            t = 1;
    end
    delay = (2*pi)/frame;

    %% Generate a sine grating
    f_grating = 1/T_grating;
    I_grating = zeros(n);
    phase_grating = zeros(n);
    for jj = 1 : n
        I_grating(:, jj) = 128+127*cos(2*pi*jj*f_grating+delay);
        phase_grating(:, jj) = 2*pi*jj*f_grating+delay;
    end
    grating = I_grating*t;
    % figure; imshow(grating);
    % figure; plot(1:n,phase_grating(1,:));
end