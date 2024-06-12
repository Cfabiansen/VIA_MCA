
%% Parametric empirical bayes (PEB) VIA15 MCA
%--------------------------------------------
addpath '/mnt/projects/VIA_MCA/spm12.7771'
spm('defaults','EEG')

%%  PEB Model settings

GCM = {}; % Initialize empty cell array
M   = struct();
M.X= [];
% The 'all' option means the between-subject variability of each connection will 
% be estimated individually
M.Q = 'all'; 

% Choose field. Here the A matrix is selected. 
% If  you're interested in the A-matrix and the B-matrix, then run a separate PEB analysis on each.
field = {'B'};

%% Creating GCM file(s) and design matrix (M.X)

% Loading table with information about HGR status
tbl = readtable(['/mnt/projects/VIA_MCA/nobackup/Clean_VIA15_Flanker_23_04.xlsx']);

mean_age = mean(tbl.age);
sd_age = std(tbl.age);

for subjectIdx = 1:height(tbl)
    subject = tbl.id(subjectIdx);
    hgr_status = tbl.hgr_status{subjectIdx}; % hgr_status for each subject to categorize subjects
    gender = tbl.gender(subjectIdx);
    age = tbl.age(subjectIdx);

    % Skip if hgr_status is missing
    if ismissing(hgr_status)
        continue;
    end

   if hgr_status == "FHR_BP"

   try 
       currsubject = sprintf('%03d', subject); % Format subject number with leading zeros
       load(['/mnt/projects/VIA_MCA/nobackup/DCM/Model2/DCM_Model2_' currsubject '.mat']);
       
       GCM{end + 1} = ['/mnt/projects/VIA_MCA/nobackup/DCM/Model2/DCM_Model2_' currsubject '.mat'];
       
       % Specify design matrix for N subjects. It should start with a
       % constant column allocated to the mean
        % Skip if hgr_status is missing
    if ismissing(hgr_status)
        continue;
    end
       
       hgr_status = string(tbl.hgr_status{subjectIdx});
       
   % Check hgr_status and add the corresponding row to the matrix
   % First suggestion of design matrix. Here PBC is baseline. Each FHR
    % group is tested seperately as the additive effect of belonging to
    % either group, compared to the PBC

    %     if strcmp(hgr_status, 'PBC')
    %         M.X= [M.X; 1, 0, 0];
    %     elseif strcmp(hgr_status, 'FHR_SZ')
    %         M.X= [M.X; 1, 1, 0];
    %     elseif strcmp(hgr_status, 'FHR_BP')
    %         M.X= [M.X; 1, 0, 1];
    %     end


    % Second version of the design matrix. First regressor belongs to the
    % mean. 2nd is the effect of being PBC (-1) and FHR (1). 3rd is the
    % difference between each of the FHR groups (SZ = -1 , BP = 1). 4rth is
    % gender (0 = female, 1 = male). 5th is standardized age (mean
    % subtracted, divided by sd)
        if strcmp(hgr_status, 'PBC')
            M.X= [M.X; 1, -1, 0, gender,(age-mean_age)/sd_ag];
        elseif strcmp(hgr_status, 'FHR_SZ')
            M.X= [M.X; 1, 1, -1, gender,(age-mean_age)/sd_age];
        elseif strcmp(hgr_status, 'FHR_BP')
            M.X= [M.X; 1, 1, 1, gender,(age-mean_age)/sd_age];
        end

  


   catch
       disp(['Something was wrong with Subject ' currsubject '! Continuing with next in line']);
   end

   end
end 
GCM = GCM';

% Saving GCM file and design settings (including design matrix)
cd('/mnt/projects/VIA_MCA/nobackup/DCM/PEB')
save('GCM_model2_B.mat',"GCM")
save('Design_Matrix.mat',"M")
%% Estimating model
PEB  = spm_dcm_peb(GCM,M,field);
save('PEB_LONGI BP',"PEB")

spm_dcm_peb_review(PEB,GCM)