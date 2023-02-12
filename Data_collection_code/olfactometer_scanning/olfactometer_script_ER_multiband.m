% Script to run the olfactometer and deliver odors with audio cues during
% fMRI scanning

% Updated for current study by: Emily Perszyk - 9/21/2020 
% Original author: Marga G Veldhuizen

%% GENERAL INFORMATION

% The order in which the stimuli are presented, the soa times, and the channel are
% loaded from txt files in the subdirectory "source_files." Data is written 
% to the subdirectory "data" folder 

% This is the script for an odor study with event-related (IR) design and
% multiband imaging.
% This script is not dependent on cogent. Messages about pump tiggering are 
% written to the matlab command window. No visuals are shown on screen for 
% the subject; only audio cues are played. Odor and odor trigger times are 
% all logged and written to a file at the end of the script. If the script 
% fails halfway, no worries -- the times are exactly the same across all 
% subjects. The order of stimuli and the soa between stimuli is all 
% determined by the input .txt files that are in the folder source_files. 
% As opposed to earlier odor scripts, the actual odor to be presented is 
% determined by this script, not by the order in the .vi file on the 
% olfactometer. This .txt file will be the only thing you have to adapt for
% your study. 

% This script is absolutely dependent on being connected to the DIO to send
% signals to the olfactometer. For troubleshooting you can skip it, but
% otherwise needed!

% Block scripts differ from event-related scripts in the sense that the
% soas are different.

% Channel IDs on olfactometer go from 1-10, not 0-9

% ------------------- MARGA INFO ------------------- %

% updated 8/5/2014 with while loop for SOA 
% updated november 2014 for saving functions
% updated january 2015 for olfactometer components
% updated april 2019 for new DIO nidaq

% ------------------- EMILY INFO ------------------- %

% CONDITIONS
% event #1 - channel #1 - odor: PEA - condition: smell rose
% event #2 - channel #5 - odor: odorless - condition: imagine rose
% event #3 - channel #2 - odor: cookie - condition: smell cookie
% event #4 - channel #5 - odor: odorless - condition: imagine cookie
% event #5 - channel #5 - odor: odorless - condition: smell odorless
% event #6 - channel #5 - odor: odorless - condition: imagine odorless

% EVENTS WITHIN A TRIAL
% audio for condition (= 2 seconds) "Smell / imagine _____."
% audio for sniff countdown (= 3 seconds) "3,2,1...sniff"
% odor presentation (= 3 seconds)
% jitter (= 7-17 seconds; mean ~ 10s)

% EXPLAIN CODE SENT TO OTHER LAPTOP VIA POWERLAB UNIT
% event coding for chart (via DIO on spirometer)
% digital byte 0 = nothing/clear
% digital byte 1 = start run
% digital byte 2 = smell rose (PEA)
% digital byte 3 = imagine rose (odorless)
% digital byte 4 = smell cookie (cookie)
% digital byte 5 = imagine cookie (odorless)
% digital byte 6 = smell odorless (odorless)
% digital byte 7 = imagine odorless (odorless)
% digital byte 8 = stop run

%% -------------------- PROGRAM SETUP SECTION -------------------- %%

%% Get rid of functionality that lingers in matlab space

if exist ('dio_trigger') % unmount dio if still left from a previous script
% outputSingleScan(dio_trigger,0); % trigger off
% outputSingleScan(dio_channel,[0 0 0 0 0 0 0 0]); % channel 1 PEA
% outputSingleScan(dio_powerlab,[0 0 0 0 0 0 0 0]);
        delete(dio_trigger);
        delete(dio_channel);
        delete(dio_powerlab);
        clear dio_trigger
        clear dio_channel
        clear dio_powerlab
        clear 
end
clear;
warning('off','MATLAB:dispatcher:InexactMatch')
warning('off','MATLAB:dispatcher:InexactCaseMatch')

%% Set up communication with external devices

h = warndlg(sprintf('Remember to switch off visual input to projector in scanner \n \n but only if the projector is connected to this computer'),'Wait');
uiwait(h);

% Device at the MOCK scanner is Dev1. Device at the REAL scanner is Dev2. 

% initialize DIO
    dio_trigger=daq.createSession('ni'); % set up lines to send trigger to olfactometer
    addDigitalChannel(dio_trigger,'Dev2','Port2/Line0','OutputOnly')
    dio_channel=daq.createSession('ni');  % set up lines to send event selection to olfactometer
    addDigitalChannel(dio_channel,'Dev2','Port0/Line0:7','OutputOnly')
    dio_powerlab=daq.createSession('ni');  % set up lines to send bytes to Chart
    addDigitalChannel(dio_powerlab,'Dev2','Port1/Line0:7','OutputOnly')
    % make sure all of these are set to 0
    outputSingleScan(dio_trigger,0); % trigger off
    outputSingleScan(dio_channel,[0 0 1 0 0 0 0 0]); % channel 5 odorless
    outputSingleScan(dio_powerlab,[0 0 0 0 0 0 0 0]);

%% Get user inputs

% get the subject number
sub_num =inputdlg('subject number?','input',1);

% which scan? (if you have multiple scans)
strscan={'scan 1'};
lstsz = [120 60];
[scan,v]= listdlg('PromptString','Choose scan:','SelectionMode','single','Listsize',lstsz ,'ListString',strscan);
scanstr = char(strscan(scan));

% ask user to specify a prot (file with order of presentations and soas in folder "source_files")
    strprot = {'protA', 'protB', 'protC', 'protD','protE'};
    lstsz = [120 60];
    [order,v]= listdlg('PromptString','Enter prot file:','SelectionMode','single','Listsize',lstsz ,'ListString',strprot);
    orderstr = char(strprot(order));
    orderstr1 = [orderstr,'.txt'];
    
%% Create subject folder for data

swd = pwd;
cd data
dirname = ['subject_' sub_num{1},'_', scanstr]; % create outputfile name
mkdir(dirname);
cd(swd)
    
%% Load files

cd source_files

% audio files
[r,fs]=audioread('sniff.mp3'); % load sniff countdown soundfile
[r1,fs1]=audioread('smell_rose.mp3');
[r2,fs2]=audioread('imagine_rose.mp3');
[r3,fs3]=audioread('smell_cookie.mp3');
[r4,fs4]=audioread('imagine_cookie.mp3');
[r5,fs5]=audioread('smell_odorless.mp3');
[r6,fs6]=audioread('imagine_odorless.mp3');
pause(.5);

% event orders with intertrial intervas (soa) and odor channels
[event, soa1, odor]=textread((orderstr1),'%f\t%f\t%f','whitespace',' \t');
cd(swd)

% load first odor
pick_channel(odor(1),dio_channel);
pause(.5);
%% --- Preallocate variables for output datafile --- %

onset_array=zeros(length(event),6);
t_starttrial=zeros(length(event),1);
odor_onset=zeros(length(event),1);
t_endtrial=zeros(length(event),1);
dur=zeros(length(event),1);


% manual trigger or scanner triggered (you will have to hook up the scanner
% USB to this laptop, which means that you cannot simultanously collect
% ratings with the other laptop for example)
h = warndlg('This script will trigger automatically with the first TR after you press OK. Click OK and let the MR technologist know they can start the scan.');
    uiwait(h);
   
%% -------------------- PROGRAM RUN SECTION -------------------- %%

%% Initate scanner triggering 

triggerwait=0;
disp('waiting for first TR');
    while (triggerwait ~= 53) % 53 is ascii code for 5 key
         triggerwait = getkey;    
    end
disp('script running!');  
send_event_powerlab(1,dio_powerlab) % write "start odor run" Chart on other computertimecont=clock; % log start time of run
timecont=clock; % log start time of run

%% Loop for all real trials

for i=1:length(event)  % i=the trial you're on, beginning with the first trial and continuing through the rest of the trials
    t_starttrial(i) = etime(clock,timecont);    
    
    if event(i) == 1 
        sound(r1,fs1); % play "smell rose"
    elseif event(i) == 2 
        sound(r2,fs2); % play "imagine rose"
    elseif event(i) == 3 
        sound(r3,fs3); % play "smell cookie"
    elseif event(i) == 4 
        sound(r4,fs4); % play "imagine cookie"
    elseif event(i) == 5 
        sound(r5,fs5); % play "smell odorless"
    elseif event(i) == 6 
        sound(r6,fs6); % play "imagine odorless"
    end
    
    pause(2.2); % wait for condition audio to finish
    sound(r,fs); % play sniff countdown 
    pause(2.6); % wait for sniff countdown to finish
    str8=sprintf('trial #%g\t out of %g\t presenting odor event #%g\t from channel #%g\t',i,length(event),event(i),odor(i));
    disp(str8);
    outputSingleScan(dio_trigger,1); % trigger on
    event_powerlab=event(i)+1;
    send_event_powerlab(event_powerlab,dio_powerlab) % write eventtype to Chart on other computer
    odor_onset(i)=etime(clock,timecont); % record odor onset
    pause(.5); 
    outputSingleScan(dio_trigger,0); % trigger off
    send_event_powerlab(0,dio_powerlab); % turn signal to Chart on other computer off
    pause(2.455); % subtract out delay (.045s or 45ms) for running code (trigger off and send to Chart) - model smell as 3s
    
    if i <= (length(event)-1) % for all trials but the last one
        pick_channel(odor(i+1),dio_channel)
    end
    
    soastarttime=clock;
    while (dur(i) < (soa1(i))) % do nothing as long as soa has not passed (with time to spare to trigger the pump for the next trial)
        soatime = clock;
        dur(i) = etime(soatime,soastarttime); 
    end
    t_endtrial(i) = etime(clock,timecont);
    onset_array(i,:)= [i event(i) odor(i) t_starttrial(i) odor_onset(i) t_endtrial(i)]; %log all info
end % end of for loop
send_event_powerlab(8,dio_powerlab) % write "stop odor run" Chart on other computertimecont=clock; % log start time of run
timeend = etime(clock,timecont); % log end of run

%% Saving results and closing all communication

cd data
cd(dirname)
outputfile =  sprintf('sub%s_%s_%s_outputfile',sub_num{1}, scanstr, orderstr); % create outputfile name
save(outputfile, 'onset_array'); % save output file
cd(swd)

pause(.1);
outputSingleScan(dio_trigger,0); % trigger off
outputSingleScan(dio_channel,[0 0 1 0 0 0 0 0]); % channel 5 odorless
outputSingleScan(dio_powerlab,[0 0 0 0 0 0 0 0]);
delete(dio_trigger);
delete(dio_channel);
delete(dio_powerlab);
clear dio_trigger
clear dio_channel
clear dio_powerlab
disp('Program Ended')
clear all;

function pick_channel(odor,dio_channel)
    switch odor
        case 1 
            outputSingleScan(dio_channel,[0 0 0 0 0 0 0 0]); % channel 1 PEA           
        case 2    
            outputSingleScan(dio_channel,[1 0 0 0 0 0 0 0]); % channel 2 cookie               
        case 5     
            outputSingleScan(dio_channel,[0 0 1 0 0 0 0 0]); % channel 5 odorless
    end
end

function send_event_powerlab(event_powerlab,dio_powerlab)
    switch event_powerlab
        case 0
            outputSingleScan(dio_powerlab,[0 0 0 0 0 0 0 0]); % digital byte 0
        case 1
            outputSingleScan(dio_powerlab,[1 0 0 0 0 0 0 0]); % digital byte 1 start odor run  
        case 2
            outputSingleScan(dio_powerlab,[0 1 0 0 0 0 0 0]); % digital byte 2 smell rose (PEA) 
        case 3
            outputSingleScan(dio_powerlab,[1 1 0 0 0 0 0 0]); % digital byte 3 imagine rose (odorless) 
        case 4
            outputSingleScan(dio_powerlab,[0 0 1 0 0 0 0 0]); % digital byte 4 smell cookie (cookie)
        case 5  
            outputSingleScan(dio_powerlab,[1 0 1 0 0 0 0 0]); % digital byte 5 imagine cookie (odorless)
        case 6 
            outputSingleScan(dio_powerlab,[0 1 1 0 0 0 0 0]); % digital byte 6 smell odorless (odorless)
        case 7
            outputSingleScan(dio_powerlab,[1 1 1 0 0 0 0 0]); % digital byte 7 imagine odorless (odorless)
        case 8
            outputSingleScan(dio_powerlab,[0 0 0 1 0 0 0 0]); % digital byte 8 stop odor run
    end
end
