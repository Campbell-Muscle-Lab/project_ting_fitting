function find_SLC_files
addpath(genpath('../../MATLAB_Utilities'));

% Variables
data_folder = 'C:\Users\ugu222\OneDrive - University of Kentucky\Documents\GitHub\project_ting_fitting\slc_files\pCa_6pt4';

summary_file_string = '../summary/18dec2017a_2.xlsx';

% Code

% Find slc_files
slc_files = sort_nat(findfiles('slc', data_folder, 0));

% Pull off summary data
progress_bar(0);
summary = [];
for file_counter = 1 : numel(slc_files)
    progress_bar(file_counter / numel(slc_files));
    
    td = transform_slcontrol_record( ...
            load_slcontrol_file(slc_files{file_counter}), -1);
       
    % Store summary data
    force_gain = 1;
    try
        file_info = strsplit(td.file_info_string);
        if (strcmp(file_info{3}, 'Force_gain'))
            force_gain = str2num(file_info{4});
        end
    end
    
    [path_name,file_name] = fileparts(slc_files{file_counter});
    ni = regexp(file_name,'\d*','Match');
    
    summary.path_name{file_counter} = path_name;
    summary.file_name{file_counter} = file_name;
    summary.file_index(file_counter) = str2num(ni{1});
    summary.pCa(file_counter) = td.pCa;
    summary.P_ss(file_counter) = td.force(1);
    summary.fl(file_counter) = td.fl(1);
    summary.force_gain(file_counter) = force_gain;
    
%     if (file_counter == 1)
%         break
%     end
end

% Output
summary = columnize_structure(summary);
summary = struct2table(summary);
try
    delete(summary_file_string);
end
writetable(summary, summary_file_string);