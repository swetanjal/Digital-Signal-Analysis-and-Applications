% Signal 5
[y, Fs] = audioread('signal_5.wav');
music = y(:, 1);
y = music( : , 1);
X = fft(y);
X_mag = abs(X);
stem(X_mag);
cutoff = Fs * 1.0 * 17760 / size(X_mag, 1);
[b, a] = butter(6, cutoff / (Fs / 2));
filtered = filter(b, a, y);
stem(abs(fft(filtered)));
sound(filtered, Fs);
