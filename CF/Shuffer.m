function data = Shuffer(data_train,times)
    len = length(data_train);
    data = data_train;
    for i = 1:times
        r1 = randi([1 len]);
        r2 = randi([1 len]);
        if(r1 ~= r2)
            a = data(r1,:);
            data(r1,:) = data(r2,:);
            data(r2,:) = a;
        end
    end
end