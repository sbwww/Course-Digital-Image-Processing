fig = imread('E:\matlab\toolbox\images\imdemos\cameraman.tif');
[m, n] = size(fig);
fig_1 = imnoise(fig, 'gaussian');
fig_2 = imnoise(fig, 'salt & pepper');
modu_1 = 3;
modu_2 = 5;
dif_1 = floor(modu_1 / 2);
dif_2 = floor(modu_2 / 2);

for x = 1 + dif_1:m - dif_1
    for y = 1 + dif_1:n - dif_1
        neib_1 = fig_1(x - dif_1:x + dif_1, y - dif_1:y + dif_1);
        new_fig_1_mean_1(x, y) = round(mean(neib_1(:)));

        neib_2 = fig_2(x - dif_1:x + dif_1, y - dif_1:y + dif_1);
        new_fig_2_mean_1(x, y) = round(mean(neib_2(:)));
    end
end

for x = 1 + dif_2:m - dif_2
    for y = 1 + dif_2:n - dif_2
        neib_1 = fig_1(x - dif_2:x + dif_2, y - dif_2:y + dif_2);
        new_fig_1_mean_2(x, y) = round(mean(neib_1(:)));

        neib_2 = fig_2(x - dif_2:x + dif_2, y - dif_2:y + dif_2);
        new_fig_2_mean_2(x, y) = round(mean(neib_2(:)));
    end
end

new_fig_1_mean_1 = uint8(new_fig_1_mean_1);
new_fig_2_mean_1 = uint8(new_fig_2_mean_1);
new_fig_1_mean_2 = uint8(new_fig_1_mean_2);
new_fig_2_mean_2 = uint8(new_fig_2_mean_2);

subplot(2, 3, 1), imshow(fig_1);
subplot(2, 3, 2), imshow(new_fig_1_mean_1);
subplot(2, 3, 3), imshow(new_fig_1_mean_2);


subplot(2, 3, 4), imshow(fig_2);
subplot(2, 3, 5), imshow(new_fig_2_mean_1);
subplot(2, 3, 6), imshow(new_fig_2_mean_2);
