fprintf('Thiết kế bộ lọc thông cao dùng phương pháp cửa sổ \n');
fprintf('Nhập thông số bộ lọc \n');
d1=input('Nhập độ gợn sóng: ');
d2=d1;
pf=input('Passband frequency: ');
sf=input('Stopband frequency: ');
wc=(pf+sf)/2;
D=sf-pf;
fs=3000; %Tần số lấy mẫu
As=20*log(d1); %Tính biên độ dựa trên độ gợn sóng
%%%% Chọn cửa sổ phù hợp
if (As>-30)
fprintf('Chọn cửa sổ Chữ nhật');
window=1;
n=ceil(4*pi/D);
end
if ((As>-49)&&(As<-30))
fprintf('Chọn cửa sổ Hanning');
window=2;
n=ceil(8*pi/D);
end
if ((As>-63)&&(As<-49))
fprintf('Chọn cửa sổ Hamming');
window=3;
n=ceil(8*pi/D);
end
if (As<-63)
fprintf('Chọn cửa sổ Blackman');
window=4;
n=ceil(12*pi/D);
end
%%%% Check đảm bảo m phải là số lẻ
if (rem(n,2)==0)
m=n+1;
else
m=n;
end
fprintf('\nBac cua bo loc %0.0f \n', m); 
%%%% Tính toán hàm cửa sổ dựa trên cửa sổ đã lựa chọn
w=zeros(m,1);
if (window==1) % Theo cửa sổ Chữ nhật
    for i=1:1:m
    w(i)=1;
    end
elseif (window==2) % Theo cửa sổ Hanning
    for i=0:1:(m-1)
    w(i+1)=0.5*(1-cos(2*pi*i/(m-1)));
    end
elseif (window==3) % Theo cửa sổ Hamming
    for i=0:1:(m-1)
    w(i+1)=0.54*1-0.46*cos(2*pi*i/(m-1));
    end
elseif (window==4) % Theo cửa sổ Blackman
    for i=0:1:(m-1)
    w(i+1)=0.42*1-0.45*cos(2*pi*i/(m-1)) + 0.08*cos(4*pi*i/(m-1));
    end
end
%%%% Tính toán đáp ứng xung lý tưởng
a=(m-1)/2;
hd=zeros(m-1,1);
%
for i=0:1:(m-1)
hd(i+1)=-sin(wc*(i-a))/(pi*(i-a));
end
hd(a+1)=1-wc/pi;
%%%%
b1=hd.*w;
h=b1'; % Gán h bằng ma trận chuyển vị của b1
%%%%
N = length(h);  % Độ dài của h
[H, w1] = freqz(h, 1, 1000);  % Tính đáp ứng tần số với 1000 mẫu
db = 20 * log10(abs(H));  % Chuyển đáp ứng tần số sang đơn vị dB
%%%%
n = 0:1:m-1;
%plot
figure; stem (n,hd);
axis ([0,m-1,-0.1,0.8]);
title('Dãy đáp ứng xung của bộ lọc lý tưởng');
xlabel('n'); ylabel('hd(n)');
%
figure; stem (n,w);
axis ([0,m-1,0,1.1]);
title('Dãy hàm cửa sổ');
xlabel('n'); ylabel('w(n)');
%
figure; stem (n,h);
axis ([0,m-1,-0.1,0.8]);
title('Hàm độ lớn tuyệt đối của đáp ứng tần số');
xlabel('n'); ylabel('h(n)');
%
figure;
plot(w1/pi,db); grid; hold on;
plot(-w1/pi,db); grid;
axis([-1,1,-100,10]);
title('Hàm độ lớn tương đối (dB) của đáp ứng tần số');
xlabel('frequency in pi units'); ylabel('Decibels');