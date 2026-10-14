% ---------- q1_spectra.m ----------
clear; close all; clc;
T = 1; w0 = 2*pi/T;
N = 15; n = -N:N;
odd = mod(abs(n),2) == 1;
cn = zeros(size(n));
cn(odd) = 2./(1j*pi*n(odd));

figure(1);
subplot(2,1,1); stem(n*w0, abs(cn), 'filled'); grid on;
xlabel('\omega (rad/s)'); ylabel('|c_n|'); title('x_1(t): magnitude spectrum');
subplot(2,1,2); stem(n*w0, angle(cn).*odd, 'filled'); grid on;
xlabel('\omega (rad/s)'); ylabel('\angle c_n (rad)'); title('x_1(t): phase spectrum');
print -dpng q1_exp_spectra.png

% trigonometric line spectrum
nn = 1:N; bn = (4./(nn*pi)).*(mod(nn,2)==1);
figure(2); stem(nn*w0, bn, 'filled'); grid on;
xlabel('\omega (rad/s)'); ylabel('b_n');
title('x_1(t): trigonometric spectrum (a_n = 0)');
print -dpng q1_trig_spectra.png