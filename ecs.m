clc
clear all

Caf = 0.5;
Car = 0.3;
lf = 1.141;
lr = 1.639;
mv = 1529.98;
vx = 0.5;
Iz = 4605;
Kus = 10;
delta = 0.2;
rho = 1;
beta_max = 0.4;
r_max = 1;
Mz_max = 2;

A = [-2*(Caf + Car)/(mv*vx), -1-2*(lf * Caf - lr * Car)/(mv*vx*vx); -2*(lf * Caf - lr * Car)/Iz , -2*(lf*lf*Caf + lr*lr*Car)/(Iz*vx)];
Bu = [0 ; 1/Iz];
Bu_aug = [0, 2*Caf/(mv * vx); 1/Iz, 2*lf*Caf/(Iz)];
G = [2*Caf/(mv * vx) 2*lf*Caf/(Iz)];

sys_bicycle = ss(A,Bu_aug,[0 0],[0 0]);
sys_bicycle_dis = c2d(sys_bicycle, 0.001);

phi = sys_bicycle_dis.a;
gamma = sys_bicycle_dis.b(:,1);
H = [0 1];

phi_aug = [1, H; [0;0], phi];
gamma_aug = [0;gamma];
gamma_r = [1; 0 ; 0];

rd = vx / ((lf+lr) + Kus * vx *vx) * delta;

Q = diag([rho, 1/(beta_max * beta_max), 1/(r_max * r_max)]);
R = 1 / (Mz_max * Mz_max);

P = dare(phi_aug, gamma_aug, Q, R)
Ka = inv(gamma_aug' * P * gamma_aug + R)*(gamma_aug'*P*phi_aug)

K = Ka(2:3);
Ki = Ka(1);

N_aug = inv([phi - eye(2), gamma; H, 0])*[0;0;1]
Nx = N_aug(1:2);
Nu = N_aug(3);
N_bar = Nu + K * Nx


