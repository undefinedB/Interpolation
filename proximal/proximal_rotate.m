function R = proximal_rotate(I, rotation_angle)
    % =========================================================================
    % Roteste imaginea alb-negru I de dimensiune m x n cu unghiul rotation_angle,
    % aplic�nd Interpolare Proximala.
    % rotation_angle este exprimat �n radiani.
    % =========================================================================
    [m n nr_colors] = size(I);
    
    % Se converteste imaginea de intrare la alb-negru, daca este cazul.
    if nr_colors > 1
        R = -1;
        return
    endif

    % Obs:
    % Atunci c�nd se aplica o scalare, punctul (0, 0) al imaginii nu se va deplasa.
    % �n Octave, pixelii imaginilor sunt indexati de la 1 la n.
    % Daca se lucreaza �n indici de la 1 la n si se inmultesc x si y cu s_x respectiv s_y,
    % atunci originea imaginii se va deplasa de la (1, 1) la (sx, sy)!
    % De aceea, trebuie lucrat cu indici �n intervalul [0, n - 1].

    % TODO: Calculeaza cosinus si sinus de rotation_angle.
    c = cos(rotation_angle);
    s = sin(rotation_angle);
    % TODO: Initializeaza matricea finala.
    R = zeros(size(I));
    % TODO: Calculeaza matricea de transformare.
    T = [c -s;s c]; 
    % TODO: Inverseaza matricea de transformare, FOLOSIND doar functii predefinite!
    T = inv(T);
    % Se parcurge fiecare pixel din imagine.
    for x = 0 : n - 1
        for y = 0 : m - 1
            % TODO: Aplica transformarea inversa asupra (x, y) si calculeaza x_p si y_p
            % din spatiul imaginii initiale.
            rez = T * [x; y];
            % TODO: Trece (xp, yp) din sistemul de coordonate [0, n - 1] �n
            % sistemul de coordonate [1, n] pentru a aplica interpolarea.

            xi = rez(1, 1);
            yi = rez(2, 1);
            % TODO: Daca xp sau yp se afla �n exteriorul imaginii,
            % se pune un pixel negru si se trece mai departe.
            
            if(xi > n-1 || yi > m-1 || xi < 0 || yi < 0)            
              R(y+1, x+1) = 0;
              continue;
            endif
            xi = xi + 1;
            yi = yi + 1;
            
            % TODO: Afla punctele ce �nconjoara(xp, yp).

            x1 = floor(xi);
            x2 = x1+1;
            y1 = floor(yi);
            y2 = y1+1;
            % TODO: Calculeaza coeficientii de interpolare notati cu a
            % Obs: Se poate folosi o functie auxiliara �n care sau se calculeze coeficientii,
            % conform formulei.
            
            a = proximal_coef(I, y1, x1, y2, x2);

            % TODO: Calculeaza valoarea interpolata a pixelului (x, y).
            R(y+1, x+1) = a(1,1) + a(2,1)*yi + a(3,1) * xi + a(4,1)*xi*yi;
        
        endfor
    endfor

    % TODO: Transforma matricea rezultata �n uint8 pentru a fi o imagine valida.
    R=uint8(R);
endfunction
