%%%% Loading the images in Matlab %%%%
N = 520;
X = [];
for i = 0 : 7
    for j = 0 : 9
        t = double(imread("./dataset/00" + i + "_" + "00"+ j + ".jpg"));
        x = reshape(t, [1 196608]);
        X = [X; x];
    end
    for j = 10 : 64
        t = double(imread("./dataset/00" + i + "_" + "0" + j + ".jpg"));
        x = reshape(t, [1 196608]);
        X = [X; x];
    end
end
%%% PCA %%%
dim = 35;
G = X * X';
[V, D] = eigs(G, dim);
D = sum(D);
E = X' * V;
for i = 1 : dim
    E(:, i) = E(:, i) ./ sqrt(D(i) * N);
end
compressed = X * E;
%%%% Reconstructing the images back %%%%
images = compressed * E';
imshow(reshape(images(18, :), [256 256 3]));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Plots %%%
oned = X * E(:, 1);
y = zeros(N, 1);
%scatter(oned, y);
twod = X * E(:, 1 : 2);
%scatter(twod(:, 1), twod(:, 2));
threed = X * E(:, 1 : 3);
%scatter3(threed(:, 1), threed(:, 2), threed(:, 3));
