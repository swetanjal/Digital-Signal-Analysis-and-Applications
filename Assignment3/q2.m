f = double(imread('lena256.jpg'));
h = double(imread('cameraman256.tif'));
F = fft2(f);
H = fft2(h);
imshow(f, []);
imshow(h, []);
convolution = conv2(f, h);
idft = ifft2(F .* H);
imshow(convolution, []);
imshow(idft, []);

sub = convolution(128:128 + 256 - 1, 128: 128 + 256 - 1);
imshow(sub, []);

avg_error = sum(sum((sub - idft) * (sub - idft))) * 1.0/ (256 * 256);

f_padded = padarray(f, [255, 255], 0, 'post');
h_padded = padarray(h, [255, 255], 0, 'post');
F_padded = fft2(f_padded);
H_padded = fft2(h_padded);
idft_padded = ifft2(F_padded .* H_padded);
imshow(idft_padded, []);

new_avg_error = sum(sum((convolution - idft_padded) * (convolution - idft_padded))) * 1.0/ (256 * 256);