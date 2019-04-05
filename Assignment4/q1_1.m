mat = [16, 11, 10, 16, 24, 40, 51, 61; 12, 12, 14, 19, 26, 58, 60, 55; 14, 13, 16, 24, 40, 57, 69, 56; 14, 17, 22, 29, 51, 87, 80, 62; 18, 22, 37, 56, 68, 109, 103, 77; 24, 35, 55, 64, 81, 104, 113, 92; 49, 64, 78, 87, 103, 121, 120, 101; 72, 92, 95, 98, 112, 100, 103, 99];
img = imread('LAKE.TIF');
img = double(img(1 : 8, 1 : 8));
F = create_mat_dct();
imgDCT = myDCT(img, F);
%disp(myIDCT(imgDCT, F));
imqDCT = myDCT_quantization(imgDCT, mat, 1);
%disp(myDCT_dequantization(imqDCT, mat, 1));
%disp(RMSE([1, 0], [4, 0]));
disp(My_entropy(imread('LAKE.TIF')));
function output = create_mat_dct()
    N = 8;
    output = eye(8);
    for i = 1 : N
        for j = 1 : N
            if i == 1
                output(i, j) = sqrt(1.0 / N) * cos(pi * (2 * (j - 1) + 1) * (i - 1) * 1.0 / (2 * N));
                continue;
            end
            output(i, j) = sqrt(2.0 / N) * cos(pi * (2 * (j - 1) + 1) * (i - 1) * 1.0 / (2 * N));
        end
    end
end

function output = myDCT(im, F)
    output = im * F';
    output = output' * F';
    output = output';
end

function output = myIDCT(im, F)
    F = F';
    output = im * F';
    output = output' * F';
    output = output';
end

function output = myDCT_quantization(imDCT, qm, c)
    tmp = c * qm;
    output = imDCT ./ tmp;
    output = round(output);
end

function output = myDCT_dequantization(imqDCT, qm, c)
    tmp = c * qm;
    output = imqDCT .* tmp;
end

function output = RMSE(im1, im2)
    diff = (im1 - im2) .^ 2;
    output = sum(sum(diff));
    output = output / (size(im1, 1) * size(im1, 2));
    output = sqrt(output);
end

function output = My_entropy(im)
    [counts, x] = imhist(im);
    res = 0.0;
    for i = 1 : size(counts, 1)
        prob = counts(i, 1) * 1.0 / sum(counts);
        if(prob > 0)
            res = res + prob * log2(prob * 1.0);
        end
    end
    output = -res;
end