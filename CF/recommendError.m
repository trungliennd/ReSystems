%RMSE
% 
ERROR = 0;
number_test = 0;
totalSim = 0;
for x = 1:n
    x
    %baseline bx
    index_x = index_start_user + x;
    bx = -totalAverage + averageRatingUser(index_x);
    predictRating = 0;
    indexRatingByX = find(data_new(1:item,index_x)' ~= 0);
    NN = length(indexRatingByX)
    indexItem = find(data_test(1:m,x)' ~= 0);
    for i = indexItem
        index_i = index_start_item + i;
        predictRating = 0;
        if(sum((data_new(index_i,1:user) ~=0)') ~= 0)
            [sim , I] = getCosine(data_new(index_i,1:user),data_new,indexRatingByX,numberSimilarItem);
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
        ERROR = ERROR + (predictRating - data_test(i,x))^2;
    end
end
numberElement  = sum(sum(data_test ~=0)');
ERROR = sqrt(ERROR/numberElement);