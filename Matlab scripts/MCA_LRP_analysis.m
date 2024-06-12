%% Flanker LRP - LRP analysis

% VIA15. Takes a while
load('/mnt/projects/VIA_MCA/MATLAB/LRP/LRP_preprocess.mat')

%% plot con and incon separate with all three groups - 8 time bins 

colors_VIA15 = [140/255 208/255 219/255;  % FHR_BP
                0/255   175/255 194/255;  % FHR_SZ
                148/255 192/255 28/255];  % PBC
% Create a figure
hfig1 = figure;

% Plot congruent conditions with custom colors
plot(LRP_results.PBC.grandavg_con_LRP.time, -LRP_results.PBC.grandavg_con_LRP.avg, 'Color', colors_VIA15(3, :), 'linewidth', 3); hold on;
plot(LRP_results.FHR_SZ.grandavg_con_LRP.time, -LRP_results.FHR_SZ.grandavg_con_LRP.avg, 'Color', colors_VIA15(2, :), 'linewidth', 3); hold on;
plot(LRP_results.FHR_BP.grandavg_con_LRP.time, -LRP_results.FHR_BP.grandavg_con_LRP.avg, 'Color', colors_VIA15(1, :), 'linewidth', 3); hold on;
plot(LRP_results.grandavg_all_groups_con.time, -LRP_results.grandavg_all_groups_con.avg, 'Color', [0, 0, 0], 'linewidth', 3); hold on;

% Plot incongruent conditions with dashed lines and custom colors
plot(LRP_results.PBC.grandavg_incon_LRP.time, -LRP_results.PBC.grandavg_incon_LRP.avg, '--', 'Color', colors_VIA15(3, :), 'linewidth', 3); hold on;
plot(LRP_results.FHR_SZ.grandavg_incon_LRP.time, -LRP_results.FHR_SZ.grandavg_incon_LRP.avg, '--', 'Color', colors_VIA15(2, :), 'linewidth', 3); hold on;
plot(LRP_results.FHR_BP.grandavg_incon_LRP.time, -LRP_results.FHR_BP.grandavg_incon_LRP.avg, '--', 'Color', colors_VIA15(1, :), 'linewidth', 3); hold on;
plot(LRP_results.grandavg_all_groups_incon.time, -LRP_results.grandavg_all_groups_incon.avg, '--', 'Color', [0, 0, 0], 'linewidth', 3); hold on;

% Add legend
lgd1 = legend('PBC Congruent', 'FHR-SZ Congruent', 'FHR-BP Congruent', 'Overall Grand Average Congruent', ...
       'PBC Incongruent', 'FHR-SZ Incongruent', 'FHR-BP Incongruent', 'Overall Grand Average Incongruent','Location', 'southwest');
lgd1.BoxFace.ColorType = 'truecoloralpha'; % Enable RGBA color mode
lgd1.BoxFace.ColorData = uint8([255; 255; 255; 1]); % White background with 50% opacity (127 in the alpha channel out of 255)

% Add title and labels
title({'LRP for VIA15: Congruent and Incongruent Conditions Across Groups'});

xlim([-0.2 1.2]);
ylim([-3.5 2.5]);
grid on;
xlabel('Time (s)');
ylabel('Amplitude (μV)');

picturewidth = 30; % set this parameter and keep it forever
hw_ratio = 0.6; % feel free to play with this ratio
set(findall(hfig1,'-property','Box'),'Box','off') % optional
set(findall(hfig1,'-property','Interpreter'),'Interpreter','latex') 
set(findall(hfig1,'-property','TickLabelInterpreter'),'TickLabelInterpreter','latex')
set(hfig1,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth])
pos = get(hfig1,'Position');
set(findall(hfig1,'-property','FontSize'),'FontSize',20) % adjust fontsize to your document
lgd1.FontSize = 17;
set(hfig1,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
print(hfig1, '-dpdf', '-vector', 'VIA15_LRP');






%% VIA11 plot
clear; clc;
% VIA11. Takes a while
load('/mnt/projects/VIA_MCA/VIA11/MATLAB_VIA11/LRP/LRP_preprocess.mat')


% Define custom colors
colors_VIA11 = [228/255, 158/255, 106/255;  % FHR_BP
                214/255, 116/255, 47/255;   % FHR_SZ
                148/255, 192/255, 28/255];  % PBC

% Create a figure
hfig1 = figure;

% Plot congruent conditions with custom colors
plot(LRP_results.PBC.grandavg_con_LRP.time, -LRP_results.PBC.grandavg_con_LRP.avg, 'Color', colors_VIA11(3, :), 'linewidth', 3); hold on;
plot(LRP_results.FHR_SZ.grandavg_con_LRP.time, -LRP_results.FHR_SZ.grandavg_con_LRP.avg, 'Color', colors_VIA11(2, :), 'linewidth', 3); hold on;
plot(LRP_results.FHR_BP.grandavg_con_LRP.time, -LRP_results.FHR_BP.grandavg_con_LRP.avg, 'Color', colors_VIA11(1, :), 'linewidth', 3); hold on;
plot(LRP_results.grandavg_all_groups_con.time, -LRP_results.grandavg_all_groups_con.avg, 'Color', [0, 0, 0], 'linewidth', 3); hold on;

% Plot incongruent conditions with dashed lines and custom colors
plot(LRP_results.PBC.grandavg_incon_LRP.time, -LRP_results.PBC.grandavg_incon_LRP.avg, '--', 'Color', colors_VIA11(3, :), 'linewidth', 3); hold on;
plot(LRP_results.FHR_SZ.grandavg_incon_LRP.time, -LRP_results.FHR_SZ.grandavg_incon_LRP.avg, '--', 'Color', colors_VIA11(2, :), 'linewidth', 3); hold on;
plot(LRP_results.FHR_BP.grandavg_incon_LRP.time, -LRP_results.FHR_BP.grandavg_incon_LRP.avg, '--', 'Color', colors_VIA11(1, :), 'linewidth', 3); hold on;
plot(LRP_results.grandavg_all_groups_incon.time, -LRP_results.grandavg_all_groups_incon.avg, '--', 'Color', [0, 0, 0], 'linewidth', 3); hold on;

% Add legend
lgd1 = legend('PBC Congruent', 'FHR-SZ Congruent', 'FHR-BP Congruent', 'Overall Grand Average Congruent', ...
       'PBC Incongruent', 'FHR-SZ Incongruent', 'FHR-BP Incongruent', 'Overall Grand Average Incongruent','Location', 'southwest');
lgd1.BoxFace.ColorType = 'truecoloralpha'; % Enable RGBA color mode
lgd1.BoxFace.ColorData = uint8([255; 255; 255; 1]); % White background with 50% opacity (127 in the alpha channel out of 255)

% Add title and labels
title({'LRP for VIA11: Congruent and Incongruent Conditions Across Groups'});

xlim([-0.2 1.2]);
ylim([-3.5 2.5]);
grid on;
xlabel('Time (s)');
ylabel('Amplitude (μV)');

picturewidth = 30; % set this parameter and keep it forever
hw_ratio = 0.6; % feel free to play with this ratio
set(findall(hfig1,'-property','Box'),'Box','off') % optional
set(findall(hfig1,'-property','Interpreter'),'Interpreter','latex') 
set(findall(hfig1,'-property','TickLabelInterpreter'),'TickLabelInterpreter','latex')
set(hfig1,'Units','centimeters','Position',[3 3 picturewidth hw_ratio*picturewidth])
pos = get(hfig1,'Position');
set(findall(hfig1,'-property','FontSize'),'FontSize',20) % adjust fontsize to your document
lgd1.FontSize = 17;
set(hfig1,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
print(hfig1, '-dpdf', '-vector', 'VIA11_LRP');

%% LRP analysis

% Groups and conditions setup
groups = {'PBC', 'FHR_SZ', 'FHR_BP'};
conditions = {'con', 'incon'};

% Initialize results storage
MaxMin_group_result = struct();
CON_PP_group_result = struct();
CON_NP_group_result = struct();

for group = groups
    for condition = conditions
        fieldName = sprintf('grandavg_%s_LRP_highsamplingrate', condition{1});
        
        % Access data
        avgData = -LRP_results.(group{1}).(fieldName).avg;
        timeData = LRP_results.(group{1}).(fieldName).time;
        
        % Restrict data to times less than 0.5 seconds
        max_val = max(avgData(timeData < 0.5));  % Directly find max before 0.5s
        max_idx = find(avgData == max_val & timeData < 0.5, 1, 'first');
        max_time = timeData(max_idx);
        
        % Calculate min values and their times for full range as normal
        [min_val, min_idx] = min(avgData);
        min_time = timeData(min_idx);
        
        % Save results
        MaxMin_group_result.(group{1}).(condition{1}) = struct('MaxValue', max_val, 'MaxTime', max_time, 'MinValue', min_val, 'MinTime', min_time);
        
        % Calculate and save time windows for positive and negative peaks
        CON_PP_group_result.(group{1}).(condition{1}) = [max_time - 0.1, max_time + 0.1];
        CON_NP_group_result.(group{1}).(condition{1}) = [min_time - 0.1, min_time + 0.1];
    end
end


% Assuming LRP_results is already defined and contains the necessary data
for group = groups
    for condition = conditions
        % Display max and min values and their corresponding times
        maxVal = MaxMin_group_result.(group{1}).(condition{1}).MaxValue;
        maxTime = MaxMin_group_result.(group{1}).(condition{1}).MaxTime;
        minVal = MaxMin_group_result.(group{1}).(condition{1}).MinValue;
        minTime = MaxMin_group_result.(group{1}).(condition{1}).MinTime;
        
        fprintf('%s - %s: MaxValue = %f at MaxTime = %f, MinValue = %f at MinTime = %f\n', ...
                group{1}, condition{1}, maxVal, maxTime, minVal, minTime);
        
        % Display the time windows for positive and negative peaks
        posPeakWindow = CON_PP_group_result.(group{1}).(condition{1});
        negPeakWindow = CON_NP_group_result.(group{1}).(condition{1});
        
        fprintf('%s - %s: Positive Peak Window = [%f, %f], Negative Peak Window = [%f, %f]\n', ...
                group{1}, condition{1}, posPeakWindow(1), posPeakWindow(2), negPeakWindow(1), negPeakWindow(2));
    end
end


%% LRP ANALYSIS

% Define lower sampling rate subjects
lower_sampling_ids = {'ID_240', 'ID_312', 'ID_334', 'ID_344', 'ID_369', 'ID_385', 'ID_408'};


lower_sampling_interval_factor = 2; % Example factor to adjust the interval width

% Initialize a structure to store the results for each subject
subjectMaxMinResults = struct();

for group = groups  % Simplify group iteration
    for subjectID = fieldnames(LRP_results.(group{1}))'  % Use cell array to iterate directly
        if startsWith(subjectID{1}, 'ID_')  % Process only subject entries (ignore group average)
            for cond = {'con', 'incon'}  % Iterate over conditions
                conditionField = sprintf('LRP_%s', cond{1});  % LRP_con or LRP_incon

                try
                    % Simplify data access to subject LRP & time
                    avgData = -LRP_results.(group{1}).(subjectID{1}).(conditionField).avg;
                    timeData = LRP_results.(group{1}).(subjectID{1}).(conditionField).time;

                    % Adjust interval if subject has a lower sampling rate
                    if any(strcmp(subjectID{1}, lower_sampling_ids))
                        pp_interval = CON_PP_group_result.(group{1}).(cond{1}) * lower_sampling_interval_factor;
                        np_interval = CON_NP_group_result.(group{1}).(cond{1}) * lower_sampling_interval_factor;
                    else
                        pp_interval = CON_PP_group_result.(group{1}).(cond{1});
                        np_interval = CON_NP_group_result.(group{1}).(cond{1});
                    end

                    % Find min, max and time placements in each subject depending on the adjusted interval
                    npIndices = find(timeData >= np_interval(1) & timeData <= np_interval(2));
                    ppIndices = find(timeData >= pp_interval(1) & timeData <= pp_interval(2));

                    [min_val, min_idx] = min(avgData(npIndices));
                    min_time = timeData(npIndices(min_idx));

                    [max_val, max_idx] = max(avgData(ppIndices));
                    max_time = timeData(ppIndices(max_idx));

                    % Store results from each subject for analysis
                    subjectMaxMinResults.(group{1}).(subjectID{1}).(cond{1}) = struct('MinValue', min_val, 'MinTime', min_time, 'MaxValue', max_val, 'MaxTime', max_time);
                catch ME
                    fprintf('Error processing %s in %s condition of %s group: %s\n', subjectID{1}, cond{1}, group{1}, ME.message);
                end
            end
        end
    end
end


%% statistics for grps
% Initialize structure for storing group-level statistics
groupLevelStats = struct();

groups = {'PBC', 'FHR_SZ', 'FHR_BP'};
conditions = {'con', 'incon'};

% Loop through each group to compute stats
for i = 1:length(groups)
    group = groups{i};
    % Initialize stats storage
    stats = struct('con', struct('MinValues', [], 'MaxValues', [], 'MinTimes', [], 'MaxTimes', []), ...
                   'incon', struct('MinValues', [], 'MaxValues', [], 'MinTimes', [], 'MaxTimes', []));
    
    % Loop through subjects to aggregate data
    for subject = fieldnames(subjectMaxMinResults.(group))'
        for cond = conditions
            try
                data = subjectMaxMinResults.(group).(subject{1}).(cond{1});
                % Aggregate data
                stats.(cond{1}).MinValues = [stats.(cond{1}).MinValues, data.MinValue];
                stats.(cond{1}).MaxValues = [stats.(cond{1}).MaxValues, data.MaxValue];
                stats.(cond{1}).MinTimes = [stats.(cond{1}).MinTimes, data.MinTime];
                stats.(cond{1}).MaxTimes = [stats.(cond{1}).MaxTimes, data.MaxTime];
            catch ME
                fprintf('Error processing subject %s for condition %s: %s\n', subject{1}, cond{1}, ME.message);
            end
        end
    end
    
    % Compute stats for each condition
    for cond = conditions
        % Calculate mean and SD
        groupLevelStats.(group).(cond{1}).MinValueMean = mean(stats.(cond{1}).MinValues);
        groupLevelStats.(group).(cond{1}).MaxValueMean = mean(stats.(cond{1}).MaxValues);
        groupLevelStats.(group).(cond{1}).MinTimeMean = mean(stats.(cond{1}).MinTimes);
        groupLevelStats.(group).(cond{1}).MaxTimeMean = mean(stats.(cond{1}).MaxTimes);
        
        groupLevelStats.(group).(cond{1}).MinValueSD = std(stats.(cond{1}).MinValues);
        groupLevelStats.(group).(cond{1}).MaxValueSD = std(stats.(cond{1}).MaxValues);
        groupLevelStats.(group).(cond{1}).MinTimeSD = std(stats.(cond{1}).MinTimes);
        groupLevelStats.(group).(cond{1}).MaxTimeSD = std(stats.(cond{1}).MaxTimes);
    end
end

% Loop through groups and conditions, printing out the means and SDs
for i = 1:length(groups)
    group = groups{i};
    for j = 1:length(conditions)
        cond = conditions{j};

        fprintf('%s - %s: MinValueMean = %f (SD = %f), MaxValueMean = %f (SD = %f), MinTimeMean = %f (SD = %f), MaxTimeMean = %f (SD = %f)\n', ...
                group, cond, ...
                groupLevelStats.(group).(cond).MinValueMean, ...
                groupLevelStats.(group).(cond).MinValueSD, ...
                groupLevelStats.(group).(cond).MaxValueMean, ...
                groupLevelStats.(group).(cond).MaxValueSD, ...   
                groupLevelStats.(group).(cond).MinTimeMean, ...
                groupLevelStats.(group).(cond).MinTimeSD, ...
                groupLevelStats.(group).(cond).MaxTimeMean, ...
                groupLevelStats.(group).(cond).MaxTimeSD);
    end
end


% Save results - subject results and group results. 
save('/mnt/projects/VIA_MCA/MATLAB/LRP/LRP_analysis_results.mat', 'subjectMaxMinResults', 'MaxMin_group_result', 'CON_PP_group_result', 'CON_NP_group_result','groupLevelStats', '-v7.3');
