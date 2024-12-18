function DSP_Task()
%% Header
% Authors:   Kara & Ken
%
% Description:
%   Main file to run the DSP task. Reads in configuration settings and
%   changes the behavior of the program appropriately. 
%
% Inputs:   None
% Output:   None

% clc; 
clear all;
delete(timerfindall)

%% Set processor priority
if ispc
    % "High"
    [~,~] = dos('wmic process where name="matlab.exe" CALL setpriority 128');
else
end

%% Load config file
config_settings = load_config();

%% Initialize GUI
% Create fullscreen figure
main_window = figure('Visible','on','units','normalized','outerposition',[0,0,1,1],...
    'MenuBar','none',...
    'DockControls','off',...
    'NumberTitle','off',...
    'Name','DSP',...
    'color','w',...
    'WindowState','fullscreen',...
    'UserData',struct(),...
    'Tag','DSP_Task_main_window');

% hide cursor
set(main_window, 'Pointer', 'custom', 'PointerShapeCData', NaN(16,16))

% Set keypress callback function
set(main_window,'KeyPressFcn',@DSP_Task_keypress);

% Include Map in case numpad is used
keySet = {'numpad7','numpad9','numpad6','numpad3','decimal'};
valueSet = {'1','2','3','4','5'};
main_window.UserData.numpadMap = containers.Map(keySet,valueSet);

% if config_settings.device_type == "numpad_SRTT"
%     set(main_window,'KeyPressFcn',@DSP_Task_keypress_numpad);
%     keySet = {'numpad7','numpad9','numpad6','numpad3','decimal'};
%     valueSet = {'1','2','3','4','5'};
%     main_window.UserData.numpadMap = containers.Map(keySet,valueSet);
%     disp("numpad_SRTT set as device")
% elseif config_settings.device_type == "teensy"
%     set(main_window,'KeyPressFcn',@DSP_Task_keypress);
%     disp("teensy set as device")
% end

% Create empty table to hold experiment data
exp_data = nan(config_settings.n_blocks*config_settings.trials_per_block*2,5);

% Create struct of user data. This is so we can pass around data between
% the GUI.
main_window.UserData.subid = config_settings.subid;
main_window.UserData.save_path = config_settings.save_path;
main_window.UserData.program_states = {'launch','warm-up','tutorial','baseline','experiment','end'};
main_window.UserData.curr_program_state = 1;
main_window.UserData.block_seq = config_settings.block_seq;
main_window.UserData.tot_blocks = config_settings.n_blocks;
main_window.UserData.curr_block_num = 0;
main_window.UserData.trials_per_block = config_settings.trials_per_block;
main_window.UserData.trial_type = config_settings.trial_type;
main_window.UserData.curr_trial = 1;
main_window.UserData.key_seq = config_settings.key_seq;
main_window.UserData.seq_length = size(config_settings.key_seq,1);
main_window.UserData.baseline_dur = config_settings.baseline_dur;
main_window.UserData.warm_up_dur = config_settings.warm_up_dur;
main_window.UserData.break_time_dur = config_settings.break_time_dur;
main_window.UserData.exp_data = exp_data;
main_window.UserData.clock = tic;
main_window.UserData.ready = 0;
main_window.UserData.timer = timer('ExecutionMode','singleShot','StartDelay',2,'TimerFcn',@play_sound);    % not sure i need the qualifiers here. can probably just do xxx = timer ?
main_window.UserData.auto_save_file = [];
main_window.UserData.training_hits = ones(1,500);
main_window.UserData.training_n_key_press = 1;
main_window.UserData.curr_training_seq = 1;
main_window.UserData.trial_n_key_press = 0;

main_window.UserData.warmup_hits = ones(1,500);
main_window.UserData.warmup_n_key_press = 1;
main_window.UserData.warmup_n_elem_hits = 0;
main_window.UserData.warmup_n_correct_hits = 0;

main_window.UserData.verif_hits = ones(1,500);
main_window.UserData.verif_n_key_press = 1;

main_window.UserData.instruct = 1;
main_window.UserData.block_ver = 0;

% main_window.UserData.trials_per_seq = (main_window.UserData.trials_per_block*main_window.UserData.tot_blocks)/2;
% jitter_range = [1,2];
% main_window.UserData.jitter_set = LoadExpJitters(main_window.UserData.subid,main_window.UserData.trials_per_block,jitter_range,main_window.UserData.block_seq);
main_window.UserData.jitter_set = config_settings.jitter_set;


main_window.UserData.global_trial = 0; % which trial wrt all training
% depending on what we end up doing, may or may not want to include jitter
% range or other stuff in config file

main_window.UserData.stimsweep_confirm = 0;
main_window.UserData.inbreak = 0;
main_window.UserData.loading = 0;

%% Start program
launch_screen(main_window);
end
