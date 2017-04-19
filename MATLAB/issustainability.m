function [ismeet]=issustainability(scorek,t)
scorekabs=abs(scorek)
summeet=0;
if(t==1)
    ismeet=-1;
    return ;
end
for k=1:6
    if(scorekabs(k,t)-scorekabs(k,t-1)>=0)
       summeet=summeet+1;
    end
end
if(scorekabs(1,t)/scorekabs(4,t)>=scorekabs(1,t-1)/scorekabs(4,t-1))
    summeet=summeet+1;
end
if(scorekabs(1,t)/scorekabs(5,t)>=scorekabs(1,t-1)/scorekabs(5,t-1))
    summeet=summeet+1;
end
summeet=summeet/8*10;
if(summeet>8)
    ismeet=1;
else
    ismeet=0;
end
return ;
end