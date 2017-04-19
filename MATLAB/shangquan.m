function shangquan(x)
digits(32);
[n,m]=size(x);
k=1/log(n);
X=zeros(n,m);
    %数据去量纲
    for j=1:m
        c=sort(x(:,j));
        max=c(n);
        min=c(1);
        X(:,j)=(x(:,j)-min)/(max-min)+1;
    end
    X
    %比重矩阵，即归一化去量纲矩阵
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
    %计算指标信息熵值矩阵
    e=[];
    for j=1:m
        eg=0;
        for i=1:n
            eh=-k*p(i,j)*log(p(i,j));
            eg=eg+eh;
        end
        e=[e,eg];
    end
    %计算所有的指标信息熵值之和
    E=0;
    for j=1:m
        E=E+e(j);
    end
    %计算熵值权重
    g=[];
    for j=1:m
        gh=(1-e(j))/(m-E);
        g=[g,gh];
    end
    %计算商权之和
    Eh=0;
    for nh=g
       Eh=Eh+nh;
    end
    %修正熵值权重
    w=[];
    for j=1:m
        wh=g(j)/Eh;
        w=[w,wh];
    end
    w
    %比重矩阵乘以权重得到评分
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
    %下面比较s矩阵元素即可
end