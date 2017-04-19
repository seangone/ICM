clc;clear;
cateofindicator=[4 1 4 4 4 3 4 1 1 1 1 1 1 1 2 1 2 2 3 3 3 3 5];
inds1=[];inds2=[];inds3=[];inds4=[];inds5=[];
for k=2:17
    %k代表是子系统
    %数据预处理
    [numk0,txt]=xlsread('DATA',k,'N2:AB24');
    [sy,sx]=size(numk0);
    numk2=zeros(sy,sx);
    fprintf('以上是第%d个国家的原始数据。\n尺寸: %d * %d (should be 23*24)\n',k,sy,sx)
    %数据缺值处理
    for i=1:sy
        numk2(i,:)=nanpolyintp(numk0(i,:),0,i);
    end

    %负性指标处理No18
    for t=1:sx
        numk2(18,t)=1/numk2(18,t);
    end
    
    ind1=[];ind2=[];ind3=[];ind4=[];ind5=[];
    %提取各个子系统的指标矩阵
    for i=1:sy
%         if(any(numk2(i,:)))
            switch (cateofindicator(i))
                case 1
                    ind1=[ind1;numk2(i,:)];
                case 2
                    ind2=[ind2;numk2(i,:)];
                case 3
                    ind3=[ind3;numk2(i,:)];
                case 4
                    ind4=[ind4;numk2(i,:)];
                case 5
                    ind5=[ind5;numk2(i,:)];
            end
%         end
    end
    inds1=[inds1 ind1];
    inds2=[inds2 ind2];
    inds3=[inds3 ind3];
    inds4=[inds4 ind4];
    inds5=[inds5 ind5];
end
[normdat1,indicator_index1,tf1]=zhuchengfen(inds1');
[normdat2,indicator_index2,tf2]=zhuchengfen(inds2');
[normdat3,indicator_index3,tf3]=zhuchengfen(inds3');
[normdat4,indicator_index4,tf4]=zhuchengfen(inds4');
[normdat5,indicator_index5,tf5]=zhuchengfen(inds5');
indicator_index=[];
c1=0;c2=0;c3=0;c4=0;c5=0;
for i=1:sy
    switch (cateofindicator(i))
        case 1
            c1=c1+1;
            indicator_index=[indicator_index indicator_index1(c1)];
        case 2
            c2=c2+1;
            indicator_index=[indicator_index indicator_index2(c2)];
        case 3
            c3=c3+1;
            indicator_index=[indicator_index indicator_index3(c3)];
        case 4
            c4=c4+1;
            indicator_index=[indicator_index indicator_index4(c4)];
        case 5
            c5=c5+1;
            indicator_index=[indicator_index indicator_index5(c5)];
    end
end
tf=tf1+tf2+tf3+tf4+tf5;
fid=fopen('indicator_index.txt','wt');
fprintf(fid,'%10.6g ',indicator_index1);
fprintf(fid,'\n');
fprintf(fid,'%10.6g ',indicator_index2);
fprintf(fid,'\n');
fprintf(fid,'%10.6g ',indicator_index3);
fprintf(fid,'\n');
fprintf(fid,'%10.6g ',indicator_index4);
fprintf(fid,'\n');
fprintf(fid,'%10.6g ',indicator_index5);
fclose(fid);