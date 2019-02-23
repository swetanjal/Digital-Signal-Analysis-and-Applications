%%% DFT
%img = double(imread('inp1.png'));
%inbuilt = fft2(img);
%DFT = twodDFT(img);
%imagesc(log(abs(DFT)));
%imagesc(log(abs(inbuilt)));
%%%%%%%%
%%% FFT
arr = [1;2;3;4];
disp(RECURSIVEtwodFFT(arr));
disp(twodDFT(arr));
disp(fft2(arr));
%%%%%%%
function output = twodDFT(I)
    N1 = size(I, 2);
    N2 = size(I, 1);
    WN1 = zeros(N1);
    WN2 = zeros(N2);
    for m = 1:N1
        for k = 1:N1
            WN1(m, k) = exp(-1i*2.0*pi*(m - 1)*(k - 1)*1.0/N1);
        end
    end
    for m = 1:N2
        for k = 1:N2
            WN2(m, k) = exp(-1i*2.0*pi*(m - 1)*(k - 1)*1.0/N2);
        end
    end
    output = WN2 * I * WN1;
end
%%% FFT
function y = RECURSIVEonedFFT(a)
    n = size(a, 1);
    if n == 1
       y = a;
       return;
    end
    a_even = a(1 : 2 : end, :);
    a_odd = a(2 : 2 : end, :);
    y_even = RECURSIVEonedFFT(a_even);
    y_odd = RECURSIVEonedFFT(a_odd);
    %y = zeros([n, 1]);
    E = [];
    for k = 0 : (n / 2) - 1
       E = [E; exp(-1i * 2.0 * pi * k / n)]; 
    end
    y = [y_even + E .* y_odd; y_even - E.* y_odd];
    %for k = 0 : (n / 2) - 1
    %    y((k + 1), 1) = y_even(k + 1, 1) + exp(-1i * 2.0 * pi * k/ n) * y_odd(k + 1, 1);
    %    y((k + 1) + (n / 2), 1) = y_even(k + 1, 1) - exp(-1i * 2.0 * pi * k/ n) * y_odd(k + 1, 1);
    %end
end

function output = RECURSIVEtwodFFT(I)
    N1 = size(I, 2);
    N2 = size(I, 1);
    colffts = [];
    output = [];
    for i = 1 : N1
       temp = I(:, i:i);
       colffts = [colffts, RECURSIVEonedFFT(temp)];
    end
    for i = 1 : N2
       temp = colffts(i:i, :).';
       output = [output, RECURSIVEonedFFT(temp)];
    end
    output = output.';
end