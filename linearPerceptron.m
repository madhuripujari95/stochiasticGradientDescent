%% Initialize
clear; close all;

%% Load the data
load('data3.mat');
X = data(:,1:2);
Y = data(:,3);


%% Plot the data

PlotData_Perceptron(X,Y);


%% Compute Cost and Gradient

[m,n] = size(X);
X = [ones(m,1) X];

InitialTheta1 = ones((n+1), 1);

E = 0.01;  %% Tolerance
end_loop_condition = 140000;
Theta_old = InitialTheta1;
Theta_optimal = 0.5.*InitialTheta1;

t=0;
i=1;
iter = 1;
P=[];
T=[];
PlotMisclassified =[];

while (norm(Theta_optimal - Theta_old) > E) & (iter < 100000)
    for i = 1:m
       if (Y(i)'.*X(i,:)*Theta_optimal < 0)
            Theta_old = Theta_optimal; 
            
            %Using the Step
            Theta_optimal = Theta_optimal + (Y(i)*X(i,:))';
            
            %Multiple X and Theta_optimal to get the 
            P = X*Theta_optimal;
            T = (P.*Y);
            
            %If the Values in T is greater than zero there are properly
            %classified, so we don't need these, if it is less than zero
            %then they are misclassified.
            T(T>=0) = 0;
            T(T<0) = 1; 
            
            %Mis-Classification Percentage = Sum of misclassified points
            %divided by Length of the entire X array
            
            MisClassPer = sum(T)/length(X);
            
            %Capturing all the mis-classified points for every
            %theta_optimal to see how new thetas reduce the number of
            %mis-classified points
            PlotMisclassified = [PlotMisclassified;MisClassPer];
           
            %Count of the number of iterations it takes to reach the
            %optimal Theta value where mis classified points are zero
            t = t + 1; 
       end
    end 
    iter=iter+1;
end

g=sprintf('%d ', Theta_optimal);
fprintf('\nThe Value of optimal Theta found is: %s\n', g)
fprintf('\nNumber of Iterations required to arrive at this optimal Theta is : %i \n', t);



%% Plot the decision boundary

hold on;
if size(X, 2) <= 3
        % Only need 2 points to define a line, so choose two endpoints
        plot_x = [min(X(:,2))-2,  max(X(:,2))+2];
    
        % Calculate the decision boundary line
        plot_y = (-1./Theta_optimal(3)).*(Theta_optimal(2).*plot_x + Theta_optimal(1));
    
        % Plot, and adjust axes for better viewing
        plot(plot_x, plot_y)
        title("Decision Boundary for the Classification using Online Perceptron")

end

%% Plot the percentage misclassified for every theta optimal we calculated till we get the actual theta optimal value
figure(2)
plot(PlotMisclassified);
xlabel('Iterations')
ylabel('Percentage misclassified')
title("Percentage of mis classification for theta optimal values");

