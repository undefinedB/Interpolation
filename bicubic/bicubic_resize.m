function R = bicubic_resize(I, p, q)
    % =========================================================================
    % Se scaleaza imaginea folosind algoritmul de Interpolare Bicubic?.
    % Transforma imaginea I din dimensiune m x n in dimensiune p x q.
    % =========================================================================

    [m n nr_colors] = size(I);

    % TODO: Initializeaza matricea finala drept o matrice nula.

    % daca imaginea e alb negru, ignora
    if nr_colors > 1
        R = -1;
        return
    endif
    
    I = double(I);

    % Obs:
    % Atunci cand se aplica o scalare, punctul (0, 0) al imaginii nu se va deplasa.
    % In Octave, pixelii imaginilor sunt indexati de la 1 la n.
    % Daca se lucreaza in indici de la 1 la n si se inmulteste x si y cu s_x
    % respectiv s_y, atunci originea imaginii se va deplasa de la (1, 1) la (sx, sy)!
    % De aceea, trebuie lucrat cu indici in intervalul [0, n - 1]!


    % TODO: Calculeaza factorii de scalare
    % Obs: Daca se lucreaza cu indici in intervalul [0, n - 1], ultimul pixel
    % al imaginii se va deplasa de la (m - 1, n - 1) la (p, q).
    % s_x nu va fi q ./ n
    sy = (q-1)/(n-1);
    sx = (p-1)/(m-1);
     % TODO: Defineste matricea de transformare pentru redimensionare.
    T = [sx 0; 0 sy];
    % TODO: Inverseaza matricea de transformare, FARA a folosi functii predefinite!
    T(1,1) = 1/T(1,1);
    T(2,2) = 1/T(2,2);

    % TODO: Precalculeaza derivatele.
    [Ix, Iy, Ixy] = precalc_d(I);
    % Parcurge fiecare pixel din imagine.
    for y = 0 : q - 1
        for x = 0 : p - 1
            % TODO: Aplica transformarea inversa asupra (x, y) si calculeaza x_p si y_p
            % din spatiul imaginii initiale.
            vector1 = [x; y];
            rez = T * vector1;
            % TODO: Trece (xp, yp) din sistemul de coordonate 0, n - 1 in
            % sistemul de coordonate 1, n pentru a aplica interpolarea.
            rez = rez + 1;
            xp = rez(1,1);
            yp = rez(2,1);
            % TODO: Gaseste cele 4 puncte ce inconjoara punctul x, y
            xi = floor(rez(1,1));
            yi = floor(rez(2,1));
            % TODO: Calculeaza coeficientii de interpolare A.

            
            if(xi >= m) xi = xi - 1;
            endif
            if(yi >= n) yi = yi - 1;
            endif
          
          
            A = bicubic_coef(I, Ix, Iy, Ixy, yi, xi, yi+1, xi+1);
            % TODO: Trece coordonatele (xp, yp) in patratul unitate, scazand (x1, y1).
            xp = xp-xi;
            yp = yp-yi;
            % TODO: Calculeaza valoarea interpolata a pixelului (x, y).
            % Obs: Pentru scrierea in imagine, x si y sunt in coordonate de
            % la 0 la n - 1 si trebuie aduse in coordonate de la 1 la n.
            R(x+1, y+1) = [1 xp xp^2 xp^3] * A' * [1 yp yp^2 yp^3]';
        endfor
    endfor

    % TODO: Transforma matricea rezultata �n uint8 pentru a fi o imagine valida.
    R = uint8(R);
endfunction





