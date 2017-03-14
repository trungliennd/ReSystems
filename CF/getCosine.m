%
% Lay k hang xom gan nhat
%
function [cosine, I, D]  = getCosine(a,b,index_nn,k)
    [m n] = size(b);
    %rd = random(1,length(index_nn),b(index_nn,1:n),50);
    %index_nn = index_nn(rd);
    e = b(index_nn,1:n)';
   % D = pdist2(a,e,'cosine');
    %cosine = 1 - D;
    b = sum((a.^2)');
    mul = a*e;
    e = sum(e.^2);
    cosine = mul./sqrt(b*e);
    [B index] = sort(cosine,'descend');
    if(length(index_nn) >= k)
        I = index_nn(index(1:k));
        cosine = cosine(index(1:k));
    else
        I = index_nn(index);
        cosine = cosine(index);
    end
 end

%function cosine = getCosine(a,b) 
%   cosine = (a*b')/(sqrt(sum(a.^2)*sum(b.^2)));
%end