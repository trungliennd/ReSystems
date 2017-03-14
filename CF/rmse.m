function r = rmse(filename, Q, P,Bu,Bi,average_rating)
    error = 0;
    len = length(filename);
    for i = 1:len
    %   if(mod(i,10000) == 0)
     %      X = sprintf('line %d loading',i);
      %     disp(X);
      % end
       user = filename(i,1);
       item = filename(i,2);
       rating = filename(i,3);
       error = error + (rating - prediction(P(:,user),Q(item,:),user,item,Bu,Bi,average_rating))^2;
       %if(isnan(error))
        %   i
         %  rating
          % prediction(P(:,user),Q(item,:),user,item,Bu,Bi,average_rating)
          % break;
       %end
    end
    r = sqrt(error/len);
end