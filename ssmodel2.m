rw = 0.5;
Iw = 12.5;
pol1 = 0.5;
pol2 = 0.55;
A = [0 1 0; 0 0 -rw/Iw; 0 0 0];
B = [0 ; 1/Iw ; 0];
C = [1 0 0];
Do = 0;
systa = ss(A,B,C,Do);
systaa = c2d(systa, 0.001);
Ad = systaa.a;
Bd = systaa.b;
Cd = systaa.c;
syms p1 p2 p3 p4 p5 p6;%unknowns
P = [p1 p2 p3; p4 p5 p6];
D = [pol1 0 ; 0 pol2];
G = [5 ; 10];%observer gain
[p1sol, p2sol, p3sol, p4sol, p5sol, p6sol] = solve(P*Ad - D*P == G*Cd);
P = [eval(p1sol) eval(p2sol) eval(p3sol); eval(p4sol) eval(p5sol) eval(p6sol)];

E = P*Bd;

Ga = [E G];

matt = [C;P]
inv(matt)