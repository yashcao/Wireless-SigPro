% mmWave BeamSpace MIMO channel
clear;close all;clc;

% parameters settings
N = 64;   % TX antenna nums
K = 16;   % user nums
L = 2;    % NLOS path nums
%SNR = 30; % SNR in dB
var = [1, 0.1, 0.1]; % channel attenuation

% original channel matrix
H = zeros(N, K);

% set Only LOS components
%L = 0;

for k=1:K
    % random distribution of channel parameters
    theta = rand(1, L+1)-0.5;
    beta = sqrt(var/2).*(randn(1, L+1) +1i*randn(1, L+1));
    % array steering vector
    a = exp(-2*1i*pi*theta'*((0:N-1)-(N-1)/2))';
    
    h_k = zeros(N, 1);
    for l=1:L+1
        h_k = h_k + kron(beta(:,l), a(:,l));
    end
    H(:, k) = h_k;
end

%disp(H);
%save('ori_H.mat', 'H')
figure(1);
[X, Y] = meshgrid(1:K, 1:N); % x and y in reverse
surf(X, Y, abs(H));
xlim([1,K]);
ylim([1,N]);
%axis auto;
set(gca, 'xtick', 1:3:K);
set(gca, 'ytick', 1:9:N);
xlabel('user index');
ylabel('antenna index');
zlabel('Channel gain amplitude');
%saveas(gcf,'ori_channel.eps', 'psc2');


% construct U matrix for beamspace
U = zeros(N, N);
theta_b = ((1:N)-(N+1)/2)/N;
for n=1:N
    a_b = exp(-2*1i*pi*theta_b(n)*((0:N-1)-(N-1)/2))';
    U(:, n) = sqrt(1/N)*a_b;
end

% beamspace channel matrix
H_b = U*H;

figure(2);
surf(X, Y, abs(H_b));
xlim([1,K]);
ylim([1,N]);
%axis auto;
set(gca, 'xtick', 1:3:K);
set(gca, 'ytick', 1:9:N);
xlabel('user index');
ylabel('beam index');
zlabel('Channel gain amplitude');
%saveas(gcf,'beam_channel.eps', 'psc2');
