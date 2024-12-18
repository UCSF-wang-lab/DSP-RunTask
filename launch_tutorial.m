function launch_tutorial(main_window)
%%
% launch_tutorial(...)
%
% Author: Kara & Ken
% Project: DSP
%
% Description:
%   Displays and launches the tutorial portion of the task. This introduces
%   the two sequences that patient needs to memorize and practice before
%   doing the task.
%
% Inputs:   main_window     [=] Object handle for the figure window used
%                               for the task.
%
% Outputs:  NONE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
persistent nCalls
if isempty(nCalls)
    nCalls = 1;
    
    % Wait until the next screen shows
    pause(2);
end

if strcmp(main_window.UserData.program_states(main_window.UserData.curr_program_state),'tutorial') && nCalls <= 10
    switch nCalls
        case 1
            % First message
            dim1 = [0.125,0.55,0.75,0.1];
            str1 = {'Well done. That concludes the warmup.';...
                '';...
                'Please rest briefly now if you need it.'};
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            % Increment counter
            main_window.UserData.instruct = 1;
            nCalls = nCalls + 1;
            
        case 2
            dim1 = [0.125,0.75,0.75,0.1];
            str1 = {'Verification 1'};
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            
            
            dim2 = [0.125,0.50,0.75,0.1];
            str2 = {'The next screen will show the first sequence for you to memorize.';...
                'Do not type while the sequence is displayed.';...
                'When you are done memorizing the sequence, please let me know.'};
            
            annotation('textbox',dim2,'String',str2,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            % want all keypresses during verifications always marked as -8 trial
            main_window.UserData.curr_trial = -8;
            
            % Increment counter
            main_window.UserData.instruct = 1;
            nCalls = nCalls + 1;
%         case 2
%             % Second message
%             dim1 = [0.10,0.85,0.80,0.1];
%             str1 = 'For this experiment, you will practice typing two different sequences of keys.';
%             annotation('textbox',dim1,'String',str1,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
%             
%             % Increment counter
%             main_window.UserData.instruct = 1;
%             nCalls = nCalls + 1;
            
%         case 3
%             % Third message
%             dim1 = [0.2250,0.8,0.55,0.1];
%             str1 = {'There are 4 steps to this experiment:';...
%                 '1) Memorize the two sequences';...
%                 '2) Verify you remember them';...
%                 '3) Help us record a 90-second baseline period';...
%                 '4) Practice the two sequences';...
%                 'Instructions will be repeated with each step.'};
%             annotation('textbox',dim1,'String',str1,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
%             
%             % Increment counter
%             main_window.UserData.instruct = 1;
%             nCalls = nCalls + 1;
        case 3    % dont want them to advance screen themselves since dont want them to touch laptop bc capacitors and if they use keypad to advance screen, patients with tremor end up skipping seeing the sequence at all
            % First sequence
%             dim1 = [0.1250,0.75,0.75,0.1];
%             str1 = 'Below is the first sequence to memorize.';
%             annotation('textbox',dim1,'String',str1,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
            
            dim2 = [0.1250,0.50,0.75,0.1];

            str2 = sprintf(cat(2,'%i',repmat(' - %i',[1,main_window.UserData.seq_length-1])),main_window.UserData.key_seq(:,1));
            a1 = annotation('textbox',dim2,'String',str2,...
                'FontName','Arial','FontSize',55,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle','visible','off');
            
%             
%             dim3 = [0.1250,0.25,0.75,0.1];
%             str3 = 'Once you are done memorizing, go to the next screen.';
%             annotation('textbox',dim3,'String',str3,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');

         a2 = annotation('rectangle',[0,0.45,0.05625,0.1],'Color',[0.75,0.75,0.75],'FaceColor',[0.75,0.75,0.75],'visible','off');
         
%           a3 = annotation('rectangle',[0,0.72,0.10625,0.2],'Color',[0.75,0.75,0.75],'FaceColor',[0.75,0.75,0.75],'visible','off');

         drawnow;
         set([a1,a2],'visible','on')
%          set([a1,a2,a3],'visible','on')
            
            % Increment counter
            main_window.UserData.instruct = 1;
            nCalls = nCalls + 1;
        case 4   
            % Increment counter
            main_window.UserData.instruct = 0;
            nCalls = nCalls + 1;
            
            % Practice screen  ... so this just shows a screen and in
            % meantime input to keypress function is tallied and compared
            % to current sequence. once it reaches 3x correct, it stops
            % accepting input, stops cross timer, but does not advance
            % state of program. then simulates z keypress 
            main_window.UserData.ready = 1;
            
%             main_window.UserData.ready
%             main_window.UserData.instruct
%             main_window.UserData.inbreak
            
            show_practice_screen();
        case 5
            % Second sequence
            dim1 = [0.125,0.75,0.75,0.1];
            str1 = {'Verification 2'};
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            
            
            dim2 = [0.125,0.50,0.75,0.1];
            str2 = {'The next screen will show the second sequence for you to memorize.';...
                'Do not type while the sequence is displayed';...
                'When you are done memorizing the sequence, please let me know.'};
            annotation('textbox',dim2,'String',str2,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            % Increment counter
            main_window.UserData.instruct = 1;
            nCalls = nCalls + 1;
            
        case 6
            
          
            dim1 = [0.1250,0.45,0.75,0.1];
            str1 = sprintf(cat(2,'%i',repmat(' - %i',[1,main_window.UserData.seq_length-1])),main_window.UserData.key_seq(:,2));
            a1 = annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',55,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle','visible','off');
            
             a2 = annotation('rectangle',[0,0.45,0.05625,0.1],'Color',[0.75,0.75,0.75],'FaceColor',[0.75,0.75,0.75],'visible','off');
     
%              a3 = annotation('rectangle',[0,0.72,0.10625,0.2],'Color',[0.75,0.75,0.75],'FaceColor',[0.75,0.75,0.75],'visible','off');
             
             drawnow;
             set([a1,a2],'visible','on')
%              set([a1,a2,a3],'visible','on')
            
            
            % Increment counter
            main_window.UserData.instruct = 1;
            nCalls = nCalls + 1;
        case 7
            % Increment counter
            main_window.UserData.instruct = 0;
            nCalls = nCalls + 1;
            
            % Advance training sequence
            main_window.UserData.curr_training_seq = main_window.UserData.curr_training_seq + 1;
            main_window.UserData.training_n_key_press = 1;
            main_window.UserData.training_hits = ones(1,500);
            
            % Practice screen
            show_practice_screen();
        case 8
            dim1 = [0.1250,0.65,0.75,0.1];
            str1 = 'Next is baseline.';
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
%             dim2 = [0.1250,0.45,0.75,0.1];
%             str2 = 'Now that you have memorized the sequences, we just need to measure baseline brain activity before you start practicing.';
%             annotation('textbox',dim2,'String',str2,...
%                 'FontName','Arial','FontSize',36,...
%                 'EdgeColor','none',...
%                 'HorizontalAlignment','center','VerticalAlignment','middle');
            
            dim3 = [0.1250,0.45,0.75,0.1];
            str3 = 'If you need to, rest briefly before proceeding to the next screen.';
            annotation('textbox',dim3,'String',str3,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            % Increment counter
            main_window.UserData.instruct = 1;
            nCalls = nCalls + 1;
            
            % Advance state of experiment 
            main_window.UserData.curr_program_state = main_window.UserData.curr_program_state + 1;
    end
    
%     % Only display when not verifying sequences
%     if nCalls ~= 4 && nCalls ~= 6
%         % Message at the bottom to advance
%         dim = [0.25,0.05,0.5,0.05];
%         str = 'Press "1" to continue.';
%         annotation('textbox',dim,'String',str,...
%             'FontName','Arial','FontSize',28,...
%             'EdgeColor','none',...
%             'HorizontalAlignment','center','VerticalAlignment','middle');
%     end
    
    main_window.UserData.ready = 1;
elseif strcmp(main_window.UserData.program_states(main_window.UserData.curr_program_state),'tutorial') && nCalls > 8
    main_window.UserData.curr_program_state = main_window.UserData.curr_program_state + 1;
    launch_baseline(main_window);
% else
%     launch_baseline(main_window)
end
end