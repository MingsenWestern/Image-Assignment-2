% ==== 数据准备（若已有 bw、bw2 可跳过到"绘图"）====
im = imread('rice.png');
if size(im,3)==3, im = rgb2gray(im); end

thres = myintermeans_34(im);       % 归一化阈值 [0,1]
bw    = im2bw(im, thres);          % P5：二值图
[L,  num ]  = bwlabel(bw);         % P6：计数

bw2 = bwareaopen(bw, 5);           % P7：去掉面积<5的小连通域
[L2, num2] = bwlabel(bw2);         % P7：再次计数

% ==== 绘图（并排对比 + 标题显示数量）====
f = figure('Color','w','Position',[100 100 980 480]);
tiledlayout(1,2,'TileSpacing','compact','Padding','compact');

nexttile;
imshow(bw,'InitialMagnification','fit'); axis off
title(sprintf('Before (num=%d)', num));

nexttile;
imshow(bw2,'InitialMagnification','fit'); axis off
title(sprintf('After bwareaopen(5) (num=%d)', num2));

% ==== 可选：保存为高分辨率图片 ====
exportgraphics(f,'before_after_bwareaopen.png','Resolution',300);
