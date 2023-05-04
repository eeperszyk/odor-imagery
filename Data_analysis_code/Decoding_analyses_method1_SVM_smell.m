% Odor imagery: decoding method #1 support vector machine
% Requires pulling in functions from The Decoding Toolbox (Hebart et al. 2015)
% These analyses were also repeated for the right piriform cortex, along with control regions (left and right
% primary visual cortices "V1")
% Train on smell, test on smell

% EP updated 9/15/21
% Use to generate individual results from runwise beta parameter estimates
% for binary classification
% WITH sniffing (i.e.,  the downsampled sniff trace was included at the first level)

% Info to update before running: subject ID, analtype

clear all;

for subject = [1681 2020 2129 2162 2306 2369 2397 2435 2438 2455 2457 2459 2460 2461 2463 2464 2467 2468 2472 2476 2477 2479 2480 2481 2482 2483 2484 2485 2487 2488 2489 2490 2491 2492 2497 2498 2499 2502 2503 2507 2508 2509 2510 2518 2526 2528 2533]; % update subject IDs here

	analtype = 'event_1bf_vec_nocue_sniff_native'; % update folder anal type here
	scaletype = 'scaled_mean'; % update for scaling type

	% RUN ROI MVPA

	sub = num2str(subject);

	result_path = '/data13/studies/OdorImagery/pipeline/results/fmri/';
	beta_dir = [result_path '1st/' analtype '/' sub '/scan1/'];

	cfg.files.mask = {['/data13/studies/OdorImagery/pipeline/results/fmri/nii/' sub '/scan1/ROI_6thr/ROI_Lpir.nii']};
	
	cfg.results.overwrite = 1;
	cfg.scale.estimation = 'separate'; 
	cfg.scale.method = 'mean';

	cfg.feature_selection.method = 'filter';
	cfg.feature_selection.filter = 'F';
	cfg.feature_selection.n_vox = 92; % minimum number of voxels for all subjects

	output_dir_SS = [result_path 'ROI_mvpa/6thr_Lpir/' analtype '/rose_cookie/1st/' scaletype '/' sub '/scan1/trainS_testI/'];
	decoding_example_scaled_ROI('roi','smell rose','smell cookie',beta_dir,output_dir_SS,4,cfg); % voxel size shouldn't matter because we aren't doing searchlight

end % for subject
