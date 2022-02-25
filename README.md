# KidneyStoneDetection_UsingUltrasoundImage

**Steps Taken to Detect Kidney Stone with MATLAB Code** <br/>
1.clc<br/>
  close all<br/>
  warning off<br/><br/>
  
2. [filename, pathname] = uigetfile('*.*', 'Pick a MATLAB code file'); <br/>
   filename=strcat(pathname,filename); <br/>
   a=imread(filename); <br/>
   imshow(a); <br/>

These 4 lines are used to select the image from the system.<br/>

![Selecting Ultrasound Image from the system](https://user-images.githubusercontent.com/56343106/155717681-546612eb-65d2-45ab-8111-7c7dea22e156.png)
<br/><br/>


3.b=rgb2gray(a);<br/>
  figure;<br/>
  imshow(b)<br/>

![Original selected image](https://user-images.githubusercontent.com/56343106/155718171-17c0ff9e-541a-4513-a330-349326f16a0c.png)
![Image after grayscale transformation](https://user-images.githubusercontent.com/56343106/155718179-232c1bd3-e8f2-409d-97e7-fc9ab6c32052.png)
<br/><br/>

4.impixelinfo;<br/>
  c=b>20;<br/>
  figure;<br/>
  imshow(c);<br/>
  Converting above grayscale image into binary image by applying Adaptive Thresholding.<br/> 

![Binary Image](https://user-images.githubusercontent.com/56343106/155718433-b09c3d3c-b6d7-4209-92a0-80cbcf8d5662.png)
<br/><br/>

5.d=imfill(c,'holes');<br/>
  imshow(d);<br/>
  Now here we fill up the remaining holes present in the image.<br/>
  ![Before filling up the hole](https://user-images.githubusercontent.com/56343106/155718594-8d410a7d-b081-4f36-b52b-b1e901a3eb16.png)
  ![After filling up the whole](https://user-images.githubusercontent.com/56343106/155718612-45927767-26fe-4210-aaa3-00b5de34504a.png)
<br/><br/>

6.e=bwareaopen(d,1000);<br/>
  figure;<br/>
  imshow(e);<br/>
  Removing the written part in the image.<br/>
  
![Before Removing the written part](https://user-images.githubusercontent.com/56343106/155718840-318ca4de-c617-4559-bfc0-eb7b7dc65e4c.png)
![Before Removing the written part](https://user-images.githubusercontent.com/56343106/155718848-8c2ce99d-0b8a-439e-b315-4f8a7aec8c64.png)
<br/><br/>

7.PreprocessedImage=uint8(double(a).*repmat(e,[1 1 3]));<br/>
  figure;<br/>
  imshow(PreprocessedImage);<br/>
  Now here we multiply binary mask to rgb image for this repmat function is used where e is the mask consisting of above image.<br/>

![After multiplying the rgb image with mask.](https://user-images.githubusercontent.com/56343106/155719197-528aaa67-bf80-4748-8455-db46e1080d36.png)
<br/><br/>

8.PreprocessedImage=imadjust(PreprocessedImage,[0.3 0.7],[])+50;<br/>
  uo=rgb2gray(PreprocessedImage);<br/>
  figure;<br/>
  imshow(uo);<br/>
  Here we adjust the contrast of an image by making brighter regions to more brighter and darker regions to more darker.<br/>
  
![Adjust image contrast after converting the above image in grayscale](https://user-images.githubusercontent.com/56343106/155719357-908cb2f6-b06f-42ff-ba4f-441ddc1d1968.png)
<br/><br/>

9.mo=medfilt2(uo,[5 5]);<br/>
  figure;<br/>
  imshow(mo);<br/>
  po=mo>250;<br/>
  figure;<br/>
  imshow(po);<br/>
  Applying median filtering using medfilt2 to remove portion which are not in our region of interest.<br/>
  
  ![After applying median filter on the last image to remove noise.](https://user-images.githubusercontent.com/56343106/155719554-58aa4175-226a-467b-8ca2-3f664df30eae.png)
  <br/><br/>

10.[r c mo]=size(po);<br/>
   x1=r/2;    % r is for rows<br/>
   y1=c/3;     % c is for columns<br/>
   row=[x1 x1+200 x1+200 x1];      % clockwise circular movement <br/>
   col=[y1 y1 y1+40 y1+40];        % clockwise circular movement <br/>
   BW = roipoly(po,row,col); <br/>
   k=po.*double(BW); <br/>
   figure; <br/>
   imshow(k); <br/><br/>
As the kidney function is to purify the blood by removing calcium and other substances from the blood and these calcium and other substances start collecting in kidney and    make a stone most of the time these stone will pass through urine but some time stone stuck into kidney and grow this type of stone will majorly occur in the junction of kidney outlet and ureters which connect kidney with bladder.<br/>
So we decide to make our region of interest in this central part and find stone in ROI only.<br/>
By considering only region of interest the other binary objects which mostly out of the kidney are not considered and our chances of predicting the stone will become more accurate.<br/><br/>

![Finding binary object in roi](https://user-images.githubusercontent.com/56343106/155719794-6f0a592a-9b79-4f13-a0ab-48f9e4e6dffb.png)
<br/><br/>

11.M=bwareaopen(k,4);      % if the binary object is more than 4 pixel then only it will consider other will ignore.<br/>
   [ya number]=bwlabel(M);  <br/>
   if(number>=1) <br/>
     disp('Stone is Detected'); <br/>
   else <br/>
     disp('Stone is not Detected'); <br/>
   end 
   <br/>
   If the brighter object in Region of Interest is greater than 4 pixels, then we recognized that as Stone else not. <br/>
   
   ![In this image stone is present which also detected by code.](https://user-images.githubusercontent.com/56343106/155720012-028edbe6-9501-40cd-ab0a-469883f87bb8.png)   
   <br/><br/>
<br/>
**References**<br/>
Suresh M B, Abhishek M R. 2021. “Kidney Stone Detection Using Digital Image Processing Techniques.” 2021 IEEE Third International Conference on Inventive Research in Computing Applications (ICIRCA).<br/>

