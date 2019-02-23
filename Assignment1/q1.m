[y, Fs] = audioread('sa_re_ga_ma.wav');
y = y(:, 1:1);
sound(y, Fs);
plot(y);
%Increase Speed of Signal by 2
y_increase = y(1:2:end,:);
sound(y_increase, Fs);
plot(y_increase);
%Decrease speed of Signal by 2
y_decrease = resample(y, 2, 1);
sound(y_decrease, Fs);
plot(y_decrease);
%Comparison graph
hold on;
plot(y_decrease, 'b');
plot(y, 'r');
plot(y_increase, 'g');