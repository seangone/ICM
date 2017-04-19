clc;clear;
cateofindicator=[0 1 4 4 4 3 4 1 1 1 1 1 1 1 2 1 2 2 3 3 3 3 5];
load('-mat','indicator_index.mat');
%k代表是子系统
%数据预处理
[numk0,txt]=xlsread('DATA0',2,'N2:AB24');
[sy,sx]=size(numk0);
numk2=zeros(sy,sx);
fprintf('以上是原始数据。\n原始数据尺寸: %d * %d (should be 23*24)\n',sy,sx)
%数据缺值处理
for i=1:sy
    numk2(i,:)=nanpolyintp(numk0(i,:),0,i);
end
%负性指标处理No18
for t=1:sx
    numk2(18,t)=1/numk2(18,t);
end
load('-mat','standardofNOR.mat');
%预测
futureyear=20;
numk3=zeros(sy,sx+futureyear);
for i=1:sy
    numk3(i,:)=nanpolyintp(numk2(i,:),futureyear,i);
end
[sy,sx]=size(numk3);
%数据标准化处理
numk3sign=zeros(sy,sx);
numk4=zeros(sy,sx);
for i=1:sy
    numk3sign(i,:)=sign(numk3(i,:));
    numk4(i,:)=sqrt(abs(numk3(i,:))/stan(i))*10;
    for t=1:sx
        numk4(i,t)=numk4(i,t)*numk3sign(i,t);
    end
end

indicator_indexK=zeros(5,sy);
for i=1:sy
    if(cateofindicator(i))
        indicator_indexK(cateofindicator(i),i)=indicator_index(i);
    end
end


scorek=zeros(6,sx);
for k=1:5
    %计算每一年的子系统评分
    numk=numk4;
    uk=indicator_indexK(k,:);
    for t=1:sx
        numk(:,t)=uk'.*numk(:,t);
    end
    for i=1:sy
        scorek(k,:)=scorek(k,:)+numk(i,:);
    end
    %scorek
%     figure(k)
%     hold on;
%     plot([1999:1999-1+sx],scorek(k,:))
%     xlabel('year')
%     ylabel('Socre of Subsystem')
end
%计算每一年的综合评分
numk=numk4;
numkact=numk;
uk=indicator_index;
for t=1:sx
    numk(:,t)=uk'.*numk(:,t);
end
for i=1:sy
    scorek(6,:)=scorek(6,:)+numk(i,:);
end
t=[0:sx-1-15];
et=[zeros(1,15) 2.1*power(0.9,t)];
 scorek(6,:)=scorek(6,:)+et;

% for k=1:5
%     scorek(6,:)=scorek(6,:)+scorek(k,:);
% end
%scorek
figure(6)
hold on;
ismeet=zeros(1,sx);
plotx=[0 0];ploty=[0 0];

plotx=[1999:2033]
ploty=[scorek(6,:)]
plot(plotx,ploty,'r:')
% for t=1:sx
%     ismeet(t)=issustainability(scorek,t);
%     if(t>=2)
%     if(ismeet(t))
%         plotx=[1999+t-2:1999+t-1]
%         ploty=[scorek(6,t-1) scorek(6,t)]
%         plot(plotx,ploty,'r-');
%     else
%         plotx=[1999+t-2:1999+t-1]
%         ploty=[scorek(6,t-1) scorek(6,t)]
%         plot(plotx,ploty,'b:');
%     end
%     end
% end
xlabel('year')
ylabel('Total socore')
scorek

% figure(7)
% pxxxx=[1999:2013]
% pyyyy1=numk2(9,:)
% pyyyy2=numk2(12,:)
% plot([1999:2033],numk3(9,:))
% hold on
% plot([1999:2033],numk3(12,:))
% hold off