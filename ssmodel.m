clc
clear all

Iw = 12.5;
rw = 0.5;
Ts = 0.001;

A = [ 0 1; 0 0 ];
B = [ 0 0; 1/Iw -rw/Iw];
C = [1 0];
D = [0 0];

sys = ss(A,B,C,D);
sysdis = c2d(sys, Ts)