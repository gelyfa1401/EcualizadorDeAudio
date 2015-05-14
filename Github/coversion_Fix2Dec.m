%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b=fopen('BajosSen.txt', 'wt')
text1 = fileread('FiltroB_Sen100.txt');
for i = 1:25:5000  
    decimal1 =  PtoFijo_a_Decimal(text1(i:(i+24)), 8, 14);
    fprintf(b, '%f \n', decimal1);
end
fclose(b);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m=fopen('MediosSen.txt', 'wt');
text2 = fileread('FiltroM_Sen1k.txt');
for i = 1:25:5000  
    decimal2 =  PtoFijo_a_Decimal(text2(i:(i+24)), 8, 14);
    fprintf(m, '%f \n', decimal2);
end
fclose(m);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a=fopen('AltosSen.txt', 'wt');
text3 = fileread('FiltroA_Sen10k.txt');
for i = 1:25:5000  
    decimal3 =  PtoFijo_a_Decimal(text3(i:(i+24)), 8, 14);
    fprintf(a, '%f \n', decimal3);
end
fclose(a);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load BajosSen.txt;
load MediosSen.txt;
load AltosSen.txt;

%Tiempo = 0:2.2676e-5:100*2.2676e-5;
Tiempo = 1:200;
subplot (3,1,1), plot (Tiempo,BajosSen,'color','b');
%axis([0 0.0023 0 0.02])
%title ('Filtro experimental de frecuencias bajas con rampa')
subplot (3,1,2), plot (Tiempo,MediosSen,'color','g');
%axis([0 0.0025 -0.1 0.1])
%title ('Filtro experimental de frecuencias medias con rampa')
subplot (3,1,3), plot (Tiempo,AltosSen,'color','r');
%axis([0 0.0025 -0.05 0.05])
%title ('Filtro experimental de frecuencias altas con rampa')


 

