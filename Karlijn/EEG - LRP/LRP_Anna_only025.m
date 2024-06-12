%% BP 

subject_BP = {'025'};
%different codes: '025',

for j = 1:numel(subject_BP)
load(['/mnt/projects/VIA11/EEG/Data/###_Flanker/EEG_analysis/0' subject_BP{j} '_data.mat'])
load(['/mnt/projects/VIA11/EEG/Data/###_Flanker/EEG_analysis/0' subject_BP{j} '_info.mat'])


trials_con_R=find(sum([accuracy_con,not(bad_trials_con)',(data_con.trialinfo==65291)],2)==3);               %%this gives the number of con and good trials? Thus, also the incorrect trials?
trials_incon_R=find(sum([accuracy_incon,not(bad_trials_incon)',(data_incon.trialinfo==65309)],2)==3);

trials_con_L=find(sum([accuracy_con,not(bad_trials_con)',(data_con.trialinfo==65311)],2)==3);               %%this gives the number of con and good trials? Thus, also the incorrect trials?
trials_incon_L=find(sum([accuracy_incon,not(bad_trials_incon)',(data_incon.trialinfo==65321)],2)==3);


cfg = [];
cfg.trials = trials_con_R;
timelock_con_R_BP(j).LRP = ft_timelockanalysis(cfg,data_con); % trials averaging

timelock_con_R_BP(j).LRP.avg(1:128,:) = ft_preproc_rereference(timelock_con_R_BP(j).LRP.avg(1:128,:)); % average referencing

cfg = [];
cfg.baseline = [-0.5 -0.1];
timelock_con_R_BP(j).LRP = ft_timelockbaseline(cfg, timelock_con_R_BP(j).LRP); % baseline correction


cfg = [];
cfg.trials = trials_incon_R;
timelock_incon_R_BP(j).LRP = ft_timelockanalysis(cfg,data_incon); % trials averaging

timelock_incon_R_BP(j).LRP.avg(1:128,:) = ft_preproc_rereference(timelock_incon_R_BP(j).LRP.avg(1:128,:)); % average referencing

cfg = [];
cfg.baseline = [-0.5 -0.1];
timelock_incon_R_BP(j).LRP = ft_timelockbaseline(cfg, timelock_incon_R_BP(j).LRP); % baseline correction

cfg = [];
cfg.trials = trials_con_L;
timelock_con_L_BP(j).LRP = ft_timelockanalysis(cfg,data_con); % trials averaging

timelock_con_L_BP(j).LRP.avg(1:128,:) = ft_preproc_rereference(timelock_con_L_BP(j).LRP.avg(1:128,:)); % average referencing

cfg = [];
cfg.baseline = [-0.5 -0.1];
timelock_con_L_BP(j).LRP = ft_timelockbaseline(cfg, timelock_con_L_BP(j).LRP); % baseline correction


cfg = [];
cfg.trials = trials_incon_L;
timelock_incon_L_BP(j).LRP = ft_timelockanalysis(cfg,data_incon); % trials averaging

timelock_incon_L_BP(j).LRP.avg(1:128,:) = ft_preproc_rereference(timelock_incon_L_BP(j).LRP.avg(1:128,:)); % average referencing

cfg = [];
cfg.baseline = [-0.5 -0.1];
timelock_incon_L_BP(j).LRP = ft_timelockbaseline(cfg, timelock_incon_L_BP(j).LRP); % baseline correction


cfg = [];
cfg.channelcmb = {'D19' 'B22'};    % C3 = electrode 115 and C4 = electrode 55
end 



for i = 1:numel(subject_BP)   
LRP_con_BP(i).LRP = ft_lateralizedpotential(cfg,timelock_con_R_BP(i).LRP,timelock_con_L_BP(i).LRP); %TURNED AROUND

LRP_incon_BP(i).LRP = ft_lateralizedpotential(cfg,timelock_incon_R_BP(i).LRP,timelock_incon_L_BP(i).LRP); %TURNED AROUND
     
end



subject_BP = [subject_BP, subject_BP_025];
LRP_con_BP = [LRP_con_BP, LRP_con_BP_025];
LRP_incon_BP = [LRP_incon_BP, LRP_incon_BP_025];

grandavg_con_LRP_BP = ft_timelockgrandaverage(cfg, LRP_con_BP(:).LRP);
grandavg_incon_LRP_BP = ft_timelockgrandaverage(cfg, LRP_incon_BP(:).LRP);



