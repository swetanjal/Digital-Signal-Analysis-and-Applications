[y, Fs] = audioread('q2.wav');
y = y(:, 1:1);
sound(y, Fs);

y24 = resample(y, 44100, 24000);
sound(y24, Fs);

y16 = resample(y, 44100, 16000);
sound(y16, Fs);

y8 = resample(y, 44100, 8000);
sound(y8, Fs);

y4 = resample(y, 44100, 4000);
sound(y4, Fs);
%Voice simulated in Small church
[smallchurch_y, Fs] = audioread('smallchurch.wav');
smallchurch_y = smallchurch_y(:, 1:1);
H_smallchurch = conv(y, smallchurch_y);
sound(H_smallchurch, Fs);
%Voice simulated in Big Hall
[bighall_y, Fs] = audioread('bighall.wav');
bighall_y = bighall_y(:, 1:1);
H_bighall = conv(y, bighall_y);
sound(H_bighall, Fs);

%Voice simulated in Gated Place
[gatedplace_y, Fs] = audioread('gatedplace.wav');
gatedplace_y = gatedplace_y(:, 1:1);
H_gatedplace = conv(y, gatedplace_y);
sound(H_gatedplace, Fs);