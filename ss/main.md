---
title: "EC2001E – Signals and Systems: Simulation 01"
author: "YourName – RollNumber"
date: "October 2026"
geometry: margin=2.5cm
header-includes:
  - \usepackage{amsmath,amssymb}
---

# Common notes

* Software: GNU Octave. All scripts are self-contained; save each one as a `.m` file and run it.
* All three periodic signals in Figures 1–3 have period $T = 1$ s, so $\omega_0 = 2\pi/T = 2\pi$ rad/s.
* Fourier series definitions used:
$$x(t)=\sum_{n=-\infty}^{\infty} c_n e^{jn\omega_0 t},\qquad c_n=\frac1T\int_T x(t)e^{-jn\omega_0 t}\,dt$$
$$x(t)=a_0+\sum_{n=1}^{\infty}a_n\cos(n\omega_0 t)+\sum_{n=1}^{\infty}b_n\sin(n\omega_0 t)$$
$$a_0=\frac1T\int_T x\,dt,\quad a_n=\frac2T\int_T x\cos(n\omega_0 t)\,dt,\quad b_n=\frac2T\int_T x\sin(n\omega_0 t)\,dt$$
* Relations: $c_0=a_0$, $c_n=\dfrac{a_n-jb_n}{2}$, $c_{-n}=c_n^*$ (for real $x$), $|c_n|=\tfrac12\sqrt{a_n^2+b_n^2}$.
* "First $N$ harmonics" means the partial sum over $n=1,\dots,N$ (harmonics whose coefficient is zero simply contribute nothing).

---

# Question 1 – Square wave $x_1(t)$

From Fig. 1: $x_1(t)=+1$ for $0<t<0.5$ and $-1$ for $0.5<t<1$ (period 1). It is an **odd** function, so $a_0=0,\ a_n=0$.

## 1(a) Fourier series

**Exponential coefficients**

$$c_n=\int_0^{0.5}e^{-j2\pi nt}dt-\int_{0.5}^{1}e^{-j2\pi nt}dt
=\frac{1-e^{-j\pi n}}{j2\pi n}-\frac{e^{-j\pi n}-e^{-j2\pi n}}{j2\pi n}
=\frac{1-(-1)^n}{j\pi n}$$

$$c_n=\begin{cases}\dfrac{2}{j\pi n}=-j\dfrac{2}{\pi n}, & n \text{ odd}\\[2mm] 0,& n\text{ even (incl. } n=0)\end{cases}$$

**(i) Exponential series**
$$x_1(t)=\sum_{\substack{n=-\infty\\ n\ \text{odd}}}^{\infty}\frac{2}{j\pi n}\,e^{j2\pi nt}$$

**(ii) Trigonometric series.** $a_0=0$, $a_n=0$, and $b_n=j(c_n-c_{-n})=-2\,\mathrm{Im}\{c_n\}$:
$$b_n=\frac{4}{\pi n}\ (n\text{ odd}),\qquad b_n=0\ (n\text{ even})$$
$$x_1(t)=\frac{4}{\pi}\sum_{n=1,3,5,\dots}^{\infty}\frac{1}{n}\sin(2\pi nt)=\frac4\pi\left[\sin 2\pi t+\frac13\sin 6\pi t+\frac15\sin 10\pi t+\cdots\right]$$

**Line spectra.** Magnitude: $|c_n|=\dfrac{2}{\pi|n|}$ for odd $n$ (decays as $1/n$). Phase: $\angle c_n=-\pi/2$ for $n>0$ and $+\pi/2$ for $n<0$ (odd $n$ only). Only odd harmonics are present.

```octave
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
xlabel('\omega (rad/s)'); ylabel('b_n'); title('x_1(t): trigonometric spectrum (a_n = 0)');
print -dpng q1_trig_spectra.png
```

## 1(b) Partial sums

$$x_1^{(N)}(t)=\frac4\pi\sum_{\substack{n=1\\ n\ \text{odd}}}^{N}\frac1n\sin(2\pi nt)$$

```octave
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
```

**Interpretation**

* $N=1$: a single sine of amplitude $4/\pi\approx1.27$ – only a rough sinusoidal approximation of the square wave (fundamental frequency, correct zero crossings and sign).
* $N=5$ (harmonics 1, 3, 5): the shape is clearly square-like, with ripples and overshoot near the jumps.
* $N=50$ (25 non-zero harmonics): flat tops are nearly flat, edges are very steep; ripples are compressed towards the discontinuities, but the overshoot **height does not shrink** (about 1.18).
* Adding harmonics improves the approximation in the mean-square sense, but near jumps convergence is non-uniform.

## 1(c) Gibbs phenomenon

Where a signal has a jump discontinuity, the partial sum overshoots the true value on each side of the jump. As $N$ increases:

* the ripple frequency increases and the width of the overshoot lobe shrinks as $\sim 1/N$,
* but the **peak overshoot tends to a constant ≈ 8.95 % of the jump height** (it does not vanish).

For $x_1$ the jump is 2, so the maximum of the partial sum is $\approx 1+0.0895\times2\approx1.18$ (the printed `max` values should approach this). At the jump itself the series converges to the midpoint (0). The Gibbs overshoot arises because the truncated series equals $x_1$ convolved with a Dirichlet kernel (a sinc-like function with side lobes). It can be reduced (but not eliminated at the jump) by windowing the coefficients, e.g. Fejér ($\sigma$-approximation) or Hamming/Lanczos windows. The mean-square error does go to zero, since $x_1$ has finite energy per period.

---

# Question 2 – Triangular wave $x_2(t)$

From Fig. 2: $x_2(t)=4|t|$ for $|t|\le 0.5$, repeated with period 1 (values 0 to 2, minima at integer $t$). It is **even**, so $b_n=0$.

## 2(a) Fourier series

$$a_0=\frac1T\int_{-0.5}^{0.5}4|t|\,dt=2\cdot4\cdot\frac{(0.5)^2}{2}=1$$

$$a_n=2\int_{-0.5}^{0.5}4|t|\cos(2\pi nt)\,dt=16\int_0^{0.5}t\cos(2\pi nt)\,dt$$

Using $\int t\cos(at)\,dt=\dfrac{t\sin at}{a}+\dfrac{\cos at}{a^2}$ with $a=2\pi n$:

$$a_n=16\cdot\frac{(-1)^n-1}{4\pi^2n^2}=\frac{4\left[(-1)^n-1\right]}{\pi^2n^2}
=\begin{cases}-\dfrac{8}{\pi^2n^2},& n\text{ odd}\\ 0,& n\text{ even}\end{cases}$$

**(i) Exponential series**: $c_0=1$, $c_n=a_n/2=-\dfrac{4}{\pi^2n^2}$ for odd $n$ (real, both signs of $n$), zero for even $n\neq0$:
$$x_2(t)=1-\frac{4}{\pi^2}\sum_{\substack{n=-\infty\\ n\ \text{odd}}}^{\infty}\frac{1}{n^2}e^{j2\pi nt}$$

**(ii) Trigonometric series**
$$x_2(t)=1-\frac{8}{\pi^2}\sum_{n=1,3,5,\dots}^{\infty}\frac{1}{n^2}\cos(2\pi nt)$$

Check at $t=0$: $1-\frac{8}{\pi^2}\cdot\frac{\pi^2}{8}=0$ ✓.

**Line spectra.** $|c_0|=1$, $|c_n|=\dfrac{4}{\pi^2n^2}$ (odd $n$). Phase: $0$ at $n=0$, $\pm\pi$ (i.e. $\pi$) at odd $n$ because $c_n<0$.

```octave
% ---------- q2_spectra.m ----------
clear; close all; clc;
w0 = 2*pi; N = 15; n = -N:N;
odd = mod(abs(n),2) == 1;
cn = zeros(size(n));
cn(odd)   = -4./(pi^2*n(odd).^2);
cn(n==0)  = 1;

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
xlabel('\omega (rad/s)'); ylabel('a_n'); title('x_2(t): trigonometric spectrum (b_n = 0)');
print -dpng q2_trig_spectra.png
```

## 2(b) Partial sums

```octave
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
x2 = 4*abs(t - round(t));                       % original triangular wave
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
```

**Interpretation**

* $N=1$: $1-\frac8{\pi^2}\cos2\pi t$ already resembles the triangle (dc level 1, correct peaks near 1.81 instead of 2).
* $N=5$: practically indistinguishable from the triangle except slight rounding at the corners.
* $N=50$: essentially exact. Convergence is much faster than for the square wave because $|c_n|\propto1/n^2$.

## 2(c) Gibbs phenomenon

$x_2(t)$ is **continuous** (only its derivative has jumps), so there is **no Gibbs overshoot** – the partial sums converge uniformly to $x_2(t)$ and the ≈ 9 % overshoot seen for $x_1$ is absent. The coefficients decay as $1/n^2$ (a signal with continuous value but discontinuous slope), versus $1/n$ for a signal with jumps. The only visible effect is a small rounding of the sharp corners that vanishes as $N$ grows. This confirms that Gibbs ringing is tied to jump discontinuities (the more abrupt the signal, the slower the spectral decay).

---

# Question 3 – Impulse train $x_3(t)$

From Fig. 3: $x_3(t)=\sum_{k=-\infty}^{\infty}\delta(t-k)$ (unit-area impulses at integers, $T=1$). It is even, so $b_n=0$.

## 3(a) Fourier series

$$c_n=\frac1T\int_{-0.5}^{0.5}\delta(t)e^{-jn\omega_0t}dt=1\quad\text{for all }n$$

**(i) Exponential series**
$$x_3(t)=\sum_{n=-\infty}^{\infty}e^{j2\pi nt}$$

**(ii) Trigonometric series**: $a_0=1$, $a_n=2c_n=2$, $b_n=0$:
$$x_3(t)=1+2\sum_{n=1}^{\infty}\cos(2\pi nt)$$

**Line spectra.** $|c_n|=1$ for all $n$ (flat, infinite bandwidth), $\angle c_n=0$.

```octave
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
xlabel('\omega (rad/s)'); ylabel('a_n'); title('x_3(t): trigonometric spectrum (b_n = 0)');
print -dpng q3_trig_spectra.png
```

## 3(b) Partial sums

$$x_3^{(N)}(t)=1+2\sum_{n=1}^{N}\cos(2\pi nt)=\sum_{n=-N}^{N}e^{j2\pi nt}=\frac{\sin\big((2N+1)\pi t\big)}{\sin(\pi t)}$$
(the Dirichlet kernel). Its peak at $t=k$ is $2N+1$ (3, 11, 101 for $N=1,5,50$) and its main-lobe width is $\approx 2/(2N+1)$, while the area per period stays 1.

```octave
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
  stem(-2:2, ones(1,5), 'k^', 'filled');   % ideal impulses (area 1)
  grid on; ylabel('x_3(t)');
  title(sprintf('First %d harmonic(s): peak = %d', Ns(i), 2*Ns(i)+1));
  xlim([-2 2]);
end
xlabel('t (s)');
print -dpng q3_partial.png
```

**Interpretation**

* $N=1$: a raised cosine $1+2\cos2\pi t$ with broad peaks.
* $N=5$: peaks become narrower and taller (height 11) with small ripples between them.
* $N=50$: very narrow, tall peaks (height 101) with fast oscillating side lobes of low amplitude between them – approaching the ideal train of impulses at $t=0,\pm1,\pm2$.
* The partial sums never converge pointwise (peak height $\to\infty$) – they converge only in the distribution sense, $\int x^{(N)}\phi\,dt\to\int x_3\phi\,dt$ for smooth $\phi$.

## 3(c) Note on Gibbs phenomenon

An impulse train is an extreme case: the "jump" is infinite, so the Gibbs overshoot of a finite jump (≈ 9 %) is not defined. The ringing seen in the plots is the side-lobe structure of the Dirichlet kernel; amplitude of the peak grows as $2N+1$ and the lobes narrow as $1/N$, so energy concentrates at the impulse locations. Since $|c_n|=1$ does not decay, the series does not converge in the ordinary sense. Applying Fejér averaging (Cesàro sums) replaces the Dirichlet kernel with the non-negative Fejér kernel and removes the negative side lobes (ringing).

---

# Question 4 – Rectangular pulse $x_4(t)=\mathrm{rect}(t)$

$\mathrm{rect}(t)=1$ for $|t|<0.5$, else 0.

## 4(a) Fourier transform

$$X_4(\omega)=\int_{-1/2}^{1/2}e^{-j\omega t}dt=\frac{e^{-j\omega/2}-e^{j\omega/2}}{-j\omega}=\frac{2\sin(\omega/2)}{\omega}=\frac{\sin(\omega/2)}{\omega/2}=\mathrm{sinc}\!\left(\frac{\omega}{2\pi}\right)$$

where $\mathrm{sinc}(x)=\sin(\pi x)/(\pi x)$. $X_4(\omega)$ is real and even, with $X_4(0)=1$ and zeros at $\omega=\pm2\pi,\pm4\pi,\dots$

* Magnitude: $|X_4(\omega)|=\left|\dfrac{\sin(\omega/2)}{\omega/2}\right|$.
* Phase: $0$ where $X_4>0$ and $\pm\pi$ where $X_4<0$ (the sign alternates in each lobe).

```octave
% ---------- q4a_spectrum.m ----------
1;
function y = sincw(w)                 % sin(w/2)/(w/2) with value 1 at w = 0
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
```

## 4(b) Approximation of $x_4(t)$ from $X_4(\omega)$

Using the inverse Fourier transform with the spectrum sampled at $\omega_k=k\,\Delta\omega$, $k=-K,\dots,K$ ($N=2K+1$ frequency points, spacing $\Delta\omega=0.1$ rad/s, bandwidth $W=K\Delta\omega$):

$$\tilde x_4(t)=\frac{1}{2\pi}\int_{-W}^{W}X_4(\omega)e^{j\omega t}\,d\omega\;\approx\;\frac{\Delta\omega}{2\pi}\sum_{k=-K}^{K}X_4(k\Delta\omega)e^{jk\Delta\omega t}
=\frac{\Delta\omega}{2\pi}\Big[X_4(0)+2\sum_{k=1}^{K}X_4(k\Delta\omega)\cos(k\Delta\omega t)\Big]$$

(the last form follows since $X_4$ is real and even).

```octave
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

Ks = [10 50 200 1000];                   % N = 2K+1 points, W = K*dw = 1, 5, 20, 100 rad/s
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
```

**Observations.** With few frequency points the reconstruction is a smooth bump that only roughly resembles the pulse. As $N$ (bandwidth) increases, the edges at $t=\pm0.5$ become steeper, the top becomes flatter, and the ripple moves closer to the edges. The overshoot near the edges stays at ≈ 9 % ($\max\tilde x_4\approx1.09$) – this is Gibbs again, as the pulse has jump discontinuities.

## 4(c) Mean-square error vs. number of frequency points

$$\mathrm{MSE}=\frac{1}{M}\sum_{m=1}^{M}\big[x_4(t_m)-\tilde x_4(t_m)\big]^2$$

Theory: the energy in the discarded band is $\dfrac1{2\pi}\int_{|\omega|>W}|X_4|^2d\omega\approx\dfrac{2}{\pi W}$, so over a window of length 4 s
$$\mathrm{MSE}\approx\frac{1}{2\pi W}=\frac{1}{2\pi K\Delta\omega}\ \propto\ \frac1N$$

```octave
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

Ks  = unique(round(logspace(0, 3.3, 30)));      % 1 ... ~2000
mse = zeros(size(Ks));
for i = 1:numel(Ks)
  mse(i) = mean((x4 - recon(Ks(i), dw, t)).^2);
end
Npts = 2*Ks + 1;

figure(3);
loglog(Npts, mse, 'bo-', 'LineWidth', 1.2); hold on;
loglog(Npts, 1./(2*pi*Ks*dw), 'r--', 'LineWidth', 1.0);   % approximate theory
grid on; xlabel('Number of frequency points N'); ylabel('MSE');
legend('Simulated', 'Approx. 1/(2\pi W)'); title('MSE vs number of frequency-domain points');
print -dpng q4c_mse.png
```

**Inferences**

* MSE decreases monotonically as more frequency points (larger bandwidth) are used; on the log-log plot it is close to a straight line of slope $-1$, i.e. $\mathrm{MSE}\propto1/N$.
* The error does not reach exactly zero for any finite $N$ because the rectangular pulse is not band-limited (its spectrum has infinitely many sidelobes decaying as $1/\omega$).
* Even though MSE $\to0$, the peak error near the discontinuities does not go to zero (Gibbs). The error energy is concentrated in ever-narrower regions around $t=\pm0.5$ – so MSE is not sensitive to the persistent 9 % overshoot.
* Practical consequence: a good rectangular-pulse approximation needs high bandwidth; a smoother pulse (e.g. a triangle, with a $1/\omega^2$ spectrum) would need far fewer frequency points for the same MSE.

---

# Conclusions

| Signal | Smoothness | Coefficient decay | Gibbs? |
|---|---|---|---|
| Square wave $x_1$ | jumps | $1/n$ | Yes, ≈ 9 % overshoot of the jump |
| Triangular wave $x_2$ | continuous | $1/n^2$ | No |
| Impulse train $x_3$ | impulses | constant ($c_n=1$) | Not applicable, series does not converge pointwise |
| Rect pulse $x_4$ (FT) | jumps | $1/\omega$ | Yes, MSE falls as $1/N$ |

The faster the spectrum decays, the smoother the signal and the fewer harmonics are needed for a good approximation.

---

*To build the PDF (images from the scripts are saved as PNGs; insert them with* `![caption](file.png)` *under each part):*

```
pandoc Simulation01_Solutions.md -o YourName_RollNumber.pdf --pdf-engine=xelatex
```