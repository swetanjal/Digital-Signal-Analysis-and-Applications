imshow((abs(fft2(fft2(imread('cameraman.tif'))))), []);

% Corrected

imshow(abs(((fft2(fliplr(flipud(fft2(imread('cameraman.tif')))))))), []);