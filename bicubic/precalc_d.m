function [Ix, Iy, Ixy] = precalc_d(I)
    % =========================================================================
    % Prealculeaza matricile Ix, Iy si Ixy ce contin derivatele dx, dy, dxy ale 
    % imaginii I pentru fiecare pixel al acesteia.
    % =========================================================================
    
    % Obtinem dimensiunea imaginii.
    [m n nr_colors] = size(I);
    
    % TODO: Tranforma matricea I in double.
    I = double(I);
    % TODO: Calculeaza matricea cu derivate fata de x Ix.
    Ix(:,n) = 0;
    Ix(:,1) = 0;
    for i = 1:m
      for j = 2:n-1
        Ix(i,j) = fx(I, i, j);
      endfor
    endfor
    
    % TODO: Calculeaza matricea cu derivate fata de y Iy.
    Iy(m,:) = 0;
    Iy(1,:) = 0;
    for i = 2:m-1
      for j = 1:n
        Iy(i,j) = fy(I, i, j);
      endfor
    endfor
    % TODO: Calculeaza matricea cu derivate fata de xy Ixy.
    Ixy(1,:) = 0;
    Ixy(m,:) = 0;
    Ixy(:,n) = 0;
    Ixy(:,1) = 0;
    for i = 2:m-1
      for j = 2:n-1
        Ixy(i,j) = fxy(I, i, j);
      endfor
    endfor
endfunction
