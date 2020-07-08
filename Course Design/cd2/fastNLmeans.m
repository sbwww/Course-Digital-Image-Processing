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
