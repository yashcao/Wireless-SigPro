%UPA_DLA_Beamspace
clear;close all;clc;

% parameters settings
Nx = 16;   % TX antenna nums
Ny = 8;    % TX antenna nums
K = 16;    % user nums
L = 2;     % NLOS path nums
%SNR = 30; % SNR in dB
var = [1, 0.01, 0.01]; % channel attenuation

N = Nx*Ny;
% original channel matrix
H = zeros(N, K);

% set Only LOS components
%L = 0;

for k=1:K
    % random distribution of channel parameters
    theta_a = rand(1, L+1)-0.5;      % azimuth cos(0-180)
    %theta_e = rand(1, L+1)-0.5;
    theta_e = rand(1, L+1)*(-1*0.5); % elevation cos(90-180)
    
    beta = sqrt(var/2).*(randn(1, L+1) +1i*randn(1, L+1));
    % array steering vector
    a_a = exp(-2*1i*pi*theta_a'*((0:Nx-1)-(Nx-1)/2))';
    a_e = exp(-2*1i*pi*theta_e'*((0:Ny-1)-(Ny-1)/2))';
    
    h_k = zeros(N, 1);
    for l=1:L+1
        a(:,l) = kron(a_a(:,l), a_e(:,l));
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
set(gca, 'ytick', 1:21:N);
xlabel('user index');
ylabel('antenna index');
zlabel('Channel gain amplitude');
%saveas(gcf,'ori_channel.eps', 'psc2');

% construct U matrix for beamspace
theta_b1 = ((1:Nx)-(Nx+1)/2)/Nx;
theta_b2 = ((1:Ny)-(Ny+1)/2)/Ny;
for n=1:Nx
    b_aa = exp(-2*1i*pi*theta_b1(n)*((0:Nx-1)-(Nx-1)/2))';
    U_a(:, n) = sqrt(1/Nx)*b_aa;
end

for n=1:Ny
    b_ae = exp(-2*1i*pi*theta_b2(n)*((0:Ny-1)-(Ny-1)/2))';
    U_e(:, n) = sqrt(1/Ny)*b_ae;
end

% beamspace channel matrix
U = kron(U_a, U_e);
H_b = U*H;


figure(2);
surf(X, Y, abs(H_b));
xlim([1,K]);
ylim([1,N]);
%axis auto;
set(gca, 'xtick', 1:3:K);
set(gca, 'ytick', 1:21:N);
xlabel('user index');
ylabel('beam index');
zlabel('Channel gain amplitude');
%saveas(gcf,'beam_channel.eps', 'psc2');

figure(3);
colormap('hot');
imagesc(abs(H_b));
colorbar;
set(gca, 'xtick', 1:3:K);
set(gca, 'ytick', 1:9:N);
xlabel('user index');
ylabel('beam index');

% Nx*Ny matrix for a UPA
c_b = sum(H_b, 2);
C_b = reshape(c_b, Nx, Ny)';

figure(4);
colormap('hot');
imagesc(abs(C_b));
colorbar;
% xlim([-0.5, 0.5]);
% ylim([-0.5, 0.5]);
set(gca, 'xtick', 1:Nx);
set(gca, 'ytick', 1:Ny);
set(gca,'XTickLabel',round(theta_b1, 1));
set(gca,'YTickLabel',round(theta_b2, 1));
xlabel('azimuth');
ylabel('elevation');
%saveas(gcf,'beam_channel.eps', 'psc2');
