%addpath(genpath(pwd));
Path = pwd;

n = 500;
a = 20:20:400;
b = 20:20:400;
c = 10:2:48;
T_grating = 20:5:120;
theta = -10*pi/11: pi/11 : 10*pi/11;

for ii = 1:20
    a_el = a(ii); b_el = b(ii); c_el = c(ii);
    object = half_ellipsoid( n, a_el, b_el,c_el );
    
    mkdir( [Path '\' num2str(ii, '%03.0f')] );
    %addpath(genpath(pwd));
    Path_file1 = [Path '\' num2str(ii, '%03.0f')];
    dlmwrite([ Path_file1 '\a.txt' ], a_el, 'precision', '%5.0f');
    dlmwrite([ Path_file1 '\b.txt' ], b_el, 'precision', '%5.0f');
    dlmwrite([ Path_file1 '\c.txt' ], c_el, 'precision', '%5.0f');
    dlmwrite([ Path_file1 '\n.txt' ], n, 'precision', '%5.0f');
    
    for jj =1:21
        t = T_grating(jj);
        [ ~, phase_grating ] = makeGrating( n, t );
        
        mkdir( [Path_file1 '\' num2str(t, '%03.0f')] );
        %addpath(genpath(pwd));
        Path_file2 = [ Path_file1 '\' num2str(t, '%03.0f')];
        dlmwrite([ Path_file2 '\Tgrating.txt' ], t, 'precision', '%5.0f');
        for kk = 1:21
            n_theta = theta(kk);
            dlmwrite([ Path_file2 '\' num2str(kk) '.txt' ], kk, 'precision', '%5.10f');
            [ E_image, phase_grating, phase_add ] = makeImage( object, phase_grating, t, n_theta, Path_file2, kk );
        end
    end
end
    