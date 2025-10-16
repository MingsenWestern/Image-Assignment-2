% main.m
clear; clc; close all;

I = imread("rice.png");

imhist(I)

disp(myintermeans_34(I))