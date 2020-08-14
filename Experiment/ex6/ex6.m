clear all; clc;
fig = imread('Fig0333(a)(test_pattern_blurring_orig).tif');
fig = double(fig);
fig_fft = fft2(fig);
fig_fft_shift = fftshift(fig_fft);
[M N] = size(fig_fft);
D = zeros(M, N);
Cx = (M + 1) / 2;
Cy = (N + 1) / 2;

for x = 1:M

    for y = 1:N
        D(x, y) = sqrt((x - Cx).^2 + (y - Cy).^2);
    end

end

%%%%% ex2 %%%%%

% subplot(4, 6, 1); imshow(mat2gray(fig));
% subplot(4, 6, 6 + 1); imshow(log(abs(fig_fft_shift) + 1), []);

% D0_list = [5 15 30 80 230];

% for i = 1:5
%     D0 = D0_list(i);
%     % lowpass
%     H_lp = double(D <= D0);
%     fig_lp_fft_shift = fig_fft_shift .* H_lp;
%     fig_lp_fft = ifftshift(fig_lp_fft_shift);
%     fig_lp = ifft2(fig_lp_fft);
%     subplot(4, 6, i + 1); imshow(mat2gray(real(fig_lp)));
%     subplot(4, 6, i + 1 + 6); imshow(log(abs(fig_lp_fft_shift) + 1), []);
%     % highpass
%     H_hp = double(D >= D0);
%     fig_hp_fft_shift = fig_fft_shift .* H_hp;
%     fig_hp_fft = ifftshift(fig_hp_fft_shift);
%     fig_hp = ifft2(fig_hp_fft);
%     subplot(4, 6, i + 1 + 6 * 2); imshow(mat2gray(real(fig_hp)));
%     subplot(4, 6, i + 1 + 6 * 3); imshow(log(abs(fig_hp_fft_shift) + 1), []);
% end

%%%%% ex2 %%%%%

%%%%% ex3 %%%%%

% subplot(2, 4, 1); imshow(mat2gray(fig));
% subplot(2, 4, 4 + 1); imshow(log(abs(fig_fft_shift) + 1), []);

% D0 = 15;
% n = 2;

% for i = 1:3

%     switch i
%         case 1% ideal
%             H = double(D <= D0);
%             titleS = 'ideal';
%         case 2% btw
%             H = 1 ./ (1 + (D ./ D0).^(2 * n));
%             titleS = 'btw';
%         case 3% gaussian
%             H = exp(-(D.^2) ./ (2 * (D0^2)));
%             titleS = 'gaussian';
%     end

%     fig_lp_fft_shift = fig_fft_shift .* H;
%     fig_lp_fft = ifftshift(fig_lp_fft_shift);
%     fig_lp = ifft2(fig_lp_fft);
%     subplot(2, 4, i + 1); imshow(mat2gray(real(fig_lp))); title(titleS);
%     subplot(2, 4, i + 1 + 4); imshow(log(abs(fig_lp_fft_shift) + 1), []);

% end

%%%%% ex3 %%%%%

%%%%% ex4 %%%%%

% subplot(2, 4, 1); imshow(mat2gray(fig));
% subplot(2, 4, 4 + 1); imshow(log(abs(fig_fft_shift) + 1), []);

% D0 = 15;
% n = 2;

% for i = 1:3

%     switch i
%         case 1% ideal
%             H = double(D >= D0);
%             titleS = 'ideal';
%         case 2% btw
%             H = 1 ./ (1 + (D0 ./ D).^(2 * n));
%             titleS = 'btw';
%         case 3% gaussian
%             H = 1 - exp(-(D.^2) ./ (2 * (D0^2)));
%             titleS = 'gaussian';
%     end

%     fig_hp_fft_shift = fig_fft_shift .* H;
%     fig_hp_fft = ifftshift(fig_hp_fft_shift);
%     fig_hp = ifft2(fig_hp_fft);
%     subplot(2, 4, i + 1); imshow(mat2gray(real(fig_hp))); title(titleS);
%     subplot(2, 4, i + 1 + 4); imshow(log(abs(fig_hp_fft_shift) + 1), []);

% end

%%%%% ex4 %%%%%

%%%%% ex5 %%%%%

subplot(2, 4, 1); imshow(mat2gray(fig));
subplot(2, 4, 4 + 1); imshow(log(abs(fig_fft_shift) + 1), []);

D0 = 15;
n = 2;

A = 2;
a = 0.5;
b = 1.5;

for i = 1:3

    switch i
        case 1% ideal
            H = double(D >= D0);
            titleS = 'ideal';
        case 2% btw
            H = 1 ./ (1 + (D0 ./ D).^(2 * n));
            titleS = 'btw';
        case 3% gaussian
            H = 1 - exp(-(D.^2) ./ (2 * (D0^2)));
            titleS = 'gaussian';
    end

    H_hb = (A - 1) + H;
    H_hfe = a + b * H;

    fig_hb_fft_shift = fig_fft_shift .* H_hb;
    fig_hb_fft = ifftshift(fig_hb_fft_shift);
    fig_hb = ifft2(fig_hb_fft);
    subplot(4, 4, i + 1); imshow(mat2gray(real(fig_hb))); title(titleS);
    subplot(4, 4, i + 1 + 4); imshow(log(abs(fig_hb_fft_shift) + 1), []);

    fig_hfe_fft_shift = fig_fft_shift .* H_hfe;
    fig_hfe_fft = ifftshift(fig_hfe_fft_shift);
    fig_hfe = ifft2(fig_hfe_fft);
    subplot(4, 4, i + 1 + 4 * 2); imshow(mat2gray(real(fig_hfe))); title(titleS);
    subplot(4, 4, i + 1 + 4 * 3); imshow(log(abs(fig_hfe_fft_shift) + 1), []);

end

%%%%% ex5 %%%%%
