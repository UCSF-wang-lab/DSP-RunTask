function break_screen(main_window)
%%
% break_screen(...)
%
% Author: Ken & Kara
% Project: DSP
%
% Description:
%   Clears the window and displays information regarding the break time for
%   the task. This function will also display a countdown to the next
%   block of the task when 5 seconds are left. At the end of the break
%   time, will start the next block.
%
% Inputs:   main_window     [=] The figure window handle that is used to
%                               display the task.
%
% Outputs:  NONE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
break_time = main_window.UserData.break_time_dur;

% Clear screen
clear_screen();


% 1.5 second before break prompt
pause(1.5);

%  intra state, sub state indicator
main_window.UserData.inbreak = 1;
% main_window.UserData.stimsweep_confirm = 0;

% go to loading screen til confirmed, and then to end screen if the block just completed was the last block
if main_window.UserData.curr_block_num == main_window.UserData.tot_blocks
    
%     first go to loading screen so can do last stim sweep, with end of
%     block indicator
    main_window.UserData.loading = 1;
    str1 = 'LOADING ...';
    dim1 = [0.125,0.70,0.75,0.1];
    a1 = annotation('textbox',dim1,'String',str1,...
        'FontName','Arial','FontSize',36,...
        'EdgeColor','none',...
        'HorizontalAlignment','center','VerticalAlignment','middle','visible','off');
    a2 = annotation('rectangle',[0,0.45,0.05625,0.1],'Color',[0.5,0.5,0.5],'FaceColor',[0.5,0.5,0.5],'visible','off');
%     a3 = annotation('rectangle',[0,0.72,0.10625,0.2],'Color',[0.5,0.5,0.5],'FaceColor',[0.5,0.5,0.5],'visible','off');
    drawnow;
    set([a1,a2],'visible','on')
%     set([a1,a2,a3],'visible','on')
    
    main_window.UserData.ready = 1;

    % block done audible indicator
    sound(sin(1:300));
    
%     return

else
    % initial break prompt
    dim1 = [0.125,0.50,0.75,0.1];
    str1 = sprintf('%i sec break',break_time);
    a1 = annotation('textbox',dim1,'String',str1,...
        'FontName','Arial','FontSize',48,...
        'EdgeColor','none',...
        'HorizontalAlignment','center','VerticalAlignment','middle','visible','off');
    a2 = annotation('rectangle',[0,0.45,0.05625,0.1],'Color',[0.5,0.5,0.5],'FaceColor',[0.5,0.5,0.5],'visible','off');
%     a3 = annotation('rectangle',[0,0.72,0.10625,0.2],'Color',[0.5,0.5,0.5],'FaceColor',[0.5,0.5,0.5],'visible','off');
    drawnow;
    set([a1,a2],'visible','on')
%      set([a1,a2,a3],'visible','on')
     
     % block done audible indicator
    sound(sin(1:300));

    if mod(main_window.UserData.curr_block_num,4) == 0
        % Block complete prompt
        dim1 = [0.125,0.30,0.75,0.1];
        str1 = sprintf('Block %i of %i is now complete. ',...
            main_window.UserData.curr_block_num,...
            main_window.UserData.tot_blocks);
        annotation('textbox',dim1,'String',str1,...
            'FontName','Arial','FontSize',36,...
            'EdgeColor','none',...
            'HorizontalAlignment','center','VerticalAlignment','middle');
    end

    % % % % % % % start taking input so that i can confirm whether stim sweep done
    % % % % update keypress function for this
%     main_window.UserData.ready = 1;

    % Pause for 10 second before showing count down
    pause(10);

    % Count down
    for i = 5:-1:1
        clear_screen();

        str1 = 'Next block starts in';
        dim1 = [0.125,0.70,0.75,0.1];
        str2 = num2str(i);
        dim2 = [0.125,0.40,0.75,0.1];
        annotation('textbox',dim1,'String',str1,...
            'FontName','Arial','FontSize',36,...
            'EdgeColor','none',...
            'HorizontalAlignment','center','VerticalAlignment','middle');
        annotation('textbox',dim2,'String',str2,...
            'FontName','Arial','FontSize',80,...
            'EdgeColor','none',...
            'HorizontalAlignment','center','VerticalAlignment','middle');

        sound(sin(1:300));

        pause(1);
    end

%     %  if stim sweep confirmed, proceed as normal
%     if main_window.UserData.stimsweep_confirm == 1
%         % Run next block
%         main_window.UserData.inbreak = 0;
%         run_block(main_window);
%     end

        % Run next block
        main_window.UserData.inbreak = 0;
        run_block(main_window);


%     %  if stim sweep not confirmed, show a loading screen
%     % leave it at a loading screen until get the stim sweep confirm
%     if main_window.UserData.stimsweep_confirm == 0
%         main_window.UserData.loading = 1;
% 
%         clear_screen();
%         str1 = 'LOADING ...';
%         dim1 = [0.125,0.70,0.75,0.1];
%         annotation('textbox',dim1,'String',str1,...
%             'FontName','Arial','FontSize',36,...
%             'EdgeColor','none',...
%             'HorizontalAlignment','center','VerticalAlignment','middle');
% 
%     %     while main_window.UserData.stimsweep_confirm == 0
%     %     end
% 
%     end

end
end