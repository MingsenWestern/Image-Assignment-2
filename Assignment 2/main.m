clear; clc; close all;

%% 1) read image and calculate thres (P4)
im    = imread('rice.png');             % imread
thres = myintermeans_34(im);            % normalization [0,1]
fprintf('thres = %.4f\n', thres);

%% 2) Binarization (P5) 
bw = im2bw(im, thres);                  % Generate bw for subsequent use

%% 3) Counting (P6)
[L,  num ]  = bwlabel(bw);              % Original binary graph count
fprintf('Count before bwareaopen: %d\n', num);

%% 4) Remove the small noise and count again (P7)
bw2 = bwareaopen(bw, 5);                % Remove the small connected domains with an area less than 5
[L2, num2] = bwlabel(bw2);
fprintf('Count after  bwareaopen(5): %d\n', num2);

%% 5) Visualization 
figure(1);
subplot(1,2,1); imshow(bw);  title(sprintf('Before (num=%d)',  num));
subplot(1,2,2); imshow(bw2); title(sprintf('After bwareaopen(5) (num=%d)', num2));

[counts, bins] = imhist(im);


T = thres * 255;                % Gray-scale threshold
[counts,bins] = imhist(im);

figure;                         % Figure 1: Original histogram + threshold line
bar(bins, counts, 'EdgeColor','none'); hold on;
xline(T, 'r--', 'LineWidth', 2);
text(T+5, max(counts)*0.9, ...
     sprintf('thres = %.4f  (Gray ≈ %.0f)', thres, T), ...
     'Color','r','FontSize',10,'FontWeight','bold');
title('Original Histogram with Threshold');
xlabel('Gray level (0–255)'); ylabel('Number of pixels'); grid on; hold off;



%%
%{
[L2, num2] = bwlabel(bw2);
stats = regionprops(L2, 'Area');
areas = [stats.Area];

figure;                         
histogram(areas); hold on;
xline(5, 'g--', 'LineWidth', 2);
text(7, ylim* [0;1]*0.9, 'area threshold = 5 px', ...
     'Color','g','FontSize',10,'FontWeight','bold');  
title(sprintf('Area Distribution After bwareaopen(5)  (count=%d)', num2));
xlabel('Connected-component area (pixels)'); ylabel('Frequency'); grid on; hold off;
%}



%{
% main.m
clear; clc; close all;

I = imread("C:\Users\yangf\OneDrive\桌面/mountain_grayscale.jpg");

imhist(I)

disp(myintermeans_34(I))

[L,  num ]  = bwlabel(bw);         
bw2 = bwareaopen(bw, 5);            
[L2, num2] = bwlabel(bw2);         
fprintf('Count before: %d, after bwareaopen: %d\n', num, num2);

figure(1);
subplot(1,2,1); imshow(bw);  title(sprintf('Before (num=%d)', num));
subplot(1,2,2); imshow(bw2); title(sprintf('After bwareaopen(5) (num=%d)', num2));
%}