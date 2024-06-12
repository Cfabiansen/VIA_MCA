%% Flanker EEG - Data Analysis (Amplitude, Latency)

tbl = readtable('/mnt/projects/VIA_MCA/nobackup/Clean_VIA15_Flanker_23_04.xlsx'); % Load table with subject information. 
VIA15_tbl = readtable('/mnt/projects/VIA_MCA/nobackup/VIA15_Flanker_everything.xlsx'); % Load a clean table with column names

% Reformatting columns to store groups
VIA15_tbl.hgr_status = cell(height(VIA15_tbl), 1); 
VIA15_tbl.fhr_group = cell(height(VIA15_tbl), 1);  


%% Analysis
% Loop through subjects
for subject = [1:530] % Subject 240, 312, 344, 369, 385, 408 have lower sampling rate. 
    try
        currsubject = sprintf('%03d', subject); % Format subject number with leading zeros

        % Load info file
        load(['/mnt/projects/VIA_MCA/nobackup/Preprocessed Data/' currsubject '_info.mat'])

        % Saving demographic data to results
        VIA15_tbl.id(subject) = subject;
    

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
        VIA15_tbl.ACC_CON(subject) = mean(accuracy_con(RT_con >= 200));
        VIA15_tbl.ACC_CON_RATE(subject)  = mean(accuracy_con(RT_con >= 200))*100;
        
        % Incon
        VIA15_tbl.ACC_INCON(subject) = mean(accuracy_incon(RT_incon >= 200));
        VIA15_tbl.ACC_INCON_RATE(subject) = mean(accuracy_incon(RT_incon >= 200))*100;

        %% Congruency effect

        % Accuracy
        VIA15_tbl.Congruency_effect_ACC(subject) = mean(accuracy_incon(RT_incon >= 200)) - mean(accuracy_con(RT_con >= 200));

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
%writetable(VIA15_tbl,'/mnt/projects/VIA_MCA/nobackup/Clean_VIA15_Flanker_20_04.xlsx')


%% Save the results structure to a .mat file
%save('/mnt/projects/VIA_MCA/nobackup/Preprocessed Data/analysis_results.mat', 'results');

% figure;
% subplot(2,1,1);plot(timelock_con.time,timelock_con.avg([1 19 85 87],:));legend('Cz', 'Pz', 'Fz', 'FCz')                           % plot of the averages % Fz = 85
% title('Average of congruent trials')
% subplot(2,1,2);plot(timelock_incon.time,timelock_incon.avg([1 19 85 87],:));legend('Cz', 'Pz', 'Fz', 'FCz')                             % plot of the averages % Fz = 85
% title('Average of incongruent trials')

