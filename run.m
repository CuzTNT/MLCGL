X = 1:30;
 plot(X,NormalCalteh,'-*b',X,NormalCoil,'-or',X,NormalMSRC,'-+y', X,NormalProkaryotic,'-^c', X,NormalUCI,'-dk'); 
 %%
 X = 1:4;
  plot(X,Obj,'-hb','MarkerFaceColor','b', 'LineWidth' ,1.2);
  xlabel('Number of Iterations')  %x����������
ylabel('Objective Function Value') %y����������