% ---------- q2_partial.m ----------
1;
function xN = tri_partial(N, t, w0)
  xN = ones(size(t));                          % a0 = 1
  for k = 1:2:N
    xN += -(8/(pi^2*k^2))*cos(k*w0*t);
  end
end

clear; close all; clc;
w0 = 2*pi; t = linspace(-2, 2, 4001);
x2 = 4*abs(t - round(t));                      % original triangular wave
Ns = [1 5 50];

figure(3);
for i = 1:3
  xN = tri_partial(Ns(i), t, w0);
  subplot(3,1,i);
  plot(t, x2, 'k--', t, xN, 'b', 'LineWidth', 1.2); grid on;
  ylim([-0.5 2.5]); ylabel('x_2(t)');
  title(sprintf('First %d harmonic(s)', Ns(i)));
  fprintf('N = %2d : max = %.4f, min = %.4f\n', Ns(i), max(xN), min(xN));
end
xlabel('t (s)');
print -dpng q2_partial.png