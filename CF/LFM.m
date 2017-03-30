% bo ml-100k
number_user = 943;
number_item = 1682;

% load tap train
load 'F:\Java\ReSystems\data\XuLyFile\u1.txt';
data_train = spconvert(u1)';
n_element = length(u1);
% load tap test
load 'F:\Java\ReSystems\data\XuLyFile\u1_test.txt';

Average_rating = full(sum(sum((data_train'))))/n_element;
X = sprintf('average rating is: %d',Average_rating);
disp(X);

lmbda = 0.1;
k_factor = 40; % so tien to an
gamma = 0.02; % learning rate
n_epochs = 100; % number of epochs
% su dung svd tach matrix data_train;

[U, S, V] = svds(data_train,k_factor);
Q = U;
P = S*V';
clear U S V;

% bias for users
Bu = sum(data_train);
for x = 1:number_user
    len = sum(data_train(1:number_item,x)~=0);
    if(len ~= 0)
        Bu(x) = Bu(x)/len - Average_rating;
    end
end
 %bias for movies
Bi = sum((data_train')); 
for i = 1:number_item
    len = sum(((data_train(i,1:number_user)~=0)'));
    if(len ~= 0)
        Bi(i) = Bi(i)/len - Average_rating;
    end
end

train_error = [];
test_error = [];
epoch = 0;
count = 0;
len = length(u1);
for epoch = 1:n_epochs
    if(mod(epoch,40) == 0)
        disp('Change learning rate');
        gamma = gamma/10;
    end
    u1 = Shuffer(u1,len);
    for i = 1:len
        user = u1(i,1);
        item = u1(i,2);
        rating = u1(i,3);
        e = (rating - prediction(P(:,user),Q(item,:),user,item,Bu,Bi,Average_rating)); % calculate error for gradient
        P(:,user) = P(:,user) + gamma*(e*Q(item,:)' - lmbda*P(:,user)); % Update latent user feature matrix
        Q(item,:) = Q(item,:) + gamma*(e*P(:,user)' - lmbda*Q(item,:)); % Update latent movie feature matrix
        Bu(user) = Bu(user) + gamma*(e - lmbda*Bu(user)); % update bias for user
        Bi(item) = Bi(item) + gamma*(e - lmbda*Bi(item)); % update bias for item 
    end
    train_rmse = rmse(u1,Q,P,Bu,Bi,Average_rating); % calculate RMSE from data train
    test_rmse = rmse(u1_test,Q,P,Bu,Bi,Average_rating);
    train_error = [train_error train_rmse];
    test_error = [test_error test_rmse];
    X = sprintf('epoch = %d\n',epoch);
    Y = sprintf('Train RMSE = %f\n',train_rmse);
    Z = sprintf('Test RMSE = %f\n',test_rmse);
    disp(X);
    disp(Y);
    disp(Z);
 end