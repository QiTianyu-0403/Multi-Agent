function plotgraphtarg(x,y,neigh,n,qtarg)
  plot(x,y,'kp');
  hold on;
  %phi = 0:.1:2*pi;
  %u = Kr * cos(phi);
  %v = Kr * sin(phi);
  %plot(u + yk(1),v + yk(2),'r');%,x,y,'m>')  
  %fill(u + yk(1),v + yk(2),'r')
  %hold on;
  plot(qtarg(1),qtarg(2),'cx','MarkerSize',20);
  hold on;
  for i = 1:n    
      len = length(neigh{i});
      for j = 2:len
         t = neigh{i}(j);
         plot([x(i) x(t)],[y(i) y(t)],'y');  
         hold on;
     end    
  end
  hold off;
end


