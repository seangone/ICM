function [normdat,indicator_index,tf]=zhuchengfen(gj)
    gj=zscore(gj); %���ݱ�׼��
    normdat=gj;
    r=corrcoef(gj); %�������ϵ������
    %�����������ϵ������������ɷַ����� x����Ϊr�����������������ɷֵ�ϵ��
    [x,y,z]=pcacov(r); %yΪr������ֵ�� zΪ�������ɷֵĹ�����
    %�Զ�ѡȡ���ɷ�
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
    f=repmat(sign(sum(x)),size(x,1),1); %������xͬά����Ԫ��Ϊ�� 1�ľ���
    x=x.*f; %�޸����������������ţ�ÿ�����������������з����͵ķ��ź���ֵ
    num=pointz; %numΪѡȡ�����ɷֵĸ���
    %num=sizez;
    %df=gj*x(:,1:num) %����������ɷֵĵ÷�
    %tf1=df*z(1:num)/100; %�����ۺϵ÷�
    indicator_index=x(:,1:num)*z(1:num)/100;
    tf=gj*indicator_index;
    indicator_index=indicator_index';
    %[stf,ind]=sort(tf,'descend'); %�ѵ÷ְ��մӸߵ��͵Ĵ�������
    %stf=stf', ind=ind'
end