img = imread('q4.jpg');
img2 = imread('rose.jpg');
%imshow(RESIZE_BLACK_AND_WHITE_NEAREST_NEIGHBOUR(img, 2));
%imshow(RESIZE_COLOR_NEAREST_NEIGHBOUR(img2, 2));
imshow(RESIZE_COLOR_BILINEAR(img2, 5));
%imshow(RESIZE_BLACK_AND_WHITE_BILINEAR(img, 10));
function output = RESIZE_BLACK_AND_WHITE_NEAREST_NEIGHBOUR(img, X)
    img = rgb2gray(img);    
    img = im2double(img);
    [r, c] = size(img);
    new_x = r * X;
    new_y = c * X;
    output = zeros(new_x, new_y);

    for i = 1:new_x
        for j = 1:new_y
            tmp_x = i * 1.0 / X;
            tmp_y = j * 1.0 / X;
            val = 0;
            dist = 5;
            if(dist > abs(tmp_x - max(1,floor(tmp_x))) + abs(tmp_y - max(1,floor(tmp_y))))
                dist = abs(tmp_x - max(1,floor(tmp_x))) + abs(tmp_y - max(1,floor(tmp_y)));
                val = img(max(1,floor(tmp_x)), max(1,floor(tmp_y)));
            end
            if(dist > abs(tmp_x - max(1, floor(tmp_x))) + abs(tmp_y - min(c, ceil(tmp_y))))
                dist = abs(tmp_x - max(1, floor(tmp_x))) + abs(tmp_y - min(c, ceil(tmp_y)));
                val = img(max(1,floor(tmp_x)), min(c, ceil(tmp_y)));
            end
            if(dist > abs(tmp_x - min(r, ceil(tmp_x))) + abs(tmp_y - max(1, floor(tmp_y))))
                dist = abs(tmp_x - min(r, ceil(tmp_x))) + abs(tmp_y - max(1, floor(tmp_y)));
                val = img(min(r, ceil(tmp_x)), max(1, floor(tmp_y)));
            end
            if(dist > abs(tmp_x - min(r, ceil(tmp_x))) + abs(tmp_y - min(c, ceil(tmp_y))))
                dist = abs(tmp_x - min(r, ceil(tmp_x))) + abs(tmp_y - min(c, ceil(tmp_y)));
                val = img(min(r, ceil(tmp_x)), min(c, ceil(tmp_y)));
            end
            output(i, j) = val;
        end
    end
end

function output = RESIZE_COLOR_NEAREST_NEIGHBOUR(img, X)
    img = im2double(img);
    [r, c, d] = size(img);
    new_x = r * X;
    new_y = c * X;
    output = zeros(new_x, new_y, d);

    for i = 1:new_x
        for j = 1:new_y
            for k = 1:3
                tmp_x = i * 1.0 / X;
                tmp_y = j * 1.0 / X;
                val = 0;
                dist = 5;
                if(dist > abs(tmp_x - max(1,floor(tmp_x))) + abs(tmp_y - max(1,floor(tmp_y))))
                    dist = abs(tmp_x - max(1,floor(tmp_x))) + abs(tmp_y - max(1,floor(tmp_y)));
                    val = img(max(1,floor(tmp_x)), max(1,floor(tmp_y)), k);
                end
                if(dist > abs(tmp_x - max(1, floor(tmp_x))) + abs(tmp_y - min(c, ceil(tmp_y))))
                    dist = abs(tmp_x - max(1, floor(tmp_x))) + abs(tmp_y - min(c, ceil(tmp_y)));
                    val = img(max(1,floor(tmp_x)), min(c, ceil(tmp_y)), k);
                end
                if(dist > abs(tmp_x - min(r, ceil(tmp_x))) + abs(tmp_y - max(1, floor(tmp_y))))
                    dist = abs(tmp_x - min(r, ceil(tmp_x))) + abs(tmp_y - max(1, floor(tmp_y)));
                    val = img(min(r, ceil(tmp_x)), max(1, floor(tmp_y)), k);
                end
                if(dist > abs(tmp_x - min(r, ceil(tmp_x))) + abs(tmp_y - min(c, ceil(tmp_y))))
                    dist = abs(tmp_x - min(r, ceil(tmp_x))) + abs(tmp_y - min(c, ceil(tmp_y)));
                    val = img(min(r, ceil(tmp_x)), min(c, ceil(tmp_y)), k);
                end
                output(i, j, k) = val;
            end
        end
    end
end
function output = RESIZE_BLACK_AND_WHITE_BILINEAR(img, X)
    img = rgb2gray(img);
    img = im2double(img);
    [r, c] = size(img);
    new_x = r * X;
    new_y = c * X;
    output = zeros(new_x, new_y);

    for i = 1:new_x
        for j = 1:new_y
            tmp_x = i * 1.0 / X;
            tmp_y = j * 1.0 / X;
            val = 0;
            val = val + img(max(1,floor(tmp_x)), max(1,floor(tmp_y))) * (1 - abs(tmp_x - max(1,floor(tmp_x)))) * (1 - abs(tmp_y - max(1,floor(tmp_y))));
            val = val + img(max(1,floor(tmp_x)), min(c, ceil(tmp_y))) * (1 - abs(tmp_x - max(1, floor(tmp_x)))) * (1 - abs(tmp_y - min(c, ceil(tmp_y))));
            val = val + img(min(r, ceil(tmp_x)), max(1, floor(tmp_y))) * (1 - abs(tmp_x - min(r, ceil(tmp_x)))) * (1 - abs(tmp_y - max(1, floor(tmp_y))));
            val = val + img(min(r, ceil(tmp_x)), min(c, ceil(tmp_y))) * (1 - abs(tmp_x - min(r, ceil(tmp_x)))) * (1 - abs(tmp_y - min(c, ceil(tmp_y))));
            output(i, j) = val;
        end
    end
end

function output = RESIZE_COLOR_BILINEAR(img, X)
    img = im2double(img);
    [r, c, d] = size(img);
    new_x = r * X;
    new_y = c * X;
    output = zeros(new_x, new_y, d);

    for i = 1:new_x
        for j = 1:new_y
            for k = 1:3
                tmp_x = i * 1.0 / X;
                tmp_y = j * 1.0 / X;
                val = 0;
                val = val + img(max(1,floor(tmp_x)), max(1,floor(tmp_y)), k) * (1 - abs(tmp_x - max(1,floor(tmp_x)))) * (1 - abs(tmp_y - max(1,floor(tmp_y))));
                val = val + img(max(1,floor(tmp_x)), min(c, ceil(tmp_y)), k) * (1 - abs(tmp_x - max(1, floor(tmp_x)))) * (1 - abs(tmp_y - min(c, ceil(tmp_y))));
                val = val + img(min(r, ceil(tmp_x)), max(1, floor(tmp_y)), k) * (1 - abs(tmp_x - min(r, ceil(tmp_x)))) * (1 - abs(tmp_y - max(1, floor(tmp_y))));
                val = val + img(min(r, ceil(tmp_x)), min(c, ceil(tmp_y)), k) * (1 - abs(tmp_x - min(r, ceil(tmp_x))) * abs(tmp_y - min(c, ceil(tmp_y))));
                output(i, j, k) = val;
            end
        end
    end
end