function config_settings = load_config()
%%
% load_config(...)
%
% Author: Kara & Ken
% Project: DSP
%
% Description:
%   Reads in a configuration text file that will set various paramters of
%   the task.
%
% Inputs:   NONE
%
% Outputs:  NONE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Default settings
config_settings.subid = [];
config_settings.save_path = [];
config_settings.n_blocks = [];
config_settings.block_seq = [];
config_settings.n_key_seq = [];
config_settings.key_seq = [];
config_settings.trials_per_block = [];
config_settings.trial_type = [];
config_settings.baseline_dur = [];
config_settings.warm_up_dur = [];
config_settings.break_time_dur = [];
config_settings.jitter_set = [];
config_settings.device_type = [];

% Try to open config file
try
    fid = fopen('test_config.txt');
catch
    error('File cannot be opened.');
end

% Read content of config file
val = fgetl(fid);
while val ~= -1
    if contains(val,'ID')
        config_settings.subid = readString(val);
    elseif contains(val,'save_path')
        config_settings.save_path = readString(val);
    elseif contains(val,'n_blocks')
        config_settings.n_blocks = getVal(val);
    elseif contains(val,'n_key_seq')
        config_settings.n_key_seq = getVal(val);
    elseif contains(val,'block_seq')
        value = getVal(val);
        if isempty(value)
            value = genBlockSeq(config_settings.n_blocks,config_settings.n_key_seq);
        end
        config_settings.block_seq = value;
    elseif contains(val,'key_seq')
        config_settings.key_seq = getVal(val);
    elseif contains(val,'trials_per_block')
        config_settings.trials_per_block = getVal(val);
    elseif contains(val,'trial_type')
        config_settings.trial_type = readString(val);
    elseif contains(val,'baseline_dur')
        config_settings.baseline_dur = getVal(val);
    elseif contains(val,'warm_up_dur')
        config_settings.warm_up_dur = getVal(val);
    elseif contains(val,'break_time_dur')
        config_settings.break_time_dur = getVal(val);
    elseif contains(val,'jitters')
        config_settings.jitter_set = readString(val);
        config_settings.jitter_set = load(config_settings.jitter_set);
        config_settings.jitter_set = config_settings.jitter_set.jitters_formatted;
%         config_settings.jitter_set = load(config_settings.jitter_set)
%     elseif contains(val, 'device')
%         config_settings.device_type = readString(val);
%         if isempty(config_settings.device_type)
%             config_settings.device_type = "aergdfv";
%         end
%         while config_settings.device_type ~= "numpad_SRTT" && config_settings.device_type ~= "teensy"
%             warning("the device type was not indicated or incorrect. type lower case without spaces.")
%             config_settings.device_type = input("What is the keypad type? Type teensy or numpad_SRTT.",'s');
%         end
    end
    val = fgetl(fid);
end

fclose(fid);
end

function name = readString(val)
if contains(val,'"')
    loc = strfind(val,'"');
    name = val(loc(1)+1:loc(2)-1);
else
    name = [];
end
end

function value = getVal(val)
if contains(val,'=')
    loc = strfind(val,'=');
    value = str2num(val(loc+2:end));
else
    value = [];
end
end

function block_seq = genBlockSeq(n_blocks,n_key_seq)
block_seq = nan(1,n_blocks);
blocks_per_key_seq = n_blocks/n_key_seq;

finished = false;
while ~finished
    % Set initial blocks so that there is no duplicates initially
    block_seq(1:n_key_seq) = randsample(n_key_seq,n_key_seq);
    
    % Fill in the rest withint 5000 iterations
    loop_count = 1;
    count = n_key_seq + 1;
    tot_key_seq_selections = ones(1,n_key_seq);
    while sum(tot_key_seq_selections) < n_blocks && loop_count < 5000
        curr_selection = randi(n_key_seq);
        if tot_key_seq_selections(curr_selection) < blocks_per_key_seq
            if (sum(block_seq(count-2:count-1)) + curr_selection) ~= curr_selection*3
                block_seq(count) = curr_selection;
                tot_key_seq_selections(curr_selection) = tot_key_seq_selections(curr_selection) + 1;
                count = count + 1;
            end
        end
    end
    
    if sum(tot_key_seq_selections) == n_blocks
        finished = true;
    end
    
end

end