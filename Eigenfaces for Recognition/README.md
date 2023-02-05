This project is one of favorite project and this is the project that drown me to this field.

# What is this project about:
## Implement a nearest-neighbor face recognotion algorithm based on Eigenfaces.

This algorithm can correctly identify the person from a test image using a low-dimensional eigenface representation
Data: There are 32x32 image resolution face images of 40 people. Each row of this data matrix contains 10 different expressions of each person.

This is the first 10 rows image representaion of the data.

![figure1](https://user-images.githubusercontent.com/81766272/216840684-1919d279-60e5-4708-b068-391ac7f4edf0.jpg)

We divided the data set into training set using first 7 expressions of the of all people data and test set is the other 3 expression of all people data

![figure2](https://user-images.githubusercontent.com/81766272/216841736-0e637a4a-1ef6-4864-baf0-7c6d321926b6.jpg) ![figure3](https://user-images.githubusercontent.com/81766272/216841737-17f7dbb0-d116-40f1-b3f9-b385ed9d22dd.jpg)

### Now we are building the algorithm with training data.
The algorithnm here is Principle Component Analysis.
More about this algorithm can be found here:
https://en.wikipedia.org/wiki/Principal_component_analysis

https://builtin.com/data-science/step-step-explanation-principal-component-analysis

https://www.cs.princeton.edu/picasso/mats/PCA-Tutorial-Intuition_jp.pdf


As the name of the algorithm it can identify the pricipal features of the data.
To perform this we need to make unbias our data. Hence, we substrac the mean face of the traing data.

![figure4](https://user-images.githubusercontent.com/81766272/216842745-f2e060d9-5dde-498a-8ac0-cc9a39745613.jpg)

This image shows what it look like after removing the mean face from a face image

![figure5](https://user-images.githubusercontent.com/81766272/216843017-fda45f8f-89e5-4d59-be82-108cf87c4412.jpg)


To identify /decide the princilpe features of the images we use energy graph of each pod modes/ eigen values/eigen faces

![figure6](https://user-images.githubusercontent.com/81766272/216846777-32812464-b381-42d6-acc6-68ed6712fe6c.jpg)

According to the graph , It is very clear that very first modes has more energy.So, we pick fisrt 12 eigenfaces to represent the data since these 12 modes best describe 
a face in data rather than taking all 280 modes to represent data. 

![figure7](https://user-images.githubusercontent.com/81766272/216847544-da590745-9f9c-4a0c-a1a8-2d2b45924846.jpg)

Then following images shows that, If I pick random image from test data set, I can check who is that person , if that person is already in the database.

![figure8](https://user-images.githubusercontent.com/81766272/216847531-00e9a23a-a531-495f-9487-b0f911273819.jpg)


