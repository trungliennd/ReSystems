% bo ml-100k
number_user = 943;
number_item = 1682;
% load tap train
load 'F:\Java\ReSystems\data\XuLyFile\u5.txt';
data_train = spconvert(u5)';
n_element = length(u5);
[n m] = size(data_train);
if(n ~= number_item || m ~= number_user)
    data_train(number_item,number_user) = 0;
end
% load tap test
load 'F:\Java\ReSystems\data\XuLyFile\u5_test.txt';

Average_rating = full(sum(sum((data_train'))))/n_element;
X = sprintf('average rating is: %d',Average_rating);
disp(X);

lmbda = 0.1;
k_factor = 40; % so tien to an
gamma = 0.025; % learning rate
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
% bias for movies
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
len = length(u5);
phi = 0.6;
Vp = 0;
Vq = 0;
Vbu = 0;
Vbi = 0;

for epoch = 1:n_epochs
   Vp = 0;
   Vq = 0;
   Vbu = 0;
   Vbi = 0;
   if(mod(epoch,40) == 0)
        disp('Change learning rate');
        gamma = gamma/2;
        phi = phi/2;
   end
   %if(epoch == 60)
    %   phi = 0;
   %end
   u5 = Shuffer(u5,len);
   for i = 1:len
        user = u5(i,1);
        item = u5(i,2);
        rating = u5(i,3);
        e = (rating - prediction(P(:,user),Q(item,:),user,item,Bu,Bi,Average_rating)); % calculate error for gradient
        Vp = Vp*phi + gamma*(lmbda*P(:,user) - e*Q(item,:)'); 
        P(:,user) = P(:,user) - Vp; % Update latent user feature matrix
        Vq = Vq*phi + gamma*(lmbda*Q(item,:) - e*P(:,user)');
        Q(item,:) = Q(item,:) - Vq; % Update latent movie feature matrix
        Vbu = Vbu*phi + gamma*(lmbda*Bu(user) - e); 
        Bu(user) = Bu(user) - Vbu; % update bias for user
        Vbi = Vbi*phi + gamma*(lmbda*Bi(item) - e);
        Bi(item) = Bi(item) -  Vbi; % update bias for item 
    end
    train_rmse = rmse(u5,Q,P,Bu,Bi,Average_rating); % calculate RMSE from data train
    test_rmse = rmse(u5_test,Q,P,Bu,Bi,Average_rating);
    train_error = [train_error train_rmse];
    test_error = [test_error test_rmse];
    X = sprintf('epoch = %d\n',epoch);
    Y = sprintf('Train RMSE = %f\n',train_rmse);
    Z = sprintf('Test RMSE = %f\n',test_rmse);
    disp(X);
    disp(Y);
    disp(Z);
end
% save('train_m100k_u5.mat','P','Q','Bu','Bi','train_error','test_error','Average_rating','lmbda','k_factor','gamma','phi');