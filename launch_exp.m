function launch_exp(main_window)
%%
% launch_exp(...)
%
% Author: Kara & Ken
% Project: DSP
%
% Description:
%   Displays instruction for the main task and then launches the main task.
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

if strcmp(main_window.UserData.program_states(main_window.UserData.curr_program_state),'experiment') && nCalls <= 4
    switch nCalls
        case 1
            dim1 = [0.1250,0.65,0.75,0.1];
            str1 = {'In each training block, the computer will show you one of the two sequences you just memorized.';...
            '';...
            'Then you will practice that sequence from memory.'};
%             you will verify one of the sequences like you did a few minutes ago. Then you practice it from memory.';
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            dim2 = [0.1250,0.45,0.75,0.1];
            if strcmp(main_window.UserData.trial_type,'discrete')
                str2 = 'During practice, type the sequence once each time the green cross appears.';
            else
                str2 = 'After you verify the sequence, the green cross will appear. As soon as the green cross appears, start typing the sequence repeatedly.'; 
            end
            
            annotation('textbox',dim2,'String',str2,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
%             dim3 = [0.1250,0.25,0.75,0.1];
%             str3 = 'Stop typing once the cross disappears, even if you did not complete the sequence';
%             annotation('textbox',dim3,'String',str3,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
            
%             dim4 = [0.1250,0.20,0.75,0.1];
%             str4 = 'If you make a mistake, it is okay. Just skip the number you missed and continue typing the rest of the sequence.';
%             annotation('textbox',dim4,'String',str4,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
            
            
            
            
%             dim1 = [0.1250,0.80,0.75,0.1];
%             str1 = 'At the start of each block, I will briefly show you which sequence to type during that block. Make sure to remember it, because the sequence will disappear after a couple of seconds. Then you will be asked to verify the sequence for that upcoming block';
%             annotation('textbox',dim1,'String',str1,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
%             
%             dim2 = [0.1250,0.60,0.75,0.1];
%             if strcmp(main_window.UserData.trial_type,'discrete')
%                 str2 = 'After you verify the sequence, the green cross will appear. As soon as the green cross appears, type the sequence one single time';
%             else
%                 str2 = 'After you verify the sequence, the green cross will appear. As soon as the green cross appears, start typing the sequence repeatedly.'; 
%             end
%             
%             annotation('textbox',dim2,'String',str2,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
%             
%             dim3 = [0.1250,0.40,0.75,0.1];
%             str3 = 'Do this every time the green cross appears during the block, and stop typing once the cross has disappeared, even if you did not complete the sequence';
%             annotation('textbox',dim3,'String',str3,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
%             
%             dim1 = [0.1250,0.20,0.75,0.1];
%             str1 = 'If you make a mistake, it is okay. Just skip the number you missed and continue typing the rest of the sequence.';
%             annotation('textbox',dim1,'String',str1,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
            
            
            % Increment counter
            main_window.UserData.instruct = 1;
            nCalls = nCalls + 1;
        case 2
            dim1 = [0.1250,0.55,0.75,0.1];
            str1 = {'Goals:';...
            '';...    
            '1) Learn to type the two sequences as fast and accurately as you can';...
                '';...
                '2) Develop a fast reaction time to the green cross'};...
%                 '';...
%                 '';...
%                 '';...
%                 'Please try to keep your hand on the keypad and your eyes focused on the green cross while typing.'};
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');                            
            
%             dim4 = [0.1250,0.25,0.75,0.1];
%             str4 = 'Please place your hand on the keypad.';
%             annotation('textbox',dim4,'String',str4,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
            
            % Increment counter
            main_window.UserData.instruct = 1;
            nCalls = nCalls + 1;
        case 3
            dim1 = [0.1250,0.55,0.75,0.1];
            str1 = 'Sequence Training Begins Now';
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            % Increment counter
            main_window.UserData.instruct = 0;
            nCalls = nCalls + 1;
            
            % pause on screen for 3 seconds
            pause(3);
            
            % start experiment
            run_block(main_window);
        case 4   % just for if skipping to end_screen during troubleshooting
            % Advance state of experiment 
            main_window.UserData.curr_program_state = main_window.UserData.curr_program_state + 1;
            nCalls = nCalls + 1;
            
            end_screen(main_window);

    end
    
%     % Message at the bottom to advance
%     if nCalls == 3
%         str = 'To begin the experiment, press 1 on the keypad.';
%     elseif nCalls ~= 4
%         str = 'Press "1" to continue.';
%     else
%         str = '';
%     end
%     annotation('textbox',[0.25,0.05,0.5,0.05],'String',str,...
%         'FontName','Arial','FontSize',28,...
%         'EdgeColor','none',...
%         'HorizontalAlignment','center','VerticalAlignment','middle');
    
    main_window.UserData.ready = 1;
end
end