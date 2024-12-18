function run_block(main_window)
%%
% launch_exp(...)
%
% Author: Kara & Ken
% Project: DSP
%
% Description:
%   This function will display the sequence the patient needs to input for 
%   each trial within the block. Afterward, the block of trials will begin.
%
% Inputs:   main_window     [=] Object handle for the figure window used
%                               for the task.
%
% Outputs:  NONE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 2 calls for each block, first one is original call to block, second one
% occurs when run_block is called again after sequence verification

persistent nCalls
if isempty(nCalls)
    nCalls = 1;
end


clear_screen();


if mod(nCalls,2)
    
    %show block start indicator
    a4 = annotation('rectangle',[0,0.45,0.05625,0.1],'Color',[0.5,0.5,0.5],'FaceColor',[0.5,0.5,0.5],'visible','off');
%     a5 = annotation('rectangle',[0,0.72,0.10625,0.2],'Color',[0.5,0.5,0.5],'FaceColor',[0.5,0.5,0.5],'visible','off');
    drawnow;
    set([a4],'visible','on')
%     set([a4,a5],'visible','on')

    pause(0.5);
    clear_screen();
    
    % Increment block num
    main_window.UserData.curr_block_num = main_window.UserData.curr_block_num + 1;
    main_window.UserData.curr_training_seq = main_window.UserData.block_seq(main_window.UserData.curr_block_num);
    
    % print block sequence
     dim1 = [0,0,1,1];
     str1 = sprintf(cat(2,'%i',repmat(' - %i',[1,main_window.UserData.seq_length-1])),main_window.UserData.key_seq(:,main_window.UserData.block_seq(main_window.UserData.curr_block_num)));
     a1 = annotation('textbox',dim1,'String',str1,...
         'FontName','Arial','FontSize',55,...
         'EdgeColor','none',...
         'HorizontalAlignment','center','VerticalAlignment','middle','visible','off');
     
     a2 = annotation('rectangle',[0,0.45,0.05625,0.1],'Color',[0.75,0.75,0.75],'FaceColor',[0.75,0.75,0.75],'visible','off');
%      a3 = annotation('rectangle',[0,0.72,0.10625,0.2],'Color',[0.75,0.75,0.75],'FaceColor',[0.75,0.75,0.75],'visible','off');
     
     drawnow;
     set([a1,a2],'visible','on')
%      set([a1,a2,a3],'visible','on')
     
     % show sequence for 2.5 sec before advancing
     pause(3.5);
     clear_screen();
     
     % do seq verification
    %  launch_verify(main_window)
    % want all keypresses during verifications always marked as -8 trial
    main_window.UserData.curr_trial = -8;
    main_window.UserData.block_ver = 1;
    main_window.UserData.instruct = 0;
    main_window.UserData.ready = 1;
    
    show_practice_screen();
    
    nCalls = nCalls+1;
    
    return
end
    
if ~mod(nCalls,2)
    
    main_window.UserData.block_ver = 0;
    nCalls = nCalls+1;
    
    clear_screen();
    
     % print block sequence one more time
     dim1 = [0,0,1,1];
     str1 = sprintf(cat(2,'%i',repmat(' - %i',[1,main_window.UserData.seq_length-1])),main_window.UserData.key_seq(:,main_window.UserData.block_seq(main_window.UserData.curr_block_num)));
     a1 = annotation('textbox',dim1,'String',str1,...
         'FontName','Arial','FontSize',55,...
         'EdgeColor','none',...
         'HorizontalAlignment','center','VerticalAlignment','middle','visible','off');
     
     a2 = annotation('rectangle',[0,0.45,0.05625,0.1],'Color',[0.75,0.75,0.75],'FaceColor',[0.75,0.75,0.75],'visible','off');
%      a3 = annotation('rectangle',[0,0.72,0.10625,0.2],'Color',[0.75,0.75,0.75],'FaceColor',[0.75,0.75,0.75],'visible','off');
     
     drawnow;
     set([a1,a2],'visible','on')
%      set([a1,a2,a3],'visible','on')
     
     % show sequence for 2.5 sec before advancing
     pause(3.5);
     clear_screen();
     pause(0.5)
    
    % print block start notification
    dim1 = [0.1250,0.55,0.75,0.1];
%     str1 = strcat('Block ',string(main_window.UserData.curr_block_num),' starts now');
    str1 = 'START';   % this MUST HAVE A SQUARE bc it is the last thing before the first jittered interval
    a1 = annotation('textbox',dim1,'String',str1,...
        'FontName','Arial','FontSize',36,...
        'EdgeColor','none',...
        'HorizontalAlignment','center','VerticalAlignment','middle','visible','off');
    
    a2 = annotation('rectangle',[0,0.45,0.05625,0.1],'Color',[0.5,0.5,0.5],'FaceColor',[0.5,0.5,0.5],'visible','off');
%     a5 = annotation('rectangle',[0,0.72,0.10625,0.2],'Color',[0.5,0.5,0.5],'FaceColor',[0.5,0.5,0.5],'visible','off');

    drawnow;
    set([a1,a2],'visible','on')
%     set([a1,a2,a5],'visible','on')
     
     % show for 3 sec before advancing
     pause(1.5);

     % Reset trial key press counter & within-block trial number
     main_window.UserData.trial_n_key_press = 0;
     main_window.UserData.curr_trial = 1;
     main_window.UserData.global_trial = main_window.UserData.global_trial+1;
     
      clear_screen();
      
     % Start timer to show initial cross
     if strcmp(main_window.UserData.trial_type,'discrete')
         start_timer_for_trial(main_window,main_window.UserData.jitter_set(main_window.UserData.global_trial),'g',[],0);
     else
         start_timer_for_trial(main_window,1.5,'g',[],0);
     end
end

 



 

end