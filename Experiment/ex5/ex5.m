f_uint8 = imread('cameraman.tif');
f_double = double(f_uint8);
f_fft = fft2(f_double); f_shift = fftshift(f_fft);
f_fft_abs = abs(f_fft); f_shift_abs = abs(f_shift);
f_fft_log = log(f_fft_abs + 1); f_shift_log = log(f_shift_abs + 1);
subplot(2, 2, 1); imshow(f_fft_abs, []); title('fft');
subplot(2, 2, 3); imshow(f_shift_abs, []); title('fft shift');
subplot(2, 2, 2); imshow(f_fft_log, []); title('fft log');
subplot(2, 2, 4); imshow(f_shift_log, []); title('fft shift log');

[m, n] = size(f_fft);

for x = 1:m

    for y = 1:n
        f_shift_manu(mod(round(x - m / 2), m) + 1, mod(round(y - n / 2), n) + 1) = (-1)^(x + y) * f_fft(x, y);
    end

end

f_shift_manu_log = log(abs(f_shift_manu) + 1);
subplot(1, 3, 1); imshow(f_fft_log, []); title('fft');
subplot(1, 3, 2); imshow(f_shift_log, []); title('fft shift');
subplot(1, 3, 3); imshow(f_shift_manu_log, []); title('fft shift manual');

thershold1 = sum(f_fft_abs(:)) / m / n;
thershold2 = 2/3 * thershold1;
f_filter_1 = f_fft;
f_filter_2 = f_fft;

for x = 1:m

    for y = 1:n

        if (f_fft_abs(x, y) > thershold1)
            f_filter_1(x, y) = 0;
        end

        if (f_fft_abs(x, y) > thershold2)
            f_filter_2(x, y) = 0;
        end

    end

end

f_filter_1_inverse = ifft2(f_filter_1);
f_filter_1_log = log(abs(f_filter_1) + 1);
f_filter_2_inverse = ifft2(f_filter_2);
f_filter_2_log = log(abs(f_filter_2) + 1);
subplot(2, 3, 1); imshow(f_uint8); title('fig');
subplot(2, 3, 4); imshow(f_fft_log, []); title('fft');
subplot(2, 3, 2); imshow(f_filter_1_inverse, []); title('average filter inverse');
subplot(2, 3, 5); imshow(f_filter_1_log, []); title('average filter');
subplot(2, 3, 3); imshow(f_filter_2_inverse, []); title('1/2 average filter inverse');
subplot(2, 3, 6); imshow(f_filter_2_log, []); title('1/2 average filter');

f_dct=dct2(f_double);
f_dct_abs=abs(f_dct);
f_dct_log=log(f_dct_abs+1);
f_dct_inverse=idct2(f_dct);
subplot(1,3,1); imshow(f_double,[]);title('fig');
subplot(1,3,2); imshow(f_dct_log,[]);title('dct');
subplot(1,3,3); imshow(f_dct_inverse,[]);title('dct inverse');