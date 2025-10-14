clear; clc; close all;

% Step 1: 读取图像
im = imread('rice.png');               % 可换成其他灰度图像
thres = myintermeans_34(im);           % 调用你的函数
bw = im2bw(im, thres);                 % 用算法算出的阈值进行二值化

% Step 2: 显示原图和二值化图
figure(1);
subplot(1,2,1);
imshow(im);
title('Original Image');

subplot(1,2,2);
imshow(bw);
title(sprintf('Binarized Image (thres = %.4f)', thres));

% Step 3: 单独显示灰度直方图 + 阈值线
figure(2);
[counts, bins] = imhist(im);           % 获取灰度值和计数
bar(bins, counts, 'FaceColor', [0.6 0.7 0.9], 'EdgeColor', 'none'); % 更平滑的柱状图
hold on;

% 绘制阈值分割线
xline(thres * 255, 'r--', 'LineWidth', 2); 
text(thres * 255 + 5, max(counts)*0.9, ...
     sprintf('Threshold = %.2f (Gray ~ %.0f)', thres, thres*255), ...
     'Color', 'r', 'FontSize', 10, 'FontWeight', 'bold');

% 美化图表
title('Histogram of rice.png with Threshold Line');
xlabel('Gray level (0–255)');
ylabel('Number of pixels');
grid on;
hold off;
 