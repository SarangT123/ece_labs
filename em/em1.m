% Line parameters
z0 = 50;
f = 1e9; %1GHz
c = 299792458;
lambda = c/f;
beta = 2*pi/lambda;
Vp = 1;
% since the line is lossless attenuation factor will be zero since alpha = Re{gamma}

d = linspace(0, 2*lambda, 1000);

% for an open circuit reflection coefficient(G) = 1
G = 1;
V = Vp*(exp(1j*beta*d) + G*exp(-1j*beta*d));
I = (Vp/z0)*(exp(1j*beta*d) - G*exp(-1j*beta*d));
Z = V./I;
figure;


subplot(3,1,1); plot(d/lambda, abs(V)); ylabel('|V|','FontSize', 25);xlabel("distance from load(d/lambda)",'FontSize', 25)
title("Open circuit V vs d/lambda",'FontSize', 30);
subplot(3,1,2); plot(d/lambda, abs(I)); ylabel('|I|','FontSize', 25);xlabel("distance from load(d/lambda)",'FontSize', 25)
title("Open circuit I vs d/lambda",'FontSize', 30);
subplot(3,1,3); plot(d/lambda, abs(Z)); ylabel('|Z|','FontSize', 25);xlabel("distance from load(d/lambda)",'FontSize', 25)
title("Open circuit Z vs d/lambda",'FontSize', 30);
ylim([0 500]);
savefig('opencircuit.fig')
% given a limit of 500 since the value of Z can tend to infinity when I is 0
%therefore scaling that high wont show the graphs properly


%now for a short circuit (G=-1)
G = -1
V = Vp*(exp(1j*beta*d) + G*exp(-1j*beta*d));
I = (Vp/z0)*(exp(1j*beta*d) - G*exp(-1j*beta*d));
Z = V./I;
figure;
subplot(3,1,1); plot(d/lambda, abs(V)); ylabel('|V|','FontSize', 25);xlabel("distance from load(d/lambda)",'FontSize', 25)
title("short circuit V vs d/lambda",'FontSize', 30);
subplot(3,1,2); plot(d/lambda, abs(I)); ylabel('|I|','FontSize', 25);xlabel("distance from load(d/lambda)",'FontSize', 25)
title("short circuit I vs d/lambda",'FontSize', 30);
subplot(3,1,3); plot(d/lambda, abs(Z)); ylabel('|Z|','FontSize', 25);xlabel("distance from load(d/lambda)",'FontSize', 25)
title("short circuit Z vs d/lambda",'FontSize', 30);
ylim([0 500]);
savefig('shortcircuit.fig')

