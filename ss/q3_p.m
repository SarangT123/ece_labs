% ---------- q3_partial.m ----------
1;
function xN = imp_partial(N, t, w0)
  xN = ones(size(t));
  for k = 1:N
    xN += 2*cos(k*w0*t);
  end
end

clear; close all; clc;
w0 = 2*pi; t = linspace(-2, 2, 40001);
Ns = [1 5 50];

figure(3);
for i = 1:3
  xN = imp_partial(Ns(i), t, w0);
  subplot(3,1,i);
  plot(t, xN, 'b', 'LineWidth', 1.0); hold on;
  stem(-2:2, ones(1,5), 'k^', 'filled');       % ideal impulses (area 1)
  grid on; ylabel('x_3(t)'); xlim([-2 2]);
  title(sprintf('First %d harmonic(s): peak = %d', Ns(i), 2*Ns(i)+1));
end
xlabel('t (s)');
print -dpng q3_partial.png