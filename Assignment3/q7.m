dat = csvread('altitude.csv');
X_train = dat(1:900, 1 : 2);
X_train = padarray(X_train, [0 1], 1, 'pre');
X_train(:, 2) = (X_train(:, 2) - mean(X_train(:, 2))) ./ range(X_train(:, 2));
X_train(:, 3) = (X_train(:, 3) - mean(X_train(:, 3))) ./ range(X_train(:, 3));
Y_train = dat(1:900, 3);

X_test = dat(901:1000, 1 : 2);
X_test = padarray(X_test, [0 1], 1, 'pre');
X_test(:, 2) = (X_test(:, 2) - mean(X_test(:, 2))) ./ range(X_test(:, 2));
X_test(:, 3) = (X_test(:, 3) - mean(X_test(:, 3))) ./ range(X_test(:, 3));
Y_test = dat(901 : 1000, 3);

% Choose some alpha value
alpha = 0.01;
num_iters = 400;

% Init Theta and Run Gradient Descent 
theta = zeros(3, 1);
res = gradientDescentBatch(X_train, Y_train, theta, alpha, num_iters);
res2 = gradientDescentMiniBatch(X_train, Y_train, theta, alpha, num_iters, 25);
res3 = gradientDescentStochastic(X_train, Y_train, theta, alpha, num_iters);
normalized_features = X_test(100, :)';
%disp(res' * normalized_features);
%disp(res2' * normalized_features);
%disp(res3' * normalized_features);
disp(computeError(res, X_test, Y_test));
disp(computeError(res2, X_test, Y_test));
disp(computeError(res3, X_test, Y_test));
function theta = gradientDescentBatch(X, y, theta, alpha, num_iters)
    %GRADIENTDESCENTMULTI Performs gradient descent to learn theta
    %   theta = GRADIENTDESCENTMULTI(x, y, theta, alpha, num_iters) updates theta by
    %   taking num_iters gradient steps with learning rate alpha

    % Initialize some useful values
    m = length(y); % number of training examples
    %J_history = zeros(num_iters, 1);
    for iter = 1:num_iters

        % ====================== YOUR CODE HERE ======================
        % Instructions: Perform a single gradient step on the parameter vector
        %               theta. 
        %
        % Hint: While debugging, it can be useful to print out the values
        %       of the cost function (computeCostMulti) and gradient here.
        %

        %theta = theta - (alpha/m).*((((X*theta)-y).'*X).');
        theta = theta - (alpha/m).*((((X*theta)-y).'*X).');
        % ============================================================

        % Save the cost J in every iteration    
        %J_history(iter) = computeCostMulti(X, y, theta);

    end
end

function theta = gradientDescentMiniBatch(X, y, theta, alpha, num_iters, batch_size)
    m = length(y);
    for iter = 1:num_iters
        for  j = 1 : batch_size : m
            theta = theta - (alpha/batch_size).*((((X(j : j + batch_size - 1, :)*theta) - y(j: j + batch_size - 1, :)).'*X(j : j + batch_size - 1, :)).');    
        end
        
    end
end

function theta = gradientDescentStochastic(X, y, theta, alpha, num_iters)
    m = length(y);
    for iter = 1 : num_iters
        data = [X, y];
        randomizedData = data(randperm(size(data,1)),:);
        X = randomizedData(:, 1 : 3);
        y = randomizedData(:, 4);
        for j = 1 : m
            theta = theta - (alpha/1).*((((X(j : j, :)*theta) - y(j: j, :)).'*X(j : j, :)).');
        end
    end
end

function error = computeError(b, X_test, Y_test)
    pred_y = X_test * b;
    error = abs(norm(Y_test, 2) - norm(pred_y, 2)) / norm(Y_test, 2) * 100;
end