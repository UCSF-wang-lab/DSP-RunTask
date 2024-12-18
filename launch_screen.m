function launch_screen(main_window)
%%
% launch_exp(...)
%
% Author: Kara & Ken
% Project: DSP
%
% Description:
%   Displays basic instructions and introduces the task to the patient.
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

if strcmp(main_window.UserData.program_states(main_window.UserData.curr_program_state),'launch') && nCalls <= 3
    switch nCalls
        case 1
            % Welcome message
            dim1 = [0.125,0.55,0.75,0.1];
            str1 = 'Motor Learning Experiment';
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
%             dim1 = [0.125,0.65,0.75,0.1];
%             str1 = 'Hello! Thank you for participating in our experiment.';
%             annotation('textbox',dim1,'String',str1,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
%             
%             dim2 = [0.125,0.45,0.75,0.1];
%             str2 = 'This experiment studies motor learning using a typing task.';
%             annotation('textbox',dim2,'String',str2,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
%             
%             dim3 = [0.125,0.25,0.75,0.1];
%             str3 = {'The two goals are 1) to learn to type two different short sequences';...
%             'as fast and accurately as possible and 2) to have a fast reaction time.'};
%             annotation('textbox',dim3,'String',str3,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
            
            main_window.UserData.instruct = 1;
            nCalls = nCalls + 1;
            
%             % Advance state of experiment 
%             main_window.UserData.curr_program_state = main_window.UserData.curr_program_state + 1;
            
            % Create auto save file
            fid = fopen([main_window.UserData.subid,'_DSP_',datestr(now,'yy-mm-dd_HH-MM-SS'),'.asd'],'w');
            main_window.UserData.auto_save_file = fid;
%         case 2
%             % rundown on experiment
%             dim1 = [0.125,0.65,0.75,0.1];
%             str1 = {'After we do a quick finger warmup, there are 3 steps to the experiment'};
%             annotation('textbox',dim1,'String',str1,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','left','VerticalAlignment','middle');
%             
%             dim2 = [0.125,0.5,0.75,0.1];
%             str2 = {'1) Memorize the two sequences';...
%                 '2) Record a 90-second baseline period';...
%                 '3) Practice the two sequences'};
%             annotation('textbox',dim2,'String',str2,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','left','VerticalAlignment','middle');
% 
%             dim3 = [0.125,0.35,0.75,0.1];
%             str3 = {'We will review instructions at each step.'};
%             annotation('textbox',dim3,'String',str3,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
%             
%             
%             
%             
%             main_window.UserData.instruct = 1;
%             nCalls = nCalls + 1;
%             

        case 2   % loading for stim sweep
            
            %  if stim sweep not confirmed, show a loading screen
            % leave it at a loading screen until get the stim sweep confirm
%             if main_window.UserData.stimsweep_confirm == 0
                main_window.UserData.inbreak = 1;
                main_window.UserData.loading = 1;

%                 clear_screen();
                str1 = 'LOADING ...';
                dim1 = [0.125,0.70,0.75,0.1];
                annotation('textbox',dim1,'String',str1,...
                    'FontName','Arial','FontSize',36,...
                    'EdgeColor','none',...
                    'HorizontalAlignment','center','VerticalAlignment','middle');

            %     while main_window.UserData.stimsweep_confirm == 0
            %     end

%             end
            nCalls = nCalls + 1;
            
            
            
%         case 3
            % Advance state of experiment 
%             main_window.UserData.curr_program_state = main_window.UserData.curr_program_state + 1;
            
    end
    
    
%     % Message at the bottom to advance
%     dim = [0.25,0.05,0.5,0.05];
%     str = 'Press "1" on the keypad to continue.';
%     annotation('textbox',dim,'String',str,...
%         'FontName','Arial','FontSize',28,...
%         'EdgeColor','none',...
%         'HorizontalAlignment','center','VerticalAlignment','middle');
    
    main_window.UserData.ready = 1;
end
end