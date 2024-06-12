 function DCM_Model2(subject_no)
% analyse some ERP data (mismatch negativity ERP)
% 
%
% Please replace filenames etc. by your own.
%--------------------------------------------------------------------------
addpath '/mnt/projects/VIA_MCA/spm12.7771'
spm('defaults','EEG')

% Data and analysis directories
%--------------------------------------------------------------------------


Panalysis = '/mnt/scratch/projects/VIA_MCA/Model2/';

currsubject = sprintf('%03d', subject_no); % Format subject number with leading zeros

clear DCM;
tic
display(currsubject,'fitting model for subject')

DCM.xY.Dfile = ['/mnt/projects/VIA_MCA/nobackup/Merged_SPM/merged_' currsubject '_con.mat'];

% Parameters and options used for setting up model
%--------------------------------------------------------------------------
DCM.options.analysis = 'ERP'; % analyze evoked responses
DCM.options.model    = 'ERP'; % ERP model
DCM.options.spatial  = 'ECD'; % spatial model
DCM.options.trials   = [1 2]; % index of ERPs within ERP/ERF file
DCM.options.Tdcm(1)  = 0;     % start of peri-stimulus time to be modelled
DCM.options.Tdcm(2)  = 600;   % end of peri-stimulus time to be modelled
DCM.options.Nmodes   = 8;     % nr of modes for data selection
DCM.options.h        = 1;     % nr of DCT components
DCM.options.onset    = 60;    % selection of onset (prior mean)
DCM.options.D        = 1;     % downsampling

%--------------------------------------------------------------------------
% Data and spatial model
%--------------------------------------------------------------------------
DCM  = spm_dcm_erp_data(DCM);
%--------------------------------------------------------------------------
% Location priors for dipoles
%--------------------------------------------------------------------------
DCM.Lpos  = [[-22; -6; 52] [28; -2; 52] [-6; 8; 50] [46; 6; 30] [-44; -44; 40] [38; -48; 46]]; % last coordinate for rPPC & lPPC is not decided yet
DCM.Sname = {'left superior frontal gyrus', 'right middle frontal gyrus','left SMA','right precentral gyrus','left inferior parietal lobule','right inferior parietal lobule'};
Nareas    = size(DCM.Lpos,2);

%--------------------------------------------------------------------------
% Data and spatial model
%--------------------------------------------------------------------------
DCM  = spm_dcm_erp_data(DCM);

%--------------------------------------------------------------------------
% Spatial model
%--------------------------------------------------------------------------
DCM = spm_dcm_erp_dipfit(DCM);

%--------------------------------------------------------------------------
% Specify connectivity model
%--------------------------------------------------------------------------
cd(Panalysis)

DCM.A{1} = zeros(Nareas,Nareas); %forward
DCM.A{1}(1,1) = 1; % self-connection l SPF
DCM.A{1}(2,2) = 1; % self-connection r MFG
DCM.A{1}(3,3) = 1; % self-connection l SMA
DCM.A{1}(4,4) = 1; % self-connection r PCG
DCM.A{1}(5,5) = 1; % self-connection r PPC
DCM.A{1}(6,6) = 1; % self-connection r PPC
DCM.A{1}(3,1) = 1; % l SPF -> l SMA
DCM.A{1}(4,1) = 1; % l SPF -> r PCG
DCM.A{1}(4,2) = 1; % r MFG -> r PCG
DCM.A{1}(3,2) = 1; % r MFG -> l SMA

DCM.A{1}(2,6) = 1; % r PPC -> r MFG % Model 2
DCM.A{1}(4,6) = 1; % r PPC -> r PCG % Model 2
DCM.A{1}(1,5) = 1; % r PPC -> r PCG % Model 2

DCM.A{2} = zeros(Nareas,Nareas); %backward
DCM.A{2}(1,3) = 1; % l SMA -> l SPF 
DCM.A{2}(1,4) = 1; % r PG -> l SPF
DCM.A{2}(2,4) = 1; % r PG -> r MFG
DCM.A{2}(2,3) = 1; % l SMAr -> MFG 

DCM.A{2}(6,2) = 1; % r PPC -> r MFG % Model 2
DCM.A{2}(6,4) = 1; % r PPC -> r PCG % Model 2
DCM.A{2}(5,1) = 1; % r PPC -> r PCG % Model 2

DCM.A{3} = zeros(Nareas,Nareas); %lateral
DCM.A{3}(1,2) = 1; % l LFG -> r MFG
DCM.A{3}(2,1) = 1; % r MFG -> l LFG
DCM.A{3}(3,4) = 1; % mid SMA -> r PCG
DCM.A{3}(4,3) = 1; % r PCG -> l SMA
DCM.A{3}(5,6) = 1; % r PPC -> l PPC % Model 2
DCM.A{3}(6,5) = 1; % l PPC -> r PPC % Model 2

DCM.B{1} = zeros(Nareas,Nareas); %modulations (on forward and backward connections)
DCM.B{1}(3,1) = 1; % l SPF -> l SMA
DCM.B{1}(4,1) = 1; % l SPF -> r PCG
DCM.B{1}(4,2) = 1; % r MFG -> r PCG
DCM.B{1}(3,2) = 1; % r MFG -> l SMA

DCM.B{1}(2,6) = 1; % r PPC -> r MFG % Model 2
DCM.B{1}(4,6) = 1; % r PPC -> r PCG % Model 2
DCM.B{1}(1,5) = 1; % r PPC -> r PCG % Model 2

DCM.B{1}(1,3) = 1; % l SMA -> l SPF 
DCM.B{1}(1,4) = 1; % r PG -> l SPF
DCM.B{1}(2,4) = 1; % r PG -> r MFG
DCM.B{1}(2,3) = 1; % l SMAr -> MFG 

DCM.B{1}(6,2) = 1; % r PPC -> r MFG % Model 2
DCM.B{1}(6,4) = 1; % r PPC -> r PCG % Model 2
DCM.B{1}(5,1) = 1; % r PPC -> r PCG % Model 2


DCM.C = [0; 0; 0; 0; 1; 1];

%--------------------------------------------------------------------------
% Between trial effects
%--------------------------------------------------------------------------
DCM.xU.X =   [0 ; 1 ];
DCM.xU.name = {'Effect of Incongruency'};

%--------------------------------------------------------------------------
% Invert
%--------------------------------------------------------------------------
DCM.name = ['DCM_Model2_',currsubject]';

DCM = spm_dcm_erp(DCM);
save(DCM.name,'DCM')


end
