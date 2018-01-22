% Simulates a general (not necessarily symmetric) binary channel.

% Imports an image and simulates the results through a set of different
% general (not necessarily symmetric) binary channels with error
% probabilities from 1 to 0 p = 0:0.1:1 and from 0 to 1 q = 0:0.1:1. Plots
% all result images into figures.

% by Matthias Wolf - 2018


close all; clear; clc; tic;
fprintf('-------------------------------------------------------------\n');
fprintf('Binary_Channel_Simulation.m running...\n');
fprintf('-------------------------------------------------------------\n');


%% Inputs for gbc.m function

% Image in uint8 (horizontal-by-vertical-by-3 for RBG components)
im_in = imread('ForbiddenCity.png');

% Error probability p from 1 to 0
p = 0:0.1:1;

% Error probability q from 0 to 1
q = 0:0.1:1;


%% Run gbc.m in double loop for p and q

% Initialize result cell
result = cell(size(p,2),size(q,2));

for p_loop = p % error probability from 1 to 0
    
    % Create figure for each case of p
    figure('Name','Images',...
        'units','normalized','outerposition',[0 0 1 1]);
    
    % Initial position in subplot
    plot_pos = 1;
    
    for q_loop = q % error probability from 0 to 1
        
        % Run gbc.m
        im_out = uint8(gbc(im_in, p_loop, q_loop));
        
        % Save result into cell
        result{find(p_loop == p),find(q_loop == q)} = im_out;
        
        % Plot the images
        subplot(3,4,plot_pos);
        imshow(im_out);
        title_txt = ['p = ',num2str(p_loop),', q = ',num2str(q_loop)];
        title(title_txt);
        
        % Update position
        plot_pos = plot_pos + 1;
        
    end
end


%% Create and save summary image

% Create summary image
result_im = cell2mat(result);

% Plot summary image
figure('Name','Result','units','normalized','outerposition',[0 0 1 1]);
imshow(result_im);

% Save summary image in Result.png
imwrite(result_im,'Result.png',...
    'Author','Matthias Wolf',...
    'Description','Output of Binary_Channel_Simulation.m',...
    'Software','MATLAB');


%% Execution time

execution_time = toc;
fprintf('-------------------------------------------------------------\n');
fprintf('Execution time: %.0f seconds.\n',execution_time);
fprintf('-------------------------------------------------------------\n');
fprintf('\n\n');

clear ans execution_time im_out plot_pos p_loop q_loop title_txt;

% END OF SCRIPT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
