% main.m
clear; clc; close all;

I = imread("rice.png");

imhist(I)

disp(myintermeans_34(I))


% 标出 threshold 值
% 假设 I 已存在：
thres = myintermeans_34(I);         % 归一化阈值 [0,1]
T = thres * 255;                    % 转成灰度(0..255)

figure(1);                          % 切到直方图窗口（或用 gcf 那个窗口号）
ax = gca; hold(ax,'on');

xline(ax, T, 'r--', 'LineWidth', 2);                     % 竖线
yl = ylim(ax);
text(ax, T+5, yl(2)*0.90, ...                            % 文本标注
     sprintf('Threshold = %.2f (Gray ~ %.0f)', thres, T), ...
     'Color','r','FontSize',10,'FontWeight','bold');

title(ax,'Histogram of rice.png with Threshold Line');
xlabel(ax,'Gray level (0–255)'); ylabel(ax,'Number of pixels');
grid(ax,'on'); box(ax,'off'); hold(ax,'off');

% 对比图
% ==== 数据与阈值 ====
im = imread('rice.png');                 % 若是RGB，imshow会自动显示；算法用灰度
thres = myintermeans_34(im);             % 归一化阈值 [0,1]
bw = im2bw(im, thres);                   % 生成二值图

% ==== 生成对比图 ====
f = figure('Color','w','Position',[100 100 1000 420]);  % 宽些好排版
t = tiledlayout(1,2,'TileSpacing','compact','Padding','compact');

% 原图
nexttile;
imshow(im, 'InitialMagnification', 'fit');  % 自适应窗口大小
title('Original Image');
axis off;

% 二值图
nexttile;
imshow(bw, 'InitialMagnification', 'fit');
title(sprintf('Binarized Image (thres = %.4f)', thres));
axis off;

% ==== 可选：保存为高分辨率 PNG ====
exportgraphics(f, 'compare_original_vs_bw.png', 'Resolution', 300);
