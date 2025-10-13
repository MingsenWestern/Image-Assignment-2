% main.m
clear; clc; close all;

I = imread("/Users/mingsenhu/Documents/Work/Code/MATLAB/Test/Test2/image/mountain_grayscale.jpg");

imhist(I)

disp(myintermeans_34(I))