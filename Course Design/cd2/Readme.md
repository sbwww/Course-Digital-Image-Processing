
# 课设2 图像增强
NUIST 数字图像处理的第二次课程设计，内容仅供参考与交流

## 1. 天鹅

|原图|噪声|
|:-:|:-:|
|![swan Original](https://img-blog.csdnimg.cn/20200712225429926.bmp?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQ0OTI2NTY3,size_16,color_FFFFFF,t_70)|![swan Noise](https://img-blog.csdnimg.cn/20200712225504635.bmp?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQ0OTI2NTY3,size_16,color_FFFFFF,t_70)|

### 1.1. 分析

1. 观察图像，可发现**脉冲（椒盐）噪声**和周期性噪声 $\rightarrow$ **中值**滤波（$3 \times 3$）
2. 观察频谱图，可发现图中的**单像素**亮点 $\rightarrow$ **陷波**滤波（$1 \times 1$ 理想）
    ![swan FFT](https://img-blog.csdnimg.cn/20200712225530398.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQ0OTI2NTY3,size_16,color_FFFFFF,t_70#pic_center)
3. 顺序设计
   - 先中值后陷波 x
        会使频谱图的单像素噪声变化（向周围扩散），陷波不好去除
        后面会比较一下
   - 先陷波后中值 √

### 1.2. 代码

1. 读图

2. 确定亮点

    ```matlab
    H = double(ones(M, N));
    midx = round(M / 2);
    midy = round(N / 2) + 1;
    dx = floor(M / 5);
    dy = floor(N / 5);
    row = [midx - 2 * dx, midx - dx, midx, midx + dx, midx + 2 * dx];
    col = [midy - 2 * dy, midy - dy, midy, midy + dy, midy + 2 * dy];
    ```

3. $1 \times 1$ 理想陷波

    ```matlab
    dr = 0; dc = 0;

    for i = 1:5
        for j = 1:5
            H(row(i) - dr:row(i) + dr, col(j) - dc:col(j) + dc) = 0;
        end
    end

    H(row(3) - dr:row(3) + dr, col(3) - dc:col(3) + dc) = 1;

    Filter_fft_shift = Filter_fft_shift .* H;
    Filter_fft = ifftshift(Filter_fft_shift);
    FreqFilter = real(ifft2(Filter_fft));
    ```

4. $3 \times 3$ 中值

    ```matlab
    SpatialFilter = medfilt2(FreqFilter, [3, 3], 'symmetric');
    ```

5. 计算均方误差

    ```matlab
    mse_Original_Final = immse(Original, SpatialFilter)
    ```

### 1.3. 效果

|原图|噪声|去噪|
|:-:|:-:|:-:|
|![swan Original](https://img-blog.csdnimg.cn/20200712225429926.bmp?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQ0OTI2NTY3,size_16,color_FFFFFF,t_70)|![swan Noise](https://img-blog.csdnimg.cn/20200712225504635.bmp?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQ0OTI2NTY3,size_16,color_FFFFFF,t_70)|![swan Result](https://img-blog.csdnimg.cn/20200712225821770.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQ0OTI2NTY3,size_16,color_FFFFFF,t_70)|
与原图的均方误差（MSE），两种顺序的比较

![swan MSE](https://img-blog.csdnimg.cn/20200712225845307.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQ0OTI2NTY3,size_16,color_FFFFFF,t_70#pic_center)

## 2. 狗

|原图|噪声|
|:-:|:-:|
|![dog Original](https://img-blog.csdnimg.cn/20200712225913342.bmp?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQ0OTI2NTY3,size_16,color_FFFFFF,t_70)|![dog Distorted](https://img-blog.csdnimg.cn/20200712225938451.bmp?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQ0OTI2NTY3,size_16,color_FFFFFF,t_70)|
### 2.1. 分析

1. 观察图像，可发现某种随机噪声和**周期性噪声**
2. 观察**局部直方图**（我选的是桶的部分，基本只有黑色），基本可以确定随机噪声是**高斯噪声**
3. 观察频谱图，可发现图中的亮块 $\rightarrow$ **陷波**滤波（范围较大）
    ![dig FFT](https://img-blog.csdnimg.cn/20200712230137159.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQ0OTI2NTY3,size_16,color_FFFFFF,t_70#pic_center)
4. 陷波设计
    每个亮块用巴特沃斯高通，然后再加线条
    it ~~sounds stupid but~~ works
    ![dog Notch](https://img-blog.csdnimg.cn/20200712230210844.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQ0OTI2NTY3,size_16,color_FFFFFF,t_70#pic_center)
5. 空域的高斯噪声密集，可以采用**快速非局部均值（Fast NonLocal Means, Fast NLM）**
   **快速**是因为普通的 NLM 太太太太太慢了
   自适应中值也许可以，但是没试过
6. 顺序设计
   - 先陷波后NLM √
   - 噪声图像的整体灰度值与原图像差别较大，去噪后最好做下灰度变换（视觉效果差别不大，但是**降 MSE 很厉害**）

### 2.2. 代码

1. 读图
2. 确定陷波位置

    ```matlab
    Filter = Noise;
    Filter_fft = fft2(double(Filter));
    Filter_fft_shift = fftshift(Filter_fft);
    H = double(ones(M, N));
    row = [37, 111, 185, 259, 333];
    col = [36, 107, 178, 249, 320];
    dr = 7; dc = 7; dl = 0; dcenter = 30; n = 4;
    ```

3. 陷波

    ```matlab

    u = abs([-dr:dr]);
    V = repmat(u, dc * 2 + 1, 1);
    U = V.';
    D = sqrt(U.^2 + V.^2);
    D0 = 10;

    notch = 1 - 1 ./ (1 + (D ./ D0).^(2 * n));

    for i = [1 2 3 4 5]
        H(row(i) - dl:row(i) + dl, :) = 0;
    end

    for j = [1 2 3 4 5]
        H(:, col(j) - dl:col(j) + dl) = 0;
    end

    for i = 1:5
        for j = 1:5
            H(row(i) - dr:row(i) + dr, col(j) - dc:col(j) + dc) = notch;
        end
    end

    H(row(3) - dcenter:row(3) + dcenter, col(3) - dcenter:col(3) + dcenter) = 1;
    Filter_fft_shift = Filter_fft_shift .* H;
    Filter_fft = ifftshift(Filter_fft_shift);
    Filter = real(ifft2(Filter_fft));

    mse_Original_Filter = immse(Original, Filter)
    ```

4. 快速非局部均值滤波实现（引用~~抄~~自 [积分图像的应用（二）：非局部均值去噪（NL-means）](https://blog.csdn.net/u010839382/article/details/48241929) ）

    ```matlab
    function DenoisedImg = fastNLmeans(I, ds, Ds, h)
        I = double(I);
        [m, n] = size(I);
        PaddedImg = padarray(I, [Ds + ds + 1, Ds + ds + 1], 'symmetric', 'both');
        PaddedV = padarray(I, [Ds, Ds], 'symmetric', 'both');
        average = zeros(m, n);
        sweight = average;
        wmax = average;
        h2 = h * h;
        d2 = (2 * ds + 1)^2;

        for t1 = -Ds:Ds
            for t2 = -Ds:Ds

                if (t1 == 0 && t2 == 0)
                    continue;
                end

                St = integralImgSqDiff(PaddedImg, Ds, t1, t2);
                v = PaddedV(1 + Ds + t1:end - Ds + t1, 1 + Ds + t2:end - Ds + t2);
                w = zeros(m, n);

                for i = 1:m
                    for j = 1:n
                        i1 = i + ds + 1;
                        j1 = j + ds + 1;
                        Dist2 = St(i1 + ds, j1 + ds) + St(i1 - ds - 1, j1 - ds - 1) - St(i1 + ds, j1 - ds - 1) - St(i1 - ds - 1, j1 + ds);
                        Dist2 = Dist2 / d2;
                        w(i, j) = exp(-Dist2 / h2);
                        sweight(i, j) = sweight(i, j) + w(i, j);
                        average(i, j) = average(i, j) + w(i, j) * v(i, j);
                    end
                end
                wmax = max(wmax, w);

            end
        end

        average = average + wmax .* I;
        sweight = sweight + wmax;
        DenoisedImg = average ./ sweight;
    ```

    ```matlab
    function Sd = integralImgSqDiff(PaddedImg, Ds, t1, t2)
        [m, n] = size(PaddedImg);
        m1 = m - 2 * Ds;
        n1 = n - 2 * Ds;
        Sd = zeros(m1, n1);
        Dist2 = (PaddedImg(1 + Ds:end - Ds, 1 + Ds:end - Ds) - PaddedImg(1 + Ds + t1:end - Ds + t1, 1 + Ds + t2:end - Ds + t2)).^2;

        for i = 1:m1
            for j = 1:n1

                if i == 1 && j == 1
                    Sd(i, j) = Dist2(i, j);
                elseif i == 1 && j ~= 1
                    Sd(i, j) = Sd(i, j - 1) + Dist2(i, j);
                elseif i ~= 1 && j == 1
                    Sd(i, j) = Sd(i - 1, j) + Dist2(i, j);
                else
                    Sd(i, j) = Dist2(i, j) + Sd(i - 1, j) + Sd(i, j - 1) - Sd(i - 1, j - 1);
                end

            end
        end
    ```


5. 快速非局部均值滤波的函数参数与调用

    ```matlab
    FilterT = fastNLmeans(Filter, 2, 7, 25);
    ```

6. 灰度变换 （为什么是 -40 后面会说）

    ```matlab
    FilterT = FilterT - 40;
    ```

### 2.3. 效果

|陷波|Fast NLM|灰度变换|
|:-:|:-:|:-:|
|![dog Result1](https://img-blog.csdnimg.cn/20200712230334866.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQ0OTI2NTY3,size_16,color_FFFFFF,t_70)|![dog Result2](https://img-blog.csdnimg.cn/20200712230352831.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQ0OTI2NTY3,size_16,color_FFFFFF,t_70)|![dog Result3](https://img-blog.csdnimg.cn/20200712230410523.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQ0OTI2NTY3,size_16,color_FFFFFF,t_70)|

与原图的均方误差（MSE），各个步骤

![dog MSE](https://img-blog.csdnimg.cn/20200712230434206.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQ0OTI2NTY3,size_16,color_FFFFFF,t_70#pic_center)

一开始做完 NLM，看到 MSE 将近 1900，以为方法有问题，但是视觉效果还不错，于是觉得可能是去噪后**整体灰度**有问题
天鹅图去噪完的 MSE 是 200 多，狗这个效果没有天鹅好，但也不会差太多，大概估计一下 $$1900-300=1600=40^2$$ 所以在灰度变换的时候 -40。当然，这个数字可以设置地更精确，但是没这个必要

## 3. 总结


1. Matlab 的**数据类型**要注意，个人一般都转成 double，不同类型的数据运算时会引发很多蜜汁错误
2. MSE 不是衡量去噪效果的唯一指标，**视觉效果**其实比 MSE 更重要
3. 虽说 MSE 不是特别重要，但是**好歹也了解一下它是什么吧**（看到有不少人结果数字非常小，一度怀疑人生，原来是那些人把标准差当成 MSE）
4. **把屏幕擦干净**