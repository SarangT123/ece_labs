% ---------- q4c_mse.m ----------
1;
function y = sincw(w)
  y = ones(size(w));
  idx = (w ~= 0);
  y(idx) = sin(w(idx)/2)./(w(idx)/2);
end
function xr = recon(K, dw, t)
  w  = (1:K)*dw;
  Xk = sincw(w);
  xr = (dw/(2*pi))*(1 + 2*(cos(t(:)*w)*Xk(:)));
  xr = xr.';
end

clear; close all; clc;
dw = 0.1;
t  = linspace(-2, 2, 2001);
x4 = double(abs(t) < 0.5);

Ks  = unique(round(logspace(0, 3.3, 30)));     % 1 ... about 2000
mse = zeros(size(Ks));
for i = 1:numel(Ks)
  mse(i) = mean((x4 - recon(Ks(i), dw, t)).^2);
end
Npts = 2*Ks + 1;

figure(3);
loglog(Npts, mse, 'bo-', 'LineWidth', 1.2); hold on;
loglog(Npts, 1./(2*pi*Ks*dw), 'r--', 'LineWidth', 1.0);   % approximate theory
grid on; xlabel('Number of frequency points N'); ylabel('MSE');
legend('Simulated', 'Approx. 1/(2\pi W)');
title('MSE vs number of frequency-domain points');
print -dpng q4c_mse.png