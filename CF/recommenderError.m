dbclear all
load 'F:\Java\ReSystems\data\XuLyFile\u1_test.txt';
%RMSE 
ERROR = 0;
number_test = 0;
sim = [];
totalSim = 0;
len = length(u1_test);
for i = 1:len
    i
    %if(i == 15109)
    index_x = u1_test(i,1);
    index_i = u1_test(i,2);
    rxi_test = u1_test(i,3);
    bx = -totalAverage + averageRatingUser(index_x);
    bi = -totalAverage + averageRatingItem(index_i);
    rxi = totalAverage + bx + bi;
    indexRatingByUser = find(data_new(1:item,index_x)' ~=0);
    predictRating = 0;
    if(sum(data_new(index_i,1:user)' ~=0) ~= 0)
        [sim, I] = getCosine(data_new(index_i,1:user),data_new,indexRatingByUser,numberSimilarItem);
        rxj = data_train(I,index_x);
        bj = -totalAverage + averageRatingItem(I);
        %baseline bxj is
        bxj = totalAverage + bx + bj;
        % predict
        predictRating = predictRating + sum((rxj' - bxj).*sim)
    else
        sim = zeros(1,numberSimilarItem);
    end
    totalSim = sum(sim')
    if(totalSim ~=0)
        predictRating = predictRating/totalSim;
        bi = -totalAverage + averageRatingItem(index_i);
        bxi = totalAverage + bx + bi;
        predictRating = predictRating + bxi;
    else
        predictRating = 3;
    end
   % data_train(index_i,index_x) = predictRating;
    ERROR = ERROR + (predictRating - rxi_test)^2;
    %elseif(i > 15109)
     %   break;
    %end
end
number_test = len;
ERROR = sqrt(ERROR/len)