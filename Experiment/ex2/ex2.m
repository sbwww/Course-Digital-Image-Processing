clear all; clc;

% ex2_1.m
fig_1 = imread('E:\matlab\toolbox\images\imdemos\pout.tif');
new_fig_1 = imadjust(fig_1);
subplot(1, 2, 1); imshow(fig_1);
subplot(1, 2, 2); imshow(new_fig_1);

% ex2_2.m
fig_2 = imread('E:\matlab\toolbox\images\imdemos\pout.tif');
new_fig_2 = fig_2 + 50;
subplot(1, 2, 1); imshow(fig_2);
subplot(1, 2, 2); imshow(new_fig_2);

% ex2_3.m
fig_3 = imread('E:\matlab\toolbox\images\imdemos\rice.png');
imhist(fig_3)
T = 130;
new_fig_3 = sign(floor(double(fig_3) ./ T));
subplot(1, 2, 1); imshow(fig_3);
subplot(1, 2, 2); imshow(new_fig_3);

% ex2_4_1.m
fig_4_1 = imread('C:\Users\SBW\Desktop\教材\实习所需数字图像\Fig0308(a)(fractured_spine).tif');
c = 1;
% c = 2.5;
% new_fig_4_1 = c * log2(double(fig_4_1) + 1);
new_fig_4_1 = c * log(double(fig_4_1) + 1);
subplot(1, 2, 1); imshow(fig_4_1);
subplot(1, 2, 2); imshow(mat2gray(new_fig_4_1));

% ex2_4_2.m
fig_4_2 = imread('C:\Users\SBW\Desktop\教材\实习所需数字图像\Fig0309(a)(washed_out_aerial_image).tif');
c = 1; gam = 4;
new_fig_4_2 = c * double(fig_4_2).^gam;
subplot(1, 2, 1); imshow(fig_4_2);
subplot(1, 2, 2); imshow(mat2gray(new_fig_4_2));

% ex2_5.m
fig_5 = imread('E:\matlab\toolbox\images\imdemos\pout.tif');
L = 256;
G_max = 255;
G_min = 0;
p = zeros(1, L);
c = zeros(1, L);
[m, n] = size(fig_5);

for i = 1:m

    for j = 1:n
        gd = fig_5(i, j); % 0~255 +1 1~256
        p(gd + 1) = p(gd + 1) + 1;
    end

end

p = 1.0 * p / (m * n);
c(1) = p(1);

for i = 2:L
    c(i) = c(i - 1) + p(i);
end

g = round((G_max - G_min) * c + G_min + 0.5);

for i = 1:m

    for j = 1:n
        new_fig_5(i, j) = g(fig_5(i, j) + 1);
    end

end

new_fig_5 = uint8(new_fig_5);
subplot(2, 2, 1); imshow(fig_5);
subplot(2, 2, 2); imhist(fig_5);
subplot(2, 2, 3); imshow(new_fig_5);
subplot(2, 2, 4); imhist(new_fig_5);


% fig=[[1,1,1,1,1],[1,0,0,0,1],[1,0,0,0,1],[1,0,0,0,1],[1,1,1,1,1]];
