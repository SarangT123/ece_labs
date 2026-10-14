% ---------- q4a_spectrum.m ----------
1;
function y = sincw(w)                 % sin(w/2)/(w/2), equal to 1 at w = 0
  y = ones(size(w));
  idx = (w ~= 0);
  y(idx) = sin(w(idx)/2)./(w(idx)/2);
end

clear; close all; clc;
w = linspace(-40, 40, 8001);
X = sincw(w);

figure(1);
subplot(2,1,1); plot(w, abs(X), 'b', 'LineWidth', 1.2); grid on;
xlabel('\omega (rad/s)'); ylabel('|X_4(\omega)|'); title('Magnitude spectrum of rect(t)');
subplot(2,1,2); plot(w, pi*(X<0), 'r', 'LineWidth', 1.2); grid on;
xlabel('\omega (rad/s)'); ylabel('\angle X_4(\omega) (rad)'); title('Phase spectrum of rect(t)');
ylim([-0.5 3.7]);
print -dpng q4a_spectra.png