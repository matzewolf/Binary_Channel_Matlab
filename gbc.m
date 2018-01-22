function [ output ] = gbc( input, p, q )

% gbc models a general (not necessarily symmetric) binary channel.
%   
%   It works similar to the bsc (Binary Symmetric Channel) function of 
%   MATLAB's Communications System Toolbox, but with two error 
%   probabilities, and non-binary input and output:
%   
%   "p" denotes the error probability that the binary values of the input 
%   signal "input" change from 1 to 0, and "q" analogously from 0 to 1.
%   "output" returns the non-binary output signal after the general binary
%   channel.
%   
%   Input args:
%   "input" can be any real-valued (not necessariliy binary) matrix. 
%   "p" and "q" both have to be scalars between 0 and 1, including these 
%   values: 0 <= p,q <= 1.
%   Output args:
%   "output" will have the same size as "input".

% by Matthias Wolf - 2018


%% Convert input to binary code

bi_in = de2bi(input);


%% Convert from 1 to 0 with probability p

% copy the input binary code
bi_1to0 = double(bi_in);

% generate random number instead of 1 in input matrix
bi_1to0(bi_in == 1) = rand(size(find(bi_in == 1)));

% put 0 instead of random number if it is < p
bi_1to0(bi_1to0 < p) = 0;

% put 1 instead of random number if it is > p
bi_1to0(bi_1to0 > p) = 1;


%% Convert from 0 to 1 with probability q

% copy the input binary code
bi_0to1 = bi_1to0;

% generate random number instead of 0 in input matrix
bi_0to1(bi_in == 0) = rand(size(find(bi_in == 0)));

% put 1 instead of random number if it is > 1-q
bi_0to1(bi_0to1 > 1-q) = 1;

% put 0 instead of random number if it is < 1-q
bi_0to1(bi_0to1 < 1-q) = 0;


%% Final output code

output = reshape(bi2de(bi_0to1),size(input));


end
