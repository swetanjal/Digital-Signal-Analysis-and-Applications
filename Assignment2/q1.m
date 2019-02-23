%%% Part 3
img = imread('cameraman.tif');
%imshow(median_filter(img, 1));
%imshow(median_filter(img, 5));
%imshow(median_filter(img, 10));
%imshow(imfilter(img, gauss_filter(67, 10)));
%imshow(imfilter(img, gauss_filter(67, 3)));
%imshow(imfilter(img, gauss_filter(67, 1)));
%disp(abs(fspecial('gaussian', 67, 3) - gauss_filter(67, 3)))
%%%%%%%%%%%


%%%% Part 4
%inp1 = imread('inp1.png');
%imshow(median_filter(inp1, 3));
%%%%%%%%%%%

%%%% Part 2
function output = median_filter(I, N)
    % Boundary pixels are thrown away by default or zero padding option
    % also there. Uncomment 25-26 if zero padding required.
    %imshow(I);
    %s = N - 1;
    %I = padarray(I, [s s], 'post');
    if(N == 1)
        output = I;
    else
        [r , c] = size(I);
        A = im2col(I, [N N]);
        M = median(A);
        %disp(M)
        dim1 = r - N + 1;
        dim2 = c - N + 1;
        output = col2im(M, [1 1], [dim1 dim2]);
    end
end
%%%%%%%%%

%%% Part1
function output = gauss_filter(N, sigma)
    output = zeros(N, N);
    middle = ceil(N * 1.0 / 2);
    for i = 1:N
        for j = 1:N
            x2 = (i - middle)*(i - middle);
            y2 = (j - middle)*(j-middle);
            output(i,j) = exp(-((x2 * 1.0) / (2 * sigma * sigma)) -((y2 * 1.0) / (2 * sigma * sigma)));            
        end
    end
    res = sum(sum(output));
    output = output / res;
    %disp(res);
end
%%%%%%%%%
