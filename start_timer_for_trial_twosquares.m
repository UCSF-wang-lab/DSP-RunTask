function start_timer_for_trial(src,delay_time,cross_color,trial_duration,adv_prog_state_after)
%%
% start_timer_for_trial(...)
%
% Author: Kara & Ken
% Project: DSP
%
% Description:
%   Displays instruction for the main task and then launches the main task.
%
% Inputs:   src                     [=] Should be the main window figure
%                                       handle. Otherwise an error will
%                                       occur.
%           delay_time              [=] How long to wait until the start of
%                                       the trial.
%           cross_color             [=] What color the cross should be when
%                                       the start delay is over.
%           trial_duration          [=] How long the cross should appear
%                                       for at the end of this timer.
%           adv_prog_state_after    [=] Boolean input. 0/false or 1/true if
%                                       the program should advance it's
%                                       state once the trial duration is
%                                       over. This value is just passed
%                                       into the timer callback function
%
% Outputs:  NONE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


src.UserData.timer.StartDelay = delay_time;
src.UserData.timer.TimerFcn = {@show_cue,src,cross_color,trial_duration,adv_prog_state_after};    % can I adjust this to account for queue lag when doing jitter?
start(src.UserData.timer);

end