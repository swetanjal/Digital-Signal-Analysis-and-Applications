mat = [16, 11, 10, 16, 24, 40, 51, 61; 12, 12, 14, 19, 26, 58, 60, 55; 14, 13, 16, 24, 40, 57, 69, 56; 14, 17, 22, 29, 51, 87, 80, 62; 18, 22, 37, 56, 68, 109, 103, 77; 24, 35, 55, 64, 81, 104, 113, 92; 49, 64, 78, 87, 103, 121, 120, 101; 72, 92, 95, 98, 112, 100, 103, 99];
F = create_mat_dct();
c = 2;
img = imread('LAKE.TIF');
%%%%%%% (420, 45) %%%%%%%%%
im = double(img(420 : 420 + 8 - 1, 45 : 45 + 8 - 1));
imDCT = myDCT(im, F);
disp(imDCT);
imqDCT = myDCT_quantization(imDCT, mat, c);
disp(imqDCT);
disp(myIDCT(myDCT_dequantization(imqDCT, mat, c) , F));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% (427, 298) %%%%%%%%%
im = double(img(427 : 427 + 8 - 1, 298 : 298 + 8 - 1));
imDCT = myDCT(im, F);
disp(imDCT);
imqDCT = myDCT_quantization(imDCT, mat, c);
disp(imqDCT);
disp(myIDCT(myDCT_dequantization(imqDCT, mat, c) , F));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% (30, 230) %%%%%%%%%%%
im = double(img(30 : 30 + 8 - 1, 230 : 230 + 8 - 1));
imDCT = myDCT(im, F);
disp(imDCT);
imqDCT = myDCT_quantization(imDCT, mat, c);
disp(imqDCT);
disp(myIDCT(myDCT_dequantization(imqDCT, mat, c) , F));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c = 5; % 5 makes distortions of the reconstructed image just perceptible 
compressed = [];
% Compressing the image %
for i = 1 : 8 : size(img, 1)
    temp = [];
    for j = 1 : 8 : size(img, 2)
        im = double(img(i : i + 8 - 1, j : j + 8 - 1));
        imDCT = myDCT(im, F);
        imqDCT = myDCT_quantization(imDCT, mat, c);
        temp = [temp, imqDCT];
    end
    compressed = [compressed; temp];
end
%imshow(compressed, []);
% Reconstructing the image %
reconstructed_img = [];
for i = 1 : 8 : size(img, 1)
    temp = [];
    for j = 1 : 8 : size(img, 2)
        im = double(compressed(i : i + 8 - 1, j : j + 8 - 1));
        imDCT = myDCT_dequantization(im, mat, c);
        image = myIDCT(imDCT, F);
        temp = [temp, image];
    end
    reconstructed_img = [reconstructed_img; temp];
end
imshow(reconstructed_img, []);
disp("Entropy: " + My_entropy(reconstructed_img)); % 0.0025
disp("Root Mean Square Error: " + RMSE(reconstructed_img, img)); % 8.5218
%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
    diff = (double(im1) - double(im2)) .^ 2;
    output = sum(sum(diff));
    output = output / (size(im1, 1) * size(im1, 2));
    output = sqrt(output);
end

function output = My_entropy(im)
    [counts, x] = imhist(im);
    res = 0.0;
    total = sum(counts);
    for i = 1 : size(counts, 1)
        prob = counts(i, 1) * 1.0 / total;
        if(prob > 0)
            res = res + prob * log2(prob * 1.0);
        end
    end
    output = -res;
end