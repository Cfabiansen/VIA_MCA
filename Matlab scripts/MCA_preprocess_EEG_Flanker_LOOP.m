%▒█▀▀▀ ▒█░░░ ░█▀▀█ ▒█▄░▒█ ▒█░▄▀ ▒█▀▀▀ ▒█▀▀█ 　 ▒█▀▀▀ ▒█▀▀▀ ▒█▀▀█ 　 ▒█░░▒█ ▀█▀ ░█▀▀█ ▄█░ █▀▀ 
%▒█▀▀▀ ▒█░░░ ▒█▄▄█ ▒█▒█▒█ ▒█▀▄░ ▒█▀▀▀ ▒█▄▄▀ 　 ▒█▀▀▀ ▒█▀▀▀ ▒█░▄▄ 　 ░▒█▒█░ ▒█░ ▒█▄▄█ ░█░ ▀▀▄ 
%▒█░░░ ▒█▄▄█ ▒█░▒█ ▒█░░▀█ ▒█░▒█ ▒█▄▄▄ ▒█░▒█ 　 ▒█▄▄▄ ▒█▄▄▄ ▒█▄▄█ 　 ░░▀▄▀░ ▄█▄ ▒█░▒█ ▄█▄ ▄▄▀ 

%▒█▀▀█ ▒█▀▀█ ▒█▀▀▀ ▒█▀▀█ ▒█▀▀█ ▒█▀▀▀█ ▒█▀▀█ ▒█▀▀▀ ▒█▀▀▀█ ▒█▀▀▀█ 
%▒█▄▄█ ▒█▄▄▀ ▒█▀▀▀ ▒█▄▄█ ▒█▄▄▀ ▒█░░▒█ ▒█░░░ ▒█▀▀▀ ░▀▀▀▄▄ ░▀▀▀▄▄ 
%▒█░░░ ▒█░▒█ ▒█▄▄▄ ▒█░░░ ▒█░▒█ ▒█▄▄▄█ ▒█▄▄█ ▒█▄▄▄ ▒█▄▄▄█ ▒█▄▄▄█


%% Initialization %%

% Adding Fieldtrip toolbox: It's recommended to do it this way, and not by
% adding path through matlab functions. 
function MCA_preprocess_EEG_Flanker_LOOP(subject_no)

addpath '/mnt/projects/VIA_MCA/fieldtrip-master'
ft_defaults;

% Defining path for data
datapath = '/mnt/projects/VIA_MCA/nobackup/Data/Flanker/';

%% Loading Behavioral data

% Getting subject files
%files = dir(fullfile('/mnt/projects/VIAKBP/nobackup/VIA15_EEGFlanker','*kids*.txt'));
%fn = {files.name};
%SubjectId = extractBetween(fn,"-","-");

% Aner ikke hvad det her er eller skal bruges til
%P = (130 , 187, 083) 

% loop for each subject to go through processing and save in indenpendent mat file. 
%for  subject = 1 : length(a) 

% Loop through subjects

    try
        currsubject = sprintf('%03d', subject_no); % Format subject number with leading zeros

% Getting Subj behafile 
subjfile = (fullfile(datapath,['flanker_kids_eegBackup_new-' currsubject '-1.txt']));     %Behafile of subject 
 
lines = fileread(subjfile);  %Reading file 

%Condition Split
%Seperate condition data of Con/Inc.  
[~,ConInc] = strsplit(lines,{'leftCon','rightCon','rightIncon','leftIncon'},'CollapseDelimiters',true); % Searching the document and splits the string of leftCon + RigthCon from the rest and puts it in ConInc.
for i=1:length(ConInc)
    if or(ConInc{i}(5)=='C',ConInc{i}(6)=='C')
        InC_C(i)=1;
    else
        InC_C(i)=2;
    end
    InC_C = reshape(InC_C,[],1); 
end

%Acc Split
% Splitting the Acc of the trials. split up 0 and 1. 
[~,Acc] = strsplit(lines,{'win.ACC: 0','win.ACC: 1'},'CollapseDelimiters',true);    
for j=1:length(Acc)
    if (Acc{j}(10)=='0')
        Accu(j)=0;
    elseif (Acc{j}(10)=='1')
        Accu(j)=1;
    end
    Accu = reshape(Accu,[],1);
end
      
%Acc of Con / Inc
% finding accuracy in Con and Inc
accuracy_con=Accu(InC_C==1);
accuracy_incon=Accu(InC_C==2);

%% Reaction times for correct answer 
% Reaction Time Split
% Extract reaction times from the data file
RT_pattern = 'responsewin.RT:\s(\d+)'; % Regular expression pattern to match "responsewin.RT: xxx"
RT_matches = regexp(lines, RT_pattern, 'tokens');

% Determine the number of trials
numTrials = length(RT_matches);

% Initialize a double array to store reaction times
ReactionTimes = zeros(numTrials, 1);

% Loop through the matches and store them in the array
for k = 1:numTrials
    if ~isempty(RT_matches{k})
        % Convert the matched value to a numeric format (assuming it's always in milliseconds)
        ReactionTimes(k) = str2double(RT_matches{k}{1});
    else
        % Handle cases where there is no match (e.g., if "responsewin.RT:" is not followed by a number)
        ReactionTimes(k) = NaN; % You can set it to some default value or use NaN
    end
end

%Reaction Time of Con / Incon
% finding Reation Time in Con and Incon
RT_con=ReactionTimes(InC_C==1);
RT_incon=ReactionTimes(InC_C==2);


% Separate Correct RTs into Con and Incon
RT_con_correct = ReactionTimes(InC_C == 1 & Accu == 1);
RT_incon_correct = ReactionTimes(InC_C == 2 & Accu == 1);


%% Loading EEG data

%Here we defines the segments of data that will be used for further processing and analysis, i.e.
% - the pieces of data that will be read in by FT_PREPROCESSING
% Define trials (_con + _incon).                                                          
 
cfg = [];% Creating a cfg struct
cfg.dataset             = [datapath currsubject '_Flanker.bdf'];   
%data2            = ['/mnt/projects/VIAKBP/nobackup/VIA15_EEGFlanker/' currsubject '_Flanker_Runde2.bdf']; 


%% Importing dataset into the created struct

% Defining the points in time (sec) pre-/post stimuli to segment the data (epoching),
% To study the event-related EEG dynamics of continuously recorded data, 
% we must extract data epochs time-locked to events of interest  
cfg.trialdef.prestim    = 0.5;     
cfg.trialdef.poststim   = 1.5;
cfg.trialdef.eventtype  = 'STATUS';
cfg.trialdef.eventvalue = {65291, 65311};  % Defining the trials specific for con and incon. 
cfg_con                 = ft_definetrial(cfg);                                             

cfg.trialdef.eventvalue = {65301, 65321};
cfg_incon               = ft_definetrial(cfg); % Call on ft_definetrial will result in "trl" being added to the output structure.
                                               % containing Nx3 columns. N = number of trials. Comlums contains, 1st = prestim, 2st = poststim & 3rd = offset



%% Preprocessing options that you should only use for EEG data

% after constructing the cfg with the relevant data and details, we will now run it through steps of preprocessing 
% Rereferencing: preprocessing trials (_con + _incon)

cfg_con.reref = 'yes';    % cfg.reref  = 'no' or 'yes' (default = 'no')
cfg_con.channel = 'all';  
cfg_con.refchannel = {'EXG1','EXG2'}; % cfg.refchannel = cell-array with new EEG reference channel(s), Channels from the hardware measurement                                                               

cfg_incon.reref = 'yes';              
cfg_incon.channel = 'all';                                                                
cfg_incon.refchannel = {'EXG1','EXG2'}; 

% Filter 
cfg_con.baselinewindow = [-0.5 -0.01]; % Baseline: interval is selected as prestimulus to stimulus onset time interval.
cfg_con.bpfilter = 'yes';    % Apply Bandpass filter                                                             
cfg_con.lpfilttype = 'fir';  % Apply a lowpass "fir" filter: in signal processing, a finite impulse response (FIR) filter is a filter whose impulse response (or response to any finite length input) is of finite duration, because it settles to zero in finite time
cfg_con.bpfiltord = 3;       % bandpass filter order (3 in this case): Is the delay of the past inputs and outputs.
cfg_con.bpfreq = [0.5 45];   % Passing frequencies 0,5 - 45. Filtering out the rest
data_con = ft_preprocessing(cfg_con);  % Add to cfg struct

cfg_incon.baselinewindow = [-0.5 -0.01];
cfg_incon.bpfilter = 'yes'; 
cfg_incon.lpfilttype = 'fir';
cfg_incon.bpfiltord = 3;
cfg_incon.bpfreq = [0.5 45];                                                                
data_incon = ft_preprocessing(cfg_incon); 

%% Inspect data
% Uncomment to plot (prestim to poststim)

%{
figure;plot(data_con.time{1}, data_con.trial{1});
title('Inspect con')
figure;plot(data_incon.time{1}, data_incon.trial{1});
title('Inspect Incon')
%}

%% artefacts

% Fieldtrip Visual artifact detection
%{
cfg = [];                                                                                   % Fieldtrip's Visual artifact detection 
cfg.viewmode = 'vertical';    
artfct       = ft_databrowser(cfg, data_con)

cfg = [];
cfg.viewmode = 'vertical';
artfct       = ft_databrowser(cfg, data_incon)

cfg          = [];
cfg.method   = 'trial';
data_clean   = ft_rejectvisual(cfg, data_con)

cfg          = [];
cfg.method   = 'trial';
data_clean   = ft_rejectvisual(cfg, data_incon)


%Summary plot
cfg          = [];
cfg.method   = 'summary';
cfg.layout   = 'biosemi128.lay';  % for plotting individual trials
cfg.channel  = [1:128];                          
data_clean_inc   = ft_rejectvisual(cfg, data_incon)


%Summary plot
cfg          = [];
cfg.method   = 'summary';
cfg.layout   = 'biosemi128.lay';  % for plotting individual trials
cfg.channel  = [1:128];                          
data_clean_con   = ft_rejectvisual(cfg, data_con)

%}



n_trialsI=size(data_incon.trial,2);  % Number of trials for Con & InCon
n_trialsC=size(data_con.trial,2);

L=size(data_incon.trial{1}(1,:),2);
Fs=data_incon.fsample;
eeg_chn=1:128;


%% incongruent artefacts

jumps=zeros(length(eeg_chn),n_trialsI);   % Detection of artifacts and other muscle movement and ect. 
clean_int=[1:length(data_incon.trial{1})];  % Array with Zero's to fill in artifact detections
art_amp=zeros(length(eeg_chn),n_trialsI);
musc=zeros(length(eeg_chn),n_trialsI);

 % For loop for artifact detection 1:number of trials
for i=1:n_trialsI      
    
    eogt=(data_incon.trial{i}(135,:)-data_incon.trial{i}(134,:))'; % Correction for EOG - eye movements from ref channels 135-134  
    if or((kurtosis(eogt)>5),(max(eogt')-min(eogt'))>200)   % EOG correction

    eegt=data_incon.trial{i}(eeg_chn,:)';
    eegt=eegt-eogt*(eogt\eegt);
    data_incon.trial{i}(eeg_chn,:)=eegt';
    end
    
    temp=diff(data_incon.trial{i}(eeg_chn,clean_int)')';  % jumps detection  % Detecting jumps for InCon, if > 30, count jump = 1. 
    [aa,bb]=find(temp>30);
    aa=unique(aa);
    if ~isempty(aa)
        jumps(aa,i)=1;
    end
    temp=abs(data_incon.trial{i}(eeg_chn,clean_int)')';  % peaks detection % Detecting peaks for InCon, if > 100, count peak = 1.
    [aa,bb]=find(temp>100);
    aa=unique(aa);
    if ~isempty(aa)
        art_amp(aa,i)=1;
    end
    
    for j=eeg_chn                       % muscular artefact detection 
    Y = fft(data_incon.trial{i}(j,:));  % Fourier transform of inCon data 
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    if mean(P1(31:60))>mean(P1(1:30))
    musc(j,i)=1;
    end
    end

end

art_tot_incon=or(or(jumps,art_amp),musc);
% art_tot2=or(or(jumps,art_amp),musc)';
% bad_chn_incon=find(sum(art_tot2)>50);
% good_chn_incon=1:128;
% good_chn_incon(bad_chn_incon)=[];

bad_trials_incon=zeros(1,200);
bad_trials_incon(sum(art_tot_incon)>size(art_tot_incon,2)/100*20)=1;

%% congruent artefacts

jumps=zeros(length(eeg_chn),n_trialsC);                                      % 
clean_int=[1:length(data_con.trial{1})];
art_amp=zeros(length(eeg_chn),n_trialsC);
musc=zeros(length(eeg_chn),n_trialsC);
for i=1:n_trialsC 
    
    eogt=(data_con.trial{i}(135,:)-data_con.trial{i}(134,:))';
    if or((kurtosis(eogt)>5),(max(eogt')-min(eogt'))>200)   % EOG correction

    eegt=data_con.trial{i}(eeg_chn,:)';
    eegt=eegt-eogt*(eogt\eegt);
    data_con.trial{i}(eeg_chn,:)=eegt';
    end
    
    temp=diff(data_con.trial{i}(eeg_chn,clean_int)')';    % jumps detection
    [aa,bb]=find(temp>30);
    aa=unique(aa);
    if ~isempty(aa)
        jumps(aa,i)=1;
    end
    temp=abs(data_con.trial{i}(eeg_chn,clean_int)')';     % peaks detection
    [aa,bb]=find(temp>100);
    aa=unique(aa);
    if ~isempty(aa)
        art_amp(aa,i)=1;
    end
    
    for j=eeg_chn                                           % muscular artefact detection
    Y = fft(data_con.trial{i}(j,:));
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    if mean(P1(31:60))>mean(P1(1:30))
    musc(j,i)=1;
    end
    end

end

art_tot_con=or(or(jumps,art_amp),musc);
% art_tot2=or(or(jumps,art_amp),musc)';
%bad_chn_con=find(sum(art_tot_con)>50);
% good_chn_con=1:128;
% good_chn_con(bad_chn_con)=[];

bad_trials_con=zeros(1,200);
bad_trials_con(sum(art_tot_con)>size(art_tot_con,2)/100*20)=1;

%% channel interpolation

% Here we 1st. want to deal with noisy channels through interpolation 
cfg = [];
cfg_neighb       	= [];                                                     % Creating a struct where we fill in the input data with info of channels of interest, method and sensor description 
cfg_neighb.method	= 'triangulation';                                        % Using the 'triangulation'method calculates a triangulation based on a 2D projection of the sensor positions
cfg.senstype      	= 'EEG';                                                  % sensor description
cfg_neighb.layout 	= 'biosemi128.lay';                                       % data structure with the channels of interest
neighbours        	= ft_prepare_neighbours(cfg_neighb);                      % FT_PREPARE_NEIGHBOURS finds the channel neighbours for spatial clustering or interpolation of bad channel

 
% next, we set up and creates a 2-D layout of the channel locations. 
% This layout is required for plotting the topographical distribution of the potential or
% field distribution, or for plotting timecourses in a topographical arrangement

cfg.neighbours    	= neighbours;
cfg.channel       	= data_con.label; %{'Fp1', 'Fp2', 'AF7', 'AF3','AF8','F7','F5','FT9',};
cfg.feedback     	 = 'yes';                                                 % 'yes' or 'no', whether to show an image of the layout (default = 'no')
cfg.layout 		= 'biosemi128.lay';                                           % filename containg the input layout
lay 				= ft_prepare_layout(cfg);                                 % Preparing the layout and returns a layout structure with different elements

sens 			= data_con;
sens.type 		= 'eeg';
sens.label		= lay.label;
sens.chanpos 		= lay.pos;
sens.chanpos(:,3) 	= 0;

ft_neighbourplot(cfg, data_con);

% Reparing channels incon

for i=1:size(art_tot_incon,2)
    cfg 				= [];
    cfg.method         	= 'nearest';
    cfg.badchannel     	= data_incon.label(art_tot_incon(:,i)==1);%{'Fp1', 'Fp2', 'AF7', 'AF3','AF8','F7','F5','FT9'};
    cfg.neighbours    	= neighbours;
    cfg.trials        	= i;
    cfg.elec            = sens;
    data_temp=ft_channelrepair(cfg, data_incon);
    data_incon.trial{i}=data_temp.trial{1};
    clear data_temp
end

% Reparing channels con

for i=1:size(art_tot_con,2)
    cfg 				= [];
    cfg.method         	= 'nearest';
    cfg.badchannel     	= data_con.label(art_tot_con(:,i)==1);
    cfg.neighbours    	= neighbours;
    cfg.trials        	= i;
    cfg.elec            = sens;
    data_temp=ft_channelrepair(cfg, data_con);
    data_con.trial{i}=data_temp.trial{1};
    clear data_temp
end

%% Timelock (average over trials)

trials_con=find(sum([accuracy_con,not(bad_trials_con)'],2)==2);    %% Excludes bad trials. 
trials_incon=find(sum([accuracy_incon,not(bad_trials_incon)'],2)==2);

cfg = [];
cfg.trials = trials_con;  % Adding selected trials given as a 1xN vector, to the cfg struct
timelock_con = ft_timelockanalysis(cfg,data_con);  % The function ft_timelockanalysis makes averages of all the trials in a data structure. 
                                                   % It requires preprocessed data, which we did earlier at ft_preprocessing

cfg = [];
cfg.trials = trials_incon;
timelock_incon = ft_timelockanalysis(cfg,data_incon);

timelock_diff = timelock_con;
timelock_diff.avg = timelock_con.avg - timelock_incon.avg;

%% average reference

data_con_aveR=timelock_con.avg(1:128,:)-mean(timelock_con.avg(1:128,:));   % Average the data over the channels
data_incon_aveR=timelock_incon.avg(1:128,:)-mean(timelock_incon.avg(1:128,:));
diff_data_aveR=data_con_aveR-data_incon_aveR;

data_con_aveC20_C23 = mean(timelock_con.avg(84:87,:),1);                   % Average the data over the channels C20-C23
data_incon_aveC20_C23= mean(timelock_incon.avg(84:87,:),1);

%% Save data 
%Save data in mat files for each participant
%save(['/mnt/projects/VIA_MCA/nobackup/Preprocessed Data/' num2str(currsubject) '_data_C20_C23.mat'],'data_con_aveC20_C23','data_incon_aveC20_C23','timelock_con','timelock_incon')
% save(['/mnt/scratch/projects/VIA_MCA/' num2str(currsubject) '_data.mat'],'data_con','data_incon')
% save(['/mnt/scratch/projects/VIA_MCA/' num2str(currsubject) '_info.mat'],'accuracy_con','accuracy_incon'...
%     ,'bad_trials_con', 'bad_trials_incon','art_tot_con', 'art_tot_incon','RT_con','RT_incon', 'RT_con_correct', 'RT_incon_correct')

% Plots

%Plots

% Figures
% figure;plot(timelock_con.time,timelock_con.avg(1:128,:))                            % plot of the averages % Fz = 85
% title('Average of congruent trials - all channels')
% 
% figure;plot(timelock_incon.time,timelock_incon.avg(1:128,:))                            % plot of the averages % Fz = 85
% title('Average of incongruent trials - all channels')
% 
% figure;plot(timelock_diff.time,timelock_diff.avg(1:128,:))                            % plot of the averages % Fz = 85
% title('Difference wave- all channels')
% 
% figure;plot(timelock_diff.time,diff_data_aveR)                            % plot of the averages % Fz = 85
% title('Difference wave of ref- all channels')
% 
% % Figures only for Cz.
% figure;plot(timelock_con.time,[timelock_con.avg(87,:); timelock_incon.avg(87,:)]')    % plot of the averages % Cz = 1
% title('Average of congruent trials - all channels')
% 
% figure;plot(timelock_incon.time,timelock_incon.avg(87,:))                            % plot of the averages % Cz = 1
% title('Average of incongruent trials - all channels')
% 
% figure;plot(timelock_diff.time,timelock_diff.avg(87,:))                            % plot of the averages % Cz = 1
% title('Difference wave- all channels')



% Plot: Average over C20-C23
% figure;plot(timelock_con.time,[data_con_aveC20_C23; data_incon_aveC20_C23]')       % Plot average of trials over Channel C20 - C23
% title('Average of congruent and incongruent trials over C20-C23')
% legend('con','incon')
% 
% % Multiplot
% cfg = [];
% cfg.layout = 'biosemi128.lay';
% cfg.interactive = 'yes';
% cfg.showoutline = 'yes';
% ft_multiplotER(cfg, timelock_con, timelock_incon)
% % 
% Topoplot 
% cfg = [];                            
% cfg.xlim = [0.27 0.3];                
% %cfg.zlim = [0 6e-14];
% cfg.gridscale = 300;
% cfg.style = 'straight';
% cfg.markersymbol  = '.';
% cfg.markersize = 10;
% cfg.layout = 'biosemi128.lay';            
% figure;(ft_topoplotER(cfg,timelock_con));colorbar;title('con trials') 
% print -depsc -adobecs -painte
% 
cfg = [];                            
cfg.xlim = [0.26 0.28];                
%cfg.zlim = [0 6e-14]; 
cfg.gridscale = 300;
cfg.style = 'straight';
cfg.markersymbol  = '.';
cfg.markersize = 10;
cfg.layout = 'biosemi128.lay';            
figure; (ft_topoplotER(cfg,grandAverage_con_PBC));colorbar;title('incon trials')  
print -depsc -adobecs -painte
% } 
% topo diff plot
% { 
% Plots
% cfg = [];                            
% cfg.xlim = [0.3 0.5];                
% cfg.zlim = [0 6e-14];  
% cfg.gridscale = 300;
% cfg.style = 'straight';
% cfg.markersymbol  = '.';
% cfg.markersize = 10;
% cfg.layout = 'biosemi128.lay';            
% figure; (ft_topoplotER(cfg,timelock_diff));colorbar;title('diff') 
% print -depsc -adobecs -painte
% 
% } 

%Catch the loop and disp if problem with subject happens, and conteniue
%with next subject
    catch
        disp(['Something was wrong with Subject' int2str(currsubject) '! Continuing with next in line']); % If something is wrong, display in window and continue with next
    end

end
