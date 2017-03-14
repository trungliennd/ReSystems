function r = random(min,max,b,k)
    count = 0;
    [m n] = size(b); 
    r = [];
    while(count < k)
        rd = randi([min max]);
        if(find(r == rd) ~= 0)
            continue;
        elseif(sum(b(rd,1:n) == 0) == n)
            count = count + 1;
            continue;
        end
        r = [r rd];
        count = count + 1;
    end
end