%path = 'F:\Java\ReSystems\data\XuLyFile\ratings.txt';
% bo ml-1m
%number_user = 6040;
%number_item = 3883;

% bo ml-100k
number_user = 943;
number_item = 1682;


%number_genre = 0;
%number_profile = 0;

% load matrix ratings of user ml-1m
%load 'F:\Java\ReSystems\data\XuLyFile\ratings.txt';
%user_moive = spconvert(ratings)';

% load matrix rating of user ml-100k
load 'F:\Java\ReSystems\data\XuLyFile\u1.txt';
data_train = spconvert(u1)';

% 20% lam bo test 
% 600 user 500 bo phim set 0 o cuoi matrix
% 80% lam bo train 

%[data_train data_test n m] = makeData(user_moive,100,100);
%clear user_moive ratings;

%  In practice we get better estimates if we model deviations
% total matrix ratings Averange
totalAverage = sum(sum(data_train)');
numberAverage = sum(sum(data_train(1:number_item,1:number_user)~=0));
totalAverage = totalAverage/numberAverage;

% average ratings of user 
averageRatingUser = sum(data_train);
for x = 1:number_user
    len = sum(data_train(1:number_item,x)~=0);
    if(len ~= 0)
        averageRatingUser(x) = averageRatingUser(x)/len;
    end
end
clear x len;
% average rating of item
averageRatingItem = sum(data_train');
for x = 1:number_item
    len  = sum((data_train(x,1:number_user)~=0));
    if(len ~= 0)
        averageRatingItem(x) = averageRatingItem(x)/len;
    end 
end
clear x len;
data_new = SubtractMeanForMatrix(data_train);
% error RMSE
numberSimilarItem = 5;
[item user] = size(data_train);
% index start data test 
