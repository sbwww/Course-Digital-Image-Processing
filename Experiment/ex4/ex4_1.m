clear all; clc;
fig = imread('cameraman.tif');
[m n] = size(fig);

% Roberts
Roberts_x = [-1 0; 0 1];
Roberts_y = [0 -1; 1 0];

tmp_fig = zeros(m + 1, n + 1);
tmp_fig(1:m, 1:n) = fig;

for x = 1:m
    for y = 1:n
        tmp = tmp_fig(x:x + 1, y:y + 1);
        x_p = Roberts_x .* tmp;
        y_p = Roberts_y .* tmp;
        Roberts_grad(x, y) = abs(sum(x_p(:))) + abs(sum(y_p(:)));
    end
end

% Prewitt
Prewitt_x = [-1 -1 -1; 0 0 0; 1 1 1];
Prewitt_y = [-1 0 1; -1 0 1; -1 0 1];

tmp_fig = zeros(m + 2, n + 2);
tmp_fig(2:m+1, 2:n+1) = fig;

for x = 1:m
    for y = 1:n
        tmp = tmp_fig(x:x + 2, y:y + 2);
        x_p = Prewitt_x .* tmp;
        y_p = Prewitt_y .* tmp;
        Prewitt_grad(x, y) = abs(sum(x_p(:))) + abs(sum(y_p(:)));
    end
end

% Sobel
Sobel_x = [-1 -2 -1; 0 0 0; 1 2 1];
Sobel_y = [-1 0 1; -2 0 2; -1 0 1];

tmp_fig = zeros(m + 2, n + 2);
tmp_fig(2:m+1, 2:n+1) = fig;

for x = 1:m
    for y = 1:n
        tmp = tmp_fig(x:x + 2, y:y + 2);
        x_p = Sobel_x .* tmp;
        y_p = Sobel_y .* tmp;
        Sobel_grad(x, y) = abs(sum(x_p(:))) + abs(sum(y_p(:)));
    end
end

new_fig_Roberts = mat2gray(Roberts_grad);
new_fig_Prewitt = mat2gray(Prewitt_grad);
new_fig_Sobel = mat2gray(Sobel_grad);

subplot(2, 3, 2); imshow(fig);title('Origin');
subplot(2, 3, 4); imshow(new_fig_Roberts);title('Roberts');
subplot(2, 3, 5); imshow(new_fig_Prewitt);title('Prewitt');
subplot(2, 3, 6); imshow(new_fig_Sobel);title('Sobel');
