%����������
function result= nanpolyintp(dat,deltasx,i)
result=dat;
[it,len]=size(result);
nani=isnan(result);
%ȫ�������0��ֻ��һ����ȫ�����
if(sum(nani)==len)
    result(nani)=0;
    fprintf('��%d��û�����ݣ�ȫ����Ϊ0.\n',i);
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
    fprintf('��%d��ֻ��1�����ݣ�ȫ����Ϊ%f.\n',i,singlenum);
    tempmar=ones(it,deltasx)*singlenum;
    result=[result,tempmar];
    return;
    end
    
%���
polyx=[];
polyy=[];
if(any(nani))
    fprintf('��%d����%d����ȱ.\n',i,sum(nani));
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
    %��ֵ���Ԥ���ȱ
    for t=1:len
        if (isnan(result(t)))
            result(t)=polyval(pfi,t);
        end
    end
    for t=(len+1):(len+deltasx)
        result=[result polyval(pfi,t)];
    end
else if(i==9)
    %��ֵ���Ԥ���ȱ
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