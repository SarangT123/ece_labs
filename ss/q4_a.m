% ---------- q4b_approx.m ----------
1;
function y = sincw(w)
  y = ones(size(w));
  idx = (w ~= 0);
  y(idx) = sin(w(idx)/2)./(w(idx)/2);
end
function xr = recon(K, dw, t)
  w  = (1:K)*dw;                         % positive frequencies
  Xk = sincw(w);
  xr = (dw/(2*pi))*(1 + 2*(cos(t(:)*w)*Xk(:)));   % X(0) = 1
  xr = xr.';
end

clear; close all; clc;
dw = 0.1;
t  = linspace(-2, 2, 2001);
x4 = double(abs(t) < 0.5);

Ks = [10 50 200 1000];        % N = 2K+1 points, W = K*dw = 1, 5, 20, 100 rad/s
figure(2);
for i = 1:4
  xr = recon(Ks(i), dw, t);
  subplot(2,2,i);
  plot(t, x4, 'k--', t, xr, 'b', 'LineWidth', 1.2); grid on;
  ylim([-0.3 1.4]); xlabel('t (s)');
  title(sprintf('N = %d points (W = %g rad/s)', 2*Ks(i)+1, Ks(i)*dw));
  fprintf('K = %4d: max(x~) = %.4f\n', Ks(i), max(xr));
end
print -dpng q4b_approx.png