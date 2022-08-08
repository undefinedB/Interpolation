function [SpV SpW] = nonsymmetric_Lanczos(A, V, W, m)
  %Vs si Ws sunt V si W cu sedila din pseudocod, mereu le schimb
  %algoritmul returneaza cele doua spatii
  
  [delta beta] = QR(W' * V);
  Vj = V * inv(beta);
  Wj = W * delta;
  Vs = A * Vj;
  Ws = A' * Wj;

  for j = 1:m
    alfa_j = Wj' * Vs;
    Vs = Vs - Vj * alfa_j;
    Ws = Ws - Wj * alfa_j';
    [Vj1 beta] = QR(Vs);
    [Wj1 delta_transpus] = QR(Ws);
    
    [U, S, Z] = svd(Wj1' * Vj1);
    delta_transpus = (S.^(1/2))' * U' *  delta_transpus;
    beta = (S.^(1/2)) * Z' * beta;
    Vj1 = Vj1 * Z * inv(S.^(1/2));
    Wj1 = Wj1 * U * inv(S.^(1/2));
    Vs = A * Vj1 - Vj * delta_transpus';
    Ws = A' * Wj1 - Wj * beta';
    SpV(:, :, j) = Vj;
    SpW(:, :, j) = Wj;
    Wj = Wj1;
    Vj = Vj1;
  endfor
  
endfunction
