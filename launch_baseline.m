function launch_baseline(main_window)
%%
% launch_baseline(...)
%
% Author: Kara & Ken
% Project: DSP
%
% Description:
%   Displays instructions to the patient and then begins a baseline
%   measurement segment of the task.
%
% Inputs:   main_window     [=] Object handle for the figure window used
%                               for the task.
%
% Outputs:  NONE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
persistent nCalls
if isempty(nCalls)
    nCalls = 1;
end

if strcmp(main_window.UserData.program_states(main_window.UserData.curr_program_state),'baseline') && nCalls <= 5
    switch nCalls
        case 1
            % First message
            dim1 = [0.1250,0.55,0.75,0.1];
            str1 = 'Baseline';
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            % Increment counter
            main_window.UserData.instruct = 1;
            nCalls = nCalls + 1;
            
        case 2
            
            dim1 = [0.1250,0.55,0.75,0.1];
            str1 = {'On the next screen, a cross will appear.';...
                'Focus your eyes on the cross while resting your fingers on the keypad'};
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
%             dim2 = [0.1250,0.45,0.75,0.1];
%             str2 = {'Please try to stay visually focused on the cross without moving your hands or body until the cross disappears.'};
%             annotation('textbox',dim2,'String',str2,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
%             
%             dim3 = [0.1250,0.25,0.75,0.1];
%             str3 = {'It is okay if you get distracted. Just refocus your eyes on the cross.';...
%                 '';...
%                 'This will last for 90 seconds.'};
%             annotation('textbox',dim3,'String',str3,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
            
            % Increment counter
            main_window.UserData.instruct = 1;
            nCalls = nCalls + 1;
        case 3
            % Increment counter
            main_window.UserData.instruct = 0;
            nCalls = nCalls + 1;
            
            % Start timer before green cross is shown
            start_timer_for_trial(main_window,2,[0.3098, 0.5020, 0.3098],main_window.UserData.baseline_dur,0);
            return;
        case 4
            % Pause before showing next screen
            pause(2);
            
             % First message
            dim1 = [0.1250,0.65,0.75,0.1];
            str1 = 'You did an excellent job!!';
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            dim2 = [0.1250,0.45,0.75,0.1];
            str2 = 'Please take some time to rest before continuing.';
            annotation('textbox',dim2,'String',str2,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            % Increment counter
            main_window.UserData.instruct = 1;
            nCalls = nCalls + 1;
        case 5
            % First message
            dim1 = [0.1250,0.55,0.75,0.1];
            str1 = 'Training';
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
%             
%             % First message
%             dim1 = [0.1250,0.60,0.75,0.1];
%             str1 = 'All that is left now is the training for the two sequences.';
%             annotation('textbox',dim1,'String',str1,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
%             
%             dim2 = [0.1250,0.45,0.75,0.1];
%             str2 = strcat("There are ",string(main_window.UserData.tot_blocks),' short training blocks.');
%             annotation('textbox',dim2,'String',str2,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
%             
%             dim3 = [0.1250,0.20,0.75,0.1];
%             str3 = 'You will have a break at the end of every block.'; % Feel free to rest your eyes and fingers during the breaks, but be ready before the next block begins.';
%             annotation('textbox',dim3,'String',str3,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
            
%             dim4 = [0.1250,0.20,0.75,0.1];
%             str4 = 'I will occasionally update you on how many blocks you have completed.';
%             annotation('textbox',dim4,'String',str4,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
            
            % Advance state of experiment 
            main_window.UserData.curr_program_state = main_window.UserData.curr_program_state + 1;
            
            % Increment counter
            main_window.UserData.instruct = 1;
            nCalls = nCalls + 1;
    end
    
%     % Message at the bottom to advance
%     if nCalls == 3
%         str = 'Press "1" to continue.';
%     else
%         str = 'Press "1" to continue.';
%     end
%     dim = [0.25,0.05,0.5,0.05];
%     annotation('textbox',dim,'String',str,...
%         'FontName','Arial','FontSize',28,...
%         'EdgeColor','none',...
%         'HorizontalAlignment','center','VerticalAlignment','middle');
    
    main_window.UserData.ready = 1;
end

end