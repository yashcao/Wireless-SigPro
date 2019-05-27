clear; clc;
t = -2:0.01:2;
n = [7;9];

y1 = sin(n(1)*pi*t)./sin(pi*t);
y2 = sin(n(2)*pi*t)./sin(pi*t);


y1(201)=n(1);
y2(201)=n(2);

% subplot(2, 1, 1);
plot(t, y1, '--b', 'linewidth', 1);
hold on;
plot(t, y2, '-r', 'linewidth', 1);

grid on;
title('$\frac{\sin(\pi n t )}{\sin(\pi t)}$', 'Interpreter', 'Latex', 'fontsize', 18);
xlabel('$t$','Interpreter','LaTex', 'fontsize', 15);
ylabel('$y$','Interpreter','LaTex', 'fontsize', 15);
l = legend('$n=7$', '$n=9$');
set(l,'Interpreter','latex', 'fontsize', 12);


% y1 = sin(n*pi*(t-0.5))./sin(pi*(t-0.5));
% subplot(2, 1, 2);
% plot(t, y1);
% grid on;
% title('$\frac{\sin(\pi n (t-0.5) )}{\sin(\pi (t-0.5))}$', 'Interpreter', 'Latex');
% xlabel('$t$','Interpreter','LaTex');
% ylabel('$y$','Interpreter','LaTex');
