function vector = rescale(vector)
a = max(vector);
b = min(vector);
vector = ((vector-b)./(a-b))*100;
end 

