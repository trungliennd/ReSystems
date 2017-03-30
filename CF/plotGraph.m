function plotGraph(train,test,n)
x_train = [1:n];
x_test = [1:n];
numberOfXTicks = 20;
h = plot(x_train,train(x_train),'r',x_test,test(x_test),'b');
xData = get(h,'XData');
set(gca,'Xtick',[1,20:20:100]);
hold on
plot([1,20:20:100],train([1,20:20:100]),'rx');
plot([1,20:20:100],test([1,20:20:100]),'bx');
title('Graph RMSE with n\_epochs = 100');
xlabel('n\_epochs');
ylabel('RMSE');
legend('train','test');
end