fprintf('Thiết kế bộ lọc thông cao dùng phương pháp bình phương tối thiểu \n');
fprintf('Nhập thông số bộ lọc \n');
fs = input('Tần số lấy mẫu: ');
t_start = input('Thời gian bắt đầu: ');
t_end = input('Thời gian kết thúc: ');
t = t_start:1/fs:t_end;
f = input('Tần số của tín hiệu sin: ');
x = sin(2*pi*f*t) + 0.5*randn(size(t)); % Tín hiệu sin với nhiễu
num_taps = input('Độ dài của bộ lọc FIR/số lượng mẫu của hồi đáp FIR: ');
cutoff = input('Tần số cắt: ');
% Tạo vector của tần số đáp ứng mong muốn
freq = [0, cutoff, cutoff*1.5, 1];
amp = [1, 1, 0, 0];
b = firls(num_taps, freq, amp);
% Áp dụng bộ lọc FIR cho tín hiệu đầu vào
y = filter(b, 1, x); % Áp dụng bộ lọc FIR
% Vẽ biểu đồ so sánh tín hiệu đầu vào và đầu ra
figure;
subplot(2, 1, 1);
plot(t, x);
title('Tín hiệu đầu vào');
xlabel('Thời gian');
ylabel('Amplitude');
subplot(2, 1, 2);
plot(t, y);
title('Tín hiệu đầu ra sau khi lọc');
xlabel('Thời gian');
ylabel('Amplitude');