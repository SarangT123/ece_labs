% ---------- q3_spectra.m ----------
clear; close all; clc;
w0 = 2*pi; N = 15; n = -N:N;
cn = ones(size(n));

figure(1);
subplot(2,1,1); stem(n*w0, abs(cn), 'filled'); grid on; ylim([0 1.5]);
xlabel('\omega (rad/s)'); ylabel('|c_n|'); title('x_3(t): magnitude spectrum');
subplot(2,1,2); stem(n*w0, angle(cn), 'filled'); grid on; ylim([-1 1]);
xlabel('\omega (rad/s)'); ylabel('\angle c_n (rad)'); title('x_3(t): phase spectrum');
print -dpng q3_exp_spectra.png

nn = 0:N; an = [1, 2*ones(1,N)];
figure(2); stem(nn*w0, an, 'filled'); grid on;
xlabel('\omega (rad/s)'); ylabel('a_n');
title('x_3(t): trigonometric spectrum (b_n = 0)');
print -dpng q3_trig_spectra.png