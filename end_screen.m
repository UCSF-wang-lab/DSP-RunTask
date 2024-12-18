function end_screen(main_window)
%%
% end_screen(...)
%
% Author: Kara & Ken
% Project: DSP
%
% Description:
%   Displays messages to the patient at the complete of the task. Once this
%   point is reach, it also calls a save function to save data into a
%   non-binary format.
%
% Inputs:   main_window     [=] Object handle to the figure window the task
%                               is run on.
%
% Outputs:  NONE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear_screen();

% First message
dim1 = [0.125,0.50,0.75,0.1];
str1 = 'That is all the training for these two sequences!';
annotation('textbox',dim1,'String',str1,...
    'FontName','Arial','FontSize',36,...
    'EdgeColor','none',...
    'HorizontalAlignment','center','VerticalAlignment','middle');

dim2 = [0.125,0.30,0.75,0.1];
str2 = 'Thank you so much for taking the time to help us understand motor learning in Parkinsons Disease!';
annotation('textbox',dim2,'String',str2,...
    'FontName','Arial','FontSize',36,...
    'EdgeColor','none',...
    'HorizontalAlignment','center','VerticalAlignment','middle');

a2 = annotation('rectangle',[0,0.45,0.05625,0.1],'Color',[0.5,0.5,0.5],'FaceColor',[0.5,0.5,0.5],'visible','off');
% a5 = annotation('rectangle',[0,0.72,0.10625,0.2],'Color',[0.5,0.5,0.5],'FaceColor',[0.5,0.5,0.5],'visible','off');

drawnow;
set([a2],'visible','on')
% set([a2,a5],'visible','on')

% Reduce Matlab processor priority
if ispc
    % "normal"
    [~,~] = dos('wmic process where name="matlab.exe" CALL setpriority 32');
else
end

% Wait 
pause(2.5);

% Save data and close window
delete(timerfindall);
save_data(main_window);
% [file_loc,file_loc2] = save_data(main_window);
% fprintf('Data file path: %s\nConfig file path: %s\n',file_loc,file_loc2);
pause(2);
close(main_window);
end