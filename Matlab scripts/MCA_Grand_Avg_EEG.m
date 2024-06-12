%% GRAND AVERAGE OF EEG's

addpath '/mnt/projects/VIA_MCA/fieldtrip-master'
ft_defaults;

results = struct();

% Initialize cell arrays to store timelocked data for all subjects
all_timelock_con = {};
all_timelock_incon = {};

% Loop through subjects
for subject = 1:530
    try
        currsubject = sprintf('%03d', subject); % Format subject number with leading zeros

        % Load data
        load(['/mnt/projects/VIA_MCA/nobackup/Preprocessed Data/' currsubject '_data.mat'])
        % Load info file
        load(['/mnt/projects/VIA_MCA/nobackup/Preprocessed Data/' currsubject '_info.mat'])
        
        

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

        all_timelock_con{end+1} = timelock_con;
        all_timelock_incon{end+1} = timelock_incon;
   
        %% Store results for the current subject in the main results structure
        results.(sprintf('Subject_%03d', subject)) = subjectresultsEEG;

    end
end

grandAverage_con = ft_timelockgrandaverage(cfg, all_timelock_con{:});
grandAverage_incon = ft_timelockgrandaverage(cfg, all_timelock_incon{:});


save('/mnt/projects/VIA_MCA/MATLAB/Grand_Average_NY.mat', 'grandAverage_con', 'grandAverage_incon');

% Define the indices to exclude
indices_to_exclude = [74, 89, 91, 98, 101, 103];

% Create new cell arrays excluding the specified indices
all_timelock_con_filtered = all_timelock_con;
all_timelock_incon_filtered = all_timelock_incon;
all_timelock_con_filtered(indices_to_exclude) = [];
all_timelock_incon_filtered(indices_to_exclude) = [];

% Now use these filtered cell arrays in the ft_timelockgrandaverage function
grandAverage_con = ft_timelockgrandaverage(cfg, all_timelock_con_filtered{:});
grandAverage_incon = ft_timelockgrandaverage(cfg, all_timelock_incon_filtered{:});

save('/mnt/projects/VIA_MCA/MATLAB/Grand_Average_NY.mat', 'grandAverage_con', 'grandAverage_incon');

