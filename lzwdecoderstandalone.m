clear all;
Encoded = csvread('encoded.csv');
col = csvread('column.txt')
Decoded = logical(vec2mat(LZW_img_dec(Encoded),col));

% demonstrating the two images before and after encoding

figure
imshow(Decoded)
