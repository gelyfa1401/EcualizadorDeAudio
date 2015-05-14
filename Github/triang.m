triangular = fopen ('FuncTriang.txt','w');
Tiempo = 0:2.2676e-5:100*2.2676e-5;

for i = 1:101
    if (i <= 50)
    y(i) = (176.5*Tiempo(i))-0.1;
    else
    y(i) = ((-176.5*Tiempo(i))+0.1)+2*y(50);
    end
    fprintf(triangular,'%i\n',y(i));
end

fclose(triangular);
load FuncTriang.txt;
plot (Tiempo, FuncTriang,'x');

