function [cost, grad] = softmaxCost(theta, numClasses, inputSize, lambda, data, labels)

% numClasses - the number of classes 
% inputSize - the size N of the input vector
% lambda - weight decay parameter
% data - the N x M input matrix, where each column data(:, i) corresponds to
%        a single test set
% labels - an M x 1 matrix containing the labels corresponding for the input data
%

% Unroll the parameters from theta
theta = reshape(theta, numClasses, inputSize);

numCases = size(data, 2);

%%% convert 5 to [0,0,0,0,1,0,0,0,0,0]
groundTruth = full(sparse(labels, 1:numCases, 1));
cost = 0;

thetagrad = zeros(numClasses, inputSize);

%% ---------- YOUR CODE HERE --------------------------------------
%  Instructions: Compute the cost and gradient for softmax regression.
%                You need to compute thetagrad and cost.
%                The groundTruth matrix might come in handy.


%%% ------------------------
%%% Omit the bias, why?

y = groundTruth;
m = numCases;

td = theta * data;
%%% If not do subtractiong will cause overflow. So a practical way is to subtract the max value  
td = bsxfun(@minus, td, max(td));
temp = exp(td);

denominator = sum(temp);
p = bsxfun(@rdivide, temp, denominator);
cost = (-1/m) * sum(sum(y .* log(p))) + (lambda / 2) * sum(sum(theta .^2));

thetagrad = (-1/m) * (y - p) * data' + lambda * theta;

% ------------------------------------------------------------------
% Unroll the gradient matrices into a vector for minFunc
grad = [thetagrad(:)];
end

