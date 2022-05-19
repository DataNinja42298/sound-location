clear all;
close all;
clc;

c = 340;
d = 0.4;
fs=16000;

%�����ĸ���Ƶ�ļ�
[x1,Fs]=audioread('zero_zero_one_ch15.wav');
[x2,Fs]=audioread('zero_zero_one_ch16.wav');
[x3,Fs]=audioread('zero_zero_one_ch13.wav');
[x4,Fs]=audioread('zero_zero_one_ch14.wav');

x1 = x1(:,1); 
x1 = x1'; 
N = length(x1);%��ȡ�������� 
t = (0:N-1)/Fs;%��?ʵ��ʱ�� 
y = fft(x1);%���źŽ�?��?Ҷ�任 
f = Fs/N*(0:round(N/2)-1);%��?ʵ��Ƶ���?�� 
subplot(211); 
plot(t,x1,'g');%����ʱ���� 
axis([0 max(t) -1 1]); 
xlabel('Time / (s)');ylabel('Amplitude'); 
title('�źŵĲ���'); 
grid; 
subplot(212); 
plot(f,abs(y(1:round(N/2)))); 
xlabel('Frequency / (s)');ylabel('Amplitude'); 
title('�źŵ�Ƶ��'); 
grid;

x2 = x2(:,1); 
x2 = x2'; 
N = length(x2);%��ȡ�������� 
t = (0:N-1)/Fs;%��?ʵ��ʱ�� 
y = fft(x2);%���źŽ�?��?Ҷ�任 
f = Fs/N*(0:round(N/2)-1);%��?ʵ��Ƶ���?�� 
subplot(211); 
plot(t,x2,'g');%����ʱ���� 
axis([0 max(t) -1 1]); 
xlabel('Time / (s)');ylabel('Amplitude'); 
title('�źŵĲ���'); 
grid; 
subplot(212); 
plot(f,abs(y(1:round(N/2)))); 
xlabel('Frequency / (s)');ylabel('Amplitude'); 
title('�źŵ�Ƶ��'); 
grid;

x3 = x3(:,1); 
x3 = x3'; 
N = length(x3);%��ȡ�������� 
t = (0:N-1)/Fs;%��?ʵ��ʱ�� 
y = fft(x3);%���źŽ�?��?Ҷ�任 
f = Fs/N*(0:round(N/2)-1);%��?ʵ��Ƶ���?�� 
subplot(211); 
plot(t,x3,'g');%����ʱ���� 
axis([0 max(t) -1 1]); 
xlabel('Time / (s)');ylabel('Amplitude'); 
title('�źŵĲ���'); 
grid; 
subplot(212); 
plot(f,abs(y(1:round(N/2)))); 
xlabel('Frequency / (s)');ylabel('Amplitude'); 
title('�źŵ�Ƶ��'); 
grid;

x4 = x4(:,1); 
x4 = x4'; 
N = length(x4);%��ȡ�������� 
t = (0:N-1)/Fs;%��?ʵ��ʱ�� 
y = fft(x4);%���źŽ�?��?Ҷ�任 
f = Fs/N*(0:round(N/2)-1);%��?ʵ��Ƶ���?�� 
subplot(211); 
plot(t,x4,'g');%����ʱ���� 
axis([0 max(t) -1 1]); 
xlabel('Time / (s)');ylabel('Amplitude'); 
title('�źŵĲ���'); 
grid; 
subplot(212); 
plot(f,abs(y(1:round(N/2)))); 
xlabel('Frequency / (s)');ylabel('Amplitude'); 
title('�źŵ�Ƶ��'); 
grid;

%PHAT


N=449;
s1=fft(x1,2*N-1);
s2=fft(x2,2*N-1);
s3=fft(x3,2*N-1);
s4=fft(x4,2*N-1);


%���㷽λ���ӳ�
S42=s4.*conj(s2);
gain=1./abs(S42);
G42=fftshift(ifft(S42.*gain));

figure(1)
subplot(2,2,1)
plot(G42);
title('T42')
[Gvalue,G]=max(G42);
T42=(1/fs)*abs(N-G)*1000;
if N>G
    sprintf("s2��s4�Ӻ�%.5fms\n",T42)
else 
    sprintf("s4��s2�Ӻ�%.5fms\n",T42)
end

S13=s1.*conj(s3);
gain=1./abs(S13);
G13=fftshift(ifft(S13.*gain));

subplot(2,2,2)
plot(G13);
title('T13')
[Gvalue,G]=max(G13);
T13=(1/fs)*abs(N-G)*1000;
if N>G
    sprintf("s3��s1�Ӻ�%.5fms\n",T13)
else 
    sprintf("s1��s��3��%.5fms\n",T13)
end

S23=s2.*conj(s3);
gain=1./abs(S23);
G23=fftshift(ifft(S23.*gain));

subplot(2,2,3)
plot(G23);
title('T23')
[Gvalue,G]=max(G23);
T23=(1/fs)*abs(N-G)*1000;
if N>G
    sprintf("s3��s2�Ӻ�%.5fms\n",T23)
else 
    sprintf("s2��s3�Ӻ�%.5fms\n",T23)
end

S14=s1.*conj(s4);
gain=1./abs(S14);
G14=fftshift(ifft(S14.*gain));

subplot(2,2,4)
plot(G14);
title('T14')
[Gvalue,G]=max(G14);
T14=(1/fs)*abs(N-G)*1000;
if N>G
    sprintf("s4��s1�Ӻ�%.5fms\n",T14)
else 
    sprintf("s1��s4�Ӻ�%.5fms\n",T14)
end

%���㷽λ��
azimuth=atan((T42-T13)/(T23+T14))*180/pi;
fprintf('��λ��Ϊ��%.5f��\n',azimuth);

%���������ӳ�
S31=s3.*conj(s1);
gain=1./abs(S31);
G31=fftshift(ifft(S31.*gain));

figure(2)
subplot(2,2,1)
plot(G31);
title('T31')
[Gvalue,G]=max(G31);
T31=(1/fs)*abs(N-G)*1000;
if N>G
    sprintf("s1��s3�Ӻ�%.5fms\n",T31)
else 
    sprintf("s3��s1�Ӻ�%.5fms\n",T31)
end

S41=s4.*conj(s1);
gain=1./abs(S41);
G41=fftshift(ifft(S41.*gain));

subplot(2,2,2)
plot(G41);
title('T41')
[Gvalue,G]=max(G41);
T41=(1/fs)*abs(N-G)*1000;
if N>G
    sprintf("s1��s4�Ӻ�%.5fms\n",T41)
else 
    sprintf("s4��s1�Ӻ�%.5fms\n",T41)
end

S21=s2.*conj(s1);
gain=1./abs(S21);
G21=fftshift(ifft(S21.*gain));

subplot(2,2,3)
plot(G21);
title('T21')
[Gvalue,G]=max(G21);
T21=(1/fs)*abs(N-G)*1000;
if N>G
    sprintf("s1��s2�Ӻ�%.5fms\n",T21)
else 
    sprintf("s2��s1�Ӻ�%.5fms\n",T21)
end

T31=T31*10^-3;
T41=T41*10^-3;
T21=T21*10^-3;

%��������
thita=asin(c*sqrt((T31^2+(T41-T21)^2)/8)/d);
thita=thita*180/pi;
fprintf('����Ϊ��%.5f��\n',thita);