%
% Lay k hang xom gan voi do do jaccard
%
function [jaccard I] = getJaccard(a,b,k)
    D = pdist2(a,b,'jaccard');
    jaccard = 1 - D;
    [B index] = sort(jaccard,'descend');
    I = index(2:k);
    jaccard = jaccard(I);
end