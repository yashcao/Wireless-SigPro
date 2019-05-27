% mmWave BeamSpace MIMO channel with ULA
clear;close all;clc;

% parameters settings
N = 81;   % TX antenna nums
K = 16;   % user nums
L = 2;    % NLOS path nums
%SNR = 30; % SNR in dB
var = [1, 0.01, 0.01]; % channel attenuation

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

% construct U matrix for beamspace
U = zeros(N, N);
theta_b = ((1:N)-(N+1)/2)/N;
for n=1:N
    a_b = exp(-2*1i*pi*theta_b(n)*((0:N-1)-(N-1)/2))';
    U(:, n) = sqrt(1/N)*a_b;
end

% beamspace channel matrix
H_b = U*H;
P = abs(H_b).^2;

figure(1);
colormap('hot');
imagesc(P);
colorbar;
set(gca, 'xtick', 1:3:K);
set(gca, 'ytick', 1:9:N);
xlabel('user index');
ylabel('beam index');

% Maximum Magnitude Selection
IndexSet=[];
%Index = cell(K, 1);
for k=1:K
    %eta = 0.5;       % threshhold
    power_eta = 0.9;  % power retaining threshhold
    %max_k = max(P(:, k));
    sum_k = sum(P(:, k));
    index_k = [];     % index set
    [V, I] = sort(P(:, k),'descend');
    v = 0;
    for n=1:N
        %if P(n, k) >= eta*max_k
            %index_k = [index_k  n];
        %end
        v = v + V(n);
        if v >= power_eta*sum_k
            index_k = I(1:n);
            break;
        end
    end
    % merge all index
    IndexSet = union(IndexSet, index_k);
    %Index(k) = {index_k};
end

% low-dimensional for corresponding to the selected beams
H_low = H_b(IndexSet, :);
% ZF precoding
%F_b = H_b*inv(H_b'*H_b);
%F_low = H_low*inv(H_low'*H_low);
%F_low = F_b(IndexSet, :);
