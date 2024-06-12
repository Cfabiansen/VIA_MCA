%% GRAND AVERAGE OF EEG's

clc; clear
% Initialize structure to store results for each subject
results = struct();

% Path to fieldtrip
addpath '/mnt/projects/VIA_MCA/fieldtrip-master'
ft_defaults;

% Load the table with information about HGR status
tbl = readtable(['/mnt/projects/VIA_MCA/nobackup/Cleaned_VIA15_Flanker_everything_WITH_LRP.xlsx']);<

% Initialize structures to hold ERPs for each HGR group
groupERPs = struct();

% Loop through subjects based on the Excel file
for subjectIdx = 1:height(tbl)
    subject = sprintf('%03d', tbl.id(subjectIdx)); % Format subject number with leading zeros
    hgr_status = tbl.hgr_status{subjectIdx}; % HGR status for each subject
    
    % Skip if hgr_status is missing
    if ismissing(hgr_status)
        continue;
    end
    
    try
        % Load data
        load(['/mnt/projects/VIA_MCA/nobackup/Preprocessed Data/' subject '_data.mat'])
        % Load info file
        load(['/mnt/projects/VIA_MCA/nobackup/Preprocessed Data/' subject '_info.mat'])
        
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

        % Incongruent
        cfg = [];
        cfg.trials = trials_incon;
        timelock_incon = ft_timelockanalysis(cfg, data_incon); % trials averaging

        timelock_incon.avg(1:128,:) = ft_preproc_rereference(timelock_incon.avg(1:128,:)); % average referencing

        % Incongruent Baseline correction
        cfg = [];
        cfg.baseline = [-0.5 -0.1];
        timelock_incon = ft_timelockbaseline(cfg, timelock_incon);

        % Initialize group arrays if not already done
        if ~isfield(groupERPs, hgr_status)
            groupERPs.(hgr_status).con = {};
            groupERPs.(hgr_status).incon = {};
        end
        
        % Add the current subject's data to the group Timelock
        groupERPs.(hgr_status).con{end+1} = timelock_con;
        groupERPs.(hgr_status).incon{end+1} = timelock_incon;

    catch ME
        warning('Failed processing for subject %s: %s', subject, ME.message);
    end
end

% Now, calculate and save grand averages for each group
groupNames = fieldnames(groupERPs);
for i = 1:numel(groupNames)
    groupName = groupNames{i};

    % Congruent grand average
    cfg = []; % You can add your configuration settings here
    grandAverage_con = ft_timelockgrandaverage(cfg, groupERPs.(groupName).con{:});
    
    % Incongruent grand average
    grandAverage_incon = ft_timelockgrandaverage(cfg, groupERPs.(groupName).incon{:});
    
    % Dynamically construct variable names
    varName_con = ['grandAverage_con_' groupName];
    varName_incon = ['grandAverage_incon_' groupName];

    % Assign the grand averages to dynamically named variables
    eval([varName_con ' = grandAverage_con;']);
    eval([varName_incon ' = grandAverage_incon;']);

    % Construct file paths
    filePath_con = ['/mnt/projects/VIA_MCA/nobackup/temporary/' groupName '_grandAverage_con.mat'];
    filePath_incon = ['/mnt/projects/VIA_MCA/nobackup/temporary/' groupName '_grandAverage_incon.mat'];

    % Save the grand averages using eval to dynamically generate the save command
    eval(['save(filePath_con, ''' varName_con ''');']);
    eval(['save(filePath_incon, ''' varName_incon ''');']);
end



