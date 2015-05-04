% Breast Cancer classification using LIBSVM
clear; clc; close all;
load('wdbc.mat');
P = size(x,2);  % ������ ��� ��������

for epan = 1:100
    % Cross-validation
    [trainidx, testidx] = crossvalind('HoldOut', P, 0.2);
    % train set:
    xtrain = x(:,trainidx);
    ttrain = t(trainidx);
    % test set:
    xtest = x(:,testidx);
    ttest = t(testidx);
    % ������ �������� train
    Ptrain = sum(trainidx);
    % ������ �������� test
    Ptest = sum(testidx);
    
    % Train SVM model
    % kernel = RBF, gamma = 0.0005, C = 100
    model = svmtrain(ttrain', xtrain', '-t 2 -g 0.0005 -c 100');
    fprintf('** Training prediction:\n');
    predict_train = svmpredict(ttrain', xtrain', model);
    
    % Test model on the test set
    fprintf('** Testing prediction:\n');
    predict_test = svmpredict(ttest', xtest', model);
    
    figure(1)
    subplot(2,1,1);
    plot(1:Ptrain, ttrain, 'bo', ...
        1:Ptrain, predict_train, 'r.');
    subplot(2,1,2);
    plot(1:Ptest, ttest, 'bo', ...
        1:Ptest, predict_test, 'r.');
    pause;
end