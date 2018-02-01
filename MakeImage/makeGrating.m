function [ img, phase_grating ] = makeGrating( n, T_grating )
% Generate a sine grating
% T_frating is the space period of the sinusoidal grating
f_grating = 1/T_grating;
I_grating = zeros(n);
phase_grating = zeros(n);
for jj = 1 : n
     I_grating(:, jj) = 128+127*cos(2*pi*jj*f_grating);
     phase_grating(:, jj) = 2*pi*jj*f_grating;
end
img = I_grating;
end