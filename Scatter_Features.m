% F : Features
% T: Tags
% H: Headers
% C: Clustering form
% P: Ploting form
% E: Plot exception
function Scatter_Features(F, T, H, C, P, E,L, TP)
if strcmp(TP,'p') 
    [~,b] = pca(F);
else
    b=F;
end
c = unique(T(:,C),'stable');
p = unique(T(:,P),'stable');
p(strcmp(p,E))=[];

marker = {'o','s','d','^','v','>','<','p','h'};
m = length(c);
n = length(p);
for y = 1: n
    figure;
    color=lines(m);
    I = logical(strcmp(T(:,P),p(y)) + strcmp(T(:,P),E));
    F_T = b(I,:);
    T_T = T(I,C);
    for x = 1: m
        scatter(F_T(strcmp(T_T,c(x)),1),F_T(strcmp(T_T,c(x)),2),50,marker{x},'MarkerFaceColor',color(x,:),'MarkerEdgeColor',color(x,:));
        hold on
    end
    legend(c,'location','best', 'Interpreter', 'none');
    title({p{y};' '}, 'Interpreter', 'none');
    xlabel('Feature 1'); 
    ylabel('Feature 2');
    print(sprintf(['Outputs/Scatter_' L '_' H{C} '_' p{y}]),'-depsc');
    close
end
end
