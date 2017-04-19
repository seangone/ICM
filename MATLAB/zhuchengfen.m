function [normdat,indicator_index,tf]=zhuchengfen(gj)
    gj=zscore(gj); %数据标准化
    normdat=gj;
    r=corrcoef(gj); %计算相关系数矩阵
    %下面利用相关系数矩阵进行主成分分析， x的列为r的特征向量，即主成分的系数
    [x,y,z]=pcacov(r); %y为r的特征值， z为各个主成分的贡献率
    %自动选取主成分
    sizez=size(z);
    cigemaz=0;
    pointz=0;
    for zi=1:sizez
        cigemaz=cigemaz+z(zi);
        if(cigemaz>=90)
            if(z(zi)>=0)
                pointz=zi;
                break;
            end
        end
    end
    f=repmat(sign(sum(x)),size(x,1),1); %构造与x同维数的元素为± 1的矩阵
    x=x.*f; %修改特征向量的正负号，每个特征向量乘以所有分量和的符号函数值
    num=pointz; %num为选取的主成分的个数
    %num=sizez;
    %df=gj*x(:,1:num) %计算各个主成分的得分
    %tf1=df*z(1:num)/100; %计算综合得分
    indicator_index=x(:,1:num)*z(1:num)/100;
    tf=gj*indicator_index;
    indicator_index=indicator_index';
    %[stf,ind]=sort(tf,'descend'); %把得分按照从高到低的次序排列
    %stf=stf', ind=ind'
end