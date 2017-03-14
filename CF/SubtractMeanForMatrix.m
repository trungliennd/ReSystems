function D = SubtracMeanForMatrix(A)
   B = A;
   [m n] = size(B); 
   for i = 1:m
      checked = (B(i,1:n) ~= 0);
      sum_rates = sum(B(i,1:n));
      mean = sum_rates/sum(checked);
      idx = find(B(i,1:n)~=0);
      B(i,idx) = B(i,idx) - mean;
   end
   D = B;
end