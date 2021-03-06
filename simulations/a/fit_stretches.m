function fit_fv_curve
% Code fits fv_curve

% Variables
optimization_file_string = 'optimization_4_state_with_4exp.json';

% Code

% Make sure the path allows us to find the right files
addpath(genpath('c:/ken/github/campbellmusclelab/models/MATMyoSim/code'));

fig_handle =@fig_summary

% Start the optimization
fit_controller(optimization_file_string, ...
    'single_run', 0, ...
    'output_handler', fig_handle);
