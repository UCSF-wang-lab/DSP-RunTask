function [seeds, allISIs] = GenerateExpJitters(trials_per_block,mu,jitter_range,block_order,n_exp, p_cutoff,starting_seed)
%%
% n_exp = number of experiments you want jitter sets for. you will get two
% sets of jitters per experiment
%
% trials_per_seq: number, total trials per sequence
% jitter_range: array of 2 numbers, closed interval of the range of durations that will be
% randomly drawn from... in seconds
%
% jitters: array, set of jitters to use for each sequence, order in block
% order
%
% starting_seed: which seed from to start so that not using same seeds
% across generation runs. should be +1 from the last seed in the seed list
% used for the previous generation run
%
%
% assumes same number of blocks for each sequence
% 
% randomly generates a n=trials_per_seq set of numbers from exponential
% distribution on closed interval jitter_range. each sequence gets its
% own set of ISIs. Each set of ISIs is found to exponential with a
% lillietest resulting in a p value greater than p_cutoff. then it is
% shifted to the minimum of jitter_range
% 
% ISIs are rounded to the nearest ms
%
% preorganizes them into correct order of blocks
% 
% saves for later loading
%
%
% did testing with range [0.5,2.5] and p < 0.3

n_seeds = 2*n_exp;

n_blocks = length(block_order);

tot_trials = n_blocks*trials_per_block;
trials_per_seq = tot_trials/2;

[seeds, allISIs] = SampleExpJitters(n_seeds, trials_per_seq, p_cutoff, mu, jitter_range,starting_seed);

% save the list of seed numbers
filename_seeds = join(['SeedList','_Range',string(min(jitter_range)),'to',string(max(jitter_range)),'_TrialsPerBlock',string(trials_per_block),'_BlockOrder',string(block_order),'_pCutoff',string(p_cutoff),'_Exp'],'');
filename_seeds = erase(filename_seeds,'.');
save(filename_seeds,'seeds');
 
for s = 1:2:n_seeds
    summoar_jitters = nan(2,trials_per_seq);
    summoar_jitters(1,:) = allISIs(s,:);
    summoar_jitters(2,:) = allISIs(s+1,:);
    
    % put them in one long array that is appropriately ordered
    jitters_formatted = repelem(block_order,repelem(trials_per_block,n_blocks));
    
    s1 = find(jitters_formatted==1);
    s2 = find(jitters_formatted==2);
    jitters_formatted(s1) = summoar_jitters(1,:);
    jitters_formatted(s2) = summoar_jitters(2,:);
    
    % save them
    filename = join(['Seeds',string(s),'and',string(s+1),'_mu',string(mu),'_Range',string(min(jitter_range)),'to',string(max(jitter_range)),'_TrialsPerBlock',string(trials_per_block),'_BlockOrder',string(block_order),'_pCutoff',string(p_cutoff),'_Exp'],'');
    filename = erase(filename,'.');
    % fopen(filename,'w');
    % writematrix(jitters,filename)
    save(filename,'summoar_jitters','jitters_formatted');
    
end

% for s = 1:n_seeds
%     some_jitters = allISIs(s,:);
% 
%     % make another array for second sequence and add both to matrix
%     summoar_jitters = nan(2,trials_per_seq);
%     summoar_jitters(1,:) = some_jitters;
%     summoar_jitters(2,:) = some_jitters(randperm(trials_per_seq));
% 
%     % put them in one long array that is appropriately ordered
%     jitters_formatted = repelem(block_order,repelem(trials_per_block,n_blocks));
% 
%     s1 = find(jitters_formatted==1);
%     s2 = find(jitters_formatted==2);
%     jitters_formatted(s1) = summoar_jitters(1,:);
%     jitters_formatted(s2) = summoar_jitters(2,:);
% 
%     % save them
%     filename = join(['Seed',string(s),'_Range',string(min(jitter_range)),'to',string(max(jitter_range)),'_TrialsPerBlock',string(trials_per_block),'_BlockOrder',string(block_order),'_pCutoff',string(p_cutoff),'_Exp'],'');
%     filename = erase(filename,'.');
%     % fopen(filename,'w');
%     % writematrix(jitters,filename)
%     save(filename,'summoar_jitters','jitters_formatted');
% end

end