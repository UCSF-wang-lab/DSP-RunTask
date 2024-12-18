function show_cue(src,event,main_window,cross_color,duration,adv_prog_state)
%%
% show_cross(...)
%
% Author: Kara & Ken
% Project: DSP
%
% Description:
%   Displays a red or green fixation cross for the patient at the start of
%   each block and trial. Additionally, a cross is shown during the
%   baseline phase and at the warm-up phase.
%
% Inputs:   src             [=] Timer object that called this function.
%           event           [=] Ignored.
%           cross_color     [=] Color of the cross that will be displayed
%           duration        [=] How long the cross is displayed for. Can be
%                               empty if no set duration.
%           adv_prog_state  [=] Boolean input. Is passed into the callback
%                               function of the internal cross timer. The
%                               cross timer only runs if a duration is
%                               given.
%
% Outputs:  NONE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
persistent cross_timer

% main_window = findobj('Tag','DSP_Task_main_window');

% % Draw cross according to color passed in
% annotation('textbox',[0,0,1,1],'String','+',...
%                 'FontName','Arial','FontSize',108,...
%                 'Color',cross_color,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
%             
% annotation('rectangle',[0,0.45,0.05625,0.1],'Color','k','FaceColor','k');
% 
% drawnow;

% adding second square universally
% another option for trying to get identical timing between the two
a1= annotation('textbox',[0,0,1,1],'String','+',...
                'FontName','Arial','FontSize',108,...
                'Color',cross_color,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle','visible','off');
            
a2= annotation('rectangle',[0,0.45,0.05625,0.1],'Color','k','FaceColor','k','visible','off');

% a3= annotation('rectangle',[0,0.72,0.10625,0.2],'Color','k','FaceColor','k','visible','off');

drawnow;

set([a1,a2],'visible','on')
% set([a1,a2,a3],'visible','on')

%Could you use Computer Vision Toolbox insertText() and insertShape() to draw into an array, then image() the array so that everything becomes visible at the same time?

cross_time = toc(main_window.UserData.clock);

% If optional duration variable is passed, only show the cross for that
% duration
if ~isempty(duration)
    cross_timer = timer('ExecutionMode','singleShot','StartDelay',duration,'TimerFcn',{@advance_program,adv_prog_state});
    start(cross_timer);
end

main_window.UserData.ready = 1;

% Write input of cross appearance if program state is "warm-up","baseline", 
% or "experiment"
switch main_window.UserData.program_states{main_window.UserData.curr_program_state}
    case 'warm-up'
        write_input(main_window,-9,cross_time);
    case 'tutorial'
        write_input(main_window,-9,cross_time);
    case 'baseline'
        write_input(main_window,-9,cross_time);
    case 'experiment'
        write_input(main_window,-9,cross_time);
end

% Stop timer that called @show_cue
stop(src);


end