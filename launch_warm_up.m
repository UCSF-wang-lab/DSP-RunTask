function launch_warm_up(main_window)
%%
% launch_warm_up(...)
%
% Author: Kara & Ken
% Project: DSP
%
% Description:
%   Displays information about the warm-up portion of the task.
%
% Inputs:   main_window     [=] Object handle for the figure window used
%                               for the task.
%
% Outputs:  NONE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Variable to know how many times this is called. Can only be called three
% times before it does nothing.
persistent nCalls
if isempty(nCalls)
    nCalls = 1;
end

if strcmp(main_window.UserData.program_states(main_window.UserData.curr_program_state),'warm-up') && nCalls <= 11
    switch nCalls
        case 1
            dim1 = [0.125,0.55,0.75,0.1];
            str1 = 'Warmup';
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
%             dim1 = [0.125,0.65,0.75,0.1];
%             str1 = 'Time for the finger typing warmup';
%             annotation('textbox',dim1,'String',str1,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
% %             
%             dim2 = [0.125,0.45,0.75,0.1];
%             str2 = 'The keypad keys are labeled 1, 2, 3, 4, 5';
%             annotation('textbox',dim2,'String',str2,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
%             
%             dim3 = [0.125,0.25,0.75,0.1];
%             str3 = 'Please rest all fingers of your dominant hand on these keypad keys';
%             annotation('textbox',dim3,'String',str3,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
            
            
            
            main_window.UserData.instruct = 1;
            nCalls = nCalls + 1;
        case 2
            dim1 = [0.125,0.65,0.75,0.1];
            str1 = {'On the next screen, a green cross will appear.';...
                '';...
                'Once the green cross appears, press "1" as fast as you can, 20 times in a row.';...
                '';...
                'The green cross will vanish once you reach 20.'};
                
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
%             
%             dim2 = [0.125,0.45,0.75,0.1];
%             str2 = {'Once the green cross appears, press "1" as fast as you can, 20 times in a row.';...
%             'The green cross will vanish once you reach 20.'};
%             annotation('textbox',dim2,'String',str2,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
            
            dim3 = [0.125,0.25,0.75,0.1];
            str3 = '1';
            annotation('textbox',dim3,'String',str3,...
                'FontName','Arial','FontSize',80,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            main_window.UserData.instruct = 1;
             % track which element it is supposed to be when writing input
             % also using this var to only let them go on if all 20 reps
             % were with correct digit
             main_window.UserData.curr_trial = 1;
             
             
            nCalls = nCalls + 1;
            
        case {3,5,7,9,11}
            % prevent typing prior to cross from having effect
            main_window.UserData.ready = 0;
            
             % Reset trial key press counter
             main_window.UserData.warmup_n_elem_hits = 0;
             
             % Start timer to show initial cross
             start_timer_for_trial(main_window,1.5,'g',[],0);
             
             % Increment counter & and adjust instructions boolean
             main_window.UserData.instruct = 0;
            nCalls = nCalls + 1;
            
            return
            
            % should i put a return here? after an if case == 12 statement?
            
        case 4   % instructions for #2 warmup
            dim1 = [0.125,0.55,0.75,0.1];
            str1 = 'Repeat for key "2"';
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            dim3 = [0.125,0.35,0.75,0.1];
            str3 = '2';
            annotation('textbox',dim3,'String',str3,...
                'FontName','Arial','FontSize',80,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            pause(1.25)
             
             % Increment counter & adjust instructions boolean
             main_window.UserData.instruct = 1;
            nCalls = nCalls + 1;
            
             % track which element it is supposed to be when writing input
             main_window.UserData.curr_trial = 2;
            
        case 6   % instructions for #3 warmup
            dim1 = [0.125,0.55,0.75,0.1];
            str1 = 'Repeat for key "3"';
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            dim3 = [0.125,0.35,0.75,0.1];
            str3 = '3';
            annotation('textbox',dim3,'String',str3,...
                'FontName','Arial','FontSize',80,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
             
             % Increment counter & adjust instructions boolean
             main_window.UserData.instruct = 1;
            nCalls = nCalls + 1;
            
             % track which element it is supposed to be when writing input
             main_window.UserData.curr_trial = 3;
            
        case 8   % instructions for #4 warmup
            dim1 = [0.125,0.55,0.75,0.1];
            str1 = 'Repeat for key "4"';
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
%             
            dim3 = [0.125,0.35,0.75,0.1];
            str3 = '4';
            annotation('textbox',dim3,'String',str3,...
                'FontName','Arial','FontSize',80,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
             
             % Increment counter & adjust instructions boolean
             main_window.UserData.instruct = 1;
            nCalls = nCalls + 1;
            
             % track which element it is supposed to be when writing input
             main_window.UserData.curr_trial = 4;
            
        case 10 % instructions for #5 warmup
            dim1 = [0.125,0.55,0.75,0.1];
            str1 = 'Repeat for key "5"';
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
%             
            dim3 = [0.125,0.35,0.75,0.1];
            str3 = '5';
            annotation('textbox',dim3,'String',str3,...
                'FontName','Arial','FontSize',80,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
             
             % Increment counter & adjust instructions boolean
             main_window.UserData.instruct = 1;
            nCalls = nCalls + 1;
            
             % track which element it is supposed to be when writing input
             main_window.UserData.curr_trial = 5;
    end
    
%     % Only display when not training sequences
%     if nCalls ~= 4 && nCalls ~= 6 && nCalls ~= 8 && nCalls ~= 10 && nCalls ~= 12
%         % Message at the bottom to advance
%         dim = [0.25,0.05,0.5,0.05];
%         str = 'Press "1" to continue.';
%         annotation('textbox',dim,'String',str,...
%             'FontName','Arial','FontSize',28,...
%             'EdgeColor','none',...
%             'HorizontalAlignment','center','VerticalAlignment','middle');
%     end
    
    main_window.UserData.ready = 1;
elseif strcmp(main_window.UserData.program_states(main_window.UserData.curr_program_state),'warm-up') && nCalls > 11
    main_window.UserData.curr_program_state = main_window.UserData.curr_program_state + 1;
    launch_tutorial(main_window);
end
end