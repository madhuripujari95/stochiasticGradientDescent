function PlotData_Perceptron(X,Y)

postive = find(Y == 1);
negative = find(Y == -1);

x1 = X(postive,1);
x2 = X(postive,2);

x3 = X(negative,1);
x4 = X(negative,2);

plot(x1, x2, 'rx');
hold on;


plot(x3, x4, 'bo');
xlabel("X1");
ylabel("X2");

end

