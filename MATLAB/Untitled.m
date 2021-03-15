
%Extracting images from current folder
files = dir('*.jpg');
j=length(files)
for i=1:length(files)
    images{i} = imread([directory '/' files(i).name]);  


%Split into RGB Channels
    Red = images{i}(:,:,1);
    Green = images{i}(:,:,2);
    Blue = images{i}(:,:,3);

    %Get histValues for each channel
    [yRed, x] = imhist(Red);
    [yGreen, x] = imhist(Green);
    [yBlue, x] = imhist(Blue);
    
    %making feature vector 
histvector=[yRed;yGreen;yBlue]

% compiling feature vectors in a array 
featvector(:,i)=histvector

end
[path,~]=uigetfile('*.jpg');
img=imread(path);
%Split into RGB Channels
    Red = img(:,:,1);
    Green = img(:,:,2);
    Blue = img(:,:,3);

    %Get histValues for each channel
    [yRed, x] = imhist(Red);
    [yGreen, x] = imhist(Green);
    [yBlue, x] = imhist(Blue);
    
    %making feature vector for query  
qvector=[yRed;yGreen;yBlue]

%this array will tell if the image is similar to query
arr=zeros(29,1);

%defining threshold
thres=70*ones(768,1);
for i=1:j
  vector2=featvector(:,i);
  D = sqrt((vector2-qvector).^2);
  %no of elements of D that will be less than the corressponding values in
  %thres
  c=0;
  
  %if max elements of D less than threshold , D is similar 
 for x=1:768
    if D(x)<thres(x)
     c=c+1; 
    end
  end
  if c>350
      arr(i)=1;
  end
  
end
r=3;
%showing the query image at top
subplot(5,4,1)
imshow(img);
title('Query Image','FontSize',20);
subplot(5,4,2)
text(0,0.5,'The Resulting Images:>>','FontSize',18); axis off

%displaying all the similar pictures
for i=1:j
    
    if arr(i)==1
        subplot(5,4,r);
      
        imshow(images{i});
        r=r+1;
    end
end
  
