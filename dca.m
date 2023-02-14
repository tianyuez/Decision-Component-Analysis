load("gb.mat");
threshold = 0:0.01:1;
net_benefit= dca(y_pred, y_test, threshold);
plot(threshold, net_benefit,'LineWidth',4);
hold on;
plot(threshold, zeros(length(threshold), 1),'LineWidth',4)
hold on;
plot(threshold, -threshold+0.5,'LineWidth',4)
legend("Gradient Boosting", "None", "All")
xlabel("Probability threshold");
ylabel("Net benefit");


function net_benefit = dca(y_pred, y_true, thresholds_arr)
    net_benefit = [];
    for i = 1:length(thresholds_arr)
        thresholds = thresholds_arr(i);
        tp = sum((y_pred >= thresholds) & (y_true == 1));
        fp = sum((y_pred >= thresholds) & (y_true == 0));
        tn = sum((y_pred < thresholds) & (y_true == 0));
        fn = sum((y_pred < thresholds) & (y_true == 1));
        n = tn + fp + fn +tp;
        net_benefit = [net_benefit (tp/n)-(fp/n)*(thresholds/(1-thresholds))];
    end
end
