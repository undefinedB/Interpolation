function [Q R] = QR(A)
  [m, n] = size(A);
    R = zeros(n ,n);
    Q = zeros(m ,n);

    %GS stabil numeric
    %algoritmul este prezentat in laboratorul 3, asa ca
    %doar l-am tradus in octave
    for i = 1:n
        R(i, i) = norm(A(:, i));
        Q(:, i) = A(:, i) / R(i, i);
        for j = 1:n
            R(i, j) = (Q(:, i))' * A(:, j);
            A(:, j) = A(:, j) - Q(:, i) * R(i, j);
        end
    end
    
endfunction