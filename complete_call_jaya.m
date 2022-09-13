%constrained optimization problem 
%%Jaya algorithm
format short
clear all
clc

%Initialize the parameters
N=100; %Population size
D=7; %Dimension
lb=[100, 50, 50, 50, 100, 50, 100];%[0.0625 0.0625 10 10];
ub=[575, 100, 140, 100, 550, 100, 410];%[99*0.0625 99*0.0625 200 200];
itermax=500;  %Max. Iteration


%Generating initial population

for i=1:N
    for j=1:D
        pos(i,j)=lb(j)+rand.*(ub(j)-lb(j));
    end
end

%Evalulate objective function 
fx=fun_jaya(pos);

for iter=1:itermax   %Main iteration loop start of the Jaya algorithm
    %Finding the Xbest position 
    [fmin,minind]=min(fx);
    Xbest=pos(minind,:);
    
    %Finding the Xworst position
    [fmax,maxind]=max(fx);
    Xworst=pos(maxind,:);
    
    %Start loop for the each iteration 
    for i=1:N
        X=pos(i,:);
        Xnew=X+rand.*(Xbest-abs(X))-rand.*(Xworst-abs(X));
        %checking the bounds
        Xnew=max(Xnew,lb);  %Preserve lower bounds
        Xnew=min(Xnew,ub);  %Preserve upper bounds
        fnew=fun_jaya(Xnew); 
        
        %Greedy selection
        
        if fnew<fx(i)
            pos(i,:)=Xnew;  %Update position paticle
            fx(i,:)=fnew;  %Update function value
        end
    end
    
    %Memorize the best particle 
    [optval,optind]=min(fx);
    BestFx(iter)=optval;
    BestX(iter,:)=pos(optind,:); 
    
    %Show iteration information
    disp(['no. of iteration' num2str(iter)...
        ' : Best cost :' num2str(BestFx(iter))])
    
    %PLotting the result
    plot(BestFx,'LineWidth',2);
    xlabel('Iteration Number');
    ylabel('Fitness value');
    title('Convergence vs Iteration');
    grid on
    
end
