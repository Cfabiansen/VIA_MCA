clear;

addpath '/mrhome/annavlvt/matlab/fieldtrip-20170827/'
ft_defaults;

%% PBC 

subject_K = {'353','365','374','402','405','407','416','436','448','449', ...
    '462','465','471','499','504','508','509'}; % controls in N=34

for j = 1:numel(subject_K)
load(['/mnt/projects/VIAKH/EEG/Data/###_Flanker/EEG_analysis/0/' subject_K{j} '_data.mat']) % for N=35
load(['/mnt/projects/VIAKH/EEG/Data/###_Flanker/EEG_analysis/0/' subject_K{j} '_info.mat']) % for N=35

trials_con_R=find(sum([accuracy_con,not(bad_trials_con)',(data_con.trialinfo==65291)],2)==3);               %%this gives the number of con and good trials? Thus, also the incorrect trials?
trials_incon_R=find(sum([accuracy_incon,not(bad_trials_incon)',(data_incon.trialinfo==65301)],2)==3);

trials_con_L=find(sum([accuracy_con,not(bad_trials_con)',(data_con.trialinfo==65311)],2)==3);               %%this gives the number of con and good trials? Thus, also the incorrect trials?
trials_incon_L=find(sum([accuracy_incon,not(bad_trials_incon)',(data_incon.trialinfo==65321)],2)==3);

% Right
cfg = [];
cfg.trials = trials_con_R;
timelock_con_R_K(j).LRP = ft_timelockanalysis(cfg,data_con); % trials averaging

timelock_con_R_K(j).LRP.avg(1:128,:) = ft_preproc_rereference(timelock_con_R_K(j).LRP.avg(1:128,:)); % average referencing

cfg = [];
cfg.baseline = [-0.5 -0.1];
timelock_con_R_K(j).LRP = ft_timelockbaseline(cfg, timelock_con_R_K(j).LRP); % baseline correction


cfg = [];
cfg.trials = trials_incon_R;
timelock_incon_R_K(j).LRP = ft_timelockanalysis(cfg,data_incon); % trials averaging

timelock_incon_R_K(j).LRP.avg(1:128,:) = ft_preproc_rereference(timelock_incon_R_K(j).LRP.avg(1:128,:)); % average referencing

cfg = [];
cfg.baseline = [-0.5 -0.1];
timelock_incon_R_K(j).LRP = ft_timelockbaseline(cfg, timelock_incon_R_K(j).LRP); % baseline correction

% Left
cfg = [];
cfg.trials = trials_con_L;
timelock_con_L_K(j).LRP = ft_timelockanalysis(cfg,data_con); % trials averaging

timelock_con_L_K(j).LRP.avg(1:128,:) = ft_preproc_rereference(timelock_con_L_K(j).LRP.avg(1:128,:)); % average referencing

cfg = [];
cfg.baseline = [-0.5 -0.1];
timelock_con_L_K(j).LRP = ft_timelockbaseline(cfg, timelock_con_L_K(j).LRP); % baseline correction


cfg = [];
cfg.trials = trials_incon_L;
timelock_incon_L_K(j).LRP = ft_timelockanalysis(cfg,data_incon); % trials averaging

timelock_incon_L_K(j).LRP.avg(1:128,:) = ft_preproc_rereference(timelock_incon_L_K(j).LRP.avg(1:128,:)); % average referencing

cfg = [];
cfg.baseline = [-0.5 -0.1];
timelock_incon_L_K(j).LRP = ft_timelockbaseline(cfg, timelock_incon_L_K(j).LRP); % baseline correction


cfg = [];
cfg.channelcmb = {'D19' 'B22'};    % D19 = C3 = electrode 115 and B22 = C4 = electrode 54
end 

% Right vs Left
for i = 1:numel(subject_K)   
LRP_con_K(i).LRP = ft_lateralizedpotential(cfg,timelock_con_R_K(i).LRP,timelock_con_L_K(i).LRP); %TURNED AROUND

LRP_incon_K(i).LRP = ft_lateralizedpotential(cfg,timelock_incon_R_K(i).LRP,timelock_incon_L_K(i).LRP); %TURNED AROUND
     
end

grandavg_con_LRP_K = ft_timelockgrandaverage(cfg, LRP_con_K(:).LRP);
grandavg_incon_LRP_K = ft_timelockgrandaverage(cfg, LRP_incon_K(:).LRP);

figure;rectangle('Position',[0.25 -2.5 0.10 6],'FaceColor',[0.9 0.9 0.9]);hold on
plot(grandavg_con_LRP_K.time,grandavg_con_LRP_K.avg);hold on
plot(grandavg_incon_LRP_K.time,grandavg_incon_LRP_K.avg);
legend('con','incon');
title('LRP in PBC');

save(['/mnt/projects/VIAKH/EEG/Data/###_Flanker/EEG_LRP/PBC_LRP_data_N34.mat'], 'subject_K', 'timelock_con_L_K', 'timelock_con_R_K', 'timelock_incon_L_K', 'timelock_con_R_K', 'grandavg_con_LRP_K', 'grandavg_incon_LRP_K', 'LRP_con_K', 'LRP_incon_K');
%save(['/mnt/projects/VIA11/EEG/Anna/Flanker_LRP/PBC_LRP_data.mat'], 'subject_K', 'timelock_con_L_K', 'timelock_con_R_K', 'timelock_incon_L_K', 'timelock_con_R_K', 'grandavg_con_LRP_K', 'grandavg_incon_LRP_K', 'LRP_con_K', 'LRP_incon_K');

%% by hand 
%lrp.avg(end+1,:) = 1/2 * ((erpC3R - erpC4R) + (erpC4L - erpC3L));



%% FHR_SZ

subject_SZ = {'322','334','350','370','408','411','418','421','426','428', ...
    '469','502'} % SZ in N=34

for j = 1:numel(subject_SZ)
load(['/mnt/projects/VIAKH/EEG/Data/###_Flanker/EEG_analysis/0/' subject_SZ{j} '_data.mat']) % for N=34
load(['/mnt/projects/VIAKH/EEG/Data/###_Flanker/EEG_analysis/0/' subject_SZ{j} '_info.mat']) % for N=34


trials_con_R=find(sum([accuracy_con,not(bad_trials_con)',(data_con.trialinfo==65291)],2)==3);               %%this gives the number of con and good trials? Thus, also the incorrect trials?
trials_incon_R=find(sum([accuracy_incon,not(bad_trials_incon)',(data_incon.trialinfo==65301)],2)==3);

trials_con_L=find(sum([accuracy_con,not(bad_trials_con)',(data_con.trialinfo==65311)],2)==3);               %%this gives the number of con and good trials? Thus, also the incorrect trials?
trials_incon_L=find(sum([accuracy_incon,not(bad_trials_incon)',(data_incon.trialinfo==65321)],2)==3);


cfg = [];
cfg.trials = trials_con_R;
timelock_con_R_SZ(j).LRP = ft_timelockanalysis(cfg,data_con); % trials averaging

timelock_con_R_SZ(j).LRP.avg(1:128,:) = ft_preproc_rereference(timelock_con_R_SZ(j).LRP.avg(1:128,:)); % average referencing

cfg = [];
cfg.baseline = [-0.5 -0.1];
timelock_con_R_SZ(j).LRP = ft_timelockbaseline(cfg, timelock_con_R_SZ(j).LRP); % baseline correction


cfg = [];
cfg.trials = trials_incon_R;
timelock_incon_R_SZ(j).LRP = ft_timelockanalysis(cfg,data_incon); % trials averaging

timelock_incon_R_SZ(j).LRP.avg(1:128,:) = ft_preproc_rereference(timelock_incon_R_SZ(j).LRP.avg(1:128,:)); % average referencing

cfg = [];
cfg.baseline = [-0.5 -0.1];
timelock_incon_R_SZ(j).LRP = ft_timelockbaseline(cfg, timelock_incon_R_SZ(j).LRP); % baseline correction

cfg = [];
cfg.trials = trials_con_L;
timelock_con_L_SZ(j).LRP = ft_timelockanalysis(cfg,data_con); % trials averaging

timelock_con_L_SZ(j).LRP.avg(1:128,:) = ft_preproc_rereference(timelock_con_L_SZ(j).LRP.avg(1:128,:)); % average referencing

cfg = [];
cfg.baseline = [-0.5 -0.1];
timelock_con_L_SZ(j).LRP = ft_timelockbaseline(cfg, timelock_con_L_SZ(j).LRP); % baseline correction


cfg = [];
cfg.trials = trials_incon_L;
timelock_incon_L_SZ(j).LRP = ft_timelockanalysis(cfg,data_incon); % trials averaging

timelock_incon_L_SZ(j).LRP.avg(1:128,:) = ft_preproc_rereference(timelock_incon_L_SZ(j).LRP.avg(1:128,:)); % average referencing

cfg = [];
cfg.baseline = [-0.5 -0.1];
timelock_incon_L_SZ(j).LRP = ft_timelockbaseline(cfg, timelock_incon_L_SZ(j).LRP); % baseline correction


cfg = [];
cfg.channelcmb = {'D19' 'B22'};    % C3 = electrode 115 and C4 = electrode 55
end 

for i = 1:numel(subject_SZ)   
LRP_con_SZ(i).LRP = ft_lateralizedpotential(cfg,timelock_con_R_SZ(i).LRP,timelock_con_L_SZ(i).LRP); %TURNED AROUND

LRP_incon_SZ(i).LRP = ft_lateralizedpotential(cfg,timelock_incon_R_SZ(i).LRP,timelock_incon_L_SZ(i).LRP); %TURNED AROUND
     
end

grandavg_con_LRP_SZ = ft_timelockgrandaverage(cfg, LRP_con_SZ(:).LRP);
grandavg_incon_LRP_SZ = ft_timelockgrandaverage(cfg, LRP_incon_SZ(:).LRP);


save(['/mnt/projects/VIAKH/EEG/Data/###_Flanker/EEG_LRP/SZ_LRP_data_N34.mat'], 'subject_SZ', 'timelock_con_L_SZ', 'timelock_con_R_SZ', 'timelock_incon_L_SZ', 'timelock_con_R_SZ', 'grandavg_con_LRP_SZ', 'grandavg_incon_LRP_SZ', 'LRP_con_SZ', 'LRP_incon_SZ');

figure;rectangle('Position',[0.25 -2.5 0.10 4],'FaceColor',[0.9 0.9 0.9]);hold on
plot(grandavg_con_LRP_SZ.time,grandavg_con_LRP_SZ.avg);hold on
plot(grandavg_incon_LRP_SZ.time,grandavg_incon_LRP_SZ.avg);
legend('con','incon');
title('LRP in FHR-SZ');

%% FHR_BP

subject_BP = {'341', '410', '460', '492', '495'} % BP in N=34

for j = 1:numel(subject_BP)
load(['/mnt/projects/VIAKH/EEG/Data/###_Flanker/EEG_analysis/0/' subject_BP{j} '_data.mat']) % for N=34
load(['/mnt/projects/VIAKH/EEG/Data/###_Flanker/EEG_analysis/0/' subject_BP{j} '_info.mat']) % for N=34


trials_con_R=find(sum([accuracy_con,not(bad_trials_con)',(data_con.trialinfo==65291)],2)==3);               %%this gives the number of con and good trials? Thus, also the incorrect trials?
trials_incon_R=find(sum([accuracy_incon,not(bad_trials_incon)',(data_incon.trialinfo==65301)],2)==3);

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

grandavg_con_LRP_BP = ft_timelockgrandaverage(cfg, LRP_con_BP(:).LRP);
grandavg_incon_LRP_BP = ft_timelockgrandaverage(cfg, LRP_incon_BP(:).LRP);

save(['/mnt/projects/VIAKH/EEG/Data/###_Flanker/EEG_LRP/BP_LRP_data_N34.mat'], 'subject_BP', 'timelock_con_L_BP', 'timelock_con_R_BP', 'timelock_incon_L_BP', 'timelock_con_R_BP', 'grandavg_con_LRP_BP', 'grandavg_incon_LRP_BP', 'LRP_con_BP', 'LRP_incon_BP');

figure;rectangle('Position',[0.25 -4 0.10 6],'FaceColor',[0.9 0.9 0.9]);hold on
plot(grandavg_con_LRP_BP.time,grandavg_con_LRP_BP.avg);hold on
plot(grandavg_incon_LRP_BP.time,grandavg_incon_LRP_BP.avg);
legend('con','incon');
title('LRP in FHR-BP');


%% FHR (SZ + BP) combined

subject_FHR = {'322','334','350','370','408','411','418','421','426','428', ...
    '469','502', '341', '410', '460', '492', '495'} % SZ + BP in N=34

for j = 1:numel(subject_FHR)
load(['/mnt/projects/VIAKH/EEG/Data/###_Flanker/EEG_analysis/0/' subject_FHR{j} '_data.mat']) % for N=34
load(['/mnt/projects/VIAKH/EEG/Data/###_Flanker/EEG_analysis/0/' subject_FHR{j} '_info.mat']) % for N=34


trials_con_R=find(sum([accuracy_con,not(bad_trials_con)',(data_con.trialinfo==65291)],2)==3);               %%this gives the number of con and good trials? Thus, also the incorrect trials?
trials_incon_R=find(sum([accuracy_incon,not(bad_trials_incon)',(data_incon.trialinfo==65301)],2)==3);

trials_con_L=find(sum([accuracy_con,not(bad_trials_con)',(data_con.trialinfo==65311)],2)==3);               %%this gives the number of con and good trials? Thus, also the incorrect trials?
trials_incon_L=find(sum([accuracy_incon,not(bad_trials_incon)',(data_incon.trialinfo==65321)],2)==3);

% Right
cfg = [];
cfg.trials = trials_con_R;
timelock_con_R_FHR(j).LRP = ft_timelockanalysis(cfg,data_con); % trials averaging

timelock_con_R_FHR(j).LRP.avg(1:128,:) = ft_preproc_rereference(timelock_con_R_FHR(j).LRP.avg(1:128,:)); % average referencing

cfg = [];
cfg.baseline = [-0.5 -0.1];
timelock_con_R_FHR(j).LRP = ft_timelockbaseline(cfg, timelock_con_R_FHR(j).LRP); % baseline correction


cfg = [];
cfg.trials = trials_incon_R;
timelock_incon_R_FHR(j).LRP = ft_timelockanalysis(cfg,data_incon); % trials averaging

timelock_incon_R_FHR(j).LRP.avg(1:128,:) = ft_preproc_rereference(timelock_incon_R_FHR(j).LRP.avg(1:128,:)); % average referencing

cfg = [];
cfg.baseline = [-0.5 -0.1];
timelock_incon_R_FHR(j).LRP = ft_timelockbaseline(cfg, timelock_incon_R_FHR(j).LRP); % baseline correction


% Left
cfg = [];
cfg.trials = trials_con_L;
timelock_con_L_FHR(j).LRP = ft_timelockanalysis(cfg,data_con); % trials averaging

timelock_con_L_FHR(j).LRP.avg(1:128,:) = ft_preproc_rereference(timelock_con_L_FHR(j).LRP.avg(1:128,:)); % average referencing

cfg = [];
cfg.baseline = [-0.5 -0.1];
timelock_con_L_FHR(j).LRP = ft_timelockbaseline(cfg, timelock_con_L_FHR(j).LRP); % baseline correction


cfg = [];
cfg.trials = trials_incon_L;
timelock_incon_L_FHR(j).LRP = ft_timelockanalysis(cfg,data_incon); % trials averaging

timelock_incon_L_FHR(j).LRP.avg(1:128,:) = ft_preproc_rereference(timelock_incon_L_FHR(j).LRP.avg(1:128,:)); % average referencing

cfg = [];
cfg.baseline = [-0.5 -0.1];
timelock_incon_L_FHR(j).LRP = ft_timelockbaseline(cfg, timelock_incon_L_FHR(j).LRP); % baseline correction


cfg = [];
cfg.channelcmb = {'D19' 'B22'};    % C3 = electrode 115 and C4 = electrode 55
end 

for i = 1:numel(subject_FHR)   
LRP_con_FHR(i).LRP = ft_lateralizedpotential(cfg,timelock_con_R_FHR(i).LRP,timelock_con_L_FHR(i).LRP); %TURNED AROUND

LRP_incon_FHR(i).LRP = ft_lateralizedpotential(cfg,timelock_incon_R_FHR(i).LRP,timelock_incon_L_FHR(i).LRP); %TURNED AROUND
     
end

grandavg_con_LRP_FHR = ft_timelockgrandaverage(cfg, LRP_con_FHR(:).LRP);
grandavg_incon_LRP_FHR = ft_timelockgrandaverage(cfg, LRP_incon_FHR(:).LRP);

save(['/mnt/projects/VIAKH/EEG/Data/###_Flanker/EEG_LRP/FHR_LRP_data_N34.mat'], 'subject_FHR', 'timelock_con_L_FHR', 'timelock_con_R_FHR', 'timelock_incon_L_FHR', 'timelock_con_R_FHR', 'grandavg_con_LRP_FHR', 'grandavg_incon_LRP_FHR', 'LRP_con_FHR', 'LRP_incon_FHR');

figure;rectangle('Position',[0.25 -2.5 0.10 6],'FaceColor',[0.9 0.9 0.9]);hold on
plot(grandavg_con_LRP_FHR.time,grandavg_con_LRP_FHR.avg);hold on
plot(grandavg_incon_LRP_FHR.time,grandavg_incon_LRP_FHR.avg);
legend('con','incon');
title('LRP in FHR');

%% load LRPs

load(['/mnt/projects/VIAKH/EEG/Data/###_Flanker/EEG_LRP/FHR_LRP_data_N34.mat'], 'subject_FHR', 'timelock_con_L_FHR', 'timelock_con_R_FHR', 'timelock_incon_L_FHR', 'timelock_con_R_FHR', 'grandavg_con_LRP_FHR', 'grandavg_incon_LRP_FHR', 'LRP_con_FHR', 'LRP_incon_FHR');
load(['/mnt/projects/VIAKH/EEG/Data/###_Flanker/EEG_LRP/PBC_LRP_data_N34.mat'], 'subject_K', 'timelock_con_L_K', 'timelock_con_R_K', 'timelock_incon_L_K', 'timelock_con_R_K', 'grandavg_con_LRP_K', 'grandavg_incon_LRP_K', 'LRP_con_K', 'LRP_incon_K');


%% plot con and incon separate with all three groups - 8 time bins 

figure,subplot(2,1,1);rectangle('Position',[0.20 -3.5 0.10 6],'FaceColor',[1 1 1]);hold on
rectangle('Position',[0.30 -3.5 0.10 6],'FaceColor',[0.9 0.9 0.9]);hold on
rectangle('Position',[0.40 -3.5 0.10 6],'FaceColor',[0.8 0.8 0.8]);hold on
rectangle('Position',[0.50 -3.5 0.10 6],'FaceColor',[0.7 0.7 0.7]);hold on
plot(grandavg_con_LRP_K.time,grandavg_con_LRP_K.avg,'color',[0.0 0.6 0.0],'linewidth',3);hold on
plot(grandavg_con_LRP_FHR.time,grandavg_con_LRP_FHR.avg,'color',[1.0 0.2 0.0],'linewidth',3);hold on
legend('Controls', 'FHR');
title('Congruent condition');
xlim([-0.2 1]);
ylim([-3.5 3]);
xlabel('Time (s)');
ylabel('Voltage (microVolt)');hold on

subplot(2,1,2);rectangle('Position',[0.20 -3.5 0.10 6],'FaceColor',[1 1 1]);hold on
rectangle('Position',[0.30 -3.5 0.10 6],'FaceColor',[0.9 0.9 0.9]);hold on
rectangle('Position',[0.40 -3.5 0.10 6],'FaceColor',[0.8 0.8 0.8]);hold on
rectangle('Position',[0.50 -3.5 0.10 6],'FaceColor',[0.7 0.7 0.7]);hold on
plot(grandavg_incon_LRP_K.time,grandavg_incon_LRP_K.avg,'color',[0.0 0.6 0.0],'linewidth',3);hold on
plot(grandavg_incon_LRP_FHR.time,grandavg_incon_LRP_FHR.avg,'color',[1.0 0.2 0.0],'linewidth',3);hold on
legend('Controls', 'FHR');
title('Incongruent condition');
xlim([-0.2 1]);
ylim([-3.5 3]);
xlabel('Time (s)');
ylabel('Voltage (microVolt)');

%% all in one - 8 time bins 

figure;rectangle('Position',[0.20 -3.5 0.10 7],'FaceColor',[1 1 1]);hold on
rectangle('Position',[0.30 -3.5 0.10 7],'FaceColor',[0.9 0.9 0.9]);hold on
rectangle('Position',[0.40 -3.5 0.10 7],'FaceColor',[0.8 0.8 0.8]);hold on
rectangle('Position',[0.50 -3.5 0.10 7],'FaceColor',[0.7 0.7 0.7]);hold on
plot(grandavg_con_LRP_K.time,grandavg_con_LRP_K.avg,'color',[0.0 0.6 0.0],'linewidth',3);hold on
plot(grandavg_con_LRP_K.time,grandavg_incon_LRP_K.avg,'color',[0.0 0.6 0.0],'linewidth',3,'linestyle',':');hold on
plot(grandavg_con_LRP_FHR.time,grandavg_con_LRP_FHR.avg,'color',[1.0 0.8 0.0],'linewidth',3);hold on 
plot(grandavg_incon_LRP_FHR.time,grandavg_incon_LRP_FHR.avg,'color',[1.0 0.8 0.0],'linewidth',3,'linestyle',':');hold on
legend('PBC (con)', 'PBC (incon)','FHR (con)', 'FHR (incon)');                
title('Lateralized Readiness Potential');
ax = gca;
ax.FontSize = 14;
xlim([-0.2 1]);
ylim([-3.5 3]);
xlabel('Time (s)');
ylabel('Voltage (microVolt)');

%% total group for figures

subject_C = [subject_K, subject_FHR];
LRP_con_C = [LRP_con_K, LRP_con_FHR]; 
LRP_incon_C = [LRP_incon_K, LRP_incon_FHR];

%grandavg_con_LRP_C = ft_timelockgrandaverage(cfg, LRP_con_C(:).LRP);
%grandavg_incon_LRP_C = ft_timelockgrandaverage(cfg, LRP_incon_C(:).LRP);

% one child
% figure;rectangle('Position',[0.2471 -5 0.10 8],'FaceColor',[0.8 1.0 0.8]);hold on
% rectangle('Position',[0.4993 -5 0.10 8],'FaceColor',[0.8 1.0 0.8]);hold on
% rectangle('Position',[0.3389 -5 0.10 8],'FaceColor',[1.0 0.6 0.6]);hold on
% rectangle('Position',[0.6399 -5 0.10 8],'FaceColor',[1.0 0.6 0.6]);hold on
% plot(LRP_con_C(88).LRP.time,LRP_con_C(88).LRP.avg, 'g','linewidth',1);hold on
% plot(LRP_incon_C(88).LRP.time,LRP_incon_C(88).LRP.avg, 'r', 'linewidth',1');
% legend('con','incon');
% title('LRP in one child');
% xlim([-0.2 1]);
% ylim([-8 10]);
% xlabel('Time (s)');
% ylabel('Voltage (microVolt)');

% congruent and incongruent for fhr: visually pick TW for FHR N=17 (KH)
figure;subplot(2,1,1);rectangle('Position',[0.1114 -4 0.20 6],'FaceColor',[0.8 1.0 0.8]);hold on
rectangle('Position',[0.4476 -4 0.20 6],'FaceColor',[0.8 1.0 0.8]);hold on
plot(grandavg_con_LRP_FHR.time,grandavg_con_LRP_FHR.avg, 'g','linewidth',2);hold on
plot(grandavg_incon_LRP_FHR.time,grandavg_incon_LRP_FHR.avg, 'r', 'linewidth',2');hold on
legend('con','incon');
title('LRP in FHR');
%xlim([0.2 1]);
%ylim([-4 3]);
xlabel('Time (s)');
ylabel('Voltage (microVolt)');hold on;

subplot(2,1,2);rectangle('Position',[0.2591 -4 0.20 6],'FaceColor',[1.0 0.6 0.6]);hold on
rectangle('Position',[0.5951 -4 0.20 6],'FaceColor',[1.0 0.6 0.6]);hold on
plot(grandavg_con_LRP_FHR.time,grandavg_con_LRP_FHR.avg, 'g','linewidth',2);hold on
plot(grandavg_incon_LRP_FHR.time,grandavg_incon_LRP_FHR.avg, 'r', 'linewidth',2');hold on
legend('con','incon');
title('LRP in FHR');
%xlim([0.2 1]);
%ylim([-4 3]);
xlabel('Time (s)');
ylabel('Voltage (microVolt)');

% congruent and incongruent for pbc : visually pick TW for PBC N=17 (KH)
figure;subplot(2,1,1);rectangle('Position',[0.1837 -4 0.20 6],'FaceColor',[0.8 1.0 0.8]);hold on
rectangle('Position',[0.4654 -4 0.20 6],'FaceColor',[0.8 1.0 0.8]);hold on
plot(grandavg_con_LRP_K.time,grandavg_con_LRP_K.avg, 'g','linewidth',2);hold on
plot(grandavg_incon_LRP_K.time,grandavg_incon_LRP_K.avg, 'r', 'linewidth',2');
legend('con','incon');
title('LRP in controls');
%xlim([-0.2 1]);
%ylim([-3 3]);
xlabel('Time (s)');
ylabel('Voltage (microVolt)');hold on

subplot(2,1,2);rectangle('Position',[0.2987 -4 0.20 6],'FaceColor',[1.0 0.6 0.6]);hold on
rectangle('Position',[0.5829 -4 0.20 6],'FaceColor',[1.0 0.6 0.6]);hold on
plot(grandavg_con_LRP_K.time,grandavg_con_LRP_K.avg, 'g','linewidth',2);hold on
plot(grandavg_incon_LRP_K.time,grandavg_incon_LRP_K.avg, 'r', 'linewidth',2');
legend('con','incon');
title('LRP in controls');
%xlim([-0.2 1]);
%ylim([-3 3]);
xlabel('Time (s)');
ylabel('Voltage (microVolt)');

% grandaverage n=34 children 
figure;rectangle('Position',[0.2471 -4 0.10 7],'FaceColor',[0.8 1.0 0.8]);hold on
rectangle('Position',[0.4993 -4 0.10 7],'FaceColor',[0.8 1.0 0.8]);hold on
rectangle('Position',[0.3389 -4 0.10 7],'FaceColor',[1.0 0.6 0.6]);hold on
rectangle('Position',[0.6399 -4 0.10 7],'FaceColor',[1.0 0.6 0.6]);hold on
plot(grandavg_con_LRP_C.time,grandavg_con_LRP_C.avg, 'g','linewidth',3);hold on
plot(grandavg_incon_LRP_C.time,grandavg_incon_LRP_C.avg, 'r', 'linewidth',3');
legend('con','incon');
title('LRP in all 34 children');
%xlim([-0.2 1]);
%ylim([-3.5 2]);
xlabel('Time (s)');
ylabel('Voltage (microVolt)');

%% 04-12-2019 Mean peak CON positive and negative peak - peak-to-peak amplitude

CON_PP = [0.2471 0.3471];           %timewindow of 100 ms; thus -50 ms and +50 ms around the peak. 
CON_NP = [0.4993 0.5993];

CON_PP_avg = find(grandavg_con_LRP_C.time >= CON_PP(1) & grandavg_con_LRP_C.time <= CON_PP(2));
CON_NP_avg = find(grandavg_con_LRP_C.time >= CON_NP(1) & grandavg_con_LRP_C.time <= CON_NP(2));

for m = 1: numel(subject_C) %5
    values_CON_PP(m)  = mean(LRP_con_C(m).LRP.avg(CON_PP_avg));
    values_CON_NP(m)  = mean(LRP_con_C(m).LRP.avg(CON_NP_avg));
end

%% 04-12-2019 Mean peak INCON positive and negative peak - peak-to-peak amplitude

INCON_PP = [0.3389 0.4389];           %timewindow of 100 ms; thus -50 ms and +50 ms around the peak. 
INCON_NP = [0.6399 0.7399];

INCON_PP_avg = find(grandavg_incon_LRP_C.time >= INCON_PP(1) & grandavg_incon_LRP_C.time <= INCON_PP(2));
INCON_NP_avg = find(grandavg_incon_LRP_C.time >= INCON_NP(1) & grandavg_incon_LRP_C.time <= INCON_NP(2));

for m = 1: numel(subject_C) %5
    values_INCON_PP(m)  = mean(LRP_incon_C(m).LRP.avg(INCON_PP_avg));
    values_INCON_NP(m)  = mean(LRP_incon_C(m).LRP.avg(INCON_NP_avg));
end

%% Mean amplitudes calculation for LRP

timewindow1_LRP_con = [0.200 0.300];

timewindow2_LRP_con = [0.300 0.400];

timewindow3_LRP_con = [0.400 0.500];

timewindow4_LRP_con = [0.500 0.600];

timewindow5_LRP_con = [0.600 0.700];

timewindow6_LRP_con = [0.700 0.800];

% find the time points for the effect of interest in the grand average data
timesel1_LRP_incon = find(grandavg_incon_LRP_C.time >= timewindow1_LRP_con(1) & grandavg_incon_LRP_C.time <= timewindow1_LRP_con(2));
timesel1_LRP_con = find(grandavg_con_LRP_C.time >= timewindow1_LRP_con(1) & grandavg_con_LRP_C.time <= timewindow1_LRP_con(2));

timesel2_LRP_incon = find(grandavg_incon_LRP_C.time >= timewindow2_LRP_con(1) & grandavg_incon_LRP_C.time <= timewindow2_LRP_con(2));
timesel2_LRP_con = find(grandavg_con_LRP_C.time >= timewindow2_LRP_con(1) & grandavg_con_LRP_C.time <= timewindow2_LRP_con(2));

timesel3_LRP_incon = find(grandavg_incon_LRP_C.time >= timewindow3_LRP_con(1) & grandavg_incon_LRP_C.time <= timewindow3_LRP_con(2));
timesel3_LRP_con = find(grandavg_con_LRP_C.time >= timewindow3_LRP_con(1) & grandavg_con_LRP_C.time <= timewindow3_LRP_con(2));

timesel4_LRP_incon = find(grandavg_incon_LRP_C.time >= timewindow4_LRP_con(1) & grandavg_incon_LRP_C.time <= timewindow4_LRP_con(2));
timesel4_LRP_con = find(grandavg_con_LRP_C.time >= timewindow4_LRP_con(1) & grandavg_con_LRP_C.time <= timewindow4_LRP_con(2));

timesel5_LRP_incon = find(grandavg_incon_LRP_C.time >= timewindow5_LRP_con(1) & grandavg_incon_LRP_C.time <= timewindow5_LRP_con(2));
timesel5_LRP_con = find(grandavg_con_LRP_C.time >= timewindow5_LRP_con(1) & grandavg_con_LRP_C.time <= timewindow5_LRP_con(2));

timesel6_LRP_incon = find(grandavg_incon_LRP_C.time >= timewindow6_LRP_con(1) & grandavg_incon_LRP_C.time <= timewindow6_LRP_con(2));
timesel6_LRP_con = find(grandavg_con_LRP_C.time >= timewindow6_LRP_con(1) & grandavg_con_LRP_C.time <= timewindow6_LRP_con(2));

% select the individual subject data from the time points and calculate the mean
for m = 1: numel(subject_C) %5
    values_LRP_incon_TW1(m)  = mean(LRP_incon_C(m).LRP.avg(timesel1_LRP_incon));
    values_LRP_con_TW1(m)  = mean(LRP_con_C(m).LRP.avg(timesel1_LRP_con));
end

for m = 1: numel(subject_C) %5
    values_LRP_incon_TW2(m)  = mean(LRP_incon_C(m).LRP.avg(timesel2_LRP_incon));
    values_LRP_con_TW2(m)  = mean(LRP_con_C(m).LRP.avg(timesel2_LRP_con));
end

for m = 1: numel(subject_C) %5
    values_LRP_incon_TW3(m)  = mean(LRP_incon_C(m).LRP.avg(timesel3_LRP_incon));
    values_LRP_con_TW3(m)  = mean(LRP_con_C(m).LRP.avg(timesel3_LRP_con));
end

for m = 1: numel(subject_C) %5
    values_LRP_incon_TW4(m)  = mean(LRP_incon_C(m).LRP.avg(timesel4_LRP_incon));
    values_LRP_con_TW4(m)  = mean(LRP_con_C(m).LRP.avg(timesel4_LRP_con));
end

for m = 1: numel(subject_C) %5
    values_LRP_incon_TW5(m)  = mean(LRP_incon_C(m).LRP.avg(timesel5_LRP_incon));
    values_LRP_con_TW5(m)  = mean(LRP_con_C(m).LRP.avg(timesel5_LRP_con));
end

for m = 1: numel(subject_C) %5
    values_LRP_incon_TW6(m)  = mean(LRP_incon_C(m).LRP.avg(timesel6_LRP_incon));
    values_LRP_con_TW6(m)  = mean(LRP_con_C(m).LRP.avg(timesel6_LRP_con));
end

%% Mean amplitude calculation for timewindow 150-850 ms

TW_large_LRP = [0.150 0.850];

TW_large_LRP_incon = find(grandavg_incon_LRP_C.time >= TW_large_LRP(1) & grandavg_incon_LRP_C.time <= TW_large_LRP(2));
TW_large_LRP_con = find(grandavg_con_LRP_C.time >= TW_large_LRP(1) & grandavg_con_LRP_C.time <= TW_large_LRP(2));

for m = 1: numel(subject_C) %5
    values_LRP_incon_TW_large(m)  = mean(LRP_incon_C(m).LRP.avg(TW_large_LRP_incon));
    values_LRP_con_TW_large(m)  = mean(LRP_con_C(m).LRP.avg(TW_large_LRP_con));
end


% %% Latency of LRP
% % Onset latency was defined as the time point
% % at which the voltage reached 50% of the peak
% % amplitude (this appears to be the optimal measure 
% % of onset time under many conditionsFsee Kiesel et al., 2008; 
% % Luck et al., 2006; Miller, Patterson, & Ulrich, 1998).
% 
% TW = [0.150 0.850];
% 
% TW_lat_incon = find(grandavg_incon_LRP_K.time >= TW(1) & grandavg_incon_LRP_K.time <= TW(2));
% TW_lat_con = find(grandavg_con_LRP_K.time >= TW(1) & grandavg_con_LRP_K.time <= TW(2));
% 
% for m = 1: numel(subject_K) %5
%     v1_peak_incon(m)  = min(LRP_incon_K(m).LRP.avg(TW_lat_incon));
%     v1_peak_con(m)  = min(LRP_con_K(m).LRP.avg(TW_lat_con));
% end 
% 
% for m = 1: numel(subject_K)
%     v2_onset_lat_con_A(m) = 0.5*v1_peak_con(m);
%     v2_onset_lat_incon_A(m) = 0.5*v1_peak_incon(m);
% end 
% 
% for m = 1: numel(subject_K) %5
%     temp  = find(LRP_incon_K(m).LRP.avg(TW_lat_incon) < v2_onset_lat_incon_A(m));          % incongruent trials
%     v3_LRPlat_incon(m)  = temp(m)+TW_lat_incon(1);
%     
%     temp  = find(LRP_con_K(m).LRP.avg(TW_lat_con) < v2_onset_lat_con_A(m));                    % congruent trials
%     v3_LRPlat_con(m)  = temp(m)+TW_lat_con(m);
% end
% 
% for m = 1: numel(subject_K)
%     v4LRP_OL_con(m) = LRP_con_K(m).LRP.time(v3_LRPlat_con(m));
%     v4LRP_OL_incon(m) = LRP_incon_K(m).LRP.time(v3_LRPlat_incon(m));
% end
% 
% for m = 130:140 %numel(subject_C) %5
%     temp  = find(LRP_incon_C(m).LRP.avg(TW_lat_incon) < v2_onset_lat_incon_A(m));          % incongruent trials
%     v31_LRPlat_incon(m)  = temp(m)+TW_lat_incon(m);
%     
%     temp  = find(LRP_con_C(m).LRP.avg(TW_lat_con) < v2_onset_lat_con_A(m));                    % congruent trials
%     v31_LRPlat_con(m)  = temp(m)+TW_lat_con(m);
% end
% 
% for m = 130:140 %numel(subject_C)
%     v41LRP_OL_con(m) = LRP_con_C(m).LRP.time(v31_LRPlat_con(m));
%     v41LRP_OL_incon(m) = LRP_incon_C(m).LRP.time(v31_LRPlat_incon(m));
% end
% 
% 
% %% 09-01-2020 FHR SZ check - larger mean amplitude 200 ms
% 
% %Multiple plots of individual data, congruent condition, SZ
% figure;
% for j = 1: numel(subject_SZ) %5 or number of subjects
%     subplot(7,9,j); %column, row, number of subject in total
%     % use the rectangle to indicate the time range used later
%     rectangle('Position',[0.1114 -4 0.20 7],'FaceColor',[0.2 1.0 0.2]);hold on
%     rectangle('Position',[0.4476 -4 0.20 7],'FaceColor',[0.8 1.0 0.8]);hold on
%     plot(LRP_con_SZ(j).LRP.time,LRP_con_SZ(j).LRP.avg);hold on
%     %xline(RT_CON_SZ(j),'m','LineWidth',2);hold on
%     title(strcat('con subject',num2str(j)))
%     xlim = [-0.5 1.0];
%     ylim = [-10 10];
% end
% 
% %Multiple plots of individual data, incongruent condition, SZ
% figure;
% for j = 1: numel(subject_SZ) %5 or number of subjects
%     subplot(7,9,j); %column, row, number of subject in total
%     % use the rectangle to indicate the time range used later
%     rectangle('Position',[0.2591 -4 0.20 7],'FaceColor',[0.2 1.0 0.2]);hold on
%     rectangle('Position',[0.5951 -4 0.20 7],'FaceColor',[0.8 1.0 0.8]);hold on
%     plot(LRP_incon_SZ(j).LRP.time,LRP_incon_SZ(j).LRP.avg);hold on
%     %xline(RT_INCON_SZ(j),'m','LineWidth',2);hold on
%     title(strcat('incon subject',num2str(j)))
%     xlim = [-0.5 1.0];
%     ylim = [-10 10];
% end

%% 09-01-2020 FHR BP check - larger mean amplitude 200 ms

%Multiple plots of individual data, congruent condition, BP
figure;
for j = 1: numel(subject_BP) %5 or number of subjects
    subplot(5,9,j); %column, row, number of subject in total
    % use the rectangle to indicate the time range used later
    rectangle('Position',[0.1783 -4 0.20 7],'FaceColor',[0.2 1.0 0.2]);hold on
    rectangle('Position',[0.4505 -4 0.20 7],'FaceColor',[0.8 1.0 0.8]);hold on
    plot(LRP_con_BP(j).LRP.time,LRP_con_BP(j).LRP.avg);hold on
    %xline(RT_CON_BP(j),'m','LineWidth',2);hold on
    title(strcat('con subject',num2str(j)))
    xlim = [-0.5 1.0];
    ylim = [-10 10];
end

%Multiple plots of individual data, incongruent condition, BP
figure;
for j = 1: numel(subject_BP) %5 or number of subjects
    subplot(5,9,j); %column, row, number of subject in total
    % use the rectangle to indicate the time range used later
    rectangle('Position',[0.2862 -4 0.20 7],'FaceColor',[0.2 1.0 0.2]);hold on
    rectangle('Position',[0.6214 -4 0.20 7],'FaceColor',[0.8 1.0 0.8]);hold on
    plot(LRP_incon_BP(j).LRP.time,LRP_incon_BP(j).LRP.avg);hold on
    %xline(RT_INCON_BP(j),'m','LineWidth',2);hold on
    title(strcat('incon subject',num2str(j)))
    xlim = [-0.5 1.0];
    ylim = [-10 10];
end

%% 09-01-2020 FHR BP check - larger mean amplitude 200 ms

%Multiple plots of individual data, congruent condition, PBC
figure;
for j = 1: numel(subject_K) %5 or number of subjects
    subplot(5,8,j); %column, row, number of subject in total
    % use the rectangle to indicate the time range used later
    rectangle('Position',[0.1837 -4 0.20 7],'FaceColor',[0.2 1.0 0.2]);hold on
    rectangle('Position',[0.4654 -4 0.20 7],'FaceColor',[0.8 1.0 0.8]);hold on
    plot(LRP_con_K(j).LRP.time,LRP_con_K(j).LRP.avg);hold on
    title(strcat('con subject',num2str(j)))
    xlim = [-0.5 1.0];
    ylim = [-10 10];
end

%Multiple plots of individual data, incongruent condition, PBC
figure;
for j = 1: numel(subject_K) %5 or number of subjects
    subplot(5,8,j); %column, row, number of subject in total
    % use the rectangle to indicate the time range used later
    rectangle('Position',[0.2987 -4 0.20 7],'FaceColor',[0.2 1.0 0.2]);hold on
    rectangle('Position',[0.5829 -4 0.20 7],'FaceColor',[0.8 1.0 0.8]);hold on
    plot(LRP_incon_K(j).LRP.time,LRP_incon_K(j).LRP.avg);hold on
    title(strcat('incon subject',num2str(j)))
    xlim = [-0.5 1.0];
    ylim = [-10 10];
end

%% 09-01-2020 peak-to-peak amplitude - LRP - FHR !

%congruent
CON_PP_FHR = [0.155 0.355];           %timewindow of 200 ms; picked visually by KH 
CON_NP_FHR = [0.494 0.693];

CON_PP_avg_FHR = find(grandavg_con_LRP_FHR.time >= CON_PP_FHR(1) & grandavg_con_LRP_FHR.time <= CON_PP_FHR(2));
CON_NP_avg_FHR = find(grandavg_con_LRP_FHR.time >= CON_NP_FHR(1) & grandavg_con_LRP_FHR.time <= CON_NP_FHR(2));

for m = 1: numel(subject_FHR) %5
    values_CON_PP_FHR(m)  = mean(LRP_con_FHR(m).LRP.avg(CON_PP_avg_FHR));
    values_CON_NP_FHR(m)  = mean(LRP_con_FHR(m).LRP.avg(CON_NP_avg_FHR));
end

%incongruent
INCON_PP_FHR = [0.321 0.521];           %timewindow of 200 ms; picked visually by KH
INCON_NP_FHR = [0.613 0.813];

INCON_PP_avg_FHR = find(grandavg_incon_LRP_FHR.time >= INCON_PP_FHR(1) & grandavg_incon_LRP_FHR.time <= INCON_PP_FHR(2));
INCON_NP_avg_FHR = find(grandavg_incon_LRP_FHR.time >= INCON_NP_FHR(1) & grandavg_incon_LRP_FHR.time <= INCON_NP_FHR(2));

for m = 1: numel(subject_FHR) %5
    values_INCON_PP_FHR(m)  = mean(LRP_incon_FHR(m).LRP.avg(INCON_PP_avg_FHR));
    values_INCON_NP_FHR(m)  = mean(LRP_incon_FHR(m).LRP.avg(INCON_NP_avg_FHR));
end


%% 09-01-2020 peak-to-peak amplitude - LRP - PBC !

%congruent
CON_PP_K = [0.095 0.295];           %timewindow of 200 ms; picked visually by KH
CON_NP_K = [0.439 0.639];

CON_PP_avg_K = find(grandavg_con_LRP_K.time >= CON_PP_K(1) & grandavg_con_LRP_K.time <= CON_PP_K(2));
CON_NP_avg_K = find(grandavg_con_LRP_K.time >= CON_NP_K(1) & grandavg_con_LRP_K.time <= CON_NP_K(2));

for m = 1: numel(subject_K) %5
    values_CON_PP_K(m)  = mean(LRP_con_K(m).LRP.avg(CON_PP_avg_K));
    values_CON_NP_K(m)  = mean(LRP_con_K(m).LRP.avg(CON_NP_avg_K));
end

%incongruent
INCON_PP_K = [0.284 0.484];           %timewindow of 200 ms; picked visually by KH
INCON_NP_K = [0.596 0.796];

INCON_PP_avg_K = find(grandavg_incon_LRP_K.time >= INCON_PP_K(1) & grandavg_incon_LRP_K.time <= INCON_PP_K(2));
INCON_NP_avg_K = find(grandavg_incon_LRP_K.time >= INCON_NP_K(1) & grandavg_incon_LRP_K.time <= INCON_NP_K(2));

for m = 1: numel(subject_K) %5
    values_INCON_PP_K(m)  = mean(LRP_incon_K(m).LRP.avg(INCON_PP_avg_K));
    values_INCON_NP_K(m)  = mean(LRP_incon_K(m).LRP.avg(INCON_NP_avg_K));
end