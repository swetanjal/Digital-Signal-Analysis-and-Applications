I = double(imread('cameraman256.tif'));
tic;
a1 = moving_average_inefficient(I, 7);
disp(toc);
tic;
b1 = moving_average_efficient(I, 7);
disp(toc);
function output = moving_average_inefficient(img, k)
    filter = ones(k) ./ (k * k);
    output = zeros(size(img, 1), size(img, 2));
    for i = ceil(k * 1.0 / 2) : size(img, 1) - ceil(k * 1.0 / 2) + 1
        for j = ceil(k * 1.0 / 2) : size(img, 2) - ceil(k * 1.0 / 2) + 1
            a = img(i - floor(k * 1.0/ 2) : i + floor(k * 1.0 / 2), j - floor(k * 1.0/ 2) : j + floor(k * 1.0 / 2));
            output(i, j) = sum(sum(a .* filter));
        end
    end
end

function output = moving_average_efficient(img, k)
    filter = ones(k) ./ (k * k);
    output = zeros(size(img, 1), size(img, 2));
    for i = ceil(k * 1.0 / 2) : size(img, 1) - ceil(k * 1.0 / 2) + 1
        for j = ceil(k * 1.0 / 2) : size(img, 2) - ceil(k * 1.0 / 2) + 1
            if i == ceil(k * 1.0 / 2) && j == ceil(k * 1.0 / 2)
                a = img(i - floor(k * 1.0/ 2) : i + floor(k * 1.0 / 2), j - floor(k * 1.0/ 2) : j + floor(k * 1.0 / 2));
                output(i, j) = sum(sum(a .* filter));
                continue;
            end
            if i == ceil(k * 1.0 / 2)
                % Get from (i, j - 1)
                output(i, j) = output(i, j - 1) - sum(filter(:, 1) .* img(i - floor(k * 1.0/ 2) : i + floor(k * 1.0 / 2), j - floor(k * 1.0 / 2) - 1)) + sum(filter(:, 1) .* img(i - floor(k * 1.0/ 2) : i + floor(k * 1.0 / 2), j + floor(k * 1.0 / 2)));
                continue;
            end
            % Get from (i - 1, j)
            output(i, j) = output(i - 1, j) - sum(filter(1, :) .* img(i - floor(k * 1.0/ 2) - 1, j - floor(k * 1.0 / 2) : j + floor(k * 1.0 / 2))) + sum(filter(1, :) .* img(i + floor(k * 1.0/ 2) , j - floor(k * 1.0 / 2) : j + floor(k * 1.0 / 2)));
        end
    end
end