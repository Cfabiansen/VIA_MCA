function DCM_Model1(subject_no)
% analyse some ERP data (mismatch negativity ERP)
% 
%
% Please replace filenames etc. by your own.
%--------------------------------------------------------------------------
addpath '/mnt/projects/VIA_MCA/spm12.7771'
spm('defaults','EEG')

% Data and analysis directories
%--------------------------------------------------------------------------


Panalysis = '/mnt/scratch/projects/VIA_MCA/Model1/';


currsubject = sprintf('%03d', subject_no); %  
        
clear DCM;
tic
display(subject_no,'fitting model for subject')


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
DCM.Lpos  = [[-22; -6; 52] [28; -2; 52] [-6; -8; 50] [46; 6; 30] ];
DCM.Sname = {'left superior frontal gyrus', 'right middle frontal gyrus','left SMA','right precentral gyrus'};
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
DCM.A{1}(1,1) = 1; % self-connections
DCM.A{1}(2,2) = 1;
DCM.A{1}(3,3) = 1;
DCM.A{1}(4,4) = 1;

DCM.A{1}(3,1) = 1;
DCM.A{1}(4,2) = 1;
DCM.A{1}(4,1) = 1;
DCM.A{1}(3,2) = 1;


DCM.A{2} = zeros(Nareas,Nareas); %backward
DCM.A{2}(1,3) = 1;
DCM.A{2}(2,4) = 1;
DCM.A{2}(1,4) = 1;
DCM.A{2}(2,3) = 1;

DCM.A{3} = zeros(Nareas,Nareas); %lateral
DCM.A{3}(2,1) = 1;
DCM.A{3}(1,2) = 1;
DCM.A{3}(4,3) = 1;
DCM.A{3}(3,4) = 1;

DCM.B{1} = zeros(Nareas,Nareas); %modulations (on forward and backward connections)
DCM.B{1}(3,1) = 1;
DCM.B{1}(4,2) = 1;
DCM.B{1}(4,1) = 1;
DCM.B{1}(3,2) = 1;

DCM.B{1}(1,3) = 1;
DCM.B{1}(2,4) = 1;
DCM.B{1}(1,4) = 1;
DCM.B{1}(2,3) = 1;

% Input
DCM.C = [1; 1; 0; 0];

%--------------------------------------------------------------------------
% Between trial effects
%--------------------------------------------------------------------------
DCM.xU.X =   [0 ; 1 ];
DCM.xU.name = {'Effect of Incongruency'};

%--------------------------------------------------------------------------
% InvertDCM.name = ['DCM_Model1_',ID]';
%--------------------------------------------------------------------------
DCM.name = ['DCM_Model1_',currsubject]';

DCM = spm_dcm_erp(DCM);
save(DCM.name,'DCM')


end
