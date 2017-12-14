%%%%%%%% SEED demo for face data %%%%%%%%
% Data is a spatially subsampled subset of face images from Yale B face database

load FaceData_10class

% input parameters
opts.kmax = 5;
opts.epsilon = 0.05;
opts.labels = newlabels;
Results = compare_cssmethods(Y2,20:20:200,opts);

plot_err_ncuts(Results) % Step 4

