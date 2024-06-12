%% Flanker EEG - Data Analysis (Amplitude, Latency)


addpath '/mnt/projects/VIA_MCA/fieldtrip-master'
ft_defaults;

tbl = readtable('/mnt/projects/VIA_MCA/nobackup/Clean_VIA15_Flanker_20_04.xlsx'); % Load table with subject information. 
VIA15_tbl = readtable('/mnt/projects/VIA_MCA/nobackup/VIA15_Flanker_everything.xlsx.xlsx'); % Load a clean table with column names

% Reformatting columns to store groups
VIA15_tbl.hgr_status = cell(height(VIA15_tbl), 1); 
VIA15_tbl.fhr_group = cell(height(VIA15_tbl), 1);  

load('/mnt/projects/VIA_MCA/MATLAB/Grand_Average_NY.mat'); % > Grand_Average_NY have 8000hz sampling rate. Grand_Average have 4000hz sampling rate. 



%% Grand average timeinterval P3

% P3 con time point
idx_P3_con = find(grandAverage_con.time >= 0.3 & grandAverage_con.time <= 0.6);
[max_val_con_P3, idx_max_con_P3] = max(grandAverage_con.avg(19, idx_P3_con));
time_con_P3 = grandAverage_con.time(idx_P3_con(idx_max_con_P3));

% P3 incon time point
idx_P3_incon = find(grandAverage_con.time >= 0.3 & grandAverage_con.time <= 0.6);
[max_val_incon_P3, idx_max_incon_P3] = max(grandAverage_incon.avg(19, idx_P3_incon));
time_incon_P3 = grandAverage_con.time(idx_P3_incon(idx_max_incon_P3));

%% Grand average timeinterval N2

% N2 con time point
idx_N2_con = find(grandAverage_con.time >= 0.15 & grandAverage_con.time <= 0.25);
[min_val_con_N2, idx_min_con_N2] = min(grandAverage_con.avg(87, idx_N2_con));
time_con_N2 = grandAverage_con.time(idx_N2_con(idx_min_con_N2));

% N2 incon time point
idx_N2_incon = find(grandAverage_incon.time >= 0.15 & grandAverage_incon.time <= 0.25);
[min_val_incon_N2, idx_min_incon_N2] = min(grandAverage_incon.avg(87, idx_N2_incon));
time_incon_N2 = grandAverage_con.time(idx_N2_incon(idx_min_incon_N2));


%% Intervals

% Define time intervals for N2 for con and incon

int_con_N2_lowr = find(and(grandAverage_con.time > time_con_N2 - 0.0002 - 0.05, grandAverage_con.time < time_con_N2 + 0.0002 - 0.05));
int_con_N2_upr = find(and(grandAverage_con.time > time_con_N2 - 0.0002 + 0.05, grandAverage_con.time < time_con_N2 + 0.0002 + 0.05));
int_incon_N2_lowr = find(and(grandAverage_con.time > time_incon_N2 - 0.0002 - 0.05, grandAverage_incon.time < time_incon_N2 + 0.0002 - 0.05));
int_incon_N2_upr = find(and(grandAverage_con.time > time_incon_N2 - 0.0002 + 0.05, grandAverage_incon.time < time_incon_N2 + 0.0002 + 0.05));

% Define time intervals for P3 for con and incon
int_con_P3_lowr = find(and(grandAverage_con.time > time_con_P3 - 0.0002 - 0.05, grandAverage_con.time < time_con_P3 + 0.0002 - 0.05));
int_con_P3_upr = find(and(grandAverage_con.time > time_con_P3 - 0.0002 + 0.05, grandAverage_con.time < time_con_P3 + 0.0002 + 0.05));
int_incon_P3_lowr = find(and(grandAverage_con.time > time_incon_P3 - 0.0002 - 0.05, grandAverage_incon.time < time_incon_P3 + 0.0002 - 0.05));
int_incon_P3_upr = find(and(grandAverage_con.time > time_incon_P3 - 0.0002 + 0.05, grandAverage_incon.time < time_incon_P3 + 0.0002 + 0.05));

%% Analysis
% Loop through subjects
for subject = [5] % Subject 240, 312, 344, 369, 385, 408 have lower sampling rate. 
    try
        currsubject = sprintf('%03d', subject); % Format subject number with leading zeros

        % Load data
        load(['/mnt/projects/VIA_MCA/nobackup/Preprocessed Data/' currsubject '_data.mat'])
        % Load info file
        load(['/mnt/projects/VIA_MCA/nobackup/Preprocessed Data/' currsubject '_info.mat'])

        % Saving demographic data to results
        VIA15_tbl.id(subject) = subject;
    

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


        %% P300 for electrode 'Pz'
        
        % Congruent 
        [PosAc, PosLc]=max(timelock_con.avg([19],int_con_P3_lowr:int_con_P3_upr))
        PosLc=timelock_con.time(int_con_P3_lowr+PosLc-1)

        VIA15_tbl.CON_P3_PZ_AMP(subject) = PosAc;
        VIA15_tbl.CON_P3_PZ_LAT(subject) = PosLc;

        % Incongruent
        [PosAi, PosLi]=max(timelock_incon.avg([19],int_incon_P3_lowr:int_incon_P3_upr));
        PosLi=timelock_incon.time(int_incon_P3_lowr+PosLi-1);

        VIA15_tbl.INCON_P3_PZ_AMP(subject) = PosAi;
        VIA15_tbl.INCON_P3_PZ_LAT(subject) = PosLi;

        

        %% N200 for electrode 'FCz'
        [NegAc, NegLc]=min(timelock_con.avg([87],int_con_N2_lowr:int_con_N2_upr));
        NegLc=timelock_con.time(int_con_N2_lowr+NegLc-1);

        VIA15_tbl.CON_N2_FCZ_AMP(subject) = NegAc;
        VIA15_tbl.CON_N2_FCZ_LAT(subject) = NegLc;

        [NegAi, NegLi]=min(timelock_incon.avg([87],int_incon_N2_lowr:int_incon_N2_upr));
        NegLi=timelock_incon.time(int_incon_N2_lowr+NegLi-1);

        VIA15_tbl.INCON_N2_FCZ_AMP(subject) = NegAi;
        VIA15_tbl.INCON_N2_FCZ_LAT(subject) = NegLi;


        %% Average Reaction Time

        % Omission error rate (no response)
        omission_errors = sum(RT_con==0) + sum(RT_incon==0);
        VIA15_tbl.Commission_errors(subject) = omission_errors/(length(RT_con)+length(RT_incon));

        % Premature responses
        VIA15_tbl.NOE_PREMATURE(subject) = sum(RT_con_correct > 0 & RT_con_correct < 200) + sum(RT_incon_correct > 0 & RT_incon_correct < 200);


        % Average RT (excluding invalid trails)
        VIA15_tbl.RT_CC(subject) = mean(RT_con_correct(RT_con_correct >= 200)); % con
        VIA15_tbl.RT_IC(subject) = mean(RT_incon_correct(RT_incon_correct >= 200)); % Incon

       
        % Standard Deviation (excluding invalid trails)
        VIA15_tbl.SDRT_CC(subject) = std(RT_con_correct(RT_con_correct >= 200)); % con
        VIA15_tbl.SDRT_IC(subject) = std(RT_incon_correct(RT_incon_correct >= 200)); % Incon

        % CV (excluding invalid trails)
        VIA15_tbl.COV_RT_CC(subject) = VIA15_tbl.SDRT_CC(subject)/VIA15_tbl.RT_CC(subject); % con
        VIA15_tbl.COV_RT_IC(subject) = VIA15_tbl.SDRT_IC(subject)/VIA15_tbl.RT_IC(subject); % Incon


        %% Accuracy rate

        % Con
        VIA15_tbl.ACC_CON(subject) = mean(accuracy_con);
        VIA15_tbl.ACC_CON_RATE(subject)  = mean(accuracy_con)*100;
        
        % Incon
        VIA15_tbl.ACC_INCON(subject) = mean(accuracy_incon);
        VIA15_tbl.ACC_INCON_RATE(subject) = mean(accuracy_incon)*100;

        %% Congruency effect

        % Accuracy
        VIA15_tbl.Congruency_effect_ACC(subject) = mean(accuracy_incon) - mean(accuracy_con);

        % RT
        VIA15_tbl.Congruency_effect_RT(subject) = VIA15_tbl.RT_IC(subject) - VIA15_tbl.RT_CC(subject);
   

        %% Demographics
        
        demo_idx = find(tbl.id == subject);
        if ~isempty(demo_idx)
            % Extract subject-specific information from the table row
            subjectInfo = tbl(demo_idx, :);
            
            % Integrate demographic information into subject_results
            VIA15_tbl.hgr_status{subject} = subjectInfo.hgr_status{1};
            VIA15_tbl.fhr_group{subject} = subjectInfo.fhr_group{1};
            VIA15_tbl.gender(subject) = subjectInfo.gender; % Adjust if coding is different
            VIA15_tbl.age(subject) = subjectInfo.age;
        end



    catch ME
        disp(['Error processing subject ' currsubject ': ' ME.message]);
    end
end

%% Save the results structure to a .mat file
writetable(VIA15_tbl,'/mnt/projects/VIA_MCA/nobackup/Clean_VIA15_Flanker_20_04.xlsx')


%% Save the results structure to a .mat file
%save('/mnt/projects/VIA_MCA/nobackup/Preprocessed Data/analysis_results.mat', 'results');

% figure;
% subplot(2,1,1);plot(timelock_con.time,timelock_con.avg([1 19 85 87],:));legend('Cz', 'Pz', 'Fz', 'FCz')                           % plot of the averages % Fz = 85
% title('Average of congruent trials')
% subplot(2,1,2);plot(timelock_incon.time,timelock_incon.avg([1 19 85 87],:));legend('Cz', 'Pz', 'Fz', 'FCz')                             % plot of the averages % Fz = 85
% title('Average of incongruent trials')

