function plotGraph(train,test,n)
x_train = [1:n];
x_test = [1:n];
%numberOfXTicks = 20;
plot(x_train,train(x_train),'r',x_test,test(x_test),'b');
%xData = get(h,'XData');
%[1,20:20:100]
set(gca,'Xtick',[1,10:10:45]);
hold on
plot([1,10:10:45],train([1,10:10:45]),'rx');
plot([1,10:10:45],test([1,10:10:45]),'bx');
title('Graph RMSE with n\_epochs = 100');
xlabel('n\_epochs');
ylabel('RMSE');
legend('train','test');
end