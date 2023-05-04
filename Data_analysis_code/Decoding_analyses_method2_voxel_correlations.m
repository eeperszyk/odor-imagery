% Odor imagery: decoding method #2 voxel correlations
% Requires pulling in functions from The Decoding Toolbox (Hebart et al. 2015)
% These analyses were also repeated for control regions (left and right
% primary visual cortices "V1")

% EP updated 9/24/21
% Use to determine voxel correlations for even vs odd runs
% Since I have 5 runs, we will use runs 2-5 for even/odd halves
% Pulls in the respective contrasts (and averages across the even/odd runs): smell rose, smell cookie, imagine rose, imagine cookie
% Using run 1 as the 'odor localizer scan'

% Info to update before running: subject ID, analtype

clear all;

% Parameters to update
analtype = 'event_1bf_vec_nocue_sniff_native'; % update folder anal type here
mask_folder = 'ROI_6thr'; % update the mask folder here
masks.name{1,1} = 'ROI_Lpir'; 
masks.name{1,2} = 'ROI_Rpir'; 

masks.vox{1,1} = 92; % number of odor-active voxels to use per mask (min subject)
masks.vox{1,2} = 54;

loc = 1; % localizer scan
scaletype = 'mean'; % scaletype: either 'mean' (for subtracting the mean of the run) or 'z' (for z-scoring the run)

% add as many masks here as we have
% ALSO update subject IDs below if needed

% Cfg setup
if ~exist('cfg', 'var')
    cfg = [];
else
    display('Using default arguments provided by cfg')
end

cfg = decoding_defaults(cfg);
cfg.testmode = 0;
cfg.analysis = 'roi';
cfg.decoding.train.classification.model_parameters = '-s 0 -t 0 -c 1 -b 0 -q'; % linear classification
try
    cfg.software = spm('ver');
catch % else try out spm8
    cfg.software = 'SPM8';
end

method = 'zcorr'; %zcorr
results = struct; % to store all the results for all of the masks


for maskn = 1:length(masks.name)

	within_pos = []; % to store all subject corr within results: smell rose even vs smell rose odd, smell cookie even vs smell cookie odd, imagine rose even vs imagine rose odd, imagine cookie even vs imagine cookie odd
	between_pos = []; % to store all subject corr between results: smell rose even vs imagine rose odd, smell cookie even vs imagine cookie odd, imagine rose even vs smell rose odd, imagine cookie even vs smell cookie odd  
	within_neg = []; 
	between_neg = []; 

	for subject = [1681 2020 2129 2162 2306 2369 2397 2435 2438 2455 2457 2459 2460 2461 2463 2464 2467 2468 2472 2476 2477 2479 2480 2481 2482 2483 2484 2485 2487 2488 2489 2490 2491 2492 2497 2498 2499 2502 2503 2507 2508 2509 2510 2518 2526 2528 2533]; % update subject IDs here

		sub = num2str(subject);

		load(['/data13/studies/OdorImagery/pipeline/results/fmri/1st/' analtype '/' sub '/scan1/regressor_names.mat']);
		regs = regressor_names(3,:);

		beta.name{1,1} = ['smell rose'];
		beta.name{2,1} = ['smell cookie'];
		beta.name{3,1} = ['imagine rose'];
		beta.name{4,1} = ['imagine cookie'];
		beta.name{5,1} = ['smell odorless'];
		beta.name{6,1} = ['imagine odorless'];

		for run =1:5; % practice for now with runs 1-4 only
		
			[~,beta.ind{1,run}] = ismember(['Sn(' num2str(run) ') smell rose*bf(1)'], regs); % run n smell rose
			[~,beta.ind{2,run}] = ismember(['Sn(' num2str(run) ') smell cookie*bf(1)'], regs); % run n smell cookie
			[~,beta.ind{3,run}] = ismember(['Sn(' num2str(run) ') imagine rose*bf(1)'], regs); % run n imagine rose
			[~,beta.ind{4,run}] = ismember(['Sn(' num2str(run) ') imagine cookie*bf(1)'], regs); % run n imagine cookie

			
			% Extract the patterns for smelling odorless and imagining odorless for odor localizer only
			if run == loc	
				[~,beta.ind{5,run}] = ismember(['Sn(' num2str(run) ') smell odorless*bf(1)'], regs); % smell odorless
				[~,beta.ind{6,run}] = ismember(['Sn(' num2str(run) ') imagine odorless*bf(1)'], regs); % imagine odorless

				% Determine the base name for the smell odorless betas 
				if beta.ind{5,run} < 10
					beta.indname{5,run} = ['beta_000' num2str(beta.ind{5,run}) '.nii'];
				elseif beta.ind{5,run} > 10 & beta.ind{5,run} < 100
					beta.indname{5,run} = ['beta_00' num2str(beta.ind{5,run}) '.nii'];
				else % beta > 100
					beta.indname{5,run} = ['beta_0' num2str(beta.ind{5,run}) '.nii'];
				end % if beta.ind

				% Determine the base name for the imagine odorless betas 
				if beta.ind{6,run} < 10
					beta.indname{6,run} = ['beta_000' num2str(beta.ind{6,run}) '.nii'];
				elseif beta.ind{6,run} > 10 & beta.ind{6,run} < 100
					beta.indname{6,run} = ['beta_00' num2str(beta.ind{6,run}) '.nii'];
				else % beta > 100
					beta.indname{6,run} = ['beta_0' num2str(beta.ind{6,run}) '.nii'];
				end % if beta.ind

			end % if run == loc

			% Determine the base name for the smell rose betas 
			if beta.ind{1,run} < 10
				beta.indname{1,run} = ['beta_000' num2str(beta.ind{1,run}) '.nii'];
			elseif beta.ind{1,run} > 10 & beta.ind{1,run} < 100
				beta.indname{1,run} = ['beta_00' num2str(beta.ind{1,run}) '.nii'];
			else % beta > 100
				beta.indname{1,run} = ['beta_0' num2str(beta.ind{1,run}) '.nii'];
			end % if beta.ind

			% Determine the base name for the smell cookie betas 
			if beta.ind{2,run} < 10
				beta.indname{2,run} = ['beta_000' num2str(beta.ind{2,run}) '.nii'];
			elseif beta.ind{2,run} > 10 & beta.ind{2,run} < 100
				beta.indname{2,run} = ['beta_00' num2str(beta.ind{2,run}) '.nii'];
			else % beta > 100
				beta.indname{2,run} = ['beta_0' num2str(beta.ind{2,run}) '.nii'];
			end % if beta.ind

			% Determine the base name for the imagine rose betas 
			if beta.ind{3,run} < 10
				beta.indname{3,run} = ['beta_000' num2str(beta.ind{3,run}) '.nii'];
			elseif beta.ind{3,run} > 10 & beta.ind{3,run} < 100
				beta.indname{3,run} = ['beta_00' num2str(beta.ind{3,run}) '.nii'];
			else % beta > 100
				beta.indname{3,run} = ['beta_0' num2str(beta.ind{3,run}) '.nii'];
			end % if beta.ind

			% Determine the base name for the imagine cookie betas 
			if beta.ind{4,run} < 10
				beta.indname{4,run} = ['beta_000' num2str(beta.ind{4,run}) '.nii'];
			elseif beta.ind{4,run} > 10 & beta.ind{4,run} < 100
				beta.indname{4,run} = ['beta_00' num2str(beta.ind{4,run}) '.nii'];
			else % beta > 100
				beta.indname{4,run} = ['beta_0' num2str(beta.ind{4,run}) '.nii'];
			end % if beta.ind

			% Find the correct betas by run
			cfg.files.chunk{(4*(run-1)+1),1} = run;
			cfg.files.chunk{(4*(run-1)+2),1} = run;
			cfg.files.chunk{(4*(run-1)+3),1} = run;
			cfg.files.chunk{(4*(run-1)+4),1} = run;
			cfg.files.name{(4*(run-1)+1),1} = ['/data13/studies/OdorImagery/pipeline/results/fmri/1st/' analtype '/' sub '/scan1/' beta.indname{1,run}]; % smell rose 
			cfg.files.name{(4*(run-1)+2),1} = ['/data13/studies/OdorImagery/pipeline/results/fmri/1st/' analtype '/' sub '/scan1/' beta.indname{2,run}]; % smell cookie 
			cfg.files.name{(4*(run-1)+3),1} = ['/data13/studies/OdorImagery/pipeline/results/fmri/1st/' analtype '/' sub '/scan1/' beta.indname{3,run}]; % imagine rose 
			cfg.files.name{(4*(run-1)+4),1} = ['/data13/studies/OdorImagery/pipeline/results/fmri/1st/' analtype '/' sub '/scan1/' beta.indname{4,run}]; % imagine cookie 

				if run == loc
					cfg.files.chunk{21,1} = run;
					cfg.files.chunk{22,1} = run;
					cfg.files.name{21,1} = ['/data13/studies/OdorImagery/pipeline/results/fmri/1st/' analtype '/' sub '/scan1/' beta.indname{5,run}]; % smell odorless 
					cfg.files.name{22,1} = ['/data13/studies/OdorImagery/pipeline/results/fmri/1st/' analtype '/' sub '/scan1/' beta.indname{6,run}]; % imagine odorless 
				end % if run == loc

		end % for run
		
		% Load the data
		cfg.files.mask = {['/data13/studies/OdorImagery/pipeline/results/fmri/nii/' sub '/scan1/' mask_folder '/' masks.name{1,maskn} '.nii']}; % just load one mask at a time
		[passed_data, misc, cfg] = decoding_load_data(cfg);


		% ODOR LOCALIZER: figure out the most odor-active voxels for each subject
		% First will need to contrast all odor > all odorless using betas from run 5 
		% Then we sort the data and keep the n most odor active voxels
		
		loc_data = [];
		t_odor = [];
		t_odorless = [];
		t_con = [];
		t_out = [];
		t_ind = [];
		t_active = [];

		chunk_ind = cell2mat(cfg.files.chunk);
		loc_data = passed_data.data(chunk_ind==loc,:);
		t_odor = (loc_data(1,:) + loc_data(2,:))/2; % 1 is smell rose, 2 is smell cookie
		t_odorless = loc_data(5,:); % 5 is smell odorless
		t_con = t_odor - t_odorless;
		[t_out,t_ind] = sort(t_con,'descend');
		t_active = t_ind(1,1:masks.vox{1,maskn}); % update the number of odor active voxels that we want to keep here		

		data_active = passed_data.data(chunk_ind~=loc,[t_active]);

		% Z-score the data by run (or mean subtract if preferred) FOR THE PATTERNS (do not include the localizer run anymore), keeping only the most odor active voxels
		for chunk = 1:4 % data active only has the four non-localizer runs now (run 2 is run 1, run 3 is run 2, etc.)
			data_av = [];
			data_meansub = [];
			data_sd = [];			
			chunk_ind = [1 1 1 1 2 2 2 2 3 3 3 3 4 4 4 4]';
			data_av = repmat(mean(mean(data_active(chunk_ind==chunk,:))),4,length(data_active));
			data_meansub = data_active(chunk_ind==chunk,:) - data_av; 
			data_sd = repmat(std(reshape(data_active(chunk_ind==chunk,:),[1,4*length(data_active)])),4,length(data_active));
			
			if scaletype == 'mean'
				data(chunk_ind==chunk,:) = data_meansub;
			elseif scaletype == 'z'
				data(chunk_ind==chunk,:) = data_meansub./data_sd;
			end % if scaletype

		end % for chunk

		% Average the data over even and odd runs (NEED TO UPDATE IF INCLUDING RUN 5 AGAIN)
		smell_rose_even = (data(1,:) + data(9,:))/2;
		smell_cookie_even = (data(2,:) + data(10,:))/2;
		imagine_rose_even = (data(3,:) + data(11,:))/2;
		imagine_cookie_even = (data(4,:) + data(12,:))/2;
		smell_rose_odd = (data(5,:) + data(13,:))/2;
		smell_cookie_odd = (data(6,:) + data(14,:))/2;
		imagine_rose_odd = (data(7,:) + data(15,:))/2;
		imagine_cookie_odd = (data(8,:) + data(16,:))/2;

		% Pattern sim for within pos	
		sub_corr_within_pos(1,1) = pattern_similarity(smell_rose_even, smell_rose_odd, method);
		sub_corr_within_pos(1,2) = pattern_similarity(smell_cookie_even, smell_cookie_odd, method);
		sub_corr_within_pos(1,3) = pattern_similarity(imagine_rose_even, imagine_rose_odd, method);
		sub_corr_within_pos(1,4) = pattern_similarity(imagine_cookie_even, imagine_cookie_odd, method);

		% Pattern sim for between pos
		sub_corr_between_pos(1,1) = pattern_similarity(smell_rose_even, imagine_rose_odd, method);
		sub_corr_between_pos(1,2) = pattern_similarity(smell_cookie_even, imagine_cookie_odd, method);
		sub_corr_between_pos(1,3) = pattern_similarity(imagine_rose_even, smell_rose_odd, method);
		sub_corr_between_pos(1,4) = pattern_similarity(imagine_cookie_even, smell_cookie_odd, method);

		% Pattern sim for within neg	
		sub_corr_within_neg(1,1) = pattern_similarity(smell_rose_even, smell_cookie_odd, method);
		sub_corr_within_neg(1,2) = pattern_similarity(smell_cookie_even, smell_rose_odd, method);
		sub_corr_within_neg(1,3) = pattern_similarity(imagine_rose_even, imagine_cookie_odd, method);
		sub_corr_within_neg(1,4) = pattern_similarity(imagine_cookie_even, imagine_rose_odd, method);

		% Pattern sim for between neg
		sub_corr_between_neg(1,1) = pattern_similarity(smell_rose_even, imagine_cookie_odd, method);
		sub_corr_between_neg(1,2) = pattern_similarity(smell_cookie_even, imagine_rose_odd, method);
		sub_corr_between_neg(1,3) = pattern_similarity(imagine_rose_even, smell_cookie_odd, method);
		sub_corr_between_neg(1,4) = pattern_similarity(imagine_cookie_even, smell_rose_odd, method);

		within_pos = [within_pos; sub_corr_within_pos];
		between_pos = [between_pos; sub_corr_between_pos];
		within_neg = [within_neg; sub_corr_within_neg];
		between_neg = [between_neg; sub_corr_between_neg];

		clearvars sub_corr_within_pos sub_corr_between_pos sub_corr_within_neg sub_corr_between_neg smell_rose_even smell_cookie_even imagine_rose_even imagine_cookie_even smell_rose_odd smell_cookie_odd imagine_rose_odd imagine_cookie_odd beta data 

	end % for subject

	results.masks{1,maskn} = masks.name{1,maskn};
	results.pos.within{1,maskn} = within_pos;
	results.pos.between{1,maskn} = between_pos;
	results.neg.within{1,maskn} = within_neg;
	results.neg.between{1,maskn} = between_neg;

	% calculate the difference of pos and neg conditions
	within_diff = within_pos - within_neg;
	between_diff = between_pos - between_neg;	
	results.diff.within{1,maskn} = within_diff;
	results.diff.between{1,maskn} = between_diff;

	% also create one with pos, neg, and diff all appended together (within on top, and between below)
	results.all{1,maskn} = [within_pos within_neg within_diff; between_pos between_neg between_diff];

end % for maskn

clearvars -except results






