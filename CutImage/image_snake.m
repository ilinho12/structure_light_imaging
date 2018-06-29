function [O, J] = image_snake(a, b, c_x, c_y, image)
% x - rows; y - cols;
input = image;
I=im2double(abs(input));
t = linspace(0, 2*pi, 100);
x0 = c_x; y0 = c_y;
x = b*cos(t) + x0;
y = a*sin(t) + y0;
P=[x(:) y(:)];
Options=struct;
Options.Verbose=false;
Options.Iterations=100;   
Options.Wedge=2;
Options.Wline=0;
Options.Wterm=0;
Options.Kappa=4;
Options.Sigma1=8;
Options.Sigma2=8;
Options.Alpha=0.1;
Options.Beta=0.1;
Options.Mu=0.2;
Options.Delta=-0.1;
Options.GIterations=600;
[O,J]=Snake2D(I,P,Options);
end