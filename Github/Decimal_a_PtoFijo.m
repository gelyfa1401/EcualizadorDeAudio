function f = Decimal2FixedPoint(x, nfracbits, nbits)

error(nargchk(2, 3, nargin));
x = x(:);
maxx = max(abs(x));
nbits_min = max([nextpow2(maxx + (any(x == maxx))) + 1 + nfracbits, ...
    nfracbits]);

if nargin < 3
    nbits = nbits_min;
elseif nbits < nbits_min
      warning('dec2twos:nbitsMuyPequeño', ['El numero minimo de bits a ' ...
        'representar con la entrada maxima x es %i, el cual es mas grande que ' ...
        'entrada de nbits = %i. Poner nbits a = %i.'], ...
        nbits_min, nbits, nbits_min)
    nbits = nbits_min;
end

f = dec2twos(round(x * 2.^nfracbits), nbits);
