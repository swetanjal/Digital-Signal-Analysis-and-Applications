img64 = double(imread('lena.jpg'));
imshow(img64, []);
img128 = padarray(img64, [64 64], 0, 'post');
imshow(img128, []);
img256 = padarray(img128, [128 128], 0, 'post');
imshow(img256, []);
img512 = padarray(img256, [256 256], 0, 'post');
imshow(img512, []);

img64_fft = fft2(img64);
imshow(log(abs(img64_fft)), []);

img128_fft = fft2(img128);
imshow(log(abs(img128_fft)), []);

img256_fft = fft2(img256);
imshow(log(abs(img256_fft)), []);

img512_fft = fft2(img512);
imshow(log(abs(img512_fft)), []);