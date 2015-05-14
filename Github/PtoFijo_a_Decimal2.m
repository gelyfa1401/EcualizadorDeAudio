function dec = pfijo2dec(binario,N,decim)
if binario(1)=='1';
    dec2=-1;
    for n = length(binario):-1:2
       if binario(n)=='1';
        for l = (n-1):-1:1;
         if binario(l)=='0';
            binario(l)=dec2binario(1);
          elseif binario(l)=='1';
            binario(l)=dec2binario(0);
          end
         end
       break
     end
  end
else
    dec2=1;
end

for m = 1:N
    binario1(m)=binario(m+1);
end
k=N;
for s = 1:decim
    binario2(s)=binario(k+2);
    k=k+1;
end
dec1=0;
for p = 1:decim
    dec1=dec1+(binario2dec(binario2(p))/(2^p));
end
dec3=binario2dec(binario1);
dec=(dec1+dec3)*dec2;

end