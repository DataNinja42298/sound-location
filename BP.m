clc
clear
%% ����ѵ��������Ԥ������
%%%ѵ������
A=[4.9,4.9,1];%%%��˷�A������
B=[4.9,5.1,1];%%%��˷�B������
C=[5.1,5.1,1];%%%��˷�C������
D=[5.1,4.9,1];%%%��˷�D������
x=20:5:70;y=20:5:70;%%%��100������ѵ��
%x=5:5:100;y=5:5:100;%%%��400������ѵ��
[X,Y]=meshgrid(x,y);
tAB=(sqrt((A(1)-X).^2+(A(2)-Y).^2+A(3).^2)-sqrt((B(1)-X).^2+(B(2)-Y).^2+B(3).^2)); %%%��Դ��A��B������˷��ʱ����ͬ
tBC=(sqrt((B(1)-X).^2+(B(2)-Y).^2+B(3).^2)-sqrt((C(1)-X).^2+(C(2)-Y).^2+C(3).^2));
tCD=(sqrt((C(1)-X).^2+(C(2)-Y).^2+C(3).^2)-sqrt((D(1)-X).^2+(D(2)-Y).^2+D(3).^2));
ttAB=tAB(:)';
ttBC=tBC(:)';
ttCD=tCD(:)';
input_train=[ttAB;ttBC;ttCD];%%%ѵ�����ݵ�����ֵ������˷����������ʱ��
XX=X(:)';
YY=Y(:)';
output_train=[XX;YY];%%%ѵ�����ݵ����ֵ����λ�����꣩
%%%Ԥ������
m=10;   %%%Ԥ��m��λ�ã����Ƿֱ���Դ�ŵ�m��λ�ã���BP�������㷨Ԥ�⣬Ȼ��Ա�Ԥ������ʵ�ʽ����
X=rand(1,m)*100;
Y=rand(1,m)*100;
tAB=(sqrt((A(1)-X).^2+(A(2)-Y).^2+A(3).^2)-sqrt((B(1)-X).^2+(B(2)-Y).^2+B(3).^2));
tBC=(sqrt((B(1)-X).^2+(B(2)-Y).^2+B(3).^2)-sqrt((C(1)-X).^2+(C(2)-Y).^2+C(3).^2));
tCD=(sqrt((C(1)-X).^2+(C(2)-Y).^2+C(3).^2)-sqrt((D(1)-X).^2+(D(2)-Y).^2+D(3).^2));
input_test=[tAB;tBC;tCD];%%%Ԥ�����ݵ�����ֵ������˷����������ʱ��
real_locate=[X;Y];%%%��ʵ����Դ���꣬���ڼ���Ԥ��ֵ�Ƿ���ȷ
%% ���ݹ�һ��
[inputn,inputps]=mapminmax(input_train);  %%%����inputps�����ڼ�¼���ݹ�һ������
[outputn,outputps]=mapminmax(output_train);   %%%outputpsͬ��
%% BP����ѵ��
% %��ʼ������ṹ
net=newff(inputn,outputn,7);%%%����һ����7����Ԫ��ɵ����ز㹹����һ�����磬�����°�matlab���÷�
net.trainParam.epochs=5000;%%%����������
net.trainParam.lr=0.1;%%%ѧϰ��
net.trainParam.goal=0.000004;%%%Ŀ�����
net.trainParam.max_fail=10000;
%����ѵ��
net=train(net,inputn,outputn);
%% BP����Ԥ��
%Ԥ�����ݹ�һ��
inputn_test=mapminmax('apply',input_test,inputps);%%%�Բ��������ٽ������ݹ�һ����֮ǰ�Ƕ�ѵ�����ݽ������ݹ�һ�������ҹ�һ����ʽ��ǰ���һ��
 
%����Ԥ�����
an=sim(net,inputn_test);   %ѵ������Ľ��
 
%�����������һ��
BPoutput=mapminmax('reverse',an,outputps);%%����һ���õ�ʵ�ʽ��
%% �������
for i=1:m
fprintf('��%d �β��Ե�ʵ��λ���ǣ�(%d,%d)',i,real_locate(:,i));fprintf('\n');
fprintf('BP������Ԥ��λ���ǣ�(%d,%d)',BPoutput(:,i));fprintf('\n');
end
%%%��ͼ
plot(real_locate(1,:),real_locate(2,:),'*')
hold on
plot(BPoutput(1,:),BPoutput(2,:),'o')
legend('ʵ��λ��','Ԥ��λ��')
title('BP����Ԥ�����','fontsize',12)
ylabel('Y����','fontsize',12)
xlabel('X����','fontsize',12)
%%%��������Ԥ��λ�õķ�����ʵ��λ�õķ�������ȡ����ֵ����ӣ�
figure(2)
r=real_locate-BPoutput;
r=abs(r(1,:))+abs(r(2,:));
plot(r,'-*')
title('BP����Ԥ�����','fontsize',12)
legend('���')
ylabel('���(��λ/�ף�','fontsize',12)
xlabel('λ��','fontsize',12)
