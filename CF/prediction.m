function result = prediction(P,Q,user,item,Bu,Bi,average_rating)
    result = Q*P + Bu(user) + Bi(item) + average_rating;
end