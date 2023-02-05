
%01)
clear all; close all; clc;

fprintf('Loading data...\n');
load('ORL_32x32.mat'); % matrix with face images (fea) and labels (gnd)
load('train_test_orl.mat'); % training and test indices (trainIdx, testIdx)

figure(1);
display_faces(fea,10,10);
title('Face data');

%% 


% partition the data into training and test subset
n_train = size(trainIdx,1);
n_test = size(testIdx,1);

%training subset
%Step 1: obtain face images(training faces)
train_data = fea(trainIdx,:);
train_label = gnd(trainIdx,:);
figure(2);
Y=display_faces(train_data,7,40); %reshaping all images to size 32x32
title('Training data set');

%% 

%test subset
test_data = fea(testIdx,:);
test_label = gnd(testIdx,:);
figure(3);
Y1=display_faces(test_data,3,40);  %reshaping all images to size 32x32
title('Test data set');

%% 


%By considering training data.....
n=32; % # of pixel in a image side
N=7; %no of images from a person
M=40; %no of people
count=0;
X=[]; %image stack;
avg=zeros(n*n,1);% defining size of the average face vector

%take all the images to one stack ;
%Step 2: represent every image as a vector and stack it into X
for i=0:M-1
    for j=0:N-1
        I_P=Y(i*n+1:(i+1)*n,j*n+1:(j+1)*n);
        R=reshape(I_P,n*n,1);% reshape image into (32x32)x1 column vector
%         size(R)
        
        X=[X,R];
        avg=avg+R;
        count=count+1;
    end
end


%Step 3: compute the average face vector :
 avg=avg/count;
  avg_person= (reshape(avg,n,n));
  figure(4);
  imshow(avg_person,[]);
%%
%Step 4: subtract the mean face:
%X has 280 images as a stack
for j=0:count-1
    X(:,j+1)=X(:,j+1)-avg;
end

%% 

% Random traning data face after removing the mean face.
R=reshape(X(:,5),n,n);
figure(5);
imshow(R);
title('Random raning data face after removing the mean face')


    %% 

%compute the SVD
[U S V]=svd(X);
size(S)
%singular value profile
figure(6);
plot(diag(S),'bd');
xlabel('n')
ylabel('energy of each pod mode')

%% 


%it is clear that by first 12 eigen values can give better eigen faces
% they are

efcol=U(:,1:12);
figure(7);
count1=1;
for i=1:4
    for j=1:3
        subplot(4,3,count1);
        
        imshow(uint8(25000*reshape(efcol(:,count1),n,n)));
        count1=count1+1;
    end
end

%% 


%project each image into basis of eigen faces space
for i=1:count
    IM_proj(:,i)=X(:,i)'*efcol(:,1:12);
end


%Face Recognition Using Eigenfaces space

%By considering test data.....
X1=[];
N=3;
M=40;
count2=0;
for i=0:M-1
    for j=0:N-1
        I_P=Y(i*n+1:(i+1)*n,j*n+1:(j+1)*n);
        R=reshape(I_P,n*n,1);% reshape image into (32x32)x1 column vector
        X1=[X1,R-avg];
        count2=count2+1;
    end
end

for i=1:count2
    IM_proj1(:,i)=X1(:,i)'*efcol(:,1:12);
end

%finding matching face

data=zeros(120,1);
for i=1:count2
    for j=1:count
        error(j)=norm(IM_proj(:,j)'-IM_proj1(:,i)');
    end
    [M,I]=min(error);
    data(i,1)=I;
    
end
%% 


%there are 120 test photos
rand_number = randi(120)
test_photo= rand_number;
original_photo=data(rand_number);
figure(8);
subplot(1,2,1);
R=uint8(reshape(X1(:,test_photo)+avg,n,n));
imshow(R);
title([num2str(rand_number),' photo of test data set ']);

subplot(1,2,2);
R=uint8(reshape(X(:,original_photo)+avg,n,n));
imshow(R);
title(sprintf('Original photo of training data set \n is in the index %d',original_photo));


