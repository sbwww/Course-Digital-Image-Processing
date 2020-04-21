fig = imread('E:\matlab\toolbox\images\imdemos\cameraman.tif');
[m, n] = size(fig);
fig_1 = imnoise(fig, 'gaussian');
fig_2 = imnoise(fig, 'salt & pepper');
modu = 3;
dif = floor(modu / 2);

for x = 1 + dif:m - dif
    for y = 1 + dif:n - dif
        neib_1 = fig_1(x - dif:x + dif, y - dif:y + dif);
        new_fig_1_max(x, y) = max(neib_1(:));
        new_fig_1_min(x, y) = min(neib_1(:));
        new_fig_1_mid(x, y) = round((new_fig_1_max(x, y) + new_fig_1_min(x, y)) / 2);
        new_fig_1_med(x, y) = round(median(neib_1(:)));

        neib_2 = fig_2(x - dif:x + dif, y - dif:y + dif);
        new_fig_2_max(x, y) = max(neib_2(:));
        new_fig_2_min(x, y) = min(neib_2(:));
        new_fig_2_mid(x, y) = round((new_fig_2_max(x, y) + new_fig_2_min(x, y)) / 2);
        new_fig_2_med(x, y) = round(median(neib_2(:)));
    end
end

subplot(2, 5, 1), imshow(fig_1);
subplot(2, 5, 2), imshow(new_fig_1_max);
subplot(2, 5, 3), imshow(new_fig_1_min);
subplot(2, 5, 4), imshow(new_fig_1_mid);
subplot(2, 5, 5), imshow(new_fig_1_med);

subplot(2, 5, 6), imshow(fig_2);
subplot(2, 5, 7), imshow(new_fig_2_max);
subplot(2, 5, 8), imshow(new_fig_2_min);
subplot(2, 5, 9), imshow(new_fig_2_mid);
subplot(2, 5, 10), imshow(new_fig_2_med);
