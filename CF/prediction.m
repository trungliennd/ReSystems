function result = prediction(P,Q,user,item,Bu,Bi,average_rating)
    result = Q*P + Bu(user) + Bi(item) + average_rating;
    if(result > 5.0)
        result = 5.0;
    elseif(result < 0.0)
        result = 0.0;
end