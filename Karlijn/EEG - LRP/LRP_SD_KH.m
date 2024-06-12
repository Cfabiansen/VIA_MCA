load(['/mnt/projects/VIAKH/EEG/Data/###_Flanker/EEG_LRP/FHR_LRP_data_N34.mat'], 'subject_FHR', 'timelock_con_L_FHR', 'timelock_con_R_FHR', 'timelock_incon_L_FHR', 'timelock_con_R_FHR', 'grandavg_con_LRP_FHR', 'grandavg_incon_LRP_FHR', 'LRP_con_FHR', 'LRP_incon_FHR');
load(['/mnt/projects/VIAKH/EEG/Data/###_Flanker/EEG_LRP/PBC_LRP_data_N34.mat'], 'subject_K', 'timelock_con_L_K', 'timelock_con_R_K', 'timelock_incon_L_K', 'timelock_con_R_K', 'grandavg_con_LRP_K', 'grandavg_incon_LRP_K', 'LRP_con_K', 'LRP_incon_K');
addpath('/mnt/projects/VIAKH/scripts') % access to JackKnife plot

%% EXAMPLE by melissa
for i = 1:17 ;
    matrix(i,:)=LRP_con_K(i).LRP.avg;
end

figure,plot_JackKnife(matrix,[0.5 0.5 0.5],'-',LRP_con_K(1).LRP.time)

%% CONTROLS
%SD for LRP for CON
for i = 1: numel(subject_K)
    matrix_K_con_LRP(i,:)=LRP_con_K(i).LRP.avg;
end

%SD for LRP for INCON
for i = 1: numel(subject_K)
    matrix_K_incon_LRP(i,:)=LRP_incon_K(i).LRP.avg;
end

%% FHR
%SD for LRP for CON
for i = 1: numel(subject_FHR)
    matrix_FHR_con_LRP(i,:)=LRP_con_FHR(i).LRP.avg;
end

%SD for LRP for  INCON
for i = 1: numel(subject_FHR)
    matrix_FHR_incon_LRP(i,:)=LRP_incon_FHR(i).LRP.avg;
end

%% PLOTS 
% FIGURE ALL IN ONE FIGURE
figure,plot_JackKnife(matrix_K_con_LRP,[0.0 0.6 0.0],'-',LRP_con_K(1).LRP.time); hold on
plot_JackKnife(matrix_K_incon_LRP,[0.0 0.8 0.4],'-.',LRP_incon_K(1).LRP.time); hold on
plot_JackKnife(matrix_FHR_con_LRP,[1.0 0.4 0.2],'-',LRP_con_FHR(1).LRP.time); hold on
plot_JackKnife(matrix_FHR_incon_LRP,[1.0 0.6 0.6],'-.',LRP_incon_FHR(1).LRP.time); hold on
legend('PBC-SD (con)', 'PBC-mean (con)', 'PBC-SD (incon)', 'PBC-mean (incon)', ...
    'FHR-SD (con)', 'FHR-mean (con)', 'FHR-SD (incon)', 'FHR-mean (incon)');                
title('Lateralized Readiness Potential (LRP)');
legend('Location','southeast');
ax = gca;
ax.FontSize = 24;
xlabel('Time (s)');
ylabel('Voltage (microVolt)');

% FIGURE GROUPS PER CONDITION
figure;subplot(2,1,1),plot_JackKnife(matrix_K_con_LRP,[0.0 0.6 0.0],'-',LRP_con_K(1).LRP.time); hold on
plot_JackKnife(matrix_FHR_con_LRP,[1.0 0.4 0.2],'-',LRP_con_FHR(1).LRP.time); hold on
legend('PBC-SD', 'PBC-mean', 'FHR-SD', 'FHR-mean');                
title('LRP: congruent condition by group');
xlabel('Time (s)');
ylabel('Voltage (microVolt)'); hold on 

subplot(2,1,2),plot_JackKnife(matrix_K_incon_LRP,[0.0 0.8 0.4],':',LRP_incon_K(1).LRP.time); hold on
plot_JackKnife(matrix_FHR_incon_LRP,[1.0 0.6 0.6],':',LRP_incon_FHR(1).LRP.time); hold on
legend('PBC-SD', 'PBC-mean', 'FHR-SD', 'FHR-mean');                
title('LRP: incongruent condition by group');
xlabel('Time (s)');
ylabel('Voltage (microVolt)');

% FIGURE CONDITION PER GROUP
figure;subplot(2,2,1),plot_JackKnife(matrix_K_con_LRP,[0.0 0.6 0.0],'-',LRP_con_K(1).LRP.time); hold on
plot_JackKnife(matrix_K_incon_LRP,[0.0 0.8 0.4],':',LRP_con_K(1).LRP.time); hold on
legend('SE (con)', 'mean (con)', 'SE (incon)', 'mean (incon)');                
title('LRP for controls, congruent and incongruent condition ');
xlabel('Time (s)');
ylabel('Voltage (microVolt)'); hold on 

subplot(2,2,2),plot_JackKnife(matrix_FHR_con_LRP,[1.0 0.4 0.2],'-',LRP_con_K(1).LRP.time); hold on
plot_JackKnife(matrix_FHR_incon_LRP,[1.0 0.6 0.6],':',LRP_con_K(1).LRP.time); hold on
legend('SE (con)', 'mean (con)', 'SE (incon)', 'mean (incon)');                
title('LRP for FHR, congruent and incongruent condition ');
xlabel('Time (s)');
ylabel('Voltage (microVolt)'); hold on 



%% try out controls
%congruent
figure;rectangle('Position',[0.1837 -4 0.20 7],'FaceColor',[0.3 0.3 0.3]);hold on
rectangle('Position',[0.4654 -4 0.20 7],'FaceColor',[0.7 0.7 0.7]);hold on
plot_JackKnife(matrix_K_con_LRP,[0.0 0.6 0.0],'-',LRP_con_K(1).LRP.time); hold on
plot_JackKnife(matrix_K_incon_LRP,[0.0 0.8 0.4],':',LRP_con_K(1).LRP.time); hold on
legend('SE (con)', 'mean (con)', 'SE (incon)', 'mean (incon)');                
title('LRP for controls, congruent condition ');
xlabel('Time (s)');
ylabel('Voltage (microVolt)') 

%incongruent
figure;rectangle('Position',[0.2987 -4 0.20 7],'FaceColor',[0.3 0.3 0.3]);hold on
rectangle('Position',[0.5829 -4 0.20 7],'FaceColor',[0.7 0.7 0.7]);hold on
plot_JackKnife(matrix_K_con_LRP,[0.0 0.6 0.0],'-',LRP_con_K(1).LRP.time); hold on
plot_JackKnife(matrix_K_incon_LRP,[0.0 0.8 0.4],':',LRP_con_K(1).LRP.time); hold on
legend('SE (con)', 'mean (con)', 'SE (incon)', 'mean (incon)');                
title('LRP for controls, incongruent condition ');
xlabel('Time (s)');
ylabel('Voltage (microVolt)') 



%% try out FHR
%congruent
figure;%rectangle('Position',[0.1837 -4 0.20 7],'FaceColor',[0.3 0.3 0.3]);hold on
%rectangle('Position',[0.4654 -4 0.20 7],'FaceColor',[0.7 0.7 0.7]);hold on
plot_JackKnife(matrix_FHR_con_LRP,[1.0 0.4 0.2],'-',LRP_con_FHR(1).LRP.time); hold on
plot_JackKnife(matrix_FHR_incon_LRP,[1.0 0.6 0.6],':',LRP_con_FHR(1).LRP.time); hold on
legend('SE (con)', 'mean (con)', 'SE (incon)', 'mean (incon)');                
title('LRP for FHR, congruent and incongruent condition ');
xlabel('Time (s)');
ylabel('Voltage (microVolt)') 
