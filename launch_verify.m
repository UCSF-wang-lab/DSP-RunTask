function launch_verify(main_window)
%%
% launch_vez(...)
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

if strcmp(main_window.UserData.program_states(main_window.UserData.curr_program_state),'tutorial') && nCalls <= 8
    switch nCalls
        case 1
            % First message
            dim1 = [0.10,0.85,0.80,0.1];
            str1 = 'Please rest briefly now if you need it. When you are ready, go to the next screen.';
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            % Increment counter
            main_window.UserData.instruct = 1;
            nCalls = nCalls + 1;
        case 2
            % Second message
            dim1 = [0.10,0.85,0.80,0.1];
            str1 = 'For this experiment, you will practice typing two different sequences.';
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            % Increment counter
            main_window.UserData.instruct = 1;
            nCalls = nCalls + 1;
            
        case 3
            % Third message
            dim1 = [0.2250,0.8,0.55,0.1];
            str1 = {'There are 4 steps to this experiment:';...
                '1) Memorize the two sequences';...
                '2) Verify you remember them';...
                '3) Help us record a 90-second baseline period';...
                '4) Practice the two sequences';...
                'Instructions will be repeated with each step.'};
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            % Increment counter
            main_window.UserData.instruct = 1;
            nCalls = nCalls + 1;
        case 4
            % First sequence
            dim1 = [0.2250,0.70,0.55,0.1];
            str1 = 'Below is the first sequence to memorize. When you feel you have memorized it, proceed to the next screen to verify.';
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            dim2 = [0.2250,0.50,0.55,0.1];
            str2 = sprintf('%i - %i - %i - %i',main_window.UserData.key_seq(1,1),...
                main_window.UserData.key_seq(2,1),...
                main_window.UserData.key_seq(3,1),...
                main_window.UserData.key_seq(4,1));
            annotation('textbox',dim2,'String',str2,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            % Increment counter
            main_window.UserData.instruct = 1;
            nCalls = nCalls + 1;
        case 5
            % Increment counter
            main_window.UserData.instruct = 0;
            nCalls = nCalls + 1;
           
            % want all keypresses during verifications always marked as -8 trial
            main_window.UserData.curr_trial = -8;
            
            % Practice screen  ... so this just shows a screen and in
            % meantime input to keypress function is tallied and compared
            % to current sequence. once it reaches 3x correct, it stops
            % accepting input, stops cross timer, but does not advance
            % state of program. then simulates z keypress 
            
            show_practice_screen();
        case 6
            % Second sequence
            dim1 = [0.2250,0.80,0.55,0.1];
            str1 = 'Good job!';
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            dim2 = [0.2250,0.70,0.55,0.1];
            str2 = 'Below is the second sequence to memorize. When you feel you have memorized it, proceed to the next screen to verify.';
            annotation('textbox',dim2,'String',str2,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            dim3 = [0.2250,0.50,0.55,0.1];
            str3 = sprintf('%i - %i - %i - %i',main_window.UserData.key_seq(1,2),...
                main_window.UserData.key_seq(2,2),...
                main_window.UserData.key_seq(3,2),...
                main_window.UserData.key_seq(4,2));
            annotation('textbox',dim3,'String',str3,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
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
            
            % Practice screen
            show_practice_screen();
        case 8
            dim1 = [0.2250,0.80,0.55,0.1];
            str1 = 'You did great!';
            annotation('textbox',dim1,'String',str1,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            dim2 = [0.2250,0.70,0.55,0.1];
            str2 = 'Now that you’ve memorized the sequences, we just need you to help us measure your baseline brain activity before you start practicing.';
            annotation('textbox',dim2,'String',str2,...
                'FontName','Arial','FontSize',36,...
                'EdgeColor','none',...
                'HorizontalAlignment','center','VerticalAlignment','middle');
            
            dim3 = [0.2250,0.50,0.55,0.1];
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
    
%     % Only display when not training sequences
%     if nCalls ~= 6 && nCalls ~= 8
%         % Message at the bottom to advance
%         dim = [0.25,0.05,0.5,0.05];
%         str = 'Press "1" to continue.';
%         annotation('textbox',dim,'String',str,...
%             'FontName','Arial','FontSize',28,...
%             'EdgeColor','none',...
%             'HorizontalAlignment','center','VerticalAlignment','middle');
%     end
    
    main_window.UserData.ready = 1;
elseif strcmp(main_window.UserData.program_states(main_window.UserData.curr_program_state),'tutorial')
    main_window.UserData.curr_program_state = main_window.UserData.curr_program_state + 1;
    launch_baseline(main_window);
% else
%     launch_baseline(main_window)
end
end