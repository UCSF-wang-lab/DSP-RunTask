function DSP_Task_keypress(object,event)
%%
% (...)
%
% Author: Kara & Ken
% Project: DSP
%
% Description:
%   Records all keypress events on the task window. There are certain keys
%   that are reserved for specific tasks. "escape" exits fullscreen mode
%   and automatically saves any data that already exist. "9" is used to
%   advance the program past certain text screens or to start trials.
%   Keys "m", ",", ".", and "/" are currently used as key presses for the
%   sequences the patient needs to hit. Additionally, these keys may have
%   different functions depending on the state of the program. 
%
% Inputs:   object  [=] Object handle for the figure window used for the
%                       task.
%           event   [=] What key was pressed   
%
% Outputs:  NONE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if object.UserData.ready == 1
    input_time = toc(object.UserData.clock);
    stop(object.UserData.timer);
    state = object.UserData.program_states{object.UserData.curr_program_state};
    switch event.Key
        case 's' % indicate that stim sweep is done so that training can proceed
            if object.UserData.inbreak == 1 && object.UserData.loading == 1
%                 object.UserData.stimsweep_confirm = 1;
                object.UserData.ready = 0;
                
%                 if object.UserData.loading == 1
                    object.UserData.loading = 0;
                    % Run next block
                    object.UserData.inbreak = 0;
                    
                    if strcmp(state,'launch')
                        clear_screen();
                        object.UserData.curr_program_state = object.UserData.curr_program_state+1;
                        launch_warm_up(object);
                        return
                    end
%                     
%                     if object.UserData.curr_block_num ~= object.UserData.tot_blocks
%                         run_block(object);
                    if object.UserData.curr_block_num == object.UserData.tot_blocks
                        object.UserData.curr_program_state = object.UserData.curr_program_state+1;
                        end_screen(object);
                    end
%                 end
                
            end
            
            return
            
        case 'n'  % move to next slide for patients. formerly used 1 for this
            if object.UserData.inbreak == 1
                return
            end
            
            switch state
                case 'launch'
                    clear_screen();
                    object.UserData.ready = 0;
                    launch_screen(object);
                case 'warm-up'
                    % if it is on an instructions slide
                    if object.UserData.instruct == 1
                        clear_screen();
                        object.UserData.ready = 0;
                        launch_warm_up(object);
                    end
                    
                case 'tutorial'     
                    % if it is on an instructions slide
                    if object.UserData.instruct == 1
                        clear_screen();
                        object.UserData.ready = 0;
                        launch_tutorial(object);
                    end
                    
                case 'baseline'
                    % if it is on an instructions slide
                    if object.UserData.instruct == 1
                        clear_screen();
                        object.UserData.ready = 0;
                        launch_baseline(object);
                    end
                    
                case 'experiment'
                    % if it is on an instructions slide
                    if object.UserData.instruct == 1
                        clear_screen();
                        object.UserData.ready = 0;
                        launch_exp(object);
                    end
                case 'end'
                    clear_screen();
                    object.UserData.ready = 0;
                    end_screen(object);
            end
            
            
        case 'p'  % workaround to just be able to skip ahead while troubleshooting code
            clear_screen();
            object.UserData.ready = 0;
            switch state
                case 'launch'
                    launch_screen(object);
                case 'warm-up'
                    launch_warm_up(object);
                case 'tutorial'
                    launch_tutorial(object);
                case 'baseline'
                    launch_baseline(object);
                case 'experiment'
                    launch_exp(object);
                case 'end'
                    end_screen(object);
            end
        case 'y'  % workaround to just be able to skip ahead by full task sections while troubleshooting
            clear_screen();
            object.UserData.ready = 0;
            switch state
                case 'launch'
                    object.UserData.curr_program_state = object.UserData.curr_program_state + 1;
                    launch_warm_up(object);
                case 'warm-up'
                    object.UserData.curr_program_state = object.UserData.curr_program_state + 1;
                    launch_tutorial(object);
                case 'tutorial'
                    object.UserData.curr_program_state = object.UserData.curr_program_state + 1;
                    launch_baseline(object);
                case 'baseline'
                    object.UserData.curr_program_state = object.UserData.curr_program_state + 1;
                    launch_exp(object);
                case 'experiment'
                    object.UserData.curr_program_state = object.UserData.curr_program_state + 1;
                    end_screen(object);
            end
        case {'1','2','3','4','5'}            
            if object.UserData.inbreak == 1
                return
            end
            
            number = str2double(event.Key);
            
            if object.UserData.instruct == 0 
                write_input(object,number,input_time);

                switch state
                    case 'experiment'
                        if object.UserData.block_ver == 1
                            object.UserData.verif_hits(object.UserData.verif_n_key_press) = number;
                            object.UserData.verif_n_key_press = object.UserData.verif_n_key_press + 1;   % an alternative option would be to straight up just append the hits and then do end-12 in the accuracy check so that don't need to rely on keypress counter, but im not actually sure that would be any faster
                            check_accuracy_interblock(object);
                        else
                            object.UserData.trial_n_key_press = object.UserData.trial_n_key_press + 1;
                            if strcmp(object.UserData.trial_type,'discrete')
                                % if full repetition length was typed
                                if mod(object.UserData.trial_n_key_press,object.UserData.seq_length) == 0
                                    % Stop receiving input until next cue
                                    object.UserData.ready = 0;

                                    % Check if it is the last trial in the block
                                    if object.UserData.curr_trial == object.UserData.trials_per_block
                                        break_screen(object);
                                    % check to see if it is the halfway
                                    % point for a reminder
%                                     elseif object.UserData.curr_trial == round(object.UserData.trials_per_block/2)
%                                         clear_screen();
%                                         pause(0.75)
%                                         %show the sequence reminder
%                                          dim1 = [0,0,1,1];
%                                          str1 = sprintf('%i - %i - %i - %i',object.UserData.key_seq(1,object.UserData.block_seq(object.UserData.curr_block_num)),...
%                                              object.UserData.key_seq(2,object.UserData.block_seq(object.UserData.curr_block_num)),...
%                                              object.UserData.key_seq(3,object.UserData.block_seq(object.UserData.curr_block_num)),...
%                                              object.UserData.key_seq(4,object.UserData.block_seq(object.UserData.curr_block_num)));
%                                          a1 = annotation('textbox',dim1,'String',str1,...
%                                              'FontName','Arial','FontSize',55,...
%                                              'EdgeColor','none',...
%                                              'HorizontalAlignment','center','VerticalAlignment','middle','visible','off');
% 
%                                          a2 = annotation('rectangle',[0,0.45,0.05625,0.1],'Color',[0.75,0.75,0.75],'FaceColor',[0.75,0.75,0.75],'visible','off');
%                                          drawnow;
%                                          set([a1,a2],'visible','on')
%                                          pause(1.5)
% 
%                                         object.UserData.global_trial = object.UserData.global_trial+1;
%                                         object.UserData.curr_trial = object.UserData.curr_trial + 1;
%                                         clear_screen();
%                                         start_timer_for_trial(object,object.UserData.jitter_set(object.UserData.global_trial),'g',[],0);
                                    else % Not the last trial. Prepare new cue
                                        object.UserData.global_trial = object.UserData.global_trial+1;
                                        object.UserData.curr_trial = object.UserData.curr_trial + 1;
                                        clear_screen();
                                        start_timer_for_trial(object,object.UserData.jitter_set(object.UserData.global_trial),'g',[],0);
                                    end
                                end
                            else
                                if object.UserData.trial_n_key_press == object.UserData.seq_length * object.UserData.trials_per_block
                                    % Stop receiving input and show break screen
                                    object.UserData.ready = 0;
                                    break_screen(object);
                                end
                            end
                        end
                   case 'tutorial'
                        object.UserData.training_hits(object.UserData.training_n_key_press) = number;
                        object.UserData.training_n_key_press = object.UserData.training_n_key_press + 1;
                        check_accuracy(object);
                    case 'warm-up'
                        if number == object.UserData.curr_trial
                            object.UserData.warmup_n_correct_hits = object.UserData.warmup_n_correct_hits+1;
                        end
                        count_hits_digitmatters(object);
                        
%                         object.UserData.warmup_hits(object.UserData.warmup_n_key_press) = number;
%                         object.UserData.warmup_n_key_press = object.UserData.warmup_n_key_press + 1;
%                         object.UserData.warmup_n_elem_hits = object.UserData.warmup_n_elem_hits + 1;
%                         count_hits(object) 
                end
            end
        case {'numpad7','numpad9','numpad6','numpad3','decimal'}    
            if object.UserData.inbreak == 1
                return
            end
            
            number = object.UserData.numpadMap(event.Key);
            number = str2double(number);
            
            if object.UserData.instruct == 0 
                write_input(object,number,input_time);

                switch state
                    case 'experiment'
                        if object.UserData.block_ver == 1
                            object.UserData.verif_hits(object.UserData.verif_n_key_press) = number;
                            object.UserData.verif_n_key_press = object.UserData.verif_n_key_press + 1;   % an alternative option would be to straight up just append the hits and then do end-12 in the accuracy check so that don't need to rely on keypress counter, but im not actually sure that would be any faster
                            check_accuracy_interblock(object);
                        else
                            object.UserData.trial_n_key_press = object.UserData.trial_n_key_press + 1;
                            if strcmp(object.UserData.trial_type,'discrete')
                                % if full repetition length was typed
                                if mod(object.UserData.trial_n_key_press,object.UserData.seq_length) == 0
                                    % Stop receiving input until next cue
                                    object.UserData.ready = 0;

                                    % Check if it is the last trial in the block
                                    if object.UserData.curr_trial == object.UserData.trials_per_block
                                        break_screen(object);
                                    else % Not the last trial. Prepare new cue
                                        object.UserData.global_trial = object.UserData.global_trial+1;
                                        object.UserData.curr_trial = object.UserData.curr_trial + 1;
                                        clear_screen();
                                        start_timer_for_trial(object,object.UserData.jitter_set(object.UserData.global_trial),'g',[],0);
                                    end
                                end
                            else
                                if object.UserData.trial_n_key_press == object.UserData.seq_length * object.UserData.trials_per_block
                                    % Stop receiving input and show break screen
                                    object.UserData.ready = 0;
                                    break_screen(object);
                                end
                            end
                        end
                   case 'tutorial'
                        object.UserData.training_hits(object.UserData.training_n_key_press) = number;
                        object.UserData.training_n_key_press = object.UserData.training_n_key_press + 1;
                        check_accuracy(object);
                    case 'warm-up'
                        if number == object.UserData.curr_trial
                            object.UserData.warmup_n_correct_hits = object.UserData.warmup_n_correct_hits+1;
                        end
                        count_hits_digitmatters(object);
                end
            end
        case 'v'   
            switch state
                case 'tutorial'
                    object.UserData.training_hits(1:object.UserData.training_n_key_press-1)
                case 'experiment'
                    object.UserData.verif_hits(1:object.UserData.verif_n_key_press-1)
            end
    end
end
end

%%%%%%%%%%%%%% HELPER FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%

function check_accuracy(main_window)
if main_window.UserData.training_n_key_press > main_window.UserData.seq_length*3
%     seq_typed = main_window.UserData.training_hits(main_window.UserData.training_n_key_press-12:main_window.UserData.training_n_key_press-1);
%     seq_actual = main_window.UserData.key_seq(:,main_window.UserData.curr_training_seq)';
    if isequal(main_window.UserData.training_hits(main_window.UserData.training_n_key_press-(main_window.UserData.seq_length*3):main_window.UserData.training_n_key_press-1),repmat(main_window.UserData.key_seq(:,main_window.UserData.curr_training_seq)',1,3))
        main_window.UserData.ready = 0;
        clear_screen();
        
        launch_tutorial(main_window);
%         advance_program([],[],0);
        
    end
end
end

function check_accuracy_interblock(main_window)
if main_window.UserData.verif_n_key_press > main_window.UserData.seq_length*3
%     seq_typed = main_window.UserData.verif_hits(main_window.UserData.verif_n_key_press-12:main_window.UserData.verif_n_key_press-1);
%     seq_actual = main_window.UserData.key_seq(:,main_window.UserData.curr_training_seq)';
    if isequal(main_window.UserData.verif_hits(main_window.UserData.verif_n_key_press-(main_window.UserData.seq_length*3):main_window.UserData.verif_n_key_press-1),repmat(main_window.UserData.key_seq(:,main_window.UserData.curr_training_seq)',1,3))
        main_window.UserData.ready = 0;
        main_window.UserData.verif_hits = ones(1,500);
        main_window.UserData.verif_n_key_press = 1;
        run_block(main_window);
%         advance_program([],[],0);
        
    end
end
end


function count_hits(main_window)   % this is old helper function for when digit didn't matter during warmup, was less robust
    if main_window.UserData.warmup_n_elem_hits == 20
        main_window.UserData.ready = 0;
        
            if main_window.UserData.warmup_n_key_press >= 20*5
                main_window.UserData.curr_program_state = main_window.UserData.curr_program_state + 1;
            end

            state1 = main_window.UserData.program_states{main_window.UserData.curr_program_state};
            
            clear_screen();
            
            switch state1
                case 'warm-up'
                    launch_warm_up(main_window);
                case 'tutorial'
                    launch_tutorial(main_window);
            end
    end
end

function count_hits_digitmatters(main_window)
    if main_window.UserData.warmup_n_correct_hits == 20
        main_window.UserData.ready = 0;
        main_window.UserData.warmup_n_correct_hits = 0;
        clear_screen();
        if main_window.UserData.curr_trial ~= 5
            launch_warm_up(main_window);
        elseif main_window.UserData.curr_trial == 5
            main_window.UserData.curr_program_state = main_window.UserData.curr_program_state + 1;
            launch_tutorial(main_window);
        end
    end
end