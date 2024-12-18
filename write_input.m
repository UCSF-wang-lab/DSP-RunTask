function write_input(main_window,input_key,input_time)
%%
% write_input(...)
%
% Author: Kara & Ken
% Project: DSP
%
% Description:
%   Helper function to write events and key presses to a binary data file
%   that is used as an auto save feature. In some cases garbage is placed
%   in some columns because it is an event marker.
%
% Inputs:   main_window     [=] Object handle for the figure window used
%                               for the task.
%           input_key       [=] Key that was pressed
%           input_time      [=] The time since the program started that the
%                               input_key was pressed.
%
% Outputs:  NONE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch main_window.UserData.program_states{main_window.UserData.curr_program_state}
    case 'warm-up'
        curr_trial = main_window.UserData.curr_trial;
        fwrite(main_window.UserData.auto_save_file,[input_key;input_time;-3;curr_trial;-9],'double');      
    case 'tutorial'
        curr_trial = main_window.UserData.curr_trial;
        fwrite(main_window.UserData.auto_save_file,[input_key;input_time;-2;curr_trial;-9],'double');     
    case 'baseline'
        fwrite(main_window.UserData.auto_save_file,[input_key;input_time;-1;-9;-9],'double');
    case 'experiment'
        curr_block = main_window.UserData.curr_block_num;
        
        if curr_block == 0
            fwrite(main_window.UserData.auto_save_file,[input_key;input_time;0;-9;-9],'double');
        else
            curr_seq = main_window.UserData.block_seq(curr_block);
            curr_trial = main_window.UserData.curr_trial;
            fwrite(main_window.UserData.auto_save_file,[input_key;input_time;curr_block;curr_trial;curr_seq],'double');
        end
end
end