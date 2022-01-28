function Ta = Tag_Matrix( Tags )
T = length(Tags);
dim = zeros(1,T);
c   = ones(1,T);
f   = ones(1,T);
for t=1:T
    dim(t) = length(Tags{t});
end
Ta = cell(prod(dim),T);

for p=1:prod(dim)
    f(1) = f(1) + 1;
    for t=1:T 
        if f(t) > dim(t) && t~=T
            f(t) = 1;
            f(t + 1) = c(t + 1) + 1;
        end
         Ta(p,t) = Tags{t}(c(t));
    end 
    c = f;
    
    
end
end

