
%% Bayesian model selection VIA15 or VIA11 or both MCA
%-----------------------------------------------------------------------
addpath '/mnt/projects/VIA_MCA/spm12.7771'

matlabbatch{1}.spm.dcm.bms.inference.dir = {'/mnt/projects/VIA_MCA/nobackup/DCM/BMS/VIA15'};

i = 1;
for subject = 1:530
    try
        currsubject = sprintf('%03d', subject); % Format subject number with leading zeros
        load(['/mnt/projects/VIA_MCA/nobackup/DCM/Model1/DCM_Model1_' currsubject '.mat'])
        load(['/mnt/projects/VIA_MCA/nobackup/DCM/Model2/DCM_Model2_' currsubject '.mat'])

        matlabbatch{1}.spm.dcm.bms.inference.sess_dcm{i}.dcmmat = {
                                                                   ['/mnt/projects/VIA_MCA/nobackup/DCM/Model1/DCM_Model1_' currsubject '.mat']
                                                                   ['/mnt/projects/VIA_MCA/nobackup/DCM/Model2/DCM_Model2_' currsubject '.mat']
                                                                   };
        i = i+1;
    catch
        disp(['Something was wrong with Subject ' currsubject '! Continuing with next in line']);
    end 
end 

% % i = 1;
% for subject = 1:530
%     try
%         currsubject = sprintf('%03d', subject); % Format subject number with leading zeros
%         load(['/mnt/projects/VIA_MCA/VIA11/MATLAB_VIA11/DCM/Model1/DCM_Model1_' currsubject '.mat'])
%         load(['/mnt/projects/VIA_MCA/VIA11/MATLAB_VIA11/DCM/Model2/DCM_Model2_' currsubject '.mat'])
% 
%         matlabbatch{1}.spm.dcm.bms.inference.sess_dcm{i}.dcmmat = {
%                                                                    ['/mnt/projects/VIA_MCA/VIA11/MATLAB_VIA11/DCM/Model1/DCM_Model1_' currsubject '.mat']
%                                                                    ['/mnt/projects/VIA_MCA/VIA11/MATLAB_VIA11/DCM/Model2/DCM_Model2_' currsubject '.mat']
%                                                                    };
%         i = i+1;
%     catch
%         disp(['Something was wrong with Subject ' currsubject '! Continuing with next in line']);
%     end 
% end 


matlabbatch{1}.spm.dcm.bms.inference.model_sp = {''};
matlabbatch{1}.spm.dcm.bms.inference.load_f = {''};
matlabbatch{1}.spm.dcm.bms.inference.method = 'RFX';
matlabbatch{1}.spm.dcm.bms.inference.bma.bma_no = 0;
matlabbatch{1}.spm.dcm.bms.inference.verify_id = 0;


nrun = 1; % enter the number of runs here
jobfile = {matlabbatch};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'EEG');
spm_jobman('run', jobs, inputs{:});

