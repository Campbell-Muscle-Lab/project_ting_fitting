function read_mat

% Make sure the path allows us to find the right files
addpath(genpath('../../MATMyoSim/code'));

low_ca_file_string = '../MAT_files/18Dec2017a_pCa_9pt0.mat';

normal_ca_file_string = '../MAT_files/18Dec2017a_pCa_6pt4.mat';

low_ca = load(low_ca_file_string)

normal_ca = load(low_ca_file_string)














end