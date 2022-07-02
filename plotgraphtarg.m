function plotgraphtarg(x,y,neigh,n,qtarg)
  plot(x,y,'kp','Color',[215/255 99/255 100/255],'MarkerSize',10,'LineWidth',1.5);
  grid on
  hold on;
  plot(qtarg(1),qtarg(2),'cx','MarkerSize',20,'Color',[100/255 149/255 237/255],'LineWidth',2);
  hold on;
  for i = 1:n    
      len = length(neigh{i});
      for j = 2:len
         t = neigh{i}(j);
         plot([x(i) x(t)],[y(i) y(t)],'Color',[190/255 184/255 220/255]);  
         hold on;
     end    
  end
  hold off;
end


