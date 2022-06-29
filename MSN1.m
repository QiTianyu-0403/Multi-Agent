%clearing variables
clc,clear
close all
%declaring nodes, desired distance and other parameters
n = 50;
dim = 2;
d = 15;
k = 1.2;
r = k * d;
h = 0.2;
neigh = {};
%Optional paramters
epsilon = 0.1; 
delta_t = 0.009;
t = 0:delta_t:7;% Set simulation time
c1 = 30;
c2 = 2 * sqrt(c1);
%Randomely generating the points
x = rand(n,1).*50;
y = rand(n,1).*50;
%Calculating neighbors and plotting the graph connecting neighbors
[x,y,neigh] = compute(x,y,r,n,neigh);
plotgraph(x,y,neigh,n);
  
%Declaring variables required for movement of the nodes
old_x = x;
old_y = y;
p_nodes = zeros(n,dim);
u_nodes = zeros(n,dim);
sum1 = zeros(n,dim);
sum2 = zeros(n,dim);
%Variables for keeping track of the node parameters for each iteration
x_iter = zeros(n,length(t));
y_iter = zeros(n,length(t));
p_iter = zeros(length(t),n);
n_iter = ones(length(t),1); 
rk_iter = zeros(length(t),1);

%Loop for movement of the flock
for iter = 1:length(t)
    p_nodes(:,1) = (x - old_x)/delta_t;  %Calculating velocity of the nod�s
    p_nodes(:,2) = (y - old_y)/delta_t;
    if (iter > 1)
      p_iter(iter,:) = ((p_nodes(:,1).^2) + (p_nodes(:,2).^2)); %Saving node velocity values for each iteration  
      n_iter(iter) = iter; %saving the no: of iterations
    end  
    old_x = x;  %Saving old x and y values for the purpose of calculating velocity
    old_y = y;
    [x,y,neigh] = compute(x,y,r,n,neigh); %Computing neighbors
    [adij] = adjacent(neigh,n); %Computing the adjacency matrix (For Connectivity)
    rk_iter(iter) = rank(adij)/n; %Computing connectivity
    [adj] = fadj(x,y,neigh,r,n); 
    [grad] = GBT(x,y,r,d,neigh,n); %Computing the Gradient Base Term
    [adjterm] = CBT(p_nodes,neigh,adj,n);%Computing the Concensus Base Term
    grad = c1 * grad; 
    adjterm = c2 * adjterm;
    u_nodes = grad + adjterm; %Calculating accelaration
    x = old_x + (delta_t * p_nodes(:,1)) + (((delta_t^2)/2) * u_nodes(:,1)); %Changing the position of the nodes
    y = old_y + (delta_t * p_nodes(:,2)) + (((delta_t^2)/2) * u_nodes(:,2));
    x_iter(:,iter) = x; %Saving the position for every iteration
    y_iter(:,iter) = y;
    hold off;
    plotgraph(x,y,neigh,n); %Plotting the graph
    drawnow;
end

%Plotting the velocity
figure(2)
for i = 1:n
    plot(n_iter,p_iter(:,i));
    hold on;
end       

%Plotting the connectivity
figure(3)
plot(n_iter,rk_iter);

%Plotting the trajectory
figure(4)
for i = 1:length(t)
 if(i == length(t))
   plot(x_iter(:,i),y_iter(:,i),'m>');
 else  
   plot(x_iter(:,i),y_iter(:,i),'k.');
 end
 hold on;
end 
