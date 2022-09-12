function generate_protocols

addpath(genpath('../../MATMyoSim/code'));
addpath(genpath('../../MATMyoSim/code'));


    % Variables
summary_file_string = '../summary/18dec2017a_2.xlsx';
tag_string = 'freeform';
protocol_base = '../simulations/e/sim_input/prot/prot_slc';
target_base = '../simulations/e/target/target_slc';

time_step = 0.001;
fit_start_s = 1.85;
fit_stop_s = 2.5;
pre_fit_s =1.7;

% Code

% Load summary
d = readtable(summary_file_string);
sd = d(find(startsWith(d.file_name, tag_string)), :)

% unique_pCas = unique(sd.pCa);
% unique_pCas(find(unique_pCas==6.6))=[];
% unique_pCas(find(unique_pCas==6.4))=[]
% unique_pCas(find(unique_pCas==6.2))=[]

% Build up new database
% vi = [];
% for i = 1 : numel(unique_pCas)
%     vi = [vi find(sd.pCa == unique_pCas(i), 1, 'first')];
% end

% pd = sd(vi, :);
pd = sd;
% Generate protocols and targets
for i = 1 : numel(pd.path_name)
    slc_file_string{i} = sprintf('%s.slc', ...
        fullfile(pd.path_name{i}, pd.file_name{i}));
    protocol_file_string = sprintf('%s_%i.txt', protocol_base, i);
    target_file_string = sprintf('%s_%i.txt', target_base, i);
    
    % Deduce pCa
    td = load_slcontrol_file(slc_file_string{i}, 1);
    
    out = process_SLControl_file_to_MATMyoSim( ...
        slc_file_string{i}, ...
        'transform_slcontrol_record_mode', -1, ...
        'start_time_s', fit_start_s, ...
        'stop_time_s', fit_stop_s, ...
        't_inc', time_step, ...
        'pre_points', round(pre_fit_s / time_step), ...
        'pCa', td.pCa, ...
        'smooth_fl_points', 10, ...
        'protocol_file_string', protocol_file_string, ...
        'target_file_string', target_file_string, ...
        'force_gain', 1);
end
        


% Generate a figure
figure(1);
clf;
r = 3;
c = 1;
for i = 1 : numel(pd.path_name)
    td = transform_slcontrol_record(load_slcontrol_file( ...
            slc_file_string{i}), -1);

    subplot(r,c,1);
    hold on;
    plot(td.time, td.force, 'b-');
end




