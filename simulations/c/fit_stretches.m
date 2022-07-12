function fit_fv_curve
% Code fits fv_curve

% Variables
optimization_file_string = 'optimization_4D_3A.json';
optimization_file_string = 'optimization_3D_1A.json'
%optimization_file_string = 'optimization_2D_1A.json'

% Code

% Make sure the path allows us to find the right files
addpath(genpath('../../../MATMyoSim/code'));

fig_handle =@fig_summary

% Start the optimization
% fit_controller(optimization_file_string, ...
%     'single_run', 0, ...
%     'output_handler', fig_handle);

fit_controller(optimization_file_string, ...
    'single_run', 0);