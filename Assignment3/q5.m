[y1, Fs] = audioread('./q5/1.wav');
[y2, Fs] = audioread('./q5/2.wav');
[y3, Fs] = audioread('./q5/3.wav');
[y4, Fs] = audioread('./q5/4.wav');
[y5, Fs] = audioread('./q5/5.wav');

done = [0; 0; 0; 0; 0];
% We get a cyclic order: 3 5 1 2 4
% But we have to determine the starting datagram.
music = dfs(3, done, y1, y2, y3, y4, y5, Fs);
stem(abs(fft(music)));
sound(medfilt1(music, 5), Fs);
disp(SIMILARITY(y5, y1, Fs));
disp(SIMILARITY(y1, y2, Fs));
disp(SIMILARITY(y2, y4, Fs));
disp(SIMILARITY(y4, y3, Fs)); % This has the least similarity, therefore 3 is the starting and 4 is ending packet.
disp(SIMILARITY(y3, y5, Fs));

function tone = dfs(node, done, y1, y2, y3, y4, y5, Fs)
    disp(node);
    done(node) = 1;
    next = -1;
    delay = -1;
    a = [];
    res = 0;
    for i = 1 : 5
        if done(i) == 1
            continue;
        end
        
        b = [];
        if node == 1
            a = y1;
        end
        if node == 2
            a = y2;
        end
        if node == 3
            a = y3;
        end
        if node == 4
            a = y4;
        end
        if node == 5
            a = y5;
        end
        
        if i == 1
            b = y1;
        end
        if i == 2
            b = y2;
        end
        if i == 3
            b = y3;
        end
        if i == 4
            b = y4;
        end
        if i == 5
            b = y5;
        end
        out = SIMILARITY(a, b, Fs);
        if out(1) >= res
            res = out(1);
            next = i;
        end
    end
    tone = a;
    if next ~= -1
        tone = [a(:, 1); dfs(next, done, y1, y2, y3, y4, y5, Fs)];
    end
    
end

function ret = SIMILARITY(a, b, fs)
    ret = [max(xcorr(a(end - fs * 5 + 1: end, 1), b(1 : fs * 5, 1))) 0];
    return;
end