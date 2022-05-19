clc
clear
%% 生成训练数据与预测数据
%%%训练数据
A=[4.9,4.9,1];%%%麦克风A的坐标
B=[4.9,5.1,1];%%%麦克风B的坐标
C=[5.1,5.1,1];%%%麦克风C的坐标
D=[5.1,4.9,1];%%%麦克风D的坐标
x=20:5:70;y=20:5:70;%%%用100组数据训练
%x=5:5:100;y=5:5:100;%%%用400组数据训练
[X,Y]=meshgrid(x,y);
tAB=(sqrt((A(1)-X).^2+(A(2)-Y).^2+A(3).^2)-sqrt((B(1)-X).^2+(B(2)-Y).^2+B(3).^2)); %%%声源到A，B两个麦克风的时间差，下同
tBC=(sqrt((B(1)-X).^2+(B(2)-Y).^2+B(3).^2)-sqrt((C(1)-X).^2+(C(2)-Y).^2+C(3).^2));
tCD=(sqrt((C(1)-X).^2+(C(2)-Y).^2+C(3).^2)-sqrt((D(1)-X).^2+(D(2)-Y).^2+D(3).^2));
ttAB=tAB(:)';
ttBC=tBC(:)';
ttCD=tCD(:)';
input_train=[ttAB;ttBC;ttCD];%%%训练数据的输入值（是麦克风接受声音的时间差）
XX=X(:)';
YY=Y(:)';
output_train=[XX;YY];%%%训练数据的输出值（是位置坐标）
%%%预测数据
m=10;   %%%预测m个位置（就是分别将声源放到m个位置，用BP神经网络算法预测，然后对比预测结果和实际结果）
X=rand(1,m)*100;
Y=rand(1,m)*100;
tAB=(sqrt((A(1)-X).^2+(A(2)-Y).^2+A(3).^2)-sqrt((B(1)-X).^2+(B(2)-Y).^2+B(3).^2));
tBC=(sqrt((B(1)-X).^2+(B(2)-Y).^2+B(3).^2)-sqrt((C(1)-X).^2+(C(2)-Y).^2+C(3).^2));
tCD=(sqrt((C(1)-X).^2+(C(2)-Y).^2+C(3).^2)-sqrt((D(1)-X).^2+(D(2)-Y).^2+D(3).^2));
input_test=[tAB;tBC;tCD];%%%预测数据的输入值（是麦克风接受声音的时间差）
real_locate=[X;Y];%%%真实的声源坐标，用于检验预测值是否正确
%% 数据归一化
[inputn,inputps]=mapminmax(input_train);  %%%其中inputps是用于记录数据归一化方法
[outputn,outputps]=mapminmax(output_train);   %%%outputps同理
%% BP网络训练
% %初始化网络结构
net=newff(inputn,outputn,7);%%%建立一个由7个神经元组成的隐藏层构成了一个网络，这是新版matlab的用法
net.trainParam.epochs=5000;%%%最大迭代次数
net.trainParam.lr=0.1;%%%学习率
net.trainParam.goal=0.000004;%%%目标误差
net.trainParam.max_fail=10000;
%网络训练
net=train(net,inputn,outputn);
%% BP网络预测
%预测数据归一化
inputn_test=mapminmax('apply',input_test,inputps);%%%对测试数据再进行数据归一化，之前是对训练数据进行数据归一化，而且归一化方式和前面的一样
 
%网络预测输出
an=sim(net,inputn_test);   %训练输出的结果
 
%网络输出反归一化
BPoutput=mapminmax('reverse',an,outputps);%%反归一化得到实际结果
%% 结果分析
for i=1:m
fprintf('第%d 次测试的实际位置是：(%d,%d)',i,real_locate(:,i));fprintf('\n');
fprintf('BP神经网络预测位置是：(%d,%d)',BPoutput(:,i));fprintf('\n');
end
%%%画图
plot(real_locate(1,:),real_locate(2,:),'*')
hold on
plot(BPoutput(1,:),BPoutput(2,:),'o')
legend('实际位置','预测位置')
title('BP网络预测输出','fontsize',12)
ylabel('Y方向','fontsize',12)
xlabel('X方向','fontsize',12)
%%%误差分析（预测位置的分量与实际位置的分量做差取绝对值再相加）
figure(2)
r=real_locate-BPoutput;
r=abs(r(1,:))+abs(r(2,:));
plot(r,'-*')
title('BP网络预测误差','fontsize',12)
legend('误差')
ylabel('误差(单位/米）','fontsize',12)
xlabel('位置','fontsize',12)
