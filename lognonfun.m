function [yiw,beta0] = lognonfun(metric,mode,data)
metric = rescale(metric);
model=@(beta,x) ((beta(1)-beta(2))./(1+exp((-x+beta(3))./abs(beta(4)))))+beta(2);
if strcmp(mode,'train')
    DMOS = data;
    beta(1)=max(DMOS);
    beta(2)=min(DMOS);
    beta(3)=mean(metric);
    beta(4)=1;
    opts = statset('nlinfit');
    opts.RobustWgtFun = 'welsch';
    beta0 = nlinfit(metric,DMOS,model,beta,opts);
elseif strcmp(mode,'fun')
    beta0 = data;
end
yiw = feval(model,beta0,metric);
end 