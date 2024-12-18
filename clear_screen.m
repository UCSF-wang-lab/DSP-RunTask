function clear_screen(src,event)
%%
% clear_screen(...)
%
% Author: Kenneth Louie
% Project: DSP
%
% Description:
%   Helper function to clear the screen of the task. 
%
% Inputs:   src             [=] Ignored. Not used as a callback function
%           event           [=] Ignored. Not used as a callback function
%
% Outputs:  NONE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
main_window = findobj('Tag','DSP_Task_main_window');
delete(findall(main_window,'type','annotation'));
end