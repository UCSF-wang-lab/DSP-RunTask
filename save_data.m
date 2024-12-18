function save_data(src,event)
% [file_loc,file_loc2] = save_data(src,event)
%%
% save_data(...)
%
% Author: Kara & Ken
% Project: DSP
%
% Description:
%   Reads in the autosave binary data and converts it to a mat and csv
%   file.
%
% Inputs:   src     [=]
%           event   [=] Ignored.
%
% Outputs:  NONE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fclose(src.UserData.auto_save_file);


% exp_data = table(zeros(total_trials,1),strings(total_trials,1),zeros(total_trials,1),zeros(total_trials,1),...
%     zeros(total_trials,1),zeros(total_trials,1),zeros(total_trials,1),...
%     'VariableNames',{'Block_Num','Block_Type','Delay_Time','Target','Response','Target_Time','Keypress_Time'});

% % Calculate response time from data
% main_window.UserData.exp_data.Response_Time = ...
%     main_window.UserData.exp_data.Keypress_Time - ...
%     main_window.UserData.exp_data.Target_Time;
% 
% % Write data table to file
% try
%     file_loc = fullfile(main_window.UserData.save_path,...
%         [main_window.UserData.subid,'_SSRT_',datestr(now,'yy-mm-dd_HH-MM-SS'),'.csv']);
%     writetable(main_window.UserData.exp_data,...
%         file_loc,...
%         'Delimiter',',');
% catch
%     file_loc = fullfile(pwd,...
%         [main_window.UserData.subid,'_SSRT_',datestr(now,'yy-mm-dd_HH-MM-SS'),'.csv']);
%     writetable(main_window.UserData.exp_data,...
%         file_loc,...
%         'Delimiter',',');
% end
% 
% % Write testing configurations to file
% file_loc2 = fullfile(main_window.UserData.save_path,...
%     [main_window.UserData.subid,'_test_config_',datestr(now,'yy-mm-dd_HH-MM-SS'),'.txt']);
% fid = fopen(file_loc2,'w');
% if fid < 0
%     file_loc2 = fullfile(pwd,...
%         [main_window.UserData.subid,'_test_config_',datestr(now,'yy-mm-dd_HH-MM-SS'),'.txt']);
%     fid = fopen(file_loc2,'w');
% end
% 
% if fid > 0
%     fprintf(fid,'ID: %s\n',main_window.UserData.subid);
%     
%     fprintf(fid,'block_sequence: ');
%     for i = 1:length(main_window.UserData.block_vals)
%         fprintf(fid,'%s,',main_window.UserData.block_vals{i});
%     end
%     fprintf(fid,'\n');
%     
%     fprintf(fid,'trials_per_block: %i\n',main_window.UserData.trials_per_block);
%     
%     fprintf(fid,'inter_trial_delay: %1.2f s\n',main_window.UserData.inter_trial_delay);
%     
%     fprintf(fid,'sequence: ');
%     for i = 1:length(main_window.UserData.key_seq)
%         fprintf(fid,'%i,',main_window.UserData.key_seq(i));
%     end
%     fprintf(fid,'\n');
%     
%     fclose(fid);
% end
end