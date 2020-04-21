clear; clc;
% 1) begin
img = imread('E:\matlab\toolbox\images\imdemos\cameraman.tif');
imshow(img)
% 1) end
% 2) begin
[x0, y0] = size(img);
new_img = img;
x_left = round(x0 / 3);
x_right = x_left * 2;
y_upper = round(y0 / 3);
y_lower = y_upper * 2;
% 2) a) begin
new_img(x_left:x_right, y_upper:y_lower) = new_img(x_left:x_right, y_upper:y_lower) * 2;
subplot(1, 2, 1), imshow(img);
subplot(1, 2, 2), imshow(new_img)
imwrite(new_img, 'C:\Users\SBW\Desktop\数字图像上机\ex1\cameraman1.bmp', 'bmp');
% 2) a) end
% 2) b) begin
new_img = 255 - img;
subplot(2, 1, 1), imshow(img);
subplot(2, 1, 2), imshow(new_img)
imwrite(new_img, 'C:\Users\SBW\Desktop\数字图像上机\ex1\cameraman2.bmp', 'bmp');
% 2) b) end
% 2) end
