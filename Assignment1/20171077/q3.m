faces = imread('Faces.jpg');
exact_face = imread('F1.jpg');
noisy_face = imread('F2.jpg');
noisy_face = smoothdata(noisy_face, 'movmedian');
faces = im2double(faces);
exact_face = im2double(exact_face);
[R, C, d] = size(faces);
[r, c, d] = size(exact_face);
res = faces;
minimum_diff = 1000000000000;
x = -1;
y = -1;
for i = 1:R
    for j = 1:C
        flag = 1;
        diff = 0;
        for k = 0:r-1
            for l = 0:c-1
                if (i + k > R) || (j + l > C)
                    flag = 0;
                    break;
                end
                %disp(abs(faces(i + k, j + l, 2) - exact_face(k + 1, l + 1, 2)));
                diff = diff + abs(faces(i + k, j + l, 1) - exact_face(k + 1, l + 1, 1)) + abs(faces(i + k, j + l, 2) - exact_face(k + 1, l + 1, 2)) + abs(faces(i + k, j + l, 3) - exact_face(k + 1, l + 1, 3));
            end
            if flag == 0
                break
            end
        end
        %disp(diff);
        if flag == 1
            if diff < minimum_diff
                minimum_diff = diff;
                x = i;
                y = j;
            end
            %disp(faces(i, j, 1) - exact_face(1, 1, 1));
        end
    end
end
x_exact = x;
y_exact = y;


minimum_diff = 1000000000000;
x = -1;
y = -1;
for i = 1:R
    for j = 1:C
        flag = 1;
        diff = 0;
        for k = 0:r-1
            for l = 0:c-1
                if (i + k > R) || (j + l > C)
                    flag = 0;
                    break;
                end
                %disp(abs(faces(i + k, j + l, 2) - exact_face(k + 1, l + 1, 2)));
                diff = diff + abs(faces(i + k, j + l, 1) - noisy_face(k + 1, l + 1, 1)) + abs(faces(i + k, j + l, 2) - noisy_face(k + 1, l + 1, 2)) + abs(faces(i + k, j + l, 3) - noisy_face(k + 1, l + 1, 3));
            end
            if flag == 0
                break
            end
        end
        %disp(diff);
        if flag == 1
            if diff < minimum_diff
                minimum_diff = diff;
                x = i;
                y = j;
            end
            %disp(faces(i, j, 1) - exact_face(1, 1, 1));
        end
    end
end
x_noisy = x;
y_noisy = y;

imshow(faces);
hold on;
rectangle('Position', [y_exact, x_exact, c, r],...
   'Curvature', [0, 0], ...
   'EdgeColor', 'r',...
    'LineWidth', 2, 'LineStyle', '-');
%rectangle('Position', [y_noisy, x_noisy, c, r],...
%   'Curvature', [0, 0], ...
%   'EdgeColor', 'b',...
%    'LineWidth', 2, 'LineStyle', '-');
