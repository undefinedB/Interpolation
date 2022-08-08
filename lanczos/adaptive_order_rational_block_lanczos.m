function [Am, Bm, Cm] = adaptive_order_rational_block_lanczos(A, B, C, sigma1, sigma2, tol)
  %ca la celelalte functii
  %folosesc Hk ca fiind H de la pasul curent
  %apelez functia de bloc rational cu cele doua sigma
  [n, p] = size(B);
  Hk = eye(p);
  
  err = 1;
  m = 1;
  while(err > tol)
    sigma = [sigma1 sigma2];
    [Vm Wm] = rational_block_lanczos(A, B, C, sigma);
    Am = Wm' * A * Vm;
    Bm = Wm' * B;
    Cm = C * Vm;
    [x y] = size(Am);
    Hk1 = Cm * inv((sigma1 * eye(x) - Am)) * Bm;
    err = norm(Hk - Hk1, inf);
    Hk = Hk1;
    A = Am;
    B = Bm;
    C = Cm;
    m = m+1;
  endwhile
    
endfunction
