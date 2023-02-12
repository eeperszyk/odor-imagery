% Odor imagery study - script for main analyses
% Emily Perszyk updated 2/12/23

%% Notes - general info about some variables collected in the study

% Post appended to a variable name denotes completion at 1-year follow-up

% For internal states ratings:
    % 1 - S1 (from states, odors, thresholds)
    % 2 - S1 (from before craving task)
    % 3 - S2 or S3 fMRI training day (from before odor interference task)
    % 4 - S2 or S3 behavioral day (from before visual interference task)
    % 5 - S2 or S3 behavioral day (from before no imagery task)
    % 6 - S2 or S3 fMRI training day (from before cookie taste test)
    % 7 - S4 (from pre-scan ratings)
    % 8 - S4 (from post-scan ratings)
    % 9 - S5 followup (from before craving task)
    % 10 - S5 followup (from before cookie taste test)
    
% For all rating scale anchors:
    % All internal states: 0-1
    % Familiarity: 0-1
    % Wanting (to eat): 0-1
    % Intensity: log of original gLMS values
    % Liking: -100 to +100 (original LHS values)
    % Craving: 0-1
    
% gLMS marker positions AFTER log transformation
    % strongest imaginable sensation of any kind - 2 (100 scale max of gLMS)
    % very strong - 1.71 (51 scale)
    % strong - 1.54 (35 scale)
    % moderate - 1.23 (17 scale)
    % weak - 0.78 (6 scale)
    % barely detectable - 0.15 (1.4 scale)
    % no sensation - 0 (0 scale min of gLMS)

% LHS marker positions (no transformation)
    % Most liked sensation imaginable: 100 (2.20 log mean)
    % Like extremely: 65.72 (2.01)
    % Like very much: 44.43 (1.84)
    % Like moderately: 27.93 (1.45)
    % Like slightly: 6.25 (0.99)
    % Dislike slightly: -5.92 (0.98)
    % Dislike moderately: -17.59 (1.45)
    % Dislike very much: -41.58 (1.83)
    % Dislike extremely: -62.89 (2.01)
    % Most disliked sensation imaginable: -100 (2.21)

% For interference task data: all read-outs are as a percentage (of trials
% correct)
    % odor int cookie: effect of imagining rose on detection of cookie
    % odor int rose: effect of imagining cookie on detection of rose

%% Final sample

% BASELINE
% Total max N = 45 (excluded 2484, 2502, 2509)
% Scan total n = 44 (missing 2478)
% Cookie intake n = 43 behavior (excluded 1681, 2508), 42 in scanner

% FOLLOWUP 
% Total n = 43 (1 did not complete followup: 2459; excluded 2507 for dBMI)

%% Load the data from saved excel sheets

clear all;

dir = pwd;
data = readtable([dir '/excel_outputs/odor_imagery_baseline_data_n45_aug23_2022.xlsx']);
crav_data = readtable([dir '/excel_outputs/odor_imagery_crav_data_n45_aug23_2022.xlsx']); % Craving
data_followup = readtable([dir '/excel_outputs/odor_imagery_followup_data_n43_aug23_2022.xlsx']);
NCS = readtable([dir '/raw_data/NCS_responses_food_anova.xlsx']); % Specific to NCS-food responses

%% Setup additional tables

% Remove individuals who did not complete the visual/no imagery control
% conditions for psychophysical testing:
psycho_data = data; % psychophysical dataset 
psycho_data(isnan(psycho_data.Hunger4),:)=[];

% Remove outliers for cookie intake:
a=isoutlier(data.TotalCookieIntake,'mean'); % 1681, 2508 
% default in matlab: outlier is a value that is more than three scaled
% median absolute deviations (MAD) away from the median OR three standard
% deviations away from the mean if including 'mean'
data_cookie = data;
data_cookie(data_cookie.TotalCookieIntake>150,:)=[]; % removes 2 people (n=43)
clear a

data_cookie_followup = data_followup;
data_cookie_followup(data_cookie_followup.TotalCookieIntake>150,:)=[]; % removes 2 people (n=43)

data_scan = data;
data_scan(data_scan.SubjectID==2478,:)=[]; % did not scan

%% Make int tables for anovas

% --- Full table for odor vs visual vs no imagery including smell type --- %
int = table;
h = height(psycho_data); % number of people for odor int

for i = 1:h
    % General info
    int.SubjectID(i)=psycho_data.SubjectID(i);
    int.BMIgroup(i)=psycho_data.BMIgroup(i);
    int.Sex(i)=psycho_data.Sex(i);
    int.S2type(i)=psycho_data.S2type(i);
    int.SubjectID(i+h)=psycho_data.SubjectID(i);
    int.BMIgroup(i+h)=psycho_data.BMIgroup(i);
    int.Sex(i+h)=psycho_data.Sex(i);
    int.S2type(i+h)=psycho_data.S2type(i);
    int.SubjectID(i+2*h)=psycho_data.SubjectID(i);
    int.BMIgroup(i+2*h)=psycho_data.BMIgroup(i);
    int.Sex(i+2*h)=psycho_data.Sex(i);
    int.S2type(i+2*h)=psycho_data.S2type(i);
    int.SubjectID(i+3*h)=psycho_data.SubjectID(i);
    int.BMIgroup(i+3*h)=psycho_data.BMIgroup(i);
    int.Sex(i+3*h)=psycho_data.Sex(i);
    int.S2type(i+3*h)=psycho_data.S2type(i);
    int.SubjectID(i+4*h)=psycho_data.SubjectID(i);
    int.BMIgroup(i+4*h)=psycho_data.BMIgroup(i);
    int.Sex(i+4*h)=psycho_data.Sex(i);
    int.S2type(i+4*h)=psycho_data.S2type(i);
    int.SubjectID(i+5*h)=psycho_data.SubjectID(i);
    int.BMIgroup(i+5*h)=psycho_data.BMIgroup(i);
    int.Sex(i+5*h)=psycho_data.Sex(i);
    int.S2type(i+5*h)=psycho_data.S2type(i);
    int.SubjectID(i+6*h)=psycho_data.SubjectID(i);
    int.BMIgroup(i+6*h)=psycho_data.BMIgroup(i);
    int.Sex(i+6*h)=psycho_data.Sex(i);
    int.S2type(i+6*h)=psycho_data.S2type(i);
    int.SubjectID(i+7*h)=psycho_data.SubjectID(i);
    int.BMIgroup(i+7*h)=psycho_data.BMIgroup(i);
    int.Sex(i+7*h)=psycho_data.Sex(i);
    int.S2type(i+7*h)=psycho_data.S2type(i);
    int.SubjectID(i+8*h)=psycho_data.SubjectID(i);
    int.BMIgroup(i+8*h)=psycho_data.BMIgroup(i);
    int.Sex(i+8*h)=psycho_data.Sex(i);
    int.S2type(i+8*h)=psycho_data.S2type(i);
    int.SubjectID(i+9*h)=psycho_data.SubjectID(i);
    int.BMIgroup(i+9*h)=psycho_data.BMIgroup(i);
    int.Sex(i+9*h)=psycho_data.Sex(i);
    int.S2type(i+9*h)=psycho_data.S2type(i);
    
    % Odor int - rose match
    int.Cond(i)=0; % 0 for odor int (condition)
    int.Smell(i)=0; % 0 for rose
    int.Detection(i)=0; % 0 for match
    int.Accuracy(i)=psycho_data.Odor_sRiR(i); % accuracy
    
    % Odor int - rose mismatch
    int.Cond(i+h)=0; % 0 for odor int (condition)
    int.Smell(i+h)=0; % 0 for rose
    int.Detection(i+h)=1; % 1 for mismatch
    int.Accuracy(i+h)=psycho_data.Odor_sRiC(i); % accuracy
    
    % Odor int - cookie match
    int.Cond(i+2*h)=0; % 0 for odor int (condition)
    int.Smell(i+2*h)=1; % 1 for cookie
    int.Detection(i+2*h)=0; % 0 for match
    int.Accuracy(i+2*h)=psycho_data.Odor_sCiC(i);
    
    % Odor int - cookie mismatch
    int.Cond(i+3*h)=0; % 0 for odor int (condition)
    int.Smell(i+3*h)=1; % 1 for cookie
    int.Detection(i+3*h)=1; 
    int.Accuracy(i+3*h)=psycho_data.Odor_sCiR(i);

    % Visual int - rose match
    int.Cond(i+4*h)=1; % 1 for visual int (condition)
    int.Smell(i+4*h)=0;
    int.Detection(i+4*h)=0; 
    int.Accuracy(i+4*h)=psycho_data.Visual_sRiR(i);  
    
    % Visual int - rose mismatch
    int.Cond(i+5*h)=1; % 1 for visual int (condition)
    int.Smell(i+5*h)=0;
    int.Detection(i+5*h)=1; 
    int.Accuracy(i+5*h)=psycho_data.Visual_sRiC(i);  
    
    % Visual int - cookie match
    int.Cond(i+6*h)=1; % 1 for visual int (condition)
    int.Smell(i+6*h)=1; 
    int.Detection(i+6*h)=0; 
    int.Accuracy(i+6*h)=psycho_data.Visual_sCiC(i);  
    
    % Visual int - cookie mismatch
    int.Cond(i+7*h)=1; % 1 for visual int (condition)
    int.Smell(i+7*h)=1; 
    int.Detection(i+7*h)=1; 
    int.Accuracy(i+7*h)=psycho_data.Visual_sCiR(i);
    
    % No imagery - rose ("match")
    int.Cond(i+8*h)=2; % 2 for no imagery
    int.Smell(i+8*h)=0; 
    int.Detection(i+8*h)=2; % 2 for no imagery
    int.Accuracy(i+8*h)=psycho_data.NoImageryRoseCorrect(i);
    
    % No imagery - cookie ("match")
    int.Cond(i+9*h)=2; % 2 for no imagery
    int.Smell(i+9*h)=1; 
    int.Detection(i+9*h)=2; % 2 for no imagery
    int.Accuracy(i+9*h)=psycho_data.NoImageryCookieCorrect(i);

end % for i

%% Clear tables

clearvars -EXCEPT data data_cookie data_followup data_scan psycho_data int NCS data_cookie_followup

%% RESULTS!!!

%% 1. Participant stats

% Low BMI group
mean(data.Age(data.BMIgroup==0,:))
mean(data.HHincome(data.BMIgroup==0,:))
mean(data.Height(data.BMIgroup==0,:))
mean(data.Weight(data.BMIgroup==0,:))
mean(data.BMI(data.BMIgroup==0,:))
mean(data.FMpercent(data.BMIgroup==0,:))

std(data.Age(data.BMIgroup==0,:))
std(data.HHincome(data.BMIgroup==0,:))
std(data.Height(data.BMIgroup==0,:))
std(data.Weight(data.BMIgroup==0,:))
std(data.BMI(data.BMIgroup==0,:))
std(data.FMpercent(data.BMIgroup==0,:))

min(data.Age(data.BMIgroup==0,:))
min(data.HHincome(data.BMIgroup==0,:))
min(data.Height(data.BMIgroup==0,:))
min(data.Weight(data.BMIgroup==0,:))
min(data.BMI(data.BMIgroup==0,:))
min(data.FMpercent(data.BMIgroup==0,:))

max(data.Age(data.BMIgroup==0,:))
max(data.HHincome(data.BMIgroup==0,:))
max(data.Height(data.BMIgroup==0,:))
max(data.Weight(data.BMIgroup==0,:))
max(data.BMI(data.BMIgroup==0,:))
max(data.FMpercent(data.BMIgroup==0,:))

% High BMI group
mean(data.Age(data.BMIgroup==1,:))
mean(data.HHincome(data.BMIgroup==1,:))
mean(data.Height(data.BMIgroup==1,:))
mean(data.Weight(data.BMIgroup==1,:))
mean(data.BMI(data.BMIgroup==1,:))
mean(data.FMpercent(data.BMIgroup==1,:))

std(data.Age(data.BMIgroup==1,:))
std(data.HHincome(data.BMIgroup==1,:))
std(data.Height(data.BMIgroup==1,:))
std(data.Weight(data.BMIgroup==1,:))
std(data.BMI(data.BMIgroup==1,:))
std(data.FMpercent(data.BMIgroup==1,:))

min(data.Age(data.BMIgroup==1,:))
min(data.HHincome(data.BMIgroup==1,:))
min(data.Height(data.BMIgroup==1,:))
min(data.Weight(data.BMIgroup==1,:))
min(data.BMI(data.BMIgroup==1,:))
min(data.FMpercent(data.BMIgroup==1,:))

max(data.Age(data.BMIgroup==1,:))
max(data.HHincome(data.BMIgroup==1,:))
max(data.Height(data.BMIgroup==1,:))
max(data.Weight(data.BMIgroup==1,:))
max(data.BMI(data.BMIgroup==1,:))
max(data.FMpercent(data.BMIgroup==1,:))

% BMI comparisons
[h,p,~,stats] = ttest2(data.Age(data.BMIgroup==0,:), data.Age(data.BMIgroup==1,:));
[h,p,~,stats] = ttest2(data.HHincome(data.BMIgroup==0,:), data.HHincome(data.BMIgroup==1,:));
[h,p,~,stats] = ttest2(data.Height(data.BMIgroup==0,:), data.Height(data.BMIgroup==1,:));
[h,p,~,stats] = ttest2(data.Weight(data.BMIgroup==0,:), data.Weight(data.BMIgroup==1,:));
[h,p,~,stats] = ttest2(data.BMI(data.BMIgroup==0,:), data.BMI(data.BMIgroup==1,:));
[h,p,~,stats] = ttest2(data.FMpercent(data.BMIgroup==0,:), data.FMpercent(data.BMIgroup==1,:));

[h,p,~,stats] = ttest2(data_followup.dWeight(data_followup.BMIgroup==0,:), data_followup.dWeight(data_followup.BMIgroup==1,:));
[h,p,~,stats] = ttest2(data_followup.dBMI(data_followup.BMIgroup==0,:), data_followup.dBMI(data_followup.BMIgroup==1,:));
[h,p,~,stats] = ttest2(data_followup.dFMpercent(data_followup.BMIgroup==0,:), data_followup.dFMpercent(data_followup.BMIgroup==1,:));

% Overall stats
mean(data.BMI)
min(data.BMI)
max(data.BMI)
std(data.BMI)

%% 2. Odor comparisons

[h,p,~,stats] = ttest(data.RoseAvScanIntensity, data.CookieAvScanIntensity); % p = 0.002
[h,p,~,stats] = ttest(data.RoseAvScanFamiliarity, data.CookieAvScanFamiliarity); % p = 0.00001
[h,p,~,stats] = ttest(data.RoseAvScanLiking, data.CookieAvScanLiking); % p = 0.045
[h,p,~,stats] = ttest(data.RoseAvScanEdibility, data.CookieAvScanEdibility); % p = 6.09e-11

%% 3. Psychophysical task (n = 35): Restricted to participants that did all three conditions (odor/visual/no imagery)

% Create some additional tables for pairwise comparison t-tests
int_odor_visual=int(int.Cond==0 | int.Cond==1,:);
int_odor_none=int(int.Cond==0 | int.Cond==2,:);
int_odor = int(int.Cond==0,:);
int_visual = int(int.Cond==1,:);
int_odor_visual_none_match = int(int.Detection==0 | int.Detection==2,:);
int_odor_visual_none_mismatch = int(int.Detection==1 | int.Detection==2,:);
int_odor_visual_mismatch = int_odor_visual(int_odor_visual.Detection==1,:);
int_odor_none_mismatch = int_odor_none(int_odor_none.Detection==1 | int_odor_none.Detection==2,:);
int_visual_none_mismatch = int_odor_visual_none_mismatch(int_odor_visual_none_mismatch.Cond==1 | int_odor_visual_none_mismatch.Cond==2,:);

% --- ANOVAS for odor vs. visual imagery --- %

% ANOVA for odor vs visual imagery
lme1 = fitlme(int_odor_visual,'Accuracy~Cond*Detection+Smell+(1|SubjectID)');
lme1_anova = anova(lme1); % Cond:Detection = 0.013, Detection = 0.0004, Smell = 0.008

% ANOVA for odor MATCHED vs MISMATCHED
lme1 = fitlme(int_odor,'Accuracy~Detection+Smell+(1|SubjectID)');
lme1_anova = anova(lme1); % Detection = 0.0002, Smell ns (0.199)
[beta,names,stats]=fixedEffects(lme1);

% ANOVA for visual MATCHED vs MISMATCHED
lme1 = fitlme(int_visual,'Accuracy~Detection+Smell+(1|SubjectID)');
lme1_anova = anova(lme1); % ns (smell sig at p = 0.020)
[beta,names,stats]=fixedEffects(lme1);

% --- ANOVA for comparison of matched with no imagery trials --- %

% ANOVA for odor MATCHED vs visual MATCHED vs no imagery 
lme1 = fitlme(int_odor_visual_none_match,'Accuracy~Cond+Smell+(1|SubjectID)');
lme1_anova = anova(lme1); % all ns

% --- ANOVAS for comparison of mismatched with no imagery trials --- %

% ANOVA for odor MISMATCHED vs visual MISMATCHED vs no imagery 
lme1 = fitlme(int_odor_visual_none_mismatch,'Accuracy~Cond+Smell+(1|SubjectID)');
lme1_anova = anova(lme1); % Cond = 0.014, Smell = 0.021

% ANOVA for odor MISMATCHED vs visual MISMATCHED
lme1 = fitlme(int_odor_visual_mismatch,'Accuracy~Cond+Smell+(1|SubjectID)');
lme1_anova = anova(lme1); % Cond = 0.008, Smell = 0.026
[beta,names,stats]=fixedEffects(lme1);

% ANOVA for odor MISMATCHED vs no imagery
lme1 = fitlme(int_odor_none_mismatch,'Accuracy~Cond+Smell+(1|SubjectID)');
lme1_anova = anova(lme1); % Cond = 0.016
[beta,names,stats]=fixedEffects(lme1);

% ANOVA for visual MISMATCHED vs no imagery
lme1 = fitlme(int_visual_none_mismatch,'Accuracy~Cond+Smell+(1|SubjectID)');
lme1_anova = anova(lme1); % Cond = 0.871
[beta,names,stats]=fixedEffects(lme1);

%% 4. Odor/visual int vs. self-reported imagery measures (n = 35)

[r1,pval] = corr(psycho_data.VOIQrev,psycho_data.OdorInt); % r = 0.428, p = 0.0104 (odor imagery)
[rho,pval] = corr(psycho_data.VFIQrev,psycho_data.OdorInt); % r = 0.427, p = 0.0105 (flavor imagery)
[r2,pval] = corr(psycho_data.VVIQrev,psycho_data.OdorInt); % r = 0.270, p = 0.1173 (visual iagery)
n1 = height(psycho_data);
n2 = height(psycho_data);

% Check to see if the correlation for VOIQ is significantly greater than
% for VVIQ (it is not)
t_r1 = 0.5*log((1+r1)/(1-r1));
t_r2 = 0.5*log((1+r2)/(1-r2));
z = (t_r1-t_r2)/sqrt(1/(n1-3)+1/(n2-3));
p = (1-normcdf(abs(z),0,1))*2;

% Check relationships with visual int
[rho,pval] = corr(psycho_data.VOIQrev,psycho_data.VisualInt); % r = 0.306, p = 0.0735
[r,p,rl,ru] = corrcoef(psycho_data.VOIQrev,psycho_data.VisualInt)
[rho,pval] = corr(psycho_data.VFIQrev,psycho_data.VisualInt); % r = 0.247, p = 0.1519
[rho,pval] = corr(psycho_data.VVIQrev,psycho_data.VisualInt); % r = 0.155, p = 0.3742

%% 5. Self-reported odor imagery vs. adiposity, odors, hunger (n = 45)

% --- Adiposity --- %
[rho,pval] = corr(data.VOIQrev,data.BMI); % r = 0.225, p = 0.1381
[rho,pval] = corr(data.VOIQrev,data.FMpercent); % r = 0.232, p = 0.1257


data_male = data(data.Sex==0,:);
lm=fitlm(data_male,'BMI~VOIQrev')

data_female = data(data.Sex==1,:);
lm=fitlm(data_female,'BMI~VOIQrev')

data_male = data(data.Sex==0,:);
lm=fitlm(data_male,'BMI~OdorInt')

data_female = data(data.Sex==1,:);
lm=fitlm(data_female,'BMI~OdorInt')


data_male = data(data.Sex==0,:);
lm=fitlm(data_male,'FMpercent~VOIQrev')

data_female = data(data.Sex==1,:);
lm=fitlm(data_female,'FMpercent~VOIQrev')

data_male = data(data.Sex==0,:);
lm=fitlm(data_male,'FMpercent~OdorInt')

data_female = data(data.Sex==1,:);
lm=fitlm(data_female,'FMpercent~OdorInt')

% --- Odor Thresholds --- %
[rho,pval] = corr(data.VOIQrev,data.RoseThreshold); % r = –0.171, p = 0.2611
[rho,pval] = corr(data.VOIQrev,data.CookieThreshold); % r = –0.280, p = 0.0630

% --- Odor Ratings (Cookie minus rose diff from scanning) --- %
[rho,pval] = corr(data_scan.VOIQrev,data_scan.ScanLikingDiff); 
[rho,pval] = corr(data_scan.VOIQrev,data_scan.ScanEdibilityDiff); 
[rho,pval] = corr(data_scan.VOIQrev,data_scan.ScanIntensityDiff); 
[rho,pval] = corr(data_scan.VOIQrev,data_scan.ScanFamiliarityDiff); 

% --- Other variables --- %
[rho,pval] = corr(data.VOIQrev,data.Sex); 
[rho,pval] = corr(data.VOIQrev,data.Age); 
[rho,pval] = corr(data.VOIQrev,data.HHincome); 
[rho,pval] = corr(data.VOIQrev,data.Education); 

% --- Hunger --- %
[rho,pval] = corr(data.VOIQrev,data.HungerIndex3); % r = –0.099, p = 0.5160

%% 6. Psychophysical odor imagery vs. adiposity, odors, and hunger (n = 45)

% --- Adiposity --- %
[rho,pval] = corr(data.OdorInt,data.BMI); % r = 0.011, p = 0.9414
[rho,pval] = corr(data.OdorInt,data.FMpercent); % r = 0.115, p = 0.4533

% --- Odor Thresholds --- %
[rho,pval] = corr(data.OdorInt,data.RoseThreshold); % r = –0.058, p = 0.7061
[rho,pval] = corr(data.OdorInt,data.CookieThreshold); % r = 0.199, p = 0.1890

% --- Odor Ratings (Cookie minus rose diff from scanning) --- %
[rho,pval] = corr(data_scan.OdorInt,data_scan.ScanLikingDiff); 
[rho,pval] = corr(data_scan.OdorInt,data_scan.ScanEdibilityDiff); 
[rho,pval] = corr(data_scan.OdorInt,data_scan.ScanIntensityDiff); 
[rho,pval] = corr(data_scan.OdorInt,data_scan.ScanFamiliarityDiff); 

% --- Other variables --- %
[rho,pval] = corr(data.OdorInt,data.Sex); 
[rho,pval] = corr(data.OdorInt,data.Age); 
[rho,pval] = corr(data.OdorInt,data.HHincome); 
[rho,pval] = corr(data.OdorInt,data.Education); 

% --- Hunger --- %
[rho,pval] = corr(data.OdorInt,data.HungerIndex3); % r = –0.121, p = 0.4305

lm = fitlm(data,'Rpir_imag_pat~VOIQrev'); 
lm = fitlm(data,'Rpir_imag_pat~VFIQrev'); 

%% 7a. Psychophysical odor imagery vs. Kober craving measure (n = 45)

% Test simple correlation
[rho,pval] = corr(data.OdorInt,data.Craving); % r = 0.211, p = 0.1640

% Determine what else is related to craving
[rho,pval] = corr(data.BMI,data.Craving); % r = –0.270, p = 0.0733 (p = 0.375 after 2 BMI outliers removed)
[rho,pval] = corr(data.FMpercent,data.Craving); % r = –0.270, p = 0.0726
[rho,pval] = corr(data.Sex,data.Craving); % r = –0.244, p = 0.1062
[rho,pval] = corr(data.LikingKober,data.Craving); % r = 0.521, p = 0.0002
[rho,pval] = corr(data.TasteTestLiking,data.Craving); 
[rho,pval] = corr(data.HungerIndex2,data.Craving); % r = 0.497, p = 0.0005 (pre-craving hunger)
[rho,pval] = corr(data.HungerIndex3,data.Craving); % ns (pre-odor int hunger)
[rho,pval] = corr(data.Age,data.Craving); % ns
[rho,pval] = corr(data.HHincome,data.Craving); % ns
[rho,pval] = corr(data.Education,data.Craving); % ns
[rho,pval] = corr(data.VOIQrev,data.Craving); % ns
[rho,pval] = corr(data.VFIQrev,data.Craving); % ns
[rho,pval] = corr(data.VVIQrev,data.Craving); % ns
[rho,pval] = corr(data.FreqConsKober,data.Craving); % ns
[rho,pval] = corr(data.TasteTestFrequencyOfConsumption,data.Craving); % ns
[rho,pval] = corr(data.DFStotal,data.Craving); % ns

% Test regression for interaction with liking 
lm = fitlm(data,'Craving~OdorInt*LikingKober'); 
% p = 0.005 for odor int:liking (liking sig too)

% Test with hunger as well since it was significant
lm = fitlm(data,'Craving~OdorInt*LikingKober+HungerIndex2'); 
% p = 0.075 for odor int alone (neg); p = 0.003 for odor int:liking (other things sig too)

% --- Tertiary split option for plotting R pat sim x liking ~ craving --- %
% since we have 45 people now, this will give 3 equal groups

data_like1 = data; % 15 people
data_like1(data_like1.LikingKober>11.7,:)=[]; % roughly equates to liking it less than slightly 
[rho,pval] = corr(data_like1.OdorInt,data_like1.Craving); % r = –0.415, p = 0.1243

data_like2 = data; % 15 people
data_like2(data_like2.LikingKober<11.7,:)=[]; % roughly equates to liking it slightly to moderately 
data_like2(data_like2.LikingKober>28,:)=[];
[rho,pval] = corr(data_like2.OdorInt,data_like2.Craving); % r = 0.519, p = 0.0476

data_like3 = data; % 15 people
data_like3(data_like3.LikingKober<28,:)=[]; % roughly equates to liking it moderately or more
[rho,pval] = corr(data_like3.OdorInt,data_like3.Craving); % r = 0.690, p = 0.0044

%% Tangent: Role of PFS and cognitive restraint/control?

% Using this in dissertation!

% PFS total is correlated positively with craving 
[rho,pval] = corr(data.PFStotal,data.Craving);
[rho,pval] = corr(data_cookie.PFStotal,data_cookie.TotalCookieIntake);
[rho,pval] = corr(data.PFStotal,data.OdorInt);

% Interaction of odor int and PFS score on food craving
lm = fitlm(data,'Craving~OdorInt*PFStotal'); % sig interaction (p = 0.0415)
data_low = data(data.PFStotal<=median(data.PFStotal),:);
data_high = data(data.PFStotal>median(data.PFStotal),:);
[rho,pval] = corr(data_low.OdorInt,data_low.Craving);
[rho,pval] = corr(data_high.OdorInt,data_high.Craving);

% Interaction of odor int and PFS score on food intake
lm = fitlm(data_cookie,'TotalCookieIntake~OdorInt*PFStotal');
data_low_cookie = data_cookie(data_cookie.PFStotal<=median(data_cookie.PFStotal),:);
data_high_cookie = data_cookie(data_cookie.PFStotal>median(data_cookie.PFStotal),:);
[rho,pval] = corr(data_low_cookie.OdorInt,data_low_cookie.TotalCookieIntake);
[rho,pval] = corr(data_high_cookie.OdorInt,data_high_cookie.TotalCookieIntake);


%% 7b. LME with craving data for individual foods (rather than averages)

% Odor int x liking
lme1 = fitlme(crav_data,'CravingByFood~OdorInt*Liking+(1|SubjectID)');
lme1_anova = anova(lme1); % odor int x liking p = 0.006 (still sig after removal of 2463 who strongly disliked the foods)

% Check with covariates
lme1 = fitlme(crav_data,'CravingByFood~OdorInt*Liking+HungerIndex2+(1|SubjectID)');
lme1_anova = anova(lme1); % odor int x liking p = 0.008

%% 8. Psychophysical odor imagery vs. cookie intake (n = 43, 2 extreme outliers removed)

% Test simple correlation
[rho,pval] = corr(data_cookie.OdorInt,data_cookie.TotalCookieIntake); % r = 0.314, p = 0.0404

lm = fitlm(data_cookie,'TotalCookieIntake~Craving')

% Determine what else is related to cookie intake: Sex, Liking, Hunger
[rho,pval] = corr(data_cookie.Craving,data_cookie.TotalCookieIntake); % r = 0.255, p = 0.0983
[rho,pval] = corr(data_cookie.BMI,data_cookie.TotalCookieIntake); % r = 0.086, p = 0.5824
[rho,pval] = corr(data_cookie.FMpercent,data_cookie.TotalCookieIntake); % r = 0.131, p = 0.4023
[rho,pval] = corr(data_cookie.Sex,data_cookie.TotalCookieIntake); % r = –0.365, p = 0.0161
[rho,pval] = corr(data_cookie.TasteTestLiking,data_cookie.TotalCookieIntake); % r = 0.349, p = 0.0217
[rho,pval] = corr(data_cookie.LikingKober,data_cookie.TotalCookieIntake);
[rho,pval] = corr(data_cookie.HungerIndex6,data_cookie.TotalCookieIntake); % r = 0.282, p = 0.0672
[rho,pval] = corr(data_cookie.Age,data_cookie.TotalCookieIntake); % ns
[rho,pval] = corr(data_cookie.Education,data_cookie.TotalCookieIntake); % ns
[rho,pval] = corr(data_cookie.VOIQrev,data_cookie.TotalCookieIntake); % ns
[rho,pval] = corr(data_cookie.VFIQrev,data_cookie.TotalCookieIntake); % ns
[rho,pval] = corr(data_cookie.VVIQrev,data_cookie.TotalCookieIntake); % ns
[rho,pval] = corr(data_cookie.TasteTestFrequencyOfConsumption,data_cookie.TotalCookieIntake); % ns
[rho,pval] = corr(data_cookie.FreqConsKober,data_cookie.TotalCookieIntake); % ns
[rho,pval] = corr(data_cookie.DFStotal,data_cookie.TotalCookieIntake); % ns
[rho,pval] = corr(data_cookie.HHincome,data_cookie.TotalCookieIntake); % ns

% Compare food intake by males (0) vs females (1)
[h,p,~,stats] = ttest2(data_cookie.TotalCookieIntake(data_cookie.Sex==0,:), data_cookie.TotalCookieIntake(data_cookie.Sex==1,:)); % p = 0.002

% Test regressions with covariates (standardized first with z scores)
data_cookie_stand = data_cookie;
data_cookie_stand.TotalCookieIntake = zscore(data_cookie_stand.TotalCookieIntake);
data_cookie_stand.Craving = zscore(data_cookie_stand.Craving);
data_cookie_stand.OdorInt = zscore(data_cookie_stand.OdorInt);
data_cookie_stand.TasteTestLiking = zscore(data_cookie_stand.TasteTestLiking);
data_cookie_stand.Sex = zscore(data_cookie_stand.Sex);
lm = fitlm(data_cookie_stand,'TotalCookieIntake~OdorInt+TasteTestLiking+Sex'); % Odor Int: p = 0.0098
lm = fitlm(data_cookie_stand,'TotalCookieIntake~Craving+TasteTestLiking+Sex'); % Craving: p = 0.3029

% --- FOR PLOTS ONLY --- %

% Create adjusted cookie intake for plots
lm = fitlm(data_cookie,'TotalCookieIntake~TasteTestLiking+Sex');
res1 = lm.Residuals.Standardized;
% Standardized residuals are raw residuals divided by their estimated standard deviation

% Correlation between adjusted intake and odor interference for plots
[rho,pval] = corr(res1,data_cookie.OdorInt); % r = 0.407, p = 0.0068

%% 9. MVPA results vs. chance

brain = data;
brain(isnan(brain.Rpir_imag_pat_sig),:)=[];
brain(brain.Rpir_imag_pat_sig<0,:)=[];

% smell
[h1,p1,~,stats1] = ttest(data.Lins_smell_mvpa,50); % ns (p = 0.044)
[h1,p1,~,stats1] = ttest(data.Lpir_smell_mvpa,50); % ns
[h1,p1,~,stats1] = ttest(data.Rpir_smell_mvpa,50); % p = 0.005

% imagine
[h1,p1,~,stats1] = ttest(data.Lins_imag_mvpa,50); % ns
[h1,p1,~,stats1] = ttest(data.Lpir_imag_mvpa,50); % ns
[h1,p1,~,stats1] = ttest(data.Rpir_imag_mvpa,50); % ns (p = 0.282)

% cross
[h1,p1,~,stats1] = ttest(data.Lins_cross_mvpa,50); % ns
[h1,p1,~,stats1] = ttest(data.Lpir_cross_mvpa,50); % ns
[h1,p1,~,stats1] = ttest(data.Rpir_cross_mvpa,50); % ns


% --- Also test for laterality --- %

% smell
[h1,p1,~,stats1] = ttest(data.Lpir_smell_mvpa,data.Rpir_smell_mvpa); % significant paired samples t-test

%% 10. Voxel correlation results vs. chance

% smell
[h1,p1,~,stats1] = ttest(data.Lins_smell_pat,0); % ns
[h1,p1,~,stats1] = ttest(data.Lpir_smell_pat,0); % ns
[h1,p1,~,stats1] = ttest(data.Rpir_smell_pat,0); % p = 0.002

% imagine
[h1,p1,~,stats1] = ttest(data.Lins_imag_pat,0); % ns
[h1,p1,~,stats1] = ttest(data.Lpir_imag_pat,0); % ns
[h1,p1,~,stats1] = ttest(data.Rpir_imag_pat,0); % ns
% what about in individuals with significant smell:
[h1,p1,~,stats1] = ttest(data.Rpir_imag_pat_sig,0); % still ns

% cross
[h1,p1,~,stats1] = ttest(data.Lins_cross_pat,0); % ns
[h1,p1,~,stats1] = ttest(data.Lpir_cross_pat,0); % ns
[h1,p1,~,stats1] = ttest(data.Rpir_cross_pat,0); % ns

% --- Also test for laterality --- %

% smell
[h1,p1,~,stats1] = ttest(data.Lpir_smell_pat,data.Rpir_smell_pat); % ns

%% 11. R pir decoding vs. Odor int

% Set up tables
data_neural = data;
data_neural(isnan(data_neural.Rpir_imag_pat_sig),:)=[]; 

% Set up tables
data_neural = data;
data_neural(data_neural.Rpir_smell_mvpa<50,:)=[]; 
data_neural(isnan(data_neural.Rpir_smell_mvpa),:)=[]; 

% Test for voxel correlations
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.OdorInt); % r = 0.638, p = 0.0002 (actual odors)
[rho,pval] = corr(data_neural.Rpir_smell_pat_sig,data_neural.OdorInt); % r = –0.185, p = 0.3290 (imagined odors)
[rho,pval] = corr(data_neural.Rpir_cross_pat_sig,data_neural.OdorInt); % r = –0.083, p = 0.6635 (crossmodal odors)

[rho,pval] = corr(data_neural.Rpir_imag_pat,data_neural.OdorInt); 
[rho,pval] = corr(data_neural.Rpir_smell_pat,data_neural.OdorInt); 
[rho,pval] = corr(data_neural.Rpir_cross_pat,data_neural.OdorInt); 


[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.Rpir_smell_pat_sig); % r = 0.038, p = 0.8403
[rho,pval] = corr(data_neural.VOIQrev,data_neural.Rpir_smell_pat_sig); % r = 0.039, p = 0.8362

% Test for SVM accuracies
[rho,pval] = corr(data_neural.Rpir_imag_mvpa,data_neural.OdorInt); % r = 0.638, p = 0.0002 (actual odors)
[rho,pval] = corr(data_neural.Rpir_smell_pat_sig,data_neural.OdorInt); % r = –0.185, p = 0.3290 (imagined odors)
[rho,pval] = corr(data_neural.Rpir_cross_pat_sig,data_neural.OdorInt); % r = –0.083, p = 0.6635 (crossmodal odors)

%% 12. Neural odor imagery vs. adiposity, odor thresholds, and hunger (n = 30, only with significant smell voxel correlations)

% Set up tables
data_neural = data;
data_neural(isnan(data_neural.Rpir_imag_pat_sig),:)=[]; 

% --- Adiposity --- %
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.BMI); % r = 0.021, p = 0.9107
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.FMpercent); % r = 0.125, p = 0.5106

% --- Odor Thresholds --- %
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.RoseThreshold); % r = –0.129, p = 0.4986
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.CookieThreshold); % r = –0.220, p = 0.2429

% --- Odor Ratings (Cookie minus rose diff from scanning) --- %
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.ScanLikingDiff); 
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.ScanEdibilityDiff); 
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.ScanIntensityDiff); 
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.ScanFamiliarityDiff); 

% --- Other variables --- %
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.Sex); 
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.Age); 
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.HHincome);
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.Education);


% --- Hunger --- %
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.HungerIndex7); % r = –0.286, p = 0.1251 (pre-scan hunger)

%% Supplementary: Real or imagined odor coding in right piriform vs other odor imagery measures

% Set up tables
data_neural = data;
data_neural(isnan(data_neural.Rpir_imag_pat),:)=[]; 

% --- Real odors --- %
[rho,pval] = corr(data_neural.Rpir_smell_pat,data_neural.VOIQrev); % r = -0.196, p = 0.2033
[rho,pval] = corr(data_neural.Rpir_smell_pat,data_neural.VFIQrev); % r = -0.079, p = 0.6104
[rho,pval] = corr(data_neural.Rpir_smell_pat,data_neural.OdorInt); % r = -0.129, p = 0.4025

% --- Imagined odors --- %
[rho,pval] = corr(data_neural.Rpir_imag_pat,data_neural.VOIQrev); % r = 0.289, p = 0.0571
[rho,pval] = corr(data_neural.Rpir_imag_pat,data_neural.VFIQrev); % r = 0.2737, p = 0.0722
[rho,pval] = corr(data_neural.Rpir_imag_pat,data_neural.OdorInt); % r = 0.352, p = 0.0191

%% 13. Neural odor imagery vs. craving and intake

% --- CRAVING --- %

[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.Craving); % r = 0.020, p = 0.9163
lm = fitlm(data,'Craving~Rpir_imag_pat_sig*LikingKober'); % ns (p = 0.0780)
lm = fitlm(data,'Craving~Rpir_imag_pat_sig*LikingKober+HungerIndex2'); % ns

% --- INTAKE --- %

% Test regressions with covariates (standardized first with z scores)
data_cookie_neural_stand = data_cookie;
data_cookie_neural_stand(isnan(data_cookie_neural_stand.Rpir_imag_pat_sig),:) = [];
[rho,pval] = corr(data_cookie_neural_stand.Rpir_imag_pat_sig,data_cookie_neural_stand.TotalCookieIntake); % r = 0.371, p = 0.0474
[rho,pval] = corr(data_cookie_neural_stand.Rpir_smell_pat_sig,data_cookie_neural_stand.TotalCookieIntake); % r = 0.371, p = 0.0474

data_cookie_neural_stand.TotalCookieIntake = zscore(data_cookie_neural_stand.TotalCookieIntake);
data_cookie_neural_stand.Rpir_imag_pat_sig = zscore(data_cookie_neural_stand.Rpir_imag_pat_sig);
data_cookie_neural_stand.TasteTestLiking = zscore(data_cookie_neural_stand.TasteTestLiking);
data_cookie_neural_stand.Sex = zscore(data_cookie_neural_stand.Sex);
data_cookie_neural_stand.Rpir_smell_pat_sig = zscore(data_cookie_neural_stand.Rpir_smell_pat_sig);
lm = fitlm(data_cookie_neural_stand,'TotalCookieIntake~Rpir_imag_pat_sig+TasteTestLiking+Sex'); % Neural OI: p = 0.0136
lm = fitlm(data_cookie_neural_stand,'TotalCookieIntake~Rpir_smell_pat_sig+TasteTestLiking+Sex'); % Smell pat: p = 0.6024

% --- FOR PLOTS ONLY --- %

% Create adjusted cookie intake for plots
lm = fitlm(data_cookie_neural_stand,'TotalCookieIntake~TasteTestLiking+Sex');
res1 = lm.Residuals.Standardized;
% Standardized residuals are raw residuals divided by their estimated standard deviation

% Correlation between adjusted intake and neural odor imagery for plots
[rho,pval] = corr(res1,data_cookie_neural_stand.Rpir_imag_pat_sig); % r = 0.454, p = 0.0133

%% 14. Pir real odor decoding vs. craving and intake

% --- CRAVING --- %

[rho,pval] = corr(data_neural.Rpir_smell_pat_sig,data_neural.Craving); % r = –0.057, p = 0.7642

% --- INTAKE --- %

% Test regressions with covariates (standardized first with z scores)
data_cookie_neural_stand = data_cookie;
data_cookie_neural_stand(isnan(data_cookie_neural_stand.Rpir_imag_pat_sig),:) = [];
data_cookie_neural_stand.TotalCookieIntake = zscore(data_cookie_neural_stand.TotalCookieIntake);
data_cookie_neural_stand.TasteTestLiking = zscore(data_cookie_neural_stand.TasteTestLiking);
data_cookie_neural_stand.Sex = zscore(data_cookie_neural_stand.Sex);
data_cookie_neural_stand.Rpir_smell_pat_sig = zscore(data_cookie_neural_stand.Rpir_smell_pat_sig);
lm = fitlm(data_cookie_neural_stand,'TotalCookieIntake~Rpir_smell_pat_sig+TasteTestLiking+Sex'); % Smell: beta = –0.091, p = 0.6024

% --- FOR PLOTS ONLY --- %

% Create adjusted cookie intake for plots
lm = fitlm(data_cookie_neural_stand,'TotalCookieIntake~TasteTestLiking+Sex');
res1 = lm.Residuals.Standardized;
% Standardized residuals are raw residuals divided by their estimated standard deviation

% Correlation between adjusted intake and R pir decoding of actual odors
[rho,pval] = corr(res1,data_cookie_neural_stand.Rpir_smell_pat_sig); % r = –0.105, p = 0.5883








%% NEED TO UPDATE BELOW

% cookie minus rose ratings in the scanner: SMELL pattern sim
lm = fitlm(data,'Rpir_smell_pat_sig~ScanIntensityDiff'); % p = 0.610
lm = fitlm(data,'Rpir_smell_pat_sig~ScanLikingDiff'); % p = 0.118
lm = fitlm(data,'Rpir_smell_pat_sig~ScanFamiliarityDiff'); % p = 0.680
lm = fitlm(data,'Rpir_smell_pat_sig~ScanEdibilityDiff'); % p = 0.453

% cookie minus rose ratings in the scanner: IMAGINE pattern sim
lm = fitlm(data,'Rpir_imag_pat_sig~ScanIntensityDiff'); % p = 0.236
lm = fitlm(data,'Rpir_imag_pat_sig~ScanLikingDiff'); % p = 0.513
lm = fitlm(data,'Rpir_imag_pat_sig~ScanFamiliarityDiff'); % p = 0.392
lm = fitlm(data,'Rpir_imag_pat_sig~ScanEdibilityDiff'); % p = 0.448

% check the role of composition frame displacement in the scanner
lm = fitlm(data,'Rpir_smell_pat_sig~Composite_fd'); % p = 0.260
lm = fitlm(data,'Rpir_imag_pat_sig~Composite_fd'); % p = 0.615
lm = fitlm(data,'Rpir_cross_pat_sig~Composite_fd'); % p = 0.201


%% 14. Make sure that odor imagery measures are not related to frequency of consumption of unhealthy foods

% VOIQ
[rho,pval] = corr(data.VOIQrev,data.DFStotal); % r = –0.069, p = 0.6511
[rho,pval] = corr(data.VOIQrev,data.FreqConsKober); % r = 0.011, p = 0.9415
[rho,pval] = corr(data.VOIQrev,data.TasteTestFrequencyOfConsumption); % r = 0.183, p = 0.2286

% Psych OI
[rho,pval] = corr(data.OdorInt,data.DFStotal); % r = –0.033, p = 0.8312
[rho,pval] = corr(data.OdorInt,data.FreqConsKober); % r = –0.013, p = 0.9312
[rho,pval] = corr(data.OdorInt,data.TasteTestFrequencyOfConsumption); % r = 0.198, p = 0.1933

% Neural OI
data_neural = data;
data_neural(isnan(data_neural.Rpir_imag_pat_sig),:)=[]; 
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.DFStotal); % r = 0.018, p = 0.9237
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.FreqConsKober); % r = –0.092, p = 0.6272
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.TasteTestFrequencyOfConsumption); % r = 0.090, p = 0.6380

%% 15. FOLLOWUP: Test relationships with dBMI, dWeight, dFMpercent

data_neural_followup = data_followup;
data_neural_followup(isnan(data_neural_followup.Rpir_imag_pat_sig),:)=[]; 

% Main variables

% dBMI
[rho,pval] = corr(data_neural_followup.Rpir_imag_pat_sig,data_neural_followup.dBMI);
[rho,pval] = corr(data_followup.OdorInt,data_followup.dBMI); 
[rho,pval] = corr(data_followup.Craving,data_followup.dBMI); 
[rho,pval] = corr(data_cookie_followup.TotalCookieIntake,data_cookie_followup.dBMI); % r = 0.372, p = 0.0140

% dFM percent
[rho,pval] = corr(data_neural_followup.Rpir_imag_pat_sig,data_neural_followup.dFMpercent); % r = 0.199, p = 0.3099
[rho,pval] = corr(data_followup.OdorInt,data_followup.dFMpercent); % r = 0.185, p = 0.2353
[rho,pval] = corr(data_cookie_followup.TotalCookieIntake,data_cookie_followup.dFMpercent); % r = 0.449, p = 0.0032
[rho,pval] = corr(data_followup.Craving,data_followup.dFMpercent); 

% Other potential variables of interest (to ensure they are not related)

% dBMI
[rho,pval] = corr(data_followup.Sex_data_followup,data_followup.dBMI); % ns
[rho,pval] = corr(data_followup.Age,data_followup.dBMI); % sig
lm = fitlm(data_followup,'dBMI~Craving+Age'); % but does not impact results
lm = fitlm(data_followup,'dBMI~OdorInt+Age'); % but does not impact results
lm = fitlm(data_followup,'dBMI~Rpir_imag_pat_sig+Age'); % but does not impact results
[rho,pval] = corr(data_followup.HHincome,data_followup.dBMI); % ns
[rho,pval] = corr(data_followup.Education,data_followup.dBMI); % sig
[rho,pval] = corr(data_followup.RoseThreshold,data_followup.dBMI); % ns
[rho,pval] = corr(data_followup.CookieThreshold,data_followup.dBMI); % ns
[rho,pval] = corr(data_followup.LikingKober,data_followup.dBMI); % ns
[rho,pval] = corr(data_followup.TasteTestLiking,data_followup.dBMI); % ns
[rho,pval] = corr(data_followup.DFStotal,data_followup.dBMI); % ns
[rho,pval] = corr(data_followup.FreqConsKober,data_followup.dBMI); % ns
[rho,pval] = corr(data_followup.TasteTestFrequencyOfConsumption,data_followup.dBMI); % ns
[rho,pval] = corr(data_followup.dActivityMets,data_followup.dBMI); % ns


% dFM percent
[rho,pval] = corr(data_followup.Sex_data_followup,data_followup.dFMpercent); % ns
[rho,pval] = corr(data_followup.Age,data_followup.dFMpercent); % ns
[rho,pval] = corr(data_followup.HHincome,data_followup.dFMpercent); % ns
[rho,pval] = corr(data_followup.Education,data_followup.dFMpercent); % ns
[rho,pval] = corr(data_followup.RoseThreshold,data_followup.dFMpercent); % ns
[rho,pval] = corr(data_followup.CookieThreshold,data_followup.dFMpercent); % ns
[rho,pval] = corr(data_followup.LikingKober,data_followup.dFMpercent); % ns
[rho,pval] = corr(data_followup.TasteTestLiking,data_followup.dFMpercent); % ns
[rho,pval] = corr(data_followup.DFStotal,data_followup.dFMpercent); % ns
[rho,pval] = corr(data_followup.FreqConsKober,data_followup.dFMpercent); % ns
[rho,pval] = corr(data_followup.TasteTestFrequencyOfConsumption,data_followup.dFMpercent); % ns
[rho,pval] = corr(data_followup.dActivityMets,data_followup.dFMpercent); % ns





% --- dBMI --- %
lm = fitlm(data_followup,'dBMI~BMI'); % ns
lm = fitlm(data_followup,'dBMI~dActivityMets'); % ns
lm = fitlm(data_followup,'dBMI~VOIQrev'); % ns
lm = fitlm(data_followup,'dBMI~VFIQrev'); % ns 
lm = fitlm(data_followup,'dBMI~VVIQrev'); % ns
lm = fitlm(data_followup,'dBMI~OdorInt'); % ns
lm = fitlm(data_followup,'dBMI~OdorInt+dActivityMets'); % ns
lm = fitlm(data_followup,'dBMI~VisualInt'); % ns
lm = fitlm(data_followup,'dBMI~Rpir_imag_pat'); % ns
lm = fitlm(data_followup,'dBMI~Rpir_imag_pat_sig'); % ns 
lm = fitlm(data_followup,'dBMI~Rpir_smell_pat'); % ns
lm = fitlm(data_followup,'dBMI~Rpir_smell_pat_sig'); % ns
lm = fitlm(data_followup,'dBMI~Craving'); % ns (p = 0.112); SIG after removing 2507 (p = 0.014)
lm = fitlm(data_followup,'dBMI~Craving*OdorIntGroup'); % craving sig, odor int NS
lm = fitlm(data_followup,'dBMI~CravingPost'); % ns 
lm = fitlm(data_followup,'dBMI~TotalCookieIntake'); % ns (p = 0.066, check for outliers)
lm = fitlm(data_followup,'dBMI~TotalCookieIntake*OdorInt'); % ns 
lm = fitlm(data_cookie_followup,'dBMI~TotalCookieIntake'); % ns (p = 0.093, check for outliers)
lm = fitlm(data_cookie_followup,'dBMI~TotalCookieIntake*OdorInt'); % ns 
lm = fitlm(data_followup,'dBMI~FCIscore'); % ns 
lm = fitlm(data_followup,'dBMI~FCQS'); % SIG after removing 2507: 0.049
lm = fitlm(data_followup,'dBMI~REDscore'); % ns
lm = fitlm(data_followup,'dBMI~LikingKober'); % ns 
lm = fitlm(data_followup,'dBMI~OdorInt*LikingKober'); % ns (p = 0.086 interaction); CLOSE after removing 2507 (p = 0.063)
lm = fitlm(data_followup,'dBMI~OdorInt*LikingKober+HungerIndex2'); % ns (p = 0.066)
lm = fitlm(data_followup,'dBMI~DFStotal'); % ns 

% --- dWeight --- %
lm = fitlm(data_followup,'dWeight~BMI'); % ns
lm = fitlm(data_followup,'dWeight~dActivityMets'); % ns
lm = fitlm(data_followup,'dWeight~VOIQrev'); % ns
lm = fitlm(data_followup,'dWeight~VFIQrev'); % ns 
lm = fitlm(data_followup,'dWeight~VVIQrev'); % ns
lm = fitlm(data_followup,'dWeight~OdorInt'); % ns
lm = fitlm(data_followup,'dWeight~OdorInt+dActivityMets'); % ns
lm = fitlm(data_followup,'dWeight~VisualInt'); % ns
lm = fitlm(data_followup,'dWeight~Rpir_imag_pat'); % ns
lm = fitlm(data_followup,'dWeight~Rpir_imag_pat_sig'); % ns 
lm = fitlm(data_followup,'dWeight~Rpir_smell_pat'); % ns
lm = fitlm(data_followup,'dWeight~Rpir_smell_pat_sig'); % ns
lm = fitlm(data_followup,'dWeight~Craving'); % ns (p = 0.099, check for outliers)
lm = fitlm(data_followup,'dWeight~Craving*OdorIntGroup'); % ns (p = 0.099, check for outliers)
lm = fitlm(data_followup,'dWeight~CravingPost'); % ns 
lm = fitlm(data_followup,'dWeight~TotalCookieIntake'); % p = 0.028, check for outliers)
lm = fitlm(data_cookie_followup,'dWeight~TotalCookieIntake'); % p = 0.047 (check for outliers)
lm = fitlm(data_followup,'dWeight~FCIscore'); % ns 
lm = fitlm(data_followup,'dWeight~FCQS'); % ns (p = 0.078) 
lm = fitlm(data_followup,'dWeight~REDscore'); % ns
lm = fitlm(data_followup,'dWeight~OdorInt*LikingKober'); % odorint:liking kober p = 0.039
lm = fitlm(data_followup,'dWeight~OdorInt*LikingKober+HungerIndex2'); % odorint:liking kober p = 0.041

% --- dFMpercent --- %
lm = fitlm(data_followup,'dFMpercent~BMI'); % ns
lm = fitlm(data_followup,'dFMpercent~dActivityMets'); % ns
lm = fitlm(data_followup,'dFMpercent~VOIQrev'); % ns
lm = fitlm(data_followup,'dFMpercent~VFIQrev'); % ns 
lm = fitlm(data_followup,'dFMpercent~VVIQrev'); % ns
lm = fitlm(data_followup,'dFMpercent~OdorInt'); % ns (p = 0.20, check for outliers)
lm = fitlm(data_followup,'dFMpercent~OdorInt+dActivityMets'); 
lm = fitlm(data_followup,'dFMpercent~VisualInt'); % ns
lm = fitlm(data_followup,'dFMpercent~Rpir_imag_pat'); % ns
lm = fitlm(data_followup,'dFMpercent~Rpir_imag_pat_sig'); % ns 
lm = fitlm(data_followup,'dFMpercent~Rpir_smell_pat'); % ns
lm = fitlm(data_followup,'dFMpercent~Rpir_smell_pat_sig'); % ns
lm = fitlm(data_followup,'dFMpercent~Craving');
lm = fitlm(data_followup,'dFMpercent~Craving*OdorIntGroup');
lm = fitlm(data_followup,'dFMpercent~CravingPost'); % ns 
lm = fitlm(data_followup,'dFMpercent~TotalCookieIntake'); % p = 0.0005, check for outliers)
lm = fitlm(data_followup,'dFMpercent~TotalCookieIntake+TasteTestLiking+Sex_data_followup'); % p = 0.0007, check for outliers)
lm = fitlm(data_cookie_followup,'dFMpercent~TotalCookieIntake'); % p = 0.009 (check for outliers)
lm = fitlm(data_cookie_followup,'dFMpercent~TotalCookieIntake+TasteTestLiking+Sex_data_followup'); % p = 0.008, check for outliers)
lm = fitlm(data_cookie_followup,'dFMpercent~TotalCookieIntake*OdorInt+TasteTestLiking+Sex_data_followup'); % odor int not sig
lm = fitlm(data_followup,'dFMpercent~FCIscore'); % ns 
lm = fitlm(data_followup,'dFMpercent~FCQS'); % ns (p = 0.017) 
lm = fitlm(data_followup,'dFMpercent~REDscore'); % ns
lm = fitlm(data_followup,'dFMpercent~OdorInt*LikingKober'); % ns
lm = fitlm(data_followup,'dFMpercent~TasteTestLiking'); % ns
lm = fitlm(data_followup,'dFMpercent~OdorInt*LikingKober+HungerIndex2'); % ns

% Adding dVAT per Dana's request
% --- dVAT --- %
data_followup.dVAT=data_followup.VATPost - data_followup.VAT;
data_cookie_followup.dVAT=data_cookie_followup.VATPost - data_cookie_followup.VAT;

lm = fitlm(data_followup,'dVAT~BMI'); % sig
lm = fitlm(data_followup,'dVAT~dActivityMets'); % ns
lm = fitlm(data_followup,'dVAT~VOIQrev'); % ns
lm = fitlm(data_followup,'dVAT~VFIQrev'); % ns 
lm = fitlm(data_followup,'dVAT~VVIQrev'); % close (p = 0.065)
lm = fitlm(data_followup,'dVAT~OdorInt'); % ns
lm = fitlm(data_followup,'dVAT~OdorInt+dActivityMets'); 
lm = fitlm(data_followup,'dVAT~VisualInt'); % ns
lm = fitlm(data_followup,'dVAT~Rpir_imag_pat'); % ns
lm = fitlm(data_followup,'dVAT~Rpir_imag_pat_sig'); % ns 
lm = fitlm(data_followup,'dVAT~Rpir_smell_pat'); % ns
lm = fitlm(data_followup,'dVAT~Rpir_smell_pat_sig'); % ns
lm = fitlm(data_followup,'dVAT~Craving*LikingKober'); % sig, but not sure what this means?
lm = fitlm(data_followup,'dVAT~CravingPost'); % ns 
lm = fitlm(data_followup,'dVAT~TotalCookieIntake'); % ns
lm = fitlm(data_followup,'dVAT~TotalCookieIntake+TasteTestLiking+Sex_data_followup'); % ns
lm = fitlm(data_cookie_followup,'dVAT~TotalCookieIntake'); % ns
lm = fitlm(data_followup,'dVAT~FCIscore'); % ns 
lm = fitlm(data_followup,'dVAT~FCQS'); % ns
lm = fitlm(data_followup,'dVAT~REDscore'); % ns
lm = fitlm(data_followup,'dVAT~OdorInt*LikingKober'); % sig
lm = fitlm(data_followup,'dVAT~TasteTestLiking'); % ns
lm = fitlm(data_followup,'dVAT~OdorInt*LikingKober+HungerIndex2'); % ns

% Test some plots
plot(data_followup.Craving, data_followup.dBMI,'ko'); 
plot(data_followup.OdorInt, data_followup.dFMpercent,'ko'); 
plot(data_followup.Rpir_imag_pat_sig, data_followup.dFMpercent,'ko'); 
plot(data_cookie_followup.TotalCookieIntake, data_cookie_followup.dFMpercent,'ko'); 
plot(data_followup.Rpir_imag_pat_sig, data_followup.dBMI,'ko'); 

%% 16. Test for data normality (variables in mediation/moderation)
% 0 = normal, 1 = not normally distributed (reject the null)

[h,p] = kstest(data_cookie_followup.TotalCookieIntake); % no
[h,p] = kstest(data_cookie_followup.TasteTestLiking); % no
[h,p] = kstest(data_cookie_followup.OdorInt); % no
[h,p] = kstest(data_cookie_followup.dFMpercent); % no

[h,p] = kstest(data_followup.Craving); % no
[h,p] = kstest(data_followup.LikingKober); % no
[h,p] = kstest(data_followup.dBMI); % no
[h,p] = kstest(data_followup.HungerIndex2); % no

%% 17. Test for data heteroskedasticity (variables in mediation/moderation)

% Do not appear to have heteroskedasticity in any of these relationships

lm = fitlm(data_followup,'dBMI~Craving'); % good
figure();
plotResiduals(lm,'fitted');

lm = fitlm(data_followup,'dBMI~OdorInt'); % good
figure();
plotResiduals(lm,'fitted');

lm = fitlm(data_followup,'Craving~OdorInt'); % good
figure();
plotResiduals(lm,'fitted');

lm = fitlm(data_cookie_followup,'TotalCookieIntake~OdorInt'); % good
figure();
plotResiduals(lm,'fitted');

lm = fitlm(data_cookie_followup,'dFMpercent~TotalCookieIntake'); % good
figure();
plotResiduals(lm,'fitted');

lm = fitlm(data_cookie_followup,'dFMpercent~OdorInt'); % good
figure();
plotResiduals(lm,'fitted');

%% 18. Test NCS anovas (below is specific to NCS food responses)

% Smell is 0, Imagine is 1
% Cookie is 0, Rose is 1, Odorless is 2
NCS.Type = nominal(NCS.Type);
NCS.Odor = nominal(NCS.Odor);

% --- overall ANOVA --- %

% Including clean air
% --- ANOVAS for type (smell/imagine) and odor (cookie/rose/odorless) --- %
lme1 = fitlme(NCS,'NCS~Type*Odor*group+(1|SubjectID)');
lme1_anova = anova(lme1); % Type = 0.006, Odor < 0.001, Type: Odor = 0.018

% --- smell vs imagine for each odor --- %

% smell cookie vs imagine cookie
NCS_cookie = NCS(NCS.Odor=='0',:); 
lme1 = fitlme(NCS_cookie,'NCS~Type+(1|SubjectID)');
lme1_anova = anova(lme1); % p = 0.002
[beta,names,stats]=fixedEffects(lme1);

% smell rose vs imagine rose
NCS_rose = NCS(NCS.Odor=='1',:); % includes smell and imagine rose
lme1 = fitlme(NCS_rose,'NCS~Type+(1|SubjectID)');
lme1_anova = anova(lme1); % p < 0.001
[beta,names,stats]=fixedEffects(lme1);

% smell odorless vs imagine odorless
NCS_odorless = NCS(NCS.Odor=='2',:); % includes smell and imagine rose
lme1 = fitlme(NCS_odorless,'NCS~Type+(1|SubjectID)');
lme1_anova = anova(lme1); % ns (p=0.708)
[beta,names,stats]=fixedEffects(lme1);

% --- smell comparisons --- %

% smell rose vs smell odorless
NCS_smell_rose_odorless = NCS(NCS.Type=='0',:); % include smell 
NCS_smell_rose_odorless(NCS_smell_rose_odorless.Odor=='0',:)=[]; % remove cookie
NCS_smell_rose_odorless.Type = nominal(NCS_smell_rose_odorless.Type);
NCS_smell_rose_odorless.Odor = nominal(NCS_smell_rose_odorless.Odor);
lme1 = fitlme(NCS_smell_rose_odorless,'NCS~Odor+(1|SubjectID)');
lme1_anova = anova(lme1); 
[beta,names,stats]=fixedEffects(lme1);

% smell cookie vs smell odorless
NCS_smell_cookie_odorless = NCS(NCS.Type=='0',:); % include smell 
NCS_smell_cookie_odorless(NCS_smell_cookie_odorless.Odor=='1',:)=[]; % remove rose
NCS_smell_cookie_odorless.Type = nominal(NCS_smell_cookie_odorless.Type);
NCS_smell_cookie_odorless.Odor = nominal(NCS_smell_cookie_odorless.Odor);
lme1 = fitlme(NCS_smell_cookie_odorless,'NCS~Odor+(1|SubjectID)');
lme1_anova = anova(lme1); 
[beta,names,stats]=fixedEffects(lme1);

% smell cookie vs smell rose
NCS_smell_cookie_rose = NCS(NCS.Type=='0',:); % include smell 
NCS_smell_cookie_rose(NCS_smell_cookie_rose.Odor=='2',:)=[]; % remove odorless
NCS_smell_cookie_rose.Type = nominal(NCS_smell_cookie_rose.Type);
NCS_smell_cookie_rose.Odor = nominal(NCS_smell_cookie_rose.Odor);
lme1 = fitlme(NCS_smell_cookie_rose,'NCS~Odor+(1|SubjectID)');
lme1_anova = anova(lme1); 
[beta,names,stats]=fixedEffects(lme1);

% --- imagine comparisons --- %

% imagine rose vs imagine odorless
NCS_imagine_rose_odorless = NCS(NCS.Type=='1',:); % include imagine 
NCS_imagine_rose_odorless(NCS_imagine_rose_odorless.Odor=='0',:)=[]; % remove cookie
NCS_imagine_rose_odorless.Type = nominal(NCS_imagine_rose_odorless.Type);
NCS_imagine_rose_odorless.Odor = nominal(NCS_imagine_rose_odorless.Odor);
lme1 = fitlme(NCS_imagine_rose_odorless,'NCS~Odor+(1|SubjectID)');
lme1_anova = anova(lme1); 
[beta,names,stats]=fixedEffects(lme1);

% imagine cookie vs imagine odorless
NCS_imagine_cookie_odorless = NCS(NCS.Type=='1',:); % include imagine 
NCS_imagine_cookie_odorless(NCS_imagine_cookie_odorless.Odor=='1',:)=[]; % remove rose
NCS_imagine_cookie_odorless.Type = nominal(NCS_imagine_cookie_odorless.Type);
NCS_imagine_cookie_odorless.Odor = nominal(NCS_imagine_cookie_odorless.Odor);
lme1 = fitlme(NCS_imagine_cookie_odorless,'NCS~Odor+(1|SubjectID)');
lme1_anova = anova(lme1); 
[beta,names,stats]=fixedEffects(lme1);

% imagine cookie vs imagine rose
NCS_imagine_cookie_rose = NCS(NCS.Type=='1',:); % include imagine 
NCS_imagine_cookie_rose(NCS_imagine_cookie_rose.Odor=='2',:)=[]; % remove odorless
NCS_imagine_cookie_rose.Type = nominal(NCS_imagine_cookie_rose.Type);
NCS_imagine_cookie_rose.Odor = nominal(NCS_imagine_cookie_rose.Odor);
lme1 = fitlme(NCS_imagine_cookie_rose,'NCS~Odor+(1|SubjectID)');
lme1_anova = anova(lme1); 
[beta,names,stats]=fixedEffects(lme1);

