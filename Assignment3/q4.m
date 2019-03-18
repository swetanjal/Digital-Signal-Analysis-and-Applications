load('Q4.mat');
sound(X, Fs);
plot(X);
F = fft(X);
stem(abs(F));
% Values of 1321 and 882 are read of from the plot which corresponds to 440
% and 293 Hz respectibely
filter = zeros(132301, 1);
filter(1321, 1) = 1;
filter(882, 1) = 1;
filter(132301 - 1321 + 2, 1) = 1;
filter(132301 - 882 + 2, 1) = 1;
%for i = 1 : 132301
%    if i == 1321 || i == 882 || i == (132301 - 1321 + 2) || i == (132301 - 882 + 2) 
%        continue;
%    end
%    F(i, 1) = 0;
%end
F = F .* filter;
Y = ifft(F);
sound(Y, Fs);
audiowrite('q4.wav', Y, Fs);