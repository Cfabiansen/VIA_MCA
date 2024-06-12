%% EXAMPLE by melissa
for i = 1:39 ;
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

%% FHR-SZ
%SD for LRP for CON
for i = 1: numel(subject_SZ)
    matrix_SZ_con_LRP(i,:)=LRP_con_SZ(i).LRP.avg;
end

%SD for LRP for  INCON
for i = 1: numel(subject_SZ)
    matrix_SZ_incon_LRP(i,:)=LRP_incon_SZ(i).LRP.avg;
end

%% FHR-BP
%SD for LRP for controls CON
for i = 1: numel(subject_BP)
    matrix_BP_con_LRP(i,:)=LRP_con_BP(i).LRP.avg;
end

%SD for LRP for controls INCON
for i = 1: numel(subject_BP)
    matrix_BP_incon_LRP(i,:)=LRP_incon_BP(i).LRP.avg;
end

%% PLOTS 
% FIGURE ALL IN ONE FIGURE
figure,plot_JackKnife(matrix_K_con_LRP,[0.0 0.6 0.0],'-',LRP_con_K(1).LRP.time); hold on
plot_JackKnife(matrix_K_incon_LRP,[0.0 0.8 0.4],'-.',LRP_incon_K(1).LRP.time); hold on
plot_JackKnife(matrix_SZ_con_LRP,[1.0 0.4 0.2],'-',LRP_con_SZ(1).LRP.time); hold on
plot_JackKnife(matrix_SZ_incon_LRP,[1.0 0.6 0.6],'-.',LRP_incon_SZ(1).LRP.time); hold on
plot_JackKnife(matrix_BP_con_LRP,[1.0 0.8 0.0],'-',LRP_con_BP(1).LRP.time); hold on
plot_JackKnife(matrix_BP_incon_LRP,[1.0 0.8 0.4],'-.',LRP_incon_BP(1).LRP.time);hold on
% legend('SZ-SD (con)', 'SZ-mean (con)', 'SZ-SD (incon)', 'SZ-mean (incon)', ...
%     'BP-SD (con)', 'BP-mean (con)', 'BP-SD (incon)', 'BP-mean (incon)', ...
%     'PBC-SD (con)', 'PBC-mean (con)', 'PBC-SD (incon)', 'PBC-mean (incon)');                
title('Lateralized Readiness Potential (LRP)');
% legend('Location','northeastoutside');
ax = gca;
ax.FontSize = 24;
xlabel('Time (s)');
ylabel('Voltage (microVolt)');

% FIGURE GROUPS PER CONDITION
figure;subplot(2,1,1),plot_JackKnife(matrix_K_con_LRP,[0.0 0.6 0.0],'-',LRP_con_K(1).LRP.time); hold on
plot_JackKnife(matrix_SZ_con_LRP,[1.0 0.4 0.2],'-',LRP_con_SZ(1).LRP.time); hold on
plot_JackKnife(matrix_BP_con_LRP,[1.0 0.8 0.0],'-',LRP_con_BP(1).LRP.time); hold on
legend('K-SD', 'K-mean', 'SZ-SD', 'SZ-mean', 'BP-SD', 'BP-mean');                
title('LRP: congruent condition by group');
xlabel('Time (s)');
ylabel('Voltage (microVolt)'); hold on 

subplot(2,1,2),plot_JackKnife(matrix_K_incon_LRP,[0.0 0.8 0.4],':',LRP_incon_K(1).LRP.time); hold on
plot_JackKnife(matrix_SZ_incon_LRP,[1.0 0.6 0.6],':',LRP_incon_SZ(1).LRP.time); hold on
plot_JackKnife(matrix_BP_incon_LRP,[1.0 0.8 0.4],':',LRP_incon_BP(1).LRP.time); hold on 
legend('K-SD', 'K-mean', 'SZ-SD', 'SZ-mean', 'BP-SD', 'BP-mean');                
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

subplot(2,2,2),plot_JackKnife(matrix_SZ_con_LRP,[1.0 0.4 0.2],'-',LRP_con_K(1).LRP.time); hold on
plot_JackKnife(matrix_SZ_incon_LRP,[1.0 0.6 0.6],':',LRP_con_K(1).LRP.time); hold on
legend('SE (con)', 'mean (con)', 'SE (incon)', 'mean (incon)');                
title('LRP for FHR-SZ, congruent and incongruent condition ');
xlabel('Time (s)');
ylabel('Voltage (microVolt)'); hold on 

subplot(2,2,3),plot_JackKnife(matrix_BP_con_LRP,[1.0 0.8 0.0],'-',LRP_con_K(1).LRP.time); hold on
plot_JackKnife(matrix_BP_incon_LRP,[1.0 0.8 0.4],':',LRP_con_K(1).LRP.time) 
legend('SE (con)', 'mean (con)', 'SE (incon)', 'mean (incon)');                
title('LRP for FHR-BP, congruent and incongruent condition ');
xlabel('Time (s)');
ylabel('Voltage (microVolt)');

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

%% try out FHRBP
%congruent
figure;%rectangle('Position',[0.1837 -4 0.20 7],'FaceColor',[0.3 0.3 0.3]);hold on
%rectangle('Position',[0.4654 -4 0.20 7],'FaceColor',[0.7 0.7 0.7]);hold on
plot_JackKnife(matrix_BP_con_LRP,[1.0 0.8 0.0],'-',LRP_con_BP(1).LRP.time); hold on
plot_JackKnife(matrix_BP_incon_LRP,[1.0 0.8 0.4],':',LRP_incon_BP(1).LRP.time); hold on
legend('SE (con)', 'mean (con)', 'SE (incon)', 'mean (incon)');                
title('LRP for FHRBP, congruent and incongruent condition ');
xlabel('Time (s)');
ylabel('Voltage (microVolt)') 

%% try out FHRSZ
%congruent
figure;%rectangle('Position',[0.1837 -4 0.20 7],'FaceColor',[0.3 0.3 0.3]);hold on
%rectangle('Position',[0.4654 -4 0.20 7],'FaceColor',[0.7 0.7 0.7]);hold on
plot_JackKnife(matrix_SZ_con_LRP,[1.0 0.4 0.2],'-',LRP_con_SZ(1).LRP.time); hold on
plot_JackKnife(matrix_SZ_incon_LRP,[1.0 0.6 0.6],':',LRP_con_SZ(1).LRP.time); hold on
legend('SE (con)', 'mean (con)', 'SE (incon)', 'mean (incon)');                
title('LRP for FHRSZ, congruent and incongruent condition ');
xlabel('Time (s)');
ylabel('Voltage (microVolt)') 
