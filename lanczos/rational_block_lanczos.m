function [Vm, Wm] = rational_block_lanczos(A, B, C, sigma)
  [alfa m] = size(sigma);
  [n n] = size(A);
  sigma = [sigma inf];
  S0 = inv(A - sigma(1) * eye(n)) * B;
  R0 = inv((A - sigma(1) * eye(n))') * C';
  
  [Vk Hk] = QR(S0);
  [Wk Gk] = QR(R0);
  
  Vm = [Vk];
  Wm = [Wk];
  
  
  for k = 1:m
    if(k < m)
    
      if(sigma(k+1) == inf)
        Sk = A * Vk;
        Rk = A' * Wk;
      else
        Sk = inv(A - sigma(k + 1) * eye(n)) * Vk;
        Rk = inv((A - sigma(k + 1) * eye(n))') * Wk;
      endif
      
      Hk = Wm' * Sk;%Wm este intregul spatiul
      Gk = Vm' * Rk;%Vm este intregul spatiul
      %cele notate cu k sunt cele curente
      
      Sk = Sk - Vm * Hk;
      Rk = Rk - Wm * Gk;
      
      [Vk1 Hk1] = QR(Sk);%Vk1 inseamna V de k+i din algoritm etc
      [Wk1 Gk1] = QR(Rk);
      
      [Pk, Dk, Qk] = svd(Wk1' * Vk1);
      Vk1 = Vk1 * Qk * (Dk.^(1/2));
      Wk1 = Wk1 * Pk * inv(Dk.^(1/2));
      %inv merge pentru a afla Dk la -1/2 
      %pentru ca svd se aplica pe o matrice patratica
      %altfel, inv nu ar fi fost valid
      %mai mult, stiu ca Dk este o matrice diagonala
      
      Hk1 = (Dk.^(1/2)) * Qk' * Hk1;
      Gk1 = (Dk.^(1/2)) * Pk' * Gk1;
      
      Vm = [Vm Vk1];
      Wm = [Wm Wk1];
      
    else
      
      if(sigma(m+1) == inf)
        Sk = A * B;
        Rk = A' * C';
      else
        Sk = inv(A) * B;
        Rk = inv(A') * C';
      endif
      
      Hk = Wm' * Sk;
      Gk = Vm' * Rk;
        
      [Vk1 Hk1] = QR(Sk);%Vk1 inseamna V de k+i din algoritm etc
      [Wk1 Gk1] = QR(Rk);
      
      [Pk, Dk, Qk] = svd(Wk1' * Vk1);
      Vk1 = Vk1 * Qk * (Dk.^(1/2));
      Wk1 = Wk1 * Pk * inv(Dk.^(1/2));
      
      Hk1 = (Dk.^(1/2)) * Qk' * Hk1;
      Gk1 = (Dk.^(1/2)) * Pk' * Gk1;
      
      Vm = [Vm Vk1];
      Wm = [Wm Wk1];
      
    endif
    %schimb indicii pe care ii folosesc la fiecare pas
    Vk = Vk1;
    Wk = Wk1;
  endfor
  
endfunction
