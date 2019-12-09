clear all;
close all;
clc;
Input = imread('1.jpg');

Binary = imbinarize(Input(:,:,1));
[row col] = size(Binary);

Encoded = logical(LZW_img_enc(Binary')); 

Ratio = numel(Encoded)/numel(Binary);
Ratio 

Decoded = vec2mat(LZW_img_dec(Encoded),numel(Binary(1,:)));


imshow(Binary)
figure
imshow(Decoded)
rmse = 0 ;
for i =1: row
for j= 1:col
    rmse = rmse + (Binary(i,j)-Decoded(i,j)).^2;
end

end
rmse
imwrite(Binary,'C:\Users\HARSH\Desktop\NOTES\ip\project\LZW_image_codec-master\LZW_image_codec-master\output\binary1.jpeg')
imwrite(Decoded,'C:\Users\HARSH\Desktop\NOTES\ip\project\LZW_image_codec-master\LZW_image_codec-master\output\decoded1.jpeg')
imwrite(Encoded,'C:\Users\HARSH\Desktop\NOTES\ip\project\LZW_image_codec-master\LZW_image_codec-master\output\encoded1.gif')
