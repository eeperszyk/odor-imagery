% Odor imagery study - script for main analyses
% Emily Perszyk updated 5/4/23

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
% Total max N = 45 (3 excluded due to baseline odor detection < 50% chance)
% Scan total n = 44 (1 excluded due to extreme claustrophobia)
% Cookie intake n = 43 behavior (2 excluded after eating greater than 2 SD above the mean), 42 in scanner

% FOLLOWUP 
% Total n = 43 (1 did not complete followup: 1 excluded after losing more than 3 SD above the mean in weight)

%% Load the data from saved .mat variables

clear all
load data.mat data % general data
load int.mat int % interference task data (setup for ANOVAs)
load psycho_data.mat psycho_data % data from interference task/ psychophysical testing (aka perceptual testing, setup for correlations)
load crav_data.mat crav_data % craving data
load data_cookie.mat data_cookie % cookie data
load data_cookie_followup.mat data_cookie_followup % restricted to individuals for cookie intake and that completed followup session
load data_followup.mat data_followup % individiuals that returned for 1-year followup session
load data_scan.mat data_scan % individuals that completed the scand
load data_control.mat data_control % decoding results from The Decoding Toolbox for the left and right primary visual cortex V1 control regions
load patel.mat patel % data from the Patel et al. study (to compare variances in BMI versus the current study)

%% Fig. 2b

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
lme1_anova = anova(lme1); 

% Post-hoc comparison: odor MATCHED vs odor MISMATCHED
lme1 = fitlme(int_odor,'Accuracy~Detection+Smell+(1|SubjectID)');
lme1_anova = anova(lme1); 
[beta,names,stats]=fixedEffects(lme1);

% Post-hoc comparison: visual MATCHED vs visual MISMATCHED
lme1 = fitlme(int_visual,'Accuracy~Detection+Smell+(1|SubjectID)');
lme1_anova = anova(lme1); 
[beta,names,stats]=fixedEffects(lme1);

% --- Tests for any interactions with odor type --- % 

% Odor type x imagery condition x trial type
lme1 = fitlme(int_odor_visual,'Accuracy~Smell*Cond*Detection+(1|SubjectID)');
lme1_anova = anova(lme1); 

% --- ANOVA for comparison of matched with no imagery trials --- %

% ANOVA for odor MATCHED vs visual MATCHED vs no imagery 
lme1 = fitlme(int_odor_visual_none_match,'Accuracy~Cond+Smell+(1|SubjectID)');
lme1_anova = anova(lme1); 

% --- ANOVAS for comparison of mismatched with no imagery trials --- %

% ANOVA for odor MISMATCHED vs visual MISMATCHED vs no imagery 
lme1 = fitlme(int_odor_visual_none_mismatch,'Accuracy~Cond+Smell+(1|SubjectID)');
lme1_anova = anova(lme1); 

% Post-hoc comparison: odor MISMATCHED vs visual MISMATCHED
lme1 = fitlme(int_odor_visual_mismatch,'Accuracy~Cond+Smell+(1|SubjectID)');
lme1_anova = anova(lme1); 
[beta,names,stats]=fixedEffects(lme1);

% Post-hoc comparison: odor MISMATCHED vs no imagery
lme1 = fitlme(int_odor_none_mismatch,'Accuracy~Cond+Smell+(1|SubjectID)');
lme1_anova = anova(lme1); 
[beta,names,stats]=fixedEffects(lme1);

% Post-hoc comparison: visual MISMATCHED vs no imagery
lme1 = fitlme(int_visual_none_mismatch,'Accuracy~Cond+Smell+(1|SubjectID)');
lme1_anova = anova(lme1); 
[beta,names,stats]=fixedEffects(lme1);

%% Fig. 2c

[rho,pval] = corr(psycho_data.OdorInt,psycho_data.VOIQrev); 

%% Fig. 2d

[rho,pval] = corr(psycho_data.OdorInt,psycho_data.VFIQrev); 

%% Fig. 2e

[rho,pval] = corr(psycho_data.OdorInt,psycho_data.VVIQrev); 

%% The difference in detection accuracy on matched vs mismatched trials of the VISUAL imagery condition

% Did not correlate with self-reported odor, flavor, or visual imagery

[rho,pval] = corr(psycho_data.VisualInt,psycho_data.VOIQrev); 
[rho,pval] = corr(psycho_data.VisualInt,psycho_data.VFIQrev); 
[rho,pval] = corr(psycho_data.VisualInt,psycho_data.VVIQrev); 

%% Fig. 3e

% Comparing decoding method #1 in left/right piriform cortex ROIs to chance level

% Smell
[h1,p1,~,stats1] = ttest(data_scan.Lpir_smell_mvpa,50); 
[h1,p1,~,stats1] = ttest(data_scan.Rpir_smell_mvpa,50); 

% Imagine
[h1,p1,~,stats1] = ttest(data_scan.Lpir_imag_mvpa,50); 
[h1,p1,~,stats1] = ttest(data_scan.Rpir_imag_mvpa,50); 

% Crossmodal
[h1,p1,~,stats1] = ttest(data_scan.Lpir_cross_mvpa,50); 
[h1,p1,~,stats1] = ttest(data_scan.Rpir_cross_mvpa,50);

% --- Also test for laterality --- %
% Smell
[h1,p1,~,stats1] = ttest(data_scan.Lpir_smell_mvpa,data_scan.Rpir_smell_mvpa);

%% Fig. 3f

% Decoding method #2

% Smell
[h1,p1,~,stats1] = ttest(data_scan.Lpir_smell_pat,0); 
[h1,p1,~,stats1] = ttest(data_scan.Rpir_smell_pat,0); 

% Imagine
[h1,p1,~,stats1] = ttest(data_scan.Lpir_imag_pat,0); 
[h1,p1,~,stats1] = ttest(data_scan.Rpir_imag_pat,0); 

% Crossmodal
[h1,p1,~,stats1] = ttest(data_scan.Lpir_cross_pat,0); 
[h1,p1,~,stats1] = ttest(data_scan.Rpir_cross_pat,0); 

%% Fig. 3g

% Set up tables
data_neural = data;
data_neural(isnan(data_neural.Rpir_imag_pat_sig),:)=[]; % include individuals with voxel correlation Fisher's Z values > 0

% Test for voxel correlations in 30 individual with decoding of real odors
% in R piriform

% Imagine condition
[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data_neural.OdorInt); 

%% Fig. 3h

% Smell condition
[rho,pval] = corr(data_neural.Rpir_smell_pat_sig,data_neural.OdorInt); 

%% Fig. 3i

% Crossmodal condition
[rho,pval] = corr(data_neural.Rpir_cross_pat_sig,data_neural.OdorInt); 
imagery ability (
%% Fig. 4a

% Test food craving against the perceptual measure of odor imagery ability
% (i.e., the odor interference effect)

% Test simple correlation
[rho,pval] = corr(data.OdorInt,data.Craving); 

%% Fig. 4b

% Test food craving against the neural measure of odor imagery ability
% (i.e., R piriform decoding of imagined odors)

[rho,pval] = corr(data_neural.Rpir_imag_pat_sig,data.Craving); 

%% Fig. 4c

% Test for interaction with liking (neural measure)
lm = fitlm(data_neural,'Craving~Rpir_imag_pat_sig*LikingKober'); 

% Test for interaction with liking (perceptual measure)
lm = fitlm(data,'Craving~OdorInt*LikingKober'); 

% Test with hunger as well since it was significant
lm = fitlm(data,'Craving~OdorInt*LikingKober+HungerIndex2'); 

% --- Tertiary split --- %
% since we have 45 people now, this will give 3 equal groups

data_like1 = data; % 15 people
data_like1(data_like1.LikingKober>11.7,:)=[]; % roughly equates to liking it less than slightly 
[rho,pval] = corr(data_like1.OdorInt,data_like1.Craving); 

data_like2 = data; % 15 people
data_like2(data_like2.LikingKober<11.7,:)=[]; % roughly equates to liking it slightly to moderately 
data_like2(data_like2.LikingKober>28,:)=[];
[rho,pval] = corr(data_like2.OdorInt,data_like2.Craving); 

data_like3 = data; % 15 people
data_like3(data_like3.LikingKober<28,:)=[]; % roughly equates to liking it moderately or more
[rho,pval] = corr(data_like3.OdorInt,data_like3.Craving); 

%% LME with craving data for individual foods (rather than averages)

% Odor int x liking
lme1 = fitlme(crav_data,'CravingByFood~OdorInt*Liking+(1|SubjectID)');
lme1_anova = anova(lme1); 

% Check with covariates
lme1 = fitlme(crav_data,'CravingByFood~OdorInt*Liking+HungerIndex2+(1|SubjectID)');
lme1_anova = anova(lme1); 

%% Fig. 4d

% Test food intake against the perceptual measure of odor imagery ability
% (i.e., the odor interference effect)
% Covariates: sex, food liking

lm = fitlm(data_cookie,'TotalCookieIntake~OdorInt+TasteTestLiking+Sex'); 

%% Fig. 4e

% Test food intake against the neural measure of odor imagery ability
% (i.e., R piriform decoding of imagined odors)

lm = fitlm(data_cookie_neural,'TotalCookieIntake~Rpir_imag_pat+TasteTestLiking+Sex'); 

%% Compare variance in BMI for our study versus the Patel study

% F test for equality of variances
[h,p,ci,stats] = vartest2(data.BMI, patel.BMI);

% Exclude the individuals with extreme obesity (> 35 kg/m2) as in previous
% work to determine if the relationship may be nonlinear

data_extreme_obesity_removed = data;
data_extreme_obesity_removed(data_extreme_obesity_removed.BMI>=35,:)=[];
[rho,pval] = corr(data_extreme_obesity_removed.OdorInt,data_extreme_obesity_removed.BMI); 
[rho,pval] = corr(data_extreme_obesity_removed.VOIQrev,data_extreme_obesity_removed.BMI); 
[rho,pval] = corr(data_extreme_obesity_removed.Rpir_imag_pat_sig,data_extreme_obesity_removed.BMI); 

%% Fig. 4f

% Is food intake associated with change in adiposity?
[rho,pval] = corr(data_followup.TotalCookieIntake,data_followup.dBMI); 
[rho,pval] = corr(data_followup.TotalCookieIntake,data_followup.dFMpercent); 

%% Fig. 4g

% Is food craving associated with change in adiposity?
[rho,pval] = corr(data_followup.Craving,data_followup.dBMI); 
[rho,pval] = corr(data_followup.Craving,data_followup.dFMpercent); 

%% Extended Data Fig. 1b

% Comparing decoding method #1 in the control regions

% Smell
[h1,p1,~,stats1] = ttest(data_scan.LV1_smell_mvpa,50); 
[h1,p1,~,stats1] = ttest(data_scan.RV1_smell_mvpa,50); 

% Imagine
[h1,p1,~,stats1] = ttest(data_scan.LV1_imag_mvpa,50); 
[h1,p1,~,stats1] = ttest(data_scan.RV1_imag_mvpa,50); 

% Crossmodal
[h1,p1,~,stats1] = ttest(data_scan.LV1_cross_mvpa,50); 
[h1,p1,~,stats1] = ttest(data_scan.RV1_cross_mvpa,50);

%% Extended Data Fig. 1c

% Decoding method #2

% Smell
[h1,p1,~,stats1] = ttest(data_scan.LV1_smell_pat,0); 
[h1,p1,~,stats1] = ttest(data_scan.RV1_smell_pat,0); 

% Imagine
[h1,p1,~,stats1] = ttest(data_scan.LV1_imag_pat,0); 
[h1,p1,~,stats1] = ttest(data_scan.RV1_imag_pat,0); 

% Crossmodal
[h1,p1,~,stats1] = ttest(data_scan.LV1_cross_pat,0); 
[h1,p1,~,stats1] = ttest(data_scan.RV1_cross_pat,0); 

%% Extended Data Fig. 3

% Subplots a-c: Measures of odor imagery ability versus change in BMI
[rho,pval] = corr(data_followup.VOIQrev,data_followup.dBMI); 
[rho,pval] = corr(data_followup.OdorInt,data_followup.dBMI); 
[rho,pval] = corr(data_followup_neural.Rpir_imag_pat_sig,data_followup_neural.dBMI); 

% Subplots d-f: Measures of odor imagery ability versus change in body fat
% percentage
[rho,pval] = corr(data_followup.VOIQrev,data_followup.dFMpercent); 
[rho,pval] = corr(data_followup.OdorInt,data_followup.dFMpercent); 
[rho,pval] = corr(data_followup_neural.Rpir_imag_pat_sig,data_followup_neural.dFMpercent); 

%% Extended Data Fig. 5

% Odor rating comparisons for rose vs cookie
[h,p,~,stats] = ttest(data.RoseAvScanIntensity, data.CookieAvScanIntensity); 
[h,p,~,stats] = ttest(data.RoseAvScanFamiliarity, data.CookieAvScanFamiliarity); 
[h,p,~,stats] = ttest(data.RoseAvScanEdibility, data.CookieAvScanEdibility); 
[h,p,~,stats] = ttest(data.RoseAvScanLiking, data.CookieAvScanLiking); 

%% Supplementary Table 1

% --- Decoding vs odor imagery measures in FULL SAMPLE --- %

% Smell
[rho,pval] = corr(data.Rpir_smell_pat,data.OdorInt);
[rho,pval] = corr(data_control.Lv1_smell_pat,data_control.OdorInt);
[rho,pval] = corr(data_control.Rv1_smell_pat,data_control.OdorInt);

% Imagine
[rho,pval] = corr(data.Rpir_imag_pat,data.OdorInt);
[rho,pval] = corr(data_control.Lv1_imag_pat,data_control.OdorInt);
[rho,pval] = corr(data_control.Rv1_imag_pat,data_control.OdorInt);

% Crossmodal
[rho,pval] = corr(data.Rpir_cross_pat,data.OdorInt);
[rho,pval] = corr(data_control.Lv1_cross_pat,data_control.OdorInt);
[rho,pval] = corr(data_control.Rv1_cross_pat,data_control.OdorInt);

% --- Decoding vs odor imagery measures in RESTRICTED SAMPLES --- %

% Rpir
Rpirdata = data_scan;
Rpirdata(isnan(Rpirdata.Rpir_smell_pat_sig),:)=[];

% Lv1
LV1data = data_control;
LV1data(isnan(LV1data.Lv1_smell_pat_sig),:)=[];

% Rv1
RV1data = data_control;
RV1data(isnan(RV1data.Rv1_smell_pat_sig),:)=[];

% Smell
[rho,pval] = corr(Rpirdata.Rpir_smell_pat,Rpirdata.OdorInt);
[rho,pval] = corr(LV1data.Lv1_smell_pat,LV1data.OdorInt);
[rho,pval] = corr(RV1data.Rv1_smell_pat,RV1data.OdorInt);

% Imagine
[rho,pval] = corr(Rpirdata.Rpir_imag_pat,Rpirdata.OdorInt);
[rho,pval] = corr(LV1data.Lv1_imag_pat,LV1data.OdorInt);
[rho,pval] = corr(RV1data.Rv1_imag_pat,RV1data.OdorInt);

% Crossmodal
[rho,pval] = corr(Rpirdata.Rpir_cross_pat,Rpirdata.OdorInt);
[rho,pval] = corr(LV1data.Lv1_cross_pat,LV1data.OdorInt);
[rho,pval] = corr(RV1data.Rv1_cross_pat,RV1data.OdorInt);

%% Supplementary Table 2

% Correlations Comparing the Behavioral Food Cue Reactivity Measures with Olfactory Function and Perception

% --- Food craving --- %
[rho,pval] = corr(data.Craving,data.RoseThreshold); 
[rho,pval] = corr(data.Craving,data.CookieThreshold);
[rho,pval] = corr(data_scan.Craving,data_scan.Rpir_smell_pat); % full sample 
[rho,pval] = corr(Rpirdata.Craving,Rpirdata.Rpir_smell_pat_sig); % restricted sample
[rho,pval] = corr(data_scan.Craving,data_scan.ScanLikingDiff); % cookie minus rose diff from scanning
[rho,pval] = corr(data_scan.Craving,data_scan.ScanEdibilityDiff); 
[rho,pval] = corr(data_scan.Craving,data_scan.ScanIntensityDiff); 
[rho,pval] = corr(data_scan.Craving,data_scan.ScanFamiliarityDiff); 

% --- Food intake --- %
[rho,pval] = corr(data_cookie.TotalCookieIntake,data_cookie.RoseThreshold); 
[rho,pval] = corr(data_cookie.TotalCookieIntake,data_cookie.CookieThreshold);
[rho,pval] = corr(data_cookie_scan.TotalCookieIntake,data_cookie_scan.Rpir_smell_pat); % full sample 
[rho,pval] = corr(Rpirdata.TotalCookieIntake,Rpirdata.Rpir_smell_pat_sig); % restricted sample
[rho,pval] = corr(data_cookie_scan.TotalCookieIntake,data_cookie_scan.ScanLikingDiff); % cookie minus rose diff from scanning
[rho,pval] = corr(data_cookie_scan.TotalCookieIntake,data_cookie_scan.ScanEdibilityDiff); 
[rho,pval] = corr(data_cookie_scan.TotalCookieIntake,data_cookie_scan.ScanIntensityDiff); 
[rho,pval] = corr(data_cookie_scan.TotalCookieIntake,data_cookie_scan.ScanFamiliarityDiff); 

%% Supplementary Table 3

% Correlations Comparing the Behavioral Food Cue Reactivity Measures with Demographics, Current Adiposity, Food Liking, Hunger, and the Consumption of Unhealthy Foods

% --- Food craving --- %
[rho,pval] = corr(data.Craving,data.Sex); 
[rho,pval] = corr(data.Craving,data.Age); 
[rho,pval] = corr(data.Craving,data.HHincome);
[rho,pval] = corr(data.Craving,data.BMI); 
[rho,pval] = corr(data.Craving,data.FMpercent); 
[rho,pval] = corr(data_cookie.Craving,data.TotalCookieIntake); 
[rho,pval] = corr(data.Craving,data.VFIQ_rev); 
[rho,pval] = corr(data.Craving,data.LikingKober); 
[rho,pval] = corr(data.Craving,data.TasteTestLiking); 
[rho,pval] = corr(data.Craving,data.Hunger2);
[rho,pval] = corr(data.Craving,data.DFStotal); 
[rho,pval] = corr(data.Craving,data.FreqConsKober); 
[rho,pval] = corr(data.Craving,data.TasteTestFrequencyOfConsumption); 

% --- Food intake --- %
[rho,pval] = corr(data_cookie.TotalCookieIntake,data_cookie.Sex); 
[rho,pval] = corr(data_cookie.TotalCookieIntake,data_cookie.Age); 
[rho,pval] = corr(data_cookie.TotalCookieIntake,data_cookie.HHincome);
[rho,pval] = corr(data_cookie.TotalCookieIntake,data_cookie.BMI); 
[rho,pval] = corr(data_cookie.TotalCookieIntake,data_cookie.FMpercent); 
[rho,pval] = corr(data_cookie.TotalCookieIntake,data_cookie.VFIQ_rev); 
[rho,pval] = corr(data_cookie.TotalCookieIntake,data_cookie.LikingKober); 
[rho,pval] = corr(data_cookie.TotalCookieIntake,data_cookie.TasteTestLiking); 
[rho,pval] = corr(data_cookie.TotalCookieIntake,data_cookie.Hunger6);
[rho,pval] = corr(data_cookie.TotalCookieIntake,data_cookie.DFStotal); 
[rho,pval] = corr(data_cookie.TotalCookieIntake,data_cookie.FreqConsKober); 
[rho,pval] = corr(data_cookie.TotalCookieIntake,data_cookie.TasteTestFrequencyOfConsumption); 

%% Supplementary Table 4 

% Correlations Comparing the Odor Imagery Ability Measures with Demographics, Current Adiposity, Olfactory Function and Perception, Sniff Parameters, Hunger, and the Consumption of Unhealthy Foods

% --- Self-report measure --- %
[rho,pval] = corr(data.VOIQrev,data.Sex); 
[rho,pval] = corr(data.VOIQrev,data.Age); 
[rho,pval] = corr(data.VOIQrev,data.HHincome);
[rho,pval] = corr(data.VOIQrev,data.BMI); 
[rho,pval] = corr(data.VOIQrev,data.FMpercent); 
[rho,pval] = corr(data.VOIQrev,data.RoseThreshold); 
[rho,pval] = corr(data.VOIQrev,data.CookieThreshold); 
[rho,pval] = corr(data_scan.VOIQrev,data_scan.Rpir_smell_pat); % full sample 
[rho,pval] = corr(Rpirdata.VOIQrev,Rpirdata.Rpir_smell_pat_sig); % restricted sample
[rho,pval] = corr(data_scan.VOIQrev,data_scan.ScanLikingDiff); % cookie minus rose diff from scanning
[rho,pval] = corr(data_scan.VOIQrev,data_scan.ScanEdibilityDiff); 
[rho,pval] = corr(data_scan.VOIQrev,data_scan.ScanIntensityDiff); 
[rho,pval] = corr(data_scan.VOIQrev,data_scan.ScanFamiliarityDiff); 
[rho,pval] = corr(data.VOIQrev,data.Hunger1); 
[rho,pval] = corr(data.VOIQrev,data.DFStotal); 
[rho,pval] = corr(data.VOIQrev,data.FreqConsKober); 
[rho,pval] = corr(data.VOIQrev,data.TasteTestFrequencyOfConsumption); 

% --- Perceptual measure --- %
[rho,pval] = corr(data.OdorInt,data.Sex); 
[rho,pval] = corr(data.OdorInt,data.Age); 
[rho,pval] = corr(data.OdorInt,data.HHincome);
[rho,pval] = corr(data.OdorInt,data.BMI); 
[rho,pval] = corr(data.OdorInt,data.FMpercent); 
[rho,pval] = corr(data.OdorInt,data.RoseThreshold); 
[rho,pval] = corr(data.OdorInt,data.CookieThreshold); 
[rho,pval] = corr(data_scan.OdorInt,data_scan.Rpir_smell_pat); % full sample 
[rho,pval] = corr(Rpirdata.OdorInt,Rpirdata.Rpir_smell_pat_sig); % restricted sample
[rho,pval] = corr(data_scan.OdorInt,data_scan.ScanLikingDiff); % cookie minus rose diff from scanning
[rho,pval] = corr(data_scan.OdorInt,data_scan.ScanEdibilityDiff); 
[rho,pval] = corr(data_scan.OdorInt,data_scan.ScanIntensityDiff); 
[rho,pval] = corr(data_scan.OdorInt,data_scan.ScanFamiliarityDiff); 
[rho,pval] = corr(data.OdorInt,data.Hunger3); 
[rho,pval] = corr(data.OdorInt,data.DFStotal); 
[rho,pval] = corr(data.OdorInt,data.FreqConsKober); 
[rho,pval] = corr(data.OdorInt,data.TasteTestFrequencyOfConsumption); 

% --- Neural measure --- %
[rho,pval] = corr(data_neural.Rpir_imag_pat,data_neural.Sex); 
[rho,pval] = corr(data_neural.Rpir_imag_pat,data_neural.Age); 
[rho,pval] = corr(data_neural.Rpir_imag_pat,data_neural.HHincome);
[rho,pval] = corr(data_neural.Rpir_imag_pat,data_neural.BMI); 
[rho,pval] = corr(data_neural.Rpir_imag_pat,data_neural.FMpercent); 
[rho,pval] = corr(data_neural.Rpir_imag_pat,data_neural.RoseThreshold); 
[rho,pval] = corr(data_neural.Rpir_imag_pat,data_neural.CookieThreshold); 
[rho,pval] = corr(data_neural.Rpir_imag_pat,data_neural.Rpir_smell_pat); % full sample 
[rho,pval] = corr(data_neural.Rpir_imag_pat,data_neural.Rpir_smell_pat_sig); % restricted sample
[rho,pval] = corr(data_neural.Rpir_imag_pat,data_neural.ScanLikingDiff); % cookie minus rose diff from scanning
[rho,pval] = corr(data_neural.Rpir_imag_pat,data_neural.ScanEdibilityDiff); 
[rho,pval] = corr(data_neural.Rpir_imag_pat,data_neural.ScanIntensityDiff); 
[rho,pval] = corr(data_neural.Rpir_imag_pat,data_neural.ScanFamiliarityDiff); 
[rho,pval] = corr(data_neural.Rpir_imag_pat,data_neural.Hunger8); 
[rho,pval] = corr(data_neural.Rpir_imag_pat,data_neural.DFStotal); 
[rho,pval] = corr(data_neural.Rpir_imag_pat,data_neural.FreqConsKober); 
[rho,pval] = corr(data_neural.Rpir_imag_pat,data_neural.TasteTestFrequencyOfConsumption); 

%% Supplementary Table 5

% Correlations Comparing Age, Current Adiposity, or Change in Adiposity Over One Year with Olfactory Function and Perception

% --- Age --- %
[rho,pval] = corr(data.Age,data.RoseThreshold); 
[rho,pval] = corr(data.Age,data.CookieThreshold); 
[rho,pval] = corr(data_scan.Age,data_scan.Rpir_smell_pat); % full sample 
[rho,pval] = corr(Rpirdata.Age,Rpirdata.Rpir_smell_pat_sig); % restricted sample
[rho,pval] = corr(data_scan.Age,data_scan.ScanLikingDiff); % cookie minus rose diff from scanning
[rho,pval] = corr(data_scan.Age,data_scan.ScanEdibilityDiff); 
[rho,pval] = corr(data_scan.Age,data_scan.ScanIntensityDiff); 
[rho,pval] = corr(data_scan.Age,data_scan.ScanFamiliarityDiff); 

% --- Current BMI --- %
[rho,pval] = corr(data.BMI,data.RoseThreshold); 
[rho,pval] = corr(data.BMI,data.CookieThreshold); 
[rho,pval] = corr(data_scan.BMI,data_scan.Rpir_smell_pat); % full sample 
[rho,pval] = corr(Rpirdata.BMI,Rpirdata.Rpir_smell_pat_sig); % restricted sample
[rho,pval] = corr(data_scan.BMI,data_scan.ScanLikingDiff); % cookie minus rose diff from scanning
[rho,pval] = corr(data_scan.BMI,data_scan.ScanEdibilityDiff); 
[rho,pval] = corr(data_scan.BMI,data_scan.ScanIntensityDiff); 
[rho,pval] = corr(data_scan.BMI,data_scan.ScanFamiliarityDiff); 

% --- Current Body Fat Percentage --- %
[rho,pval] = corr(data.FMpercent,data.RoseThreshold); 
[rho,pval] = corr(data.FMpercent,data.CookieThreshold); 
[rho,pval] = corr(data_scan.FMpercent,data_scan.Rpir_smell_pat); % full sample 
[rho,pval] = corr(Rpirdata.FMpercent,Rpirdata.Rpir_smell_pat_sig); % restricted sample
[rho,pval] = corr(data_scan.FMpercent,data_scan.ScanLikingDiff); % cookie minus rose diff from scanning
[rho,pval] = corr(data_scan.FMpercent,data_scan.ScanEdibilityDiff); 
[rho,pval] = corr(data_scan.FMpercent,data_scan.ScanIntensityDiff); 
[rho,pval] = corr(data_scan.FMpercent,data_scan.ScanFamiliarityDiff); 

% --- Change in BMI --- %
[rho,pval] = corr(data_followup.dBMI,data.RoseThreshold); 
[rho,pval] = corr(data_followup.dBMI,data_followup.CookieThreshold); 
[rho,pval] = corr(data_followup_scan.dBMI,data_followup_scan.Rpir_smell_pat); % full sample 
[rho,pval] = corr(Rpirdata.dBMI,Rpirdata.Rpir_smell_pat_sig); % restricted sample
[rho,pval] = corr(data_followup_scan.dBMI,data_followup_scan.ScanLikingDiff); % cookie minus rose diff from scanning
[rho,pval] = corr(data_followup_scan.dBMI,data_followup_scan.ScanEdibilityDiff); 
[rho,pval] = corr(data_followup_scan.dBMI,data_followup_scan.ScanIntensityDiff); 
[rho,pval] = corr(data_followup_scan.dBMI,data_followup_scan.ScanFamiliarityDiff); 

% --- Change in Body Fat Percentage --- %
[rho,pval] = corr(data_followup.dFMpercent,data.RoseThreshold); 
[rho,pval] = corr(data_followup.dFMpercent,data_followup.CookieThreshold); 
[rho,pval] = corr(data_followup_scan.dFMpercent,data_followup_scan.Rpir_smell_pat); % full sample 
[rho,pval] = corr(Rpirdata.dFMpercent,Rpirdata.Rpir_smell_pat_sig); % restricted sample
[rho,pval] = corr(data_followup_scan.dFMpercent,data_followup_scan.ScanLikingDiff); % cookie minus rose diff from scanning
[rho,pval] = corr(data_followup_scan.dFMpercent,data_followup_scan.ScanEdibilityDiff); 
[rho,pval] = corr(data_followup_scan.dFMpercent,data_followup_scan.ScanIntensityDiff); 
[rho,pval] = corr(data_followup_scan.dFMpercent,data_followup_scan.ScanFamiliarityDiff); 

%% Supplementary Table 6

% Correlations Comparing Current or Change in Adiposity Over One Year with Demographics, Food Liking, the Consumption of Unhealthy Foods, and Physical Activity Change

% --- Current BMI --- %
[rho,pval] = corr(data.BMI,data.Sex); 
[rho,pval] = corr(data.BMI,data.Age); 
[rho,pval] = corr(data.BMI,data.HHincome);
[rho,pval] = corr(data.BMI,data.BMI); 
[rho,pval] = corr(data.BMI,data.FMpercent); 
[rho,pval] = corr(data.BMI,data.LikingKober); 
[rho,pval] = corr(data.BMI,data.TasteTestLiking); 
[rho,pval] = corr(data.BMI,data.Hunger1);
[rho,pval] = corr(data.BMI,data.DFStotal); 
[rho,pval] = corr(data.BMI,data.FreqConsKober); 
[rho,pval] = corr(data.BMI,data.TasteTestFrequencyOfConsumption); 
[rho,pval] = corr(data.BMI,data.dIPAQ); 

% --- Current Body fat percentage --- %
[rho,pval] = corr(data.FMpercent,data.Sex); 
[rho,pval] = corr(data.FMpercent,data.Age); 
[rho,pval] = corr(data.FMpercent,data.HHincome);
[rho,pval] = corr(data.FMpercent,data.BMI); 
[rho,pval] = corr(data.FMpercent,data.FMpercent); 
[rho,pval] = corr(data.FMpercent,data.LikingKober); 
[rho,pval] = corr(data.FMpercent,data.TasteTestLiking); 
[rho,pval] = corr(data.FMpercent,data.Hunger1);
[rho,pval] = corr(data.FMpercent,data.DFStotal); 
[rho,pval] = corr(data.FMpercent,data.FreqConsKober); 
[rho,pval] = corr(data.FMpercent,data.TasteTestFrequencyOfConsumption); 
[rho,pval] = corr(data.FMpercent,data.dIPAQ); 

% --- Change in BMI --- %
[rho,pval] = corr(data_followup.dBMI,data_followup.Sex); 
[rho,pval] = corr(data_followup.dBMI,data_followup.Age); 
[rho,pval] = corr(data_followup.dBMI,data_followup.HHincome);
[rho,pval] = corr(data_followup.dBMI,data_followup.BMI); 
[rho,pval] = corr(data_followup.dBMI,data_followup.FMpercent); 
[rho,pval] = corr(data_followup.dBMI,data_followup.LikingKober); 
[rho,pval] = corr(data_followup.dBMI,data_followup.TasteTestLiking); 
[rho,pval] = corr(data_followup.dBMI,data_followup.Hunger1);
[rho,pval] = corr(data_followup.dBMI,data_followup.DFStotal); 
[rho,pval] = corr(data_followup.dBMI,data_followup.FreqConsKober); 
[rho,pval] = corr(data_followup.dBMI,data_followup.TasteTestFrequencyOfConsumption); 
[rho,pval] = corr(data_followup.dBMI,data_followup.dIPAQ);

% --- Change in Body Fat Percentage --- %
[rho,pval] = corr(data_followup.dFMpercent,data_followup.Sex); 
[rho,pval] = corr(data_followup.dFMpercent,data_followup.Age); 
[rho,pval] = corr(data_followup.dFMpercent,data_followup.HHincome);
[rho,pval] = corr(data_followup.dFMpercent,data_followup.BMI); 
[rho,pval] = corr(data_followup.dFMpercent,data_followup.FMpercent); 
[rho,pval] = corr(data_followup.dFMpercent,data_followup.LikingKober); 
[rho,pval] = corr(data_followup.dFMpercent,data_followup.TasteTestLiking); 
[rho,pval] = corr(data_followup.dFMpercent,data_followup.Hunger1);
[rho,pval] = corr(data_followup.dFMpercent,data_followup.DFStotal); 
[rho,pval] = corr(data_followup.dFMpercent,data_followup.FreqConsKober); 
[rho,pval] = corr(data_followup.dFMpercent,data_followup.TasteTestFrequencyOfConsumption); 
[rho,pval] = corr(data_followup.dFMpercent,data_followup.dIPAQ);

%% Supplementary Table 7

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

% BMI group comparisons
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
