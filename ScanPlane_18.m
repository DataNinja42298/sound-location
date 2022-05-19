clear;
close all;
clc;
%---------初始化常量----------%
c = 340; % 声速c
Fs = 44100; % 抽样频率fs
T = 0.03; % ??
t = 0:1/Fs:T; % 时间 [0,0.1]
N = length(t); % 时间长度
f = 1000;  % 感兴趣的频率
w = 2*pi*f; % 角频率
k = w/c; % 波数 k
%---------各阵元坐标---------%
M = 10;% 阵元个数
Array_Y = zeros(M,1); % 生成一个M*1维的零矩阵
Array_X = [0;0;0;0;0;...
     -0.4;-0.212;-0.024;...
     0.071;0.259;];
 Array_Z = [-0.4;-0.212;-0.024;...%十字形麦克风阵列
     0.071;0.259;...
    0;0;0;0;0];
% Array_X = [0.4;0.376;0.306;0.2;0.069;-0.069;...%均匀圆形麦克风阵列
%     -0.2;-0.306;-0.376;-0.4;-0.376;-0.306;...
%     -0.2;-0.069;0.069;0.2;0.306;0.376]
% Array_Z = [0;0.137;0.257;0.346;0.394;0.346;...
%     0.306;0.2;0.069;-0.0694592710667720;-0.2;-0.3061;...
%     -0.346;-0.394;-0.3943;-0.346;-0.257;-0.137];
%Array_X=[0.000  -1.510  2.458  -12.985  12.196  ...%螺旋型麦克风阵列
%   -6.749  -8.026  18.974  -21.711  6.088 ...
%   29.042  -12.662  -8.619  26.609  -37.427 ...
%   -22.327  36.929  -36.729]'*0.01;
%Array_Z=[0.000  2.104  -0.815  2.877  5.305  ...
%   -11.461  21.234  -12.461  -19.526  28.558 ...
%   3.035  -32.093  33.406  -21.959  -11.352 ...
%   32.099  -12.845  -22.932]'*0.01;



figure
scatter(Array_X,Array_Z,'k','MarkerFaceColor',[0 0 0])%2d array figure
title('螺旋型麦克风阵列')
%--------- 声源位置----------%
% x1 = 12;
% y1 = 10;
% z1 = 12; %声源位置 （12,10,12） x,z为水平面
Signal_X = 0;
Signal_Y = 1;
Signal_Z = 0; %声源位置 （12,10,12） x,z为水平面

% x2 = 12;
% y2 = 0;
% z2 = 12;
Central_X = 0;
Central_Y = 0;
Central_Z = 0;


Ric1 = sqrt((Signal_X-Array_X).^2+(Signal_Y-Array_Y).^2+(Signal_Z-Array_Z).^2); % 声源到各阵元的距离
Ric2 = sqrt((Signal_X-Central_X).^2+(Signal_Y-Central_Y).^2+(Signal_Z-Central_Z).^2);%声源到参考阵元的距离
Rn1 = Ric1 - Ric2; %声源至各阵元与参考阵元的声程差矢量


s1 = 0.5*cos(2*w*t); % 参考阵元接收到的矢量

Am = 10^(-1); % 噪声的振幅
% Am=0.5;
Noise = Am * (randn(M,N)+1i*randn(M,N)); % 各阵元高斯白噪声
figure
plot(abs(Noise(1,:)))
S = zeros(M,N);
%--------------------------各阵元的延迟求和--------------------------------%
for m = 1:M
    S(m,:) = Ric2/Ric1(m)*s1.*exp(-1i*w*Rn1(m)/c);
    % 接收到的信号
end
X = S+Noise; % 各阵元接收的声压信号矩阵
figure
plot(abs(X(1,:)))
R = X*X'/N; % 接收数据的自协方差矩阵 ?A.'是一般转置，A'是共轭转置
%-------扫描范围------%
step_x = 0.01; % 步长设置为0.1
step_z = 0.01;

y = Signal_Y;%扫描面定在Y距离处
x = (-1:step_x:1); % 扫描范围 9-15
z = (-1:step_z:1);


for i=1:length(x)
    for j=1:length(z)
        Ri = sqrt((x(j)-Array_X).^2+(y-Array_Y).^2+(z(i)-Array_Z).^2);% 该扫描点到各阵元的聚焦距离矢量
        
        Ri2 = sqrt((x(j)-Central_X).^2+(y-Central_Y).^2+(z(i)-Central_Z).^2);% 扫描点到各阵元与参考阵元的程差矢量
        
        Rn = Ri-Ri2;
        
        
        A = exp(-1i*2*pi*f*Rn/c); % 声压聚焦方向矢量
        P_CB(i,j) = abs(A'*R*A); % CSM
    end
end
%--------------------------------------归一化------------------------------%
% for m = 1:length(z)
%     pp(m) = max(P_CB(m,:)); % Pcbf 的第k1行的最大元素的值
% end
% 
% P_CB = P_CB/max(pp);  % 所有元素除以其最大值 归一化幅度
P_CB=20*log10(P_CB/max(P_CB(:)));%SPL?分子分母的声压与这个的对应关系是怎样的？
[Z_max,X_max]=find(P_CB==max(P_CB(:)));
disp(['预测坐标X: ',num2str(x(X_max)),'°','预测坐标Z: ',num2str(z(Z_max)),'°'])
%-------------------------------作图展示-----------------------------------%
figure
mesh(x,z,P_CB,'FaceColor','interp');
xlabel('x(m)'),ylabel('z(m)')
title('CBF三维单声源图')
colorbar
map=jet(256);%扩展到256色，颜色条无分层
colormap(map);

figure
h=pcolor(x,z,P_CB);
set(h,'edgecolor','none','facecolor','interp');%去掉网格，平滑网络
map=jet(256);%扩展到256色，颜色条无分层
colormap(map);
xlabel('x(m)');
ylabel('z(m)');
title('CBF单声源图')
colorbar
axis equal
hold on
plot(x(X_max),z(Z_max),'g*')
text(x(X_max),z(Z_max),['  X=',num2str(x(X_max)),newline,'  Z=',num2str(z(Z_max)),newline],'Color','g');
