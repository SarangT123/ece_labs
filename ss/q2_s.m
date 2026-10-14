% ---------- q2_spectra.m ----------
clear; close all; clc;
w0 = 2*pi; N = 15; n = -N:N;
odd = mod(abs(n),2) == 1;
cn = zeros(size(n));
cn(odd)  = -4./(pi^2*n(odd).^2);
cn(n==0) = 1;

figure(1);
subplot(2,1,1); stem(n*w0, abs(cn), 'filled'); grid on;
xlabel('\omega (rad/s)'); ylabel('|c_n|'); title('x_2(t): magnitude spectrum');
subplot(2,1,2); stem(n*w0, angle(cn).*(abs(cn)>0), 'filled'); grid on;
xlabel('\omega (rad/s)'); ylabel('\angle c_n (rad)'); title('x_2(t): phase spectrum');
print -dpng q2_exp_spectra.png

nn = 0:N; an = zeros(size(nn));
an(1) = 1;                                   % a0
k = nn(2:end); an(2:end) = -8./(pi^2*k.^2).*(mod(k,2)==1);
figure(2); stem(nn*w0, an, 'filled'); grid on;
xlabel('\omega (rad/s)'); ylabel('a_n');
title('x_2(t): trigonometric spectrum (b_n = 0)');
print -dpng q2_trig_spectra.png