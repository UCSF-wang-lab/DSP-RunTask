function [seeds, all_ISIs] = SampleExpJitters(n_seeds, n_ISIs, p_cutoff, mu, jitter_range, starting_seed)

% ISIs are rounded to the nearest ms before testing

all_ISIs = nan(n_seeds,n_ISIs);
seeds = nan(1,n_seeds);
s = 1;
j = starting_seed;

while s <= n_seeds
    p = 0 ;
    
    while p < p_cutoff
        rng(j);

        ISIs = nan(1,n_ISIs); 

        % draw and then shift later after testing
        i = 1;
        while i <= n_ISIs
            new = exprnd(mu);
            if new <= (max(jitter_range)-min(jitter_range))
                ISIs(i) = new;
                i = i+1;
            end
        end
        

        ISIs = round(ISIs,3);
        [h,p]=lillietest(ISIs,'Distribution','exponential');
        % with shifting back, I can get a p >0.3 at random seed 560
        % without shifting back, i ran it for a while to no avail


        % % draw and exclude numbers until all are within range
        % i = 1;
        % while i <= trials_per_seq
        %     new = exprnd(mu);
        %     if new >= min(jitter_range) && new <= max(jitter_range)
        %         some_jitters(i) = new;
        %         i = i+1;
        %     end
        % end
        % % some_jitters = some_jitters-min(jitter_range);
        % [h,p]=lillietest(some_jitters,'Distribution','exponential');
        % % with shifting back, I can get a p >0.3 at random seed 205
        % % without shifting back, i ran it for a while to no avail


        % % try shifting every draw instead and then just redrawing ones over max
        % i = 1;
        % while i <= trials_per_seq
        %     new = exprnd(mu)+min(jitter_range);
        %     if new <= max(jitter_range)
        %         some_jitters(i) = new;
        %         i = i+1;
        %     end
        % end
        % % some_jitters = some_jitters-min(jitter_range);
        % [h,p]=lillietest(some_jitters,'Distribution','exponential');
        % % still fails with or without shifting
        % % with shifting back, can get p>0.3 on rng seed 560
        % % without shifting back, I let it run for a few min to no avail

        j = j+1;
    end

    % shift to desired min ISI
    ISIs = ISIs+min(jitter_range);
    all_ISIs(s,:) = ISIs;

    % save and advance the seed number
    seeds(s) = j;
    s = s+1;

end

end