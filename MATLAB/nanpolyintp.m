%输入行向量
function result= nanpolyintp(dat,deltasx,i)
result=dat;
[it,len]=size(result);
nani=isnan(result);
%全空则填充0，只有一个数全部填充
if(sum(nani)==len)
    result(nani)=0;
    fprintf('第%d行没有数据，全部填为0.\n',i);
    tempmar=zeros(it,deltasx);
    result=[result,tempmar];
    return;
else if(sum(nani)==len-1)
    for t=1:len
        if (~isnan(result(t)))
            singlenum=result(t);
        end
    end
    result(nani)=singlenum;
    fprintf('第%d行只有1个数据，全部填为%f.\n',i,singlenum);
    tempmar=ones(it,deltasx)*singlenum;
    result=[result,tempmar];
    return;
    end
    
%拟合
polyx=[];
polyy=[];
if(any(nani))
    fprintf('第%d行有%d个空缺.\n',i,sum(nani));
    for t=1:len
        if(~isnan(result(t)))
            polyx=[polyx t];
            polyy=[polyy result(t)];
        end
    end
else
    polyx=[1:len];
    polyy=result;
end
if(i~=9&&i~=12)
    pfi=polyfit(polyx,polyy,min(1,len));
    %插值，填补预测空缺
    for t=1:len
        if (isnan(result(t)))
            result(t)=polyval(pfi,t);
        end
    end
    for t=(len+1):(len+deltasx)
        result=[result polyval(pfi,t)];
    end
else if(i==9)
    %插值，填补预测空缺
    for t=1:len
        if (isnan(result(t)))
            result(t)=-0.03161*t+0.3612*sin(1.6*t+0.887)+1.228;
        end
    end
    for t=(len+1):(len+deltasx)
        result=[result -0.03161*t+0.3612*sin(1.6*t+0.887)+1.228];
    end
else if(i==12)
    for t=1:len
        if (isnan(result(t)))
            result(t)=0.7192*sin(1.2*t+0.2113)+4.142;
        end
    end
    for t=(len+1):(len+deltasx)
        result=[result 0.7192*sin(1.2*t+0.2113)+4.142];
    end
end
end
end
end