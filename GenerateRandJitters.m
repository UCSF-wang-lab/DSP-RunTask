function jitters = GenerateRandJitters(ID,trials_per_block,jitter_range,block_order)
%%
% trials_per_seq: number, total trials per sequence
% jitter_range: array of 2 numbers, closed interval of the range of durations that will be
% randomly drawn from... in seconds
%
% jitters: array, set of jitters to use for each sequence, order in block
% order
%
% assumes same number of blocks for each sequence
% 
% randomly generates a n=trials_per_seq set of numbers from random uniform 
% distribution on closed interval jitter_range. drawing from same sample, 
% just reorders the numbers between the two sequences so that they use 
% the same set of jitters but in different orders
%
% preorganizes them into correct order of blocks

rng(1)

n_blocks = length(block_order);

tot_trials = n_blocks*trials_per_block;
trials_per_seq = tot_trials/2;

% draw numbers and scale and then shift
some_jitters = round((rand([1,trials_per_seq])*(jitter_range(2)-jitter_range(1)))+jitter_range(1),3);

% make another array for second sequence and add both to matrix
summoar_jitters = nan(2,trials_per_seq);
summoar_jitters(1,:) = some_jitters;
summoar_jitters(2,:) = some_jitters(randperm(trials_per_seq));

% save them for reference just in case
filename = [ID,'_Jitter_',datestr(now,'yy-mm-dd_HH-MM-SS')];
% fopen(filename,'w');
% writematrix(jitters,filename)

save(filename,'summoar_jitters')

% jitters = nan(1,tot_trials);
jitters = repelem(block_order,repelem(trials_per_block,n_blocks));

s1 = find(jitters==1);
s2 = find(jitters==2);
jitters(s1) = summoar_jitters(1,:);
jitters(s2) = summoar_jitters(2,:);

% for b = 1:trials_per_block:n_blocks*trials_per_block
%     jitters(b:b+trials_per_block-1) = 


end