% script to plot results

function plot_err_ncuts(Results)

Markerz{1} = '-';
Markerz{2} = 'o-';
Markerz{3} = '<-';
Markerz{4} = '*-';
Markerz{5} = '^-';
Markerz{6} = '>-';
Markerz{7} = '--';

% Plot error as function of factorization size
figure; 
for i=1:4
    plot(Results.opts.L,Results.Errs(:,i),Markerz{i}); hold on;
end
hold off;
title('Factorization error vs. number of samples (L)')
xlabel('Number of columns (L)')
ylabel('Relative error')

tmp = Results.ErrMethods;
legend(tmp{1},tmp{2},tmp{3},tmp{4})

% Plot normalized cut ratios
figure; 
for i=1:7
    plot(Results.opts.L,Results.Ncuts(:,i),Markerz{i}); hold on;
end
hold off;
title('Cost of normalized cut vs. number of samples (L)')
xlabel('Number of columns (L)')
ylabel('Cost of normalized cut')

tmp = Results.ClustMethods;
legend(tmp{1},tmp{2},tmp{3},tmp{4},tmp{5},tmp{6},tmp{7})


end