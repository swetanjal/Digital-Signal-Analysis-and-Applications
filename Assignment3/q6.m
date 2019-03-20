I = double(imread('cameraman256.tif'));
%x = [7, 17, 27, 37, 47, 99];
%y_inefficient512 = [];
%y_efficient512 = [];
%for i = 1 : 6
%    tic;
%    a1 = moving_average_inefficient(I, x(i));
%    y_inefficient512 = [y_inefficient512, toc];
%    tic;
%    b1 = moving_average_efficient(I, x(i));
%    y_efficient512 = [y_efficient512, toc];
%end
%hold on;
%plot(x, y_efficient, '--', 'MarkerSize', 12, 'color', 'red');
%plot(x, y_inefficient, 'MarkerSize', 12, 'color', 'red');

%plot(x, y_efficient256, '--', 'MarkerSize', 12, 'color', 'blue');
%plot(x, y_inefficient256, 'MarkerSize', 12, 'color', 'blue');


%plot(x, y_efficient512, '--', 'MarkerSize', 12, 'color', 'green');
%plot(x, y_inefficient512, 'MarkerSize', 12, 'color', 'green');

imshow(I, []);
imshow(moving_average_efficient(I, 7), []);
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