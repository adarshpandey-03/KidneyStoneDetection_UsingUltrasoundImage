clc
close all
warning off

[filename, pathname] = uigetfile('*.*', 'Pick a MATLAB code file');
filename=strcat(pathname,filename);
a=imread(filename);
imshow(a);

b=rgb2gray(a);    %converting to grayscale
figure;
imshow(b)

%figure;
%imhist(b)   

impixelinfo;
%c=imbinarize(b,20/255);
c=b>20;
figure;
imshow(c);

d=imfill(c,'holes');
imshow(d);

e=bwareaopen(d,1000);   %removing written part from the image
figure;
imshow(e);

PreprocessedImage=uint8(double(a).*repmat(e,[1 1 3]));
figure;
imshow(PreprocessedImage);

%now make dark region darker and bright region brighter this nothing but
%ajusting contrast

PreprocessedImage=imadjust(PreprocessedImage,[0.3 0.7],[])+50;
uo=rgb2gray(PreprocessedImage);
figure;
imshow(uo);

mo=medfilt2(uo,[5 5]);
figure;
imshow(mo);
po=mo>250;
figure;
imshow(po);

%As the kidney function is to purify the blood by removing calcium and
%other substances from the blood and these calcium and other substances
%start collecting in kidney and make a stone most of the time these stone
%will pass through urine but some time stone stuck into kidney and grow
%this type of stone will majorly occur in the junction of kidney outlet and
%ureters which connect kidney with bladder.
%So we decide to make our region of interest in this central part and find
%stone in roi only.
%By considering only region of interest the other binary objects which
%mostly out of the kidney are not considered and our chances of predicting
%the stone will become more accurate.

[r c mo]=size(po);
x1=r/2;    % r is for rows
y1=c/3;     % c is for columns

row=[x1 x1+200 x1+200 x1];      % clockwise circular movement
col=[y1 y1 y1+40 y1+40];        % clockwise circular movement

BW = roipoly(po,row,col);
%figure;
%imshow(BW);

k=po.*double(BW);
figure;
imshow(k);

M=bwareaopen(k,4);      % if the binary object is more than 4 pixel then only it will consider 
                        % other will ignore.

[ya number]=bwlabel(M);
if(number>=1)
    disp('Stone is Detected');
else
    disp('Stone is not Detected');
end
 




