function generate_protocols_mat

% Make sure the path allows us to find the right files
addpath(genpath('../../MATMyoSim/code'));

% Variables
% summary_file_string = '../summary/18dec2017a.xlsx';
% tag_string = 'freeform';
protocol_base = '../simulations/e/sim_input/prot/prot';
target_base = '../simulations/e/target/target';

low_ca_file_string = '../MAT_files/18Dec2017a_pCa_9pt0.mat';

normal_ca_file_string = '../MAT_files/18Dec2017a_pCa_6pt4.mat';

low_ca = load(low_ca_file_string);

normal_ca = load(normal_ca_file_string);

low_ca_pCa = low_ca.new_data(1).pCa;

normal_ca_pCa = normal_ca.new_data(1).pCa;

time_step = 0.001;
fit_start_s = 0.8;
fit_stop_s = 1.5;
pre_fit_s =1.7;

% 18Dec2017a_pCa_9pt0.mat: First 5 trials with ISI = 1.

for i = 1 : 5

protocol_file_string = sprintf('%s_pas_%i.txt', protocol_base, i);
target_file_string = sprintf('%s_pas_%i.txt', target_base, i);
td = low_ca.new_data(i);


out = process_MAT_SLControl_file_to_MATMyoSim( ...
         td, ...
        'transform_slcontrol_record_mode', -1, ...
        'start_time_s', fit_start_s, ...
        'stop_time_s', fit_stop_s, ...
        't_inc', time_step, ...
        'pre_points', round(pre_fit_s / time_step), ...
        'pCa', td.pCa, ...
        'smooth_fl_points', 10, ...
        'protocol_file_string', protocol_file_string, ...
        'target_file_string', target_file_string, ...
        'force_gain', 10);
end

time_step = 0.001;
fit_start_s = 0.9;
fit_stop_s = 1.5;
pre_fit_s =1.7;

for i = 2 : 6

protocol_file_string = sprintf('%s_%i.txt', protocol_base, i-1);
target_file_string = sprintf('%s_%i.txt', target_base, i-1);
td = normal_ca.new_data(i);


out = process_MAT_SLControl_file_to_MATMyoSim( ...
         td, ...
        'transform_slcontrol_record_mode', -1, ...
        'start_time_s', fit_start_s, ...
        'stop_time_s', fit_stop_s, ...
        't_inc', time_step, ...
        'pre_points', round(pre_fit_s / time_step), ...
        'pCa', td.pCa, ...
        'smooth_fl_points', 10, ...
        'protocol_file_string', protocol_file_string, ...
        'target_file_string', target_file_string, ...
        'force_gain', 10);
end









% Build up new database
% vi = [];
% for i = 1 : numel(unique_pCas)
%     vi = [vi find(sd.pCa == unique_pCas(i), 1, 'first')];
% end
% 
% pd = sd(vi, :);
% 
% % Generate protocols and targets
% for i = 1 : numel(pd.path_name)
%     slc_file_string{i} = sprintf('%s.slc', ...
%         fullfile(pd.path_name{i}, pd.file_name{i}));
%     protocol_file_string = sprintf('%s_%i.txt', protocol_base, i);
%     target_file_string = sprintf('%s_%i.txt', target_base, i);
%     
%     % Deduce pCa
%     td = load_slcontrol_file(slc_file_string{i}, 1);
%     
%     out = process_SLControl_file_to_MATMyoSim( ...
%         slc_file_string{i}, ...
%         'transform_slcontrol_record_mode', -1, ...
%         'start_time_s', fit_start_s, ...
%         'stop_time_s', fit_stop_s, ...
%         't_inc', time_step, ...
%         'pre_points', round(pre_fit_s / time_step), ...
%         'pCa', td.pCa, ...
%         'smooth_fl_points', 10, ...
%         'protocol_file_string', protocol_file_string, ...
%         'target_file_string', target_file_string, ...
%         'force_gain', 1);
% end
%         
% 
% 
% % Generate a figure
% figure(1);
% clf;
% r = 3;
% c = 1;
% for i = 1 : numel(pd.path_name)
%     td = transform_slcontrol_record(load_slcontrol_file( ...
%             slc_file_string{i}), -1);
% 
%     subplot(r,c,1);
%     hold on;
%     plot(td.time, td.force, 'b-');
% end

end


