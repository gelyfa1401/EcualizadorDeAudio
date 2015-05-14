b=fopen('Senoidal_AltFijo.txt', 'wt');
load Senoidal_Alt.txt
for i = 1:601;
    binario = Decimal_a_PtoFijo(Senoidal_Alt(i), 14, 23);
    fprintf(b, '%s \n', binario);
end

fclose(b);