function out = proximal_2x2(f, STEP = 0.1)
    % ===================================================================================
    % Aplica Interpolare Proximala pe imaginea 2 x 2 f cu puncte intermediare echidistante.
    % f are valori cunoscute �n punctele (1, 1), (1, 2), (2, 1) ?i (2, 2).
    % Parametrii:
    % - f = imaginea ce se va interpola;
    % - STEP = distan?a dintre dou? puncte succesive.
    % ===================================================================================
    
    % TODO: Defineste coordonatele x si y ale punctelor intermediare.
    x_int = zeros(1/STEP + 1);
    y_int = zeros(1/STEP + 1);

    % Se afl? num?rul de puncte.
    n = length(x_int);
    for i = 1 : n
      x_int(i) = i;
      y_int(i) = i;
    endfor
    
    % TODO: Cele 4 puncte �ncadratoare vor fi aceleasi pentru toate punctele din interior.

    % TODO: Initializeaza rezultatul cu o matrice nula n x n.
    out = zeros(n, n);
  
    % Se parcurge fiecare pixel din imaginea finala.
    for i = 1 : n
        for j = 1 : n
            % TODO: Afla cel mai apropiat pixel din imaginea initiala.
            
            %coordonatele punctelor pe care trebuie sa le compar au fost definite mai sus
            %atunci vad pentru x si pentru y in parte
            
            aproxi = 2;
            aproxj = 2;
            
            if(i <= n/2)
              aproxi = 1;
            endif
            if(j <= n/2)
              aproxj = 1;
            endif
            
            out(i, j) = f(aproxi, aproxj);
            % TODO: Calculeaza pixelul din imaginea finala.
    
        endfor
    endfor

endfunction