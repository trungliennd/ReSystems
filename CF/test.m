r = Q*P;
for i = 1:number_item
   r(i,:) = r(i,:) + Bi(i);
end
for x = 1:number_user
    r(:,x) = r(:,x) + Bu(x);
end

r = r + Average_rating;