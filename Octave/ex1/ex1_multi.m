%% Machine Learning Online Class
%  Exercise 1: Linear regression with multiple variables
%
%  Instructions
%  ------------
% 
%  This file contains code that helps you get started on the
%  linear regression exercise. 
%
%  You will need to complete the following functions in this 
%  exericse:
%
%     warmUpExercise.m
%     plotData.m
%     gradientDescent.m
%     computeCost.m
%     gradientDescentMulti.m
%     computeCostMulti.m
%     featureNormalize.m
%     normalEqn.m
%
%  For this part of the exercise, you will need to change some
%  parts of the code below for various experiments (e.g., changing
%  learning rates).
%

%% Initialization

%% ================ Part 1: Feature Normalization ================

%% Clear and Close Figures
clear ; close all; clc

fprintf('Loading data ...\n');

%% Load Data
data = load('ex1data2.txt');
X = data(:, 1:2);
y = data(:, 3);
m = length(y);

% Print out some data points
fprintf('First 10 examples from the dataset: \n');
fprintf(' x = [%.0f %.0f], y = %.0f \n', [X(1:10,:) y(1:10,:)]');

fprintf('Program paused. Press enter to continue.\n');
pause;

% Scale features and set them to zero mean
fprintf('Normalizing Features ...\n');

[X mu sigma] = featureNormalize(X);

% Add intercept term to X
X = [ones(m, 1) X];


%% ================ Part 2: Gradient Descent ================

% ====================== YOUR CODE HERE ======================
% Instructions: We have provided you with the following starter
%               code that runs gradient descent with a particular
%               learning rate (alpha). 
%
%               Your task is to first make sure that your functions - 
%               computeCost and gradientDescent already work with 
%               this starter code and support multiple variables.
%
%               After that, try running gradient descent with 
%               different values of alpha and see which one gives
%               you the best result.
%
%               Finally, you should complete the code at the end
%               to predict the price of a 1650 sq-ft, 3 br house.
%
% Hint: By using the 'hold on' command, you can plot multiple
%       graphs on the same figure.
%
% Hint: At prediction, make sure you do the same feature normalization.
%


% ========= Comparing J values for different learning rates =========

% num_iters = 50;

% alpha = 0.001;
% theta = zeros(3, 1);
% [theta, J1] = gradientDescentMulti(X, y, theta, alpha, num_iters);

% alpha = 0.003;
% theta = zeros(3, 1);
% [theta, J2] = gradientDescentMulti(X, y, theta, alpha, num_iters);

% alpha = 0.01;
% theta = zeros(3, 1);
% [theta, J3] = gradientDescentMulti(X, y, theta, alpha, num_iters);

% alpha = 0.03;
% theta = zeros(3, 1);
% [theta, J4] = gradientDescentMulti(X, y, theta, alpha, num_iters);

% alpha = 0.1;
% theta = zeros(3, 1);
% [theta, J5] = gradientDescentMulti(X, y, theta, alpha, num_iters);

% alpha = 0.3;
% theta = zeros(3, 1);
% [theta, J6] = gradientDescentMulti(X, y, theta, alpha, num_iters);

% alpha = 1;
% theta = zeros(3, 1);
% [theta, J7] = gradientDescentMulti(X, y, theta, alpha, num_iters);



% plot(1:50, J1(1:50), 'b');
% hold on;
% plot(1:50, J2(1:50), 'r');
% hold on;
% plot(1:50, J3(1:50), 'k');
% hold on;
% plot(1:50, J4(1:50), 'g');
% hold on;
% plot(1:50, J5(1:50), 'y');
% hold on;
% plot(1:50, J6(1:50), 'm');
% hold on;
% plot(1:50, J7(1:50), 'c');


% legStr = { '0.001', '0.003', '0.01', '0.03', '0.1', '0.3', '1'};
% legend( legStr );

% pause;


% Comment: Command + K + C
% Un-Comment: Command + K + U

% ============================================================

fprintf('Running gradient descent ...\n');

% Choose some alpha value
alpha = 0.1;
num_iters = 400;

% Init Theta and Run Gradient Descent 
theta = zeros(3, 1);
[theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters);

% Plot the convergence graph
figure;
plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost J');

% Display gradient descent's result
fprintf('Theta computed from gradient descent: \n');
fprintf(' %f \n', theta);
fprintf('\n');



% Estimate the price of a 1650 sq-ft, 3 br house
% ====================== YOUR CODE HERE ======================
% Recall that the first column of X is all-ones. Thus, it does
% not need to be normalized.
%price = 0; % You should change this

predict_1_area = 1650
predict_1_rooms = 3
predict_1_area_normalized = ((predict_1_area - mu(1)) / sigma(1))
predict_1_rooms_normalized = ((predict_1_rooms - mu(2)) / sigma(2))

price = [ 1, predict_1_area_normalized, predict_1_rooms_normalized] * theta;
fprintf('For a 3 br house of 1650sq-ft, we predict a price of %f\n', price);


% ============================================================

fprintf(['Predicted price of a 1650 sq-ft, 3 br house ' ...
         '(using gradient descent):\n $%f\n'], price);

fprintf('Program paused. Press enter to continue.\n');
pause;






%% ================ Part 3: Normal Equations ================

fprintf('Solving with normal equations...\n');

% ====================== YOUR CODE HERE ======================
% Instructions: The following code computes the closed form 
%               solution for linear regression using the normal
%               equations. You should complete the code in 
%               normalEqn.m
%
%               After doing so, you should complete this code 
%               to predict the price of a 1650 sq-ft, 3 br house.
%

%% Load Data
data = csvread('ex1data2.txt');
X = data(:, 1:2);
y = data(:, 3);
m = length(y);

% Add intercept term to X
X = [ones(m, 1) X];

% Calculate the parameters from the normal equation
theta = normalEqn(X, y);

% Display normal equation's result
fprintf('Theta computed from the normal equations: \n');
fprintf(' %f \n', theta);
fprintf('\n');


% Estimate the price of a 1650 sq-ft, 3 br house
% ====================== YOUR CODE HERE ======================
%price = 0; % You should change this

price = [ 1, 1650, 3] * theta;

% ============================================================

fprintf(['Predicted price of a 1650 sq-ft, 3 br house ' ...
         '(using normal equations):\n $%f\n'], price);

