% EP updated 5/4/23

% To analyze sniff parameters
% Excluded 2484, 2502, and 2509 (due to no imagery < 50%)

%% Prepare

clear all;

sample = [1681 2020 2129 2162 2306 2369 2397 2435 2438 2455 2457 2459 2460 2461 2463 2464 2467 2468 2472 2476 2477 2479 2480 2481 2482 2483 2485 2487 2488 2489 2490 2491 2492 2497 2498 2499 2503 2507 2508 2510 2518 2526 2528 2533]; % UPDATE SUBJECT IDs HERE 

% table to store average sniff amplitude, duration, and peak for all
% subjects
sniff_table = table;

% table for svm results
svm_table = table;
svm_table.SubjectID = sample';

% other
subcount = 1;
full_sniff = [];
full_event = [];

%% Load subject data

for subject = sample   
    
    sub = num2str(subject);
    load(['raw_data/S4_data/spirometer_recordings/sniff_mat_files/sub_' sub '_sniff.mat']); % sniff trace output from LabChart7 but saved as a .mat file (no downsampling)
    
    sniff_table.SubjectID(subcount:subcount+5,:) = subject;
    sniff_table.Event(sniff_table.SubjectID==subject,1) = 1:6;
    
    %% Define some variables

    tr = 2.1; % TR for scanner is 2.1s
    vols = 255; % Number of volumes in the BOLD functional runs
    samprate = 100; % Sampling rate is 100 Hz; Interval output from LabChart is 0.01s or 10 ms (how frequently a new sample is taken)
    points = tr * vols * samprate; % Number of datapoints in each of the 5 bold runs (e.g., 53,500)

    %% Add events to the data

    data = data'; % transpose the data (initial sniff units is L/min)
    data(:,2) = 0; % put zeros for no event as the default

    if subject == 2397
        com(1,:)=[]; % had an extra run 1 start that we quit out of right away
    end % if subject
    
    for row = 1:length(com)
        rownum = com(row,3); % column three indicates the number of the event
        rowevent = com(row,5); % column five indicates the event type (as listed in comtext)
        data(rownum,2) = rowevent;    
    end % for row
       
        % Final event types
        % 1) smell rose 
        % 2) imagine rose 
        % 3) smell cookie
        % 4) imagine cookie 
        % 5) smell odorless
        % 6) imagine odorless   
    
    for oldevent = 1:7
        comevents(oldevent,1)=length(strfind(comtext(oldevent,:),'smell rose (PEA)')); % col indicates new event type
        comevents(oldevent,2)=length(strfind(comtext(oldevent,:),'imagine rose (odorless)')); 
        comevents(oldevent,3)=length(strfind(comtext(oldevent,:),'smell cookie (cookie)')); 
        comevents(oldevent,4)=length(strfind(comtext(oldevent,:),'imagine cookie (odorless)'));
        comevents(oldevent,5)=length(strfind(comtext(oldevent,:),'smell odorless (odorless)'));
        comevents(oldevent,6)=length(strfind(comtext(oldevent,:),'imagine odorless (odorless)'));
    end % for oldevent
    
    fix = [];
    fix(1:6,1) = 2:7; % col 1 is old event type
    fix(1,2) = find(comevents(2,:));
    fix(2,2) = find(comevents(3,:));
    fix(3,2) = find(comevents(4,:));
    fix(4,2) = find(comevents(5,:));
    fix(5,2) = find(comevents(6,:));
    fix(6,2) = find(comevents(7,:));   
    
    %% Break the data into the five runs

    % Find the starts of each run
    starts = find(data(:,2)==1);
    
    if subject == 2459
        starts(3) = []; % restarted run 3 so don't use the first version
    elseif subject == 2483
        starts(1:2) = []; % only using 3-4 and 6 for this subject due to issues with comments + fell asleep in original run 5
        starts(3) = [];
    end % if subject
        
   count1 = 1;
   count2 = 30;
        
   all_sniff = []; % to store all final sniff traces into
   all_events = []; % to store events and sniff params (amp, lat, vol)
   
   for run = 1:length(starts)
       
       what_events = [];
       where_events = [];
       
       % set up the run and trial info
       sniff = [];
       sniff(1:points,1) = data(starts(run):starts(run)+points-1,1); % sniff data for full run
       sniff(1:points,2) = data(starts(run):starts(run)+points-1,2); % keep track of the events still
       
       %% Update to the new (correct) event types
       
       rep = [];
       
       rep(1,1:5)=find(sniff(:,2)==2); % vals to replace
       rep(2,1:5)=find(sniff(:,2)==3);
       rep(3,1:5)=find(sniff(:,2)==4);
       rep(4,1:5)=find(sniff(:,2)==5);
       rep(5,1:5)=find(sniff(:,2)==6);
       rep(6,1:5)=find(sniff(:,2)==7);
   
       for old = 2:7
           sniff(rep(old-1,:),2)=fix(old-1,2);
       end % for old
       
       %% Temporal smoothing
       
       sniff(:,1) = smoothdata(sniff(:,1),'movmean',50); % s for smoothed; smooth the datapoints: moving window of 500 ms (moving is default option, 50 indicates 500 ms/ 10s per point = 50 datapoints in that frame)
       
       %% High pass filtering       
       
       sniff(:,1) = highpass(sniff(:,1),.02,100); % f for filtered; 0.02 hz is a 50s period cutoff for the high pass filter, starting frequency is 100 hz sample rate

       %% Normalization

       sniff(:,1) = (sniff(:,1) - mean(sniff(:,1)))/std(sniff(:,1)); % subtract the mean and divide by the SD of the run trace
       
       %% Isolate trial-wise sniff traces and stack them together
       
       what_events(1:32,1) = run;
       
       % Use the normalized sniff trace
       [where_events,~,what_events(:,2)] = find(sniff(:,2));
       where_events([1 32],:) = []; % remove first and last events (start and end of run, not acutal trials); these are the start of each sniff cue even
       what_events([1 32],:) = [];
       
       trial_sniff = zeros(30,500); % to stack the sniff traces into
       
       for trial = 1:30 % 30 trials per run
           
           base_start = [];
           base_end = [];
           base_span = [];
           base_val = [];
           base_trial = [];
           trial_start = [];
           trial_end = [];
           pos_val1 = [];
           pos_val2 = [];
           switch_val = [];
           switch_where = [];
           pick = [];
           sel = [];
           
           window = 0.75; % set the window for how long before/after sniff onset to find the minimum
           base_start = where_events(trial,1)-(samprate*window)-1; % look at the 1 s preceding or following sniff cue onset
           base_end = where_events(trial,1)+(samprate*window);
           base_span = sniff(base_start:base_end,1);
           
           pos_val1 = base_span>0; % determine where the base_span is above zero
           pos_val2 = NaN;
           pos_val2 = [pos_val2; pos_val1];
           pos_val1 = [pos_val1; 0];
           switch_where = find(pos_val2-pos_val1==-1); % this finds the flip from 0 to 1 (indicating change from exhalation to inhalation)
           switch_val = base_span(switch_where,:);
           switch_where = switch_where-1;
                 
           
           % choose the switch_where that is closest to the original sniff
           % cue onset (at samprate*window)
           if length(switch_where)>1
               pick = abs(switch_where-(samprate*window));
               [~,sel]=min(pick);
               switch_where = switch_where(sel,1);
               switch_val = switch_val(sel,1);
           end 
          
           trial_start = base_start+switch_where;
           trial_end = trial_start + (samprate*5)-1; % go out 5s from the min for the full sniff trace
           
           if isempty(trial_start)
               trial_sniff(trial,:) = NaN;
           else
              trial_sniff(trial,:) = sniff(trial_start:trial_end,1)-switch_val;
           end
           
           
       end % for trial
       
       % Compile all of the run traces and events together
       all_sniff = [all_sniff; trial_sniff];
       all_events = [all_events; what_events];
       
   end % end run 1-5
   
   %% Remove the NaN sniff traces (does not go from exhalation to inhalation)
   
   nan_trace = [];
   nan_trace = isnan(all_sniff(:,1));
   all_sniff(nan_trace,:)=[];
   all_events(nan_trace,:)=[];
   
      %% Determine sniff parameters for each trial
   
   for trace = 1:size(all_sniff,1) % 150 total trials
            
       this_trace = [];
       pos_val3 = [];
       pos_val4 =[];   
       switch_where2 = [];
       this_trace_cut = [];
       amp = [];
       lat = [];
       volume = [];
       dur = [];
       
       this_trace = all_sniff(trace,:);       
       pos_val3 = this_trace>0; % determine where the base_span is above zero
       pos_val4 = NaN;
       pos_val4 = [pos_val4, pos_val3];
       pos_val3 = [pos_val3, 1];
       switch_where2 = find(pos_val4-pos_val3==1); % this finds the flip from 1 to 0 (indicating change from inhalation back to exhalation)   
       
       if isempty(switch_where2)
           [~,switch_where2] = min(this_trace(1,0.5*samprate:3*samprate)); % use the minimum from 1-3s if it doesn't actually pass through zero
           switch_where2 = switch_where2 + 0.5*samprate;
           
           % Other option would be to remove the trace fully
           % all_sniff(trace,:) = NaN; % remove the trace if it doesn't go back down to baseline
           % all_events(trace,:) = NaN;
       else
           switch_where2 = switch_where2(1,1);           
       end
       
       this_trace_cut = this_trace(1:switch_where2); % full sniff trace INHALATION only (above 0 baseline)
       
       % The full sniff duration is where it switches back below zero
       dur = switch_where2/samprate; % was in ms, divide by samp rate to get to sec
        
       % Derivative provides the instantaneous rate of change at that point
       deriv = diff(this_trace_cut).*samprate; % this will find the rate per sec
       max_flow = max(deriv); % Max airflow rate
       mean_flow = mean(deriv(deriv>0)); % Mean airflow rate
       
       % Determine amplitude and latency
       [amp, lat] = max(this_trace_cut(1,:));
       lat = lat/samprate; % lat was in ms, divide by samp rate to get to sec
       
       % Determine the volume with the trapezoidal method
       volume = (trapz([1:length(this_trace_cut)],this_trace_cut)/samprate); % taken in ms, divide by samp rate to get to sec
       
       all_events(trace,3) = amp; % col 3 is amplitude
       all_events(trace,4) = lat; % col 4 is latency
       all_events(trace,5) = volume; % col 5 is volume
       all_events(trace,6) = dur; % col 6 is duration
       all_events(trace,7) = max_flow; % col 7 is max airflow rate
       all_events(trace,8) = mean_flow; % col 8 is mean airflow rate
   
   end % for trace
   
   %% Remove the NaN sniff traces (does not go from inhalation to exhalation)
   
   nan_trace2 = [];
   nan_trace2 = isnan(all_sniff(:,1));
   all_sniff(nan_trace2,:)=[];
   all_events(nan_trace2,:)=[];  
   
   %% Remove extreme outlier traces by scan run
   
   num_runs = length(all_events)/30; % 30 trials per run
   out = [];
   
   for this_run = 1:num_runs
       
       nrun = find(all_events(:,1)==this_run);
       out(nrun,1) = isoutlier(all_events(nrun,3),'Mean','ThresholdFactor',4); % more than 4 standard deviations from the mean
       out(nrun,2) = isoutlier(all_events(nrun,4),'Mean','ThresholdFactor',4);
       out(nrun,3) = isoutlier(all_events(nrun,5),'Mean','ThresholdFactor',4);
       out(nrun,4) = isoutlier(all_events(nrun,6),'Mean','ThresholdFactor',4);
       out(nrun,5) = isoutlier(all_events(nrun,7),'Mean','ThresholdFactor',4);
       out(nrun,6) = isoutlier(all_events(nrun,8),'Mean','ThresholdFactor',4);
       
   end % for num_runs
   
   out(:,7) = sum(out,2);
   all_events(out(:,7)>0,:)=[];
   all_sniff(out(:,7)>0,:)=[];
   
   sniff_table.Count(sniff_table.SubjectID==subject,:) = length(all_events);
   
   %% Determine average sniff parameters per event type (for plots and ANOVAs)
   
   sub_sniff = [];
   sub_event = [];
   
   for event = 1:6 
       
       av_amp = [];
       av_lat = [];
       av_volume = [];
       av_dur = [];
       av_max_flow = [];
       av_mean_flow = [];
       
       nevent = find(all_events(:,2)==event);
       av_amp = mean(all_events(nevent,3));
       av_lat = mean(all_events(nevent,4));
       av_volume = mean(all_events(nevent,5));
       av_dur = mean(all_events(nevent,6));
       av_max_flow = mean(all_events(nevent,7));
       av_mean_flow = mean(all_events(nevent,8));
       
       sub_sniff(event,:) = mean(all_sniff(nevent,:));
       sub_event(event,1) = subject;
       sub_event(event,2) = event; % col 1 is event
      
       sniff_table.Amplitude(sniff_table.SubjectID==subject & sniff_table.Event==event,:)=av_amp;
       sniff_table.Latency(sniff_table.SubjectID==subject & sniff_table.Event==event,:)=av_lat;
       sniff_table.Volume(sniff_table.SubjectID==subject & sniff_table.Event==event,:)=av_volume;
       sniff_table.Duration(sniff_table.SubjectID==subject & sniff_table.Event==event,:)=av_dur;
       sniff_table.MaxFlow(sniff_table.SubjectID==subject & sniff_table.Event==event,:)=av_max_flow;
       sniff_table.MeanFlow(sniff_table.SubjectID==subject & sniff_table.Event==event,:)=av_mean_flow;       
       
   end % for event
     
   full_sniff = [full_sniff; sub_sniff];
   full_event = [full_event; sub_event];
   subcount = subcount + 6;
  
end % for subject

clearvars -except sniff_table full_sniff full_event svm_table

%% Load the full data table (for other non-sniffing variables)

dir = pwd;
data = readtable([dir '/excel_outputs/odor_imagery_baseline_data_n45_aug23_2022.xlsx']);
data(data.SubjectID==2478,:) = []; % subject who did not scan

%% Join tables together

data_cor = data; % keep a clean copy for testing correlations

data = [data; data; data; data; data; data];
data.Event(1:44,:)=1;
data.Event(45:88,:)=2;
data.Event(89:132,:)=3;
data.Event(133:176,:)=4;
data.Event(177:220,:)=5;
data.Event(221:264,:)=6;

data = join(data,sniff_table,'keys',{'SubjectID','Event'});

clearvars -except data sniff_table full_sniff full_event data_cor;

%% Pull out sniff parameters 
% For each event type to plot in Prism (rose and cookie only, not including clean air here)

data_cor.IRAmplitude = sniff_table.Amplitude(sniff_table.Event==2,:);
data_cor.IRLatency = sniff_table.Latency(sniff_table.Event==2,:);
data_cor.IRVolume = sniff_table.Volume(sniff_table.Event==2,:);
data_cor.IRDuration = sniff_table.Duration(sniff_table.Event==2,:);
data_cor.IRMaxFlow = sniff_table.MaxFlow(sniff_table.Event==2,:);
data_cor.IRMeanFlow = sniff_table.MeanFlow(sniff_table.Event==2,:);

data_cor.ICAmplitude = sniff_table.Amplitude(sniff_table.Event==4,:);
data_cor.ICLatency = sniff_table.Latency(sniff_table.Event==4,:);
data_cor.ICVolume = sniff_table.Volume(sniff_table.Event==4,:);
data_cor.ICDuration = sniff_table.Duration(sniff_table.Event==4,:);
data_cor.ICMaxFlow = sniff_table.MaxFlow(sniff_table.Event==4,:);
data_cor.ICMeanFlow = sniff_table.MeanFlow(sniff_table.Event==4,:);

data_cor.SRAmplitude = sniff_table.Amplitude(sniff_table.Event==1,:);
data_cor.SRLatency = sniff_table.Latency(sniff_table.Event==1,:);
data_cor.SRVolume = sniff_table.Volume(sniff_table.Event==1,:);
data_cor.SRDuration = sniff_table.Duration(sniff_table.Event==1,:);
data_cor.SRMaxFlow = sniff_table.MaxFlow(sniff_table.Event==1,:);
data_cor.SRMeanFlow = sniff_table.MeanFlow(sniff_table.Event==1,:);

data_cor.SCAmplitude = sniff_table.Amplitude(sniff_table.Event==3,:);
data_cor.SCLatency = sniff_table.Latency(sniff_table.Event==3,:);
data_cor.SCVolume = sniff_table.Volume(sniff_table.Event==3,:);
data_cor.SCDuration = sniff_table.Duration(sniff_table.Event==3,:);
data_cor.SCMaxFlow = sniff_table.MaxFlow(sniff_table.Event==3,:);
data_cor.SCMeanFlow = sniff_table.MeanFlow(sniff_table.Event==3,:);

%% Calculate differences for cookie minus rose

% Difference of imagine cookie - imagine rose sniffing
data_cor.ICminusIRAmplitude = data_cor.ICAmplitude - data_cor.IRAmplitude;
data_cor.ICminusIRLatency = data_cor.ICLatency - data_cor.IRLatency;
data_cor.ICminusIRVolume = data_cor.ICVolume - data_cor.IRVolume;
data_cor.ICminusIRDuration = data_cor.ICDuration - data_cor.IRDuration;
data_cor.ICminusIRMaxFlow = data_cor.ICMaxFlow - data_cor.IRMaxFlow;
data_cor.ICminusIRMeanFlow = data_cor.ICMeanFlow - data_cor.IRMeanFlow;

%% Test for correlations with odor imagery measures

% Check for correlations with odor imagery ability: VOIQ rev
[rho,pval] = corr(data_cor.VOIQrev,data_cor.ICminusIRAmplitude)
[rho,pval] = corr(data_cor.VOIQrev,data_cor.ICminusIRLatency)
[rho,pval] = corr(data_cor.VOIQrev,data_cor.ICminusIRVolume)
[rho,pval] = corr(data_cor.VOIQrev,data_cor.ICminusIRDuration)
[rho,pval] = corr(data_cor.VOIQrev,data_cor.ICminusIRMaxFlow)
[rho,pval] = corr(data_cor.VOIQrev,data_cor.ICminusIRMeanFlow)

% Check for correlations with odor imagery ability: Odor int
[rho,pval] = corr(data_cor.OdorInt,data_cor.ICminusIRAmplitude)
[rho,pval] = corr(data_cor.OdorInt,data_cor.ICminusIRLatency)
[rho,pval] = corr(data_cor.OdorInt,data_cor.ICminusIRVolume)
[rho,pval] = corr(data_cor.OdorInt,data_cor.ICminusIRDuration)
[rho,pval] = corr(data_cor.OdorInt,data_cor.ICminusIRMaxFlow)
[rho,pval] = corr(data_cor.OdorInt,data_cor.ICminusIRMeanFlow)

% Check for correlations with odor imagery ability: R pir imag decoding 
data_neural = data_cor;
data_neural(isnan(data_neural.Rpir_imag_pat_sig),:)=[];
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.ICminusIRAmplitude)
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.ICminusIRLatency)
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.ICminusIRVolume)
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.ICminusIRDuration)
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.ICminusIRMaxFlow)
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.ICminusIRMeanFlow)

%% Set-up and test ANOVAS for rose and cookie (assess interactions with odor int)

data_odors = data;
data_odors(data_odors.Event==5,:)=[]; % remove smell clean air
data_odors(data_odors.Event==6,:)=[]; % remove imagine clean air

data_odors.Cond(data_odors.Event==1 | data_odors.Event==3,:) = 0; % smell condition
data_odors.Cond(data_odors.Event==2 | data_odors.Event==4,:) = 1; % imagine condition
data_odors.Odor(data_odors.Event==1 | data_odors.Event==2,:) = 0; % rose odor
data_odors.Odor(data_odors.Event==3 | data_odors.Event==4,:) = 1; % cookie odor

data_odors.Cond = nominal(data_odors.Cond);
data_odors.Odor = nominal(data_odors.Odor);

% Test for main effects of condition, odor, or odor int or interactions on sniffing

lme = fitlme(data_odors,'Amplitude~Cond*Odor*OdorInt+(1|SubjectID)');
lme_anova = anova(lme); % ns

lme = fitlme(data_odors,'Latency~Cond*Odor*OdorInt+(1|SubjectID)');
lme_anova = anova(lme); % ns

lme = fitlme(data_odors,'Volume~Cond*Odor*OdorInt+(1|SubjectID)');
lme_anova = anova(lme); % ns

lme = fitlme(data_odors,'Duration~Cond*Odor*OdorInt+(1|SubjectID)');
lme_anova = anova(lme); % ns

lme = fitlme(data_odors,'MaxFlow~Cond*Odor*OdorInt+(1|SubjectID)');
lme_anova = anova(lme); % ns

lme = fitlme(data_odors,'MeanFlow~Cond*Odor*OdorInt+(1|SubjectID)');
lme_anova = anova(lme); % ns

%% Isolate event sniff traces (for Prism plotting)

SR_trace = full_sniff(full_event(:,2)==1,:);
SC_trace = full_sniff(full_event(:,2)==3,:);
IR_trace = full_sniff(full_event(:,2)==2,:);
IC_trace = full_sniff(full_event(:,2)==4,:);
