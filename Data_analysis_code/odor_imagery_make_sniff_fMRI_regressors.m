% Script to make sniff regressers for odor imagery study
% Input: sniff trace output from LabChart7 saved as a .mat file
% Output: downsampled and preprocessed sniff trace for use as SPM multiple
% regressors in GLM first-level fMRI design

% Emily Perszyk - Updated 1/8/2021

%% Load the subject data

clear all;

for subject = [1] % UPDATE SUBJECT IDs HERE   
    sub = num2str(subject);
    load(['../raw_data/S4_data/spirometer_recordings/sniff_mat_files/sub_' sub '_sniff.mat']); % sniff trace output from LabChart7 but saved as a .mat file (no downsampling)
    
    mkdir(['sniff_regressors/' sub '/scan1']);
    %% Define some variables

    tr = 2.1; % TR for scanner is 2.1s
    vols = 255; % Number of volumes in the BOLD functional runs
    samprate = 100; % Sampling rate is 100 Hz; Interval output from LabChart is 0.01s or 10 ms (how frequently a new sample is taken)
    points = tr * vols * samprate; % Number of datapoints in each of the 5 bold runs (e.g., 53,500)

    %% Add events to the data

    data = data'; % transpose the data (initial sniff units is L/min)
    data(:,2) = 0; % put zeros for no event as the default

    for row = 1:length(com)
        rownum = com(row,3); % column three indicates the number of the event
        rowevent = com(row,5); % column five indicates the event type (as listed in comtext)
        data(rownum,2) = rowevent;    
    end % for row

    %% Break the data into the five runs

    % Find the starts of each run
    starts = find(data(:,2)==1);
    
    for run = 1:5
        sniff = [];
        sniff(1:points,1) = data(starts(run):starts(run)+points-1,1); % no longer need to keep track of the events
    
        %% Temporal smoothing

        sniff = smoothdata(sniff,'movmean',50); % s for smoothed; smooth the datapoints: moving window of 500 ms (moving is default option, 50 indicates 500 ms/ 10s per point = 50 datapoints in that frame)

        %% High pass filtering 

        sniff = highpass(sniff,.02,100); % f for filtered; 0.02 hz is a 50s period cutoff for the high pass filter, starting frequency is 100 hz sample rate

        %% Normalization

        sniff = (sniff - mean(sniff))/std(sniff); % n for normalized; subtract the mean and divide by the SD of the run trace
        

        %% Downsample to scanner resolution
        
        % There are two ways to downsample: 1) Drop the data, 2) Average
        % the data
        
        % COMMENT OUT the option you are not using
        
        % Option 1: Drop the data (also called decimating)
        sniff = downsample(sniff,(tr*samprate)); % downsample to scanner resolution by taking first value and value at every point equal to tr * samprate

%         % Option 2: Average the data
%         sniff = mean(reshape(sniff,(tr*samprate),[])); % tr * samprate is the averaging size
%         sniff = sniff';
  
        %% Save the files
        save(['sniff_regressors/' sub '/scan1/sub-' sub '_sniff' num2str(run) '.mat'],'sniff');

    end % end run 1-5
    
end % for subject