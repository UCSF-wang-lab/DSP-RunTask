function advance_program(src,event,adv_prog_state)
%%
% advance_program(...)
%
% Author: Kara & Ken
% Project: DSP
%
% Description:
%   Helper function to advance the SRTT task program to the next window
%   and/or the next program state if the option is passed through.
%
% Inputs:   src             [=] If was called from a timer object, src is 
%                               the timer object. Otherwise, it is an empty
%                               vector.
%           event           [=] Second input that exist as a requirement to
%                               be a callback function. This input is 
%                               ignored.
%           adv_prog_state  [=] Boolean input. If 0/false, this function
%                               does not increment the program state
%                               variable.
%
% Outputs:  NONE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

main_window = findobj('Tag','DSP_Task_main_window');

% Stop cross timer and stop accepting key presses
if isa(src,'timer')
    main_window.UserData.ready = 0;
    clear_screen();
    stop(src);
end

% Check if program state should be advanced
if adv_prog_state
    main_window.UserData.curr_program_state = main_window.UserData.curr_program_state + 1;
end

state = main_window.UserData.program_states{main_window.UserData.curr_program_state};
main_window.UserData.ready = 1;

% launch whatever current state
switch state
    case 'launch'
        launch_screen(main_window);
    case 'warm-up'
        launch_warm_up(main_window);
    case 'tutorial'
        launch_tutorial(main_window);
    case 'baseline'
        launch_baseline(main_window);
    case 'experiment'
        launch_exp(main_window);
    case 'end'
        end_screen(main_window);
end


end