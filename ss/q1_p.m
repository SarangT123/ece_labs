% ---------- q1_partial.m ----------
1;
function xN = sq_partial(N, t, w0)
  xN = zeros(size(t));
  for k = 1:2:N                      % only odd harmonics are non-zero
    xN += (4/(k*pi))*sin(k*w0*t);
  end
end

clear; close all; clc;
w0 = 2*pi; t = linspace(-2, 2, 4001);
x1 = sign(sin(w0*t));                % original square wave
Ns = [1 5 50];

figure(3);
for i = 1:3
  xN = sq_partial(Ns(i), t, w0);
  subplot(3,1,i);
  plot(t, x1, 'k--', t, xN, 'b', 'LineWidth', 1.2); grid on;
  ylim([-1.5 1.5]); ylabel('x_1(t)');
  title(sprintf('First %d harmonic(s)', Ns(i)));
  fprintf('N = %2d : max of partial sum = %.4f\n', Ns(i), max(xN));
end
xlabel('t (s)');
print -dpng q1_partial.png