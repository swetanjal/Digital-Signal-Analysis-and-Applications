imshow(spec(1000, 1000), [0 255]);
%%%%Part 2
%spectrogram(audioread('message.wav'), 2000, 'yaxis');
%%% Answer is Joker.
%%%%%%%%%%
%part3();
%%%%Part 3
function output = part3()
    Fs = 44100;
    space = 0.3;
    mark = 0.5;
    low_freq = [0,0,0,0,0,0,0,0,0,0];
    high_freq = [0,0,0,0,0,0,0,0,0,0];
    for j = 0:9
        file = strcat(strcat('./q3/', int2str(j)), '.ogg');
        [tone0, fs] = audioread(file);
        %sound(tone0, Fs);
        %plot(tone0)
        X = fft(tone0);
        X_mag = abs(X);
        X_angle = angle(X);
        %stem(X_mag)
        low = -1;
        high = -1;
        c = 0;
        for i = 1:size(X_mag)
            if X_mag(i) > 2000
                c = c+1;
                if low == -1
                    low = i - 1;
                elseif high == -1
                    high = i - 1;
                end
            end
            if c == 2
                break
            end
        end
        low_freq(j + 1) = low;
        high_freq(j + 1) = high;
    end
    roll = '20171077';
    output = []
    for d = 1 : size(roll, 2)
       digit = str2num(roll(d));
       for n = 1 : Fs * mark
           output = [output; sin(2.0 * pi * low_freq(digit + 1) * n / Fs) + sin(2.0 * pi * high_freq(digit + 1) * n / Fs)];
       end
       for n = 1 : Fs * space
           output = [output; 0];
       end
    end
    sound(output, Fs);
end
%%%%%%%%%%

%%%%Part 1
function output = spec(w_sz, stride)
    [y, Fs] = audioread('chirp.wav');
    output = zeros(w_sz,size(y, 1));
    for i = 1 : stride : size(y, 1) - w_sz
        temp = y(i : i + w_sz - 1 , :);
        mat = abs(fft(temp));
        %mat = mat ./ max(mat);
        %mat = mat .* 256;
        for j = i : i + w_sz - 1
           output(:, j:j) = output(:, j:j) + mat; 
        end
    end
    output = output ./ max(output);
    output = output .* 255;
end

%%%%%%%%%%