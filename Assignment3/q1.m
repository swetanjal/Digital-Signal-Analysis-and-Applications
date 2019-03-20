% Part 1
mat = csvread('houses.csv');
Y = mat(:, 3);
X = mat(:, 1:2);
X = padarray(X, [0 1], 1, 'pre');

train_sz = 42;
test_sz = 5;

X_train = X(1 : train_sz, :);
X_test = X(train_sz + 1 : end, :);

Y_train = Y(1 : train_sz, :);
Y_test = Y(train_sz + 1 : end, :);

b = inv(X_train' * X_train) * X_train' * Y_train;

features = [1; 1400; 4];
res = b' * features;
disp(res);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 2
X_train_normalized = X_train;
X_train_normalized(:,1) = X_train(:, 1);
X_train_normalized(:, 2) = (X_train(:, 2) - mean(X_train(:, 2))) ./ range(X_train(:, 2));
X_train_normalized(:, 3) = (X_train(:, 3) - mean(X_train(:, 3))) ./ range(X_train(:, 3));

new_b = inv(X_train_normalized' * X_train_normalized) * X_train_normalized' * Y_train;
normalized_features = [1; (1400 - mean(X_train(:, 2)))./range(X_train(:, 2)); (4 - mean(X_train(:, 3)))./range(X_train(:, 3))];
res_normalized = new_b' * normalized_features;
disp(res_normalized);
% Using this formula does not require any feature scaling, and you will get an exact solution in one calculation: 
% there is no 'loop until convergence' like in gradient descent. So doesn't
% help.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Part 3
mean1 = mean(X_train(:, 1));
mean2 = mean(X_train(:, 2));
mean3 = mean(X_train(:, 3));
y_mean = mean(Y_train(:, 1));
y_pred = b' * [mean1; mean2; mean3]; % Yes passes the regression line.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Computing the % error
pred_y = X_test * b;
error = abs(norm(Y_test, 2) - norm(pred_y, 2)) / norm(Y_test, 2) * 100;
disp(error);