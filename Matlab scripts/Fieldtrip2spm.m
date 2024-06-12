 %% Fieldtrip 2 SPM

addpath '/mnt/projects/VIA_MCA/spm12.7771'
spm('defaults','EEG')

%% Set ID
for subject = 7:530
    try
        currsubject = sprintf('%03d', subject); % Format subject number with leading zeros

%% Load Fieldtrip data

load(['/mnt/projects/VIA_MCA/nobackup/Preprocessed Data/' currsubject '_data.mat'])
% Load info file
load(['/mnt/projects/VIA_MCA/nobackup/Preprocessed Data/' currsubject '_info.mat'])
        
%% Averaging trials

% Identify "good" trials for congruent and incongruent conditions
trials_con = find(sum([accuracy_con, not(bad_trials_con)'], 2) == 2);
trials_incon = find(sum([accuracy_incon, not(bad_trials_incon)'], 2) == 2);

% Congruent
cfg = [];
cfg.trials = trials_con;
timelock_con = ft_timelockanalysis(cfg, data_con); % trials averaging

timelock_con.avg(1:128,:) = ft_preproc_rereference(timelock_con.avg(1:128,:)); % average referencing

% Congruent Baseline correction
cfg = [];
cfg.baseline = [-0.5 -0.1];
timelock_con = ft_timelockbaseline(cfg, timelock_con);
%%
% Incongruent
cfg = [];
cfg.trials = trials_incon;
timelock_incon = ft_timelockanalysis(cfg, data_incon); % trials averaging

timelock_incon.avg(1:128,:) = ft_preproc_rereference(timelock_incon.avg(1:128,:)); % average referencing

% Incongruent Baseline correction
cfg = [];
cfg.baseline = [-0.5 -0.1];
timelock_incon = ft_timelockbaseline(cfg, timelock_incon);

%% Define as ftdata

ftdata_con = timelock_con;
ftdata_incon = timelock_incon;

%%  Convert congruent to SPM format

% Convert from fieldtrip to SPM
spm_data_con = spm_eeg_ft2spm(ftdata_con,['/mnt/projects/VIA_MCA/nobackup/Merged_SPM/' currsubject '_con.mat'])

% Load newly created SPM file
load(['/mnt/projects/VIA_MCA/nobackup/Merged_SPM/' currsubject '_con.mat'])

% Edit conditions (condlist + trials)
D.condlist = {'Congruent','Incongruent'}
[D.trials(:).label] = deal('Congruent');

% Saving edited file
save(['/mnt/projects/VIA_MCA/nobackup/Merged_SPM/' currsubject '_con.mat'],'D')



%% Convert incongruent to SPM format

% Convert from fieldtrip to SPM
spm_data_incon = spm_eeg_ft2spm(ftdata_incon,['/mnt/projects/VIA_MCA/nobackup/Merged_SPM/' currsubject '_incon.mat'])

% Load newly created SPM file
load(['/mnt/projects/VIA_MCA/nobackup/Merged_SPM/' currsubject '_incon.mat'])

% Edit conditions (condlist + trials)
D.condlist = {'Congruent','Incongruent'}
[D.trials(:).label] = deal('Incongruent');

% Saving edited file
save(['/mnt/projects/VIA_MCA/nobackup/Merged_SPM/' currsubject '_incon.mat'],'D')


%% Merging con and incon

% Creating structure for merging
S.D = {spm_eeg_load(['/mnt/projects/VIA_MCA/nobackup/Merged_SPM/' currsubject '_con.mat']),spm_eeg_load(['/mnt/projects/VIA_MCA/nobackup/Merged_SPM/' currsubject '_incon.mat'])}

% Adding prefix
S.prefix = 'merged_';

% Function to merge
spm_eeg_merge(S)

% Deleting temporary files
delete(['/mnt/projects/VIA_MCA/nobackup/Merged_SPM/' currsubject '_con.mat'],['/mnt/projects/VIA_MCA/nobackup/Merged_SPM/' currsubject '_incon.mat'])
delete(['/mnt/projects/VIA_MCA/nobackup/Merged_SPM/' currsubject '_con.dat'],['/mnt/projects/VIA_MCA/nobackup/Merged_SPM/' currsubject '_incon.dat'])

%% Adding sensors
% Define the job directly within the batch script
matlabbatch{1}.spm.meeg.preproc.prepare.D = {['/mnt/projects/VIA_MCA/nobackup/Merged_SPM/merged_' currsubject '_con.mat']};
matlabbatch{1}.spm.meeg.preproc.prepare.task{1}.defaulteegsens.multimodal.nasfid = 'nas';
matlabbatch{1}.spm.meeg.preproc.prepare.task{1}.defaulteegsens.multimodal.lpafid = 'lpa';
matlabbatch{1}.spm.meeg.preproc.prepare.task{1}.defaulteegsens.multimodal.rpafid = 'rpa';



%% Adding headmodel
matlabbatch{2}.spm.meeg.source.headmodel.D = {['/mnt/projects/VIA_MCA/nobackup/Merged_SPM/merged_' currsubject '_con.mat']};
matlabbatch{2}.spm.meeg.source.headmodel.val = 1;
matlabbatch{2}.spm.meeg.source.headmodel.meshing.meshes.template = 1;
matlabbatch{2}.spm.meeg.source.headmodel.meshing.meshres = 2;
matlabbatch{2}.spm.meeg.source.headmodel.coregistration.coregdefault = 1;
matlabbatch{2}.spm.meeg.source.headmodel.forward.eeg = '3-Shell Sphere';


% List of open inputs
nrun = 2; % enter the number of runs here
jobfile = {matlabbatch}; % Define the job directly within the batch script
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end

spm('defaults', 'EEG');
spm_jobman('run', jobs, inputs{:});

    catch
        disp(['Something was wrong with Subject ' currsubject '! Continuing with next in line']); % If something is wrong, display in window and continue with next
    end
end




