function shangquan(x)
digits(32);
[n,m]=size(x);
k=1/log(n);
X=zeros(n,m);
    %����ȥ����
    for j=1:m
        c=sort(x(:,j));
        max=c(n);
        min=c(1);
        X(:,j)=(x(:,j)-min)/(max-min)+1;
    end
    X
    %���ؾ��󣬼���һ��ȥ���پ���
    p=[];
    for j=1:m
        th=0;
        for t=(X(:,j))'
            th=th+t;
        end
        Ph=X(:,j)/th;
        p=[p Ph];
    end
    p
    %����ָ����Ϣ��ֵ����
    e=[];
    for j=1:m
        eg=0;
        for i=1:n
            eh=-k*p(i,j)*log(p(i,j));
            eg=eg+eh;
        end
        e=[e,eg];
    end
    %�������е�ָ����Ϣ��ֵ֮��
    E=0;
    for j=1:m
        E=E+e(j);
    end
    %������ֵȨ��
    g=[];
    for j=1:m
        gh=(1-e(j))/(m-E);
        g=[g,gh];
    end
    %������Ȩ֮��
    Eh=0;
    for nh=g
       Eh=Eh+nh;
    end
    %������ֵȨ��
    w=[];
    for j=1:m
        wh=g(j)/Eh;
        w=[w,wh];
    end
    w
    %���ؾ������Ȩ�صõ�����
    s=[];
    for i=1:n
        sh=w.*p(i,:);
        shen=0;
        for she=sh
            shen=shen+she;
        end
            s=[s;shen];
    end
    s
    %����Ƚ�s����Ԫ�ؼ���
end