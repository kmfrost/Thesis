mat = [8,0,0,0,0,0;0,29,0,0,0,1;0,0,7,0,0,0;0,0,0,2,0,0;0,0,0,0,5,0;0,2,0,0,0,15];
labels = {'Director','GradStudent','Operations','Outreach','PM','Research'};

mat2 = [4,1,1,0,2;0,27,0,0,3;0,1,2,0,4;1,0,0,3,1;2,6,0,0,9];
labels2 = {'Director','GradStudent','Operations','PM','Research'};

confusionMatrix(mat,labels);
confusionMatrix(mat2,labels2);