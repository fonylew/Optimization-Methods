disp("==== [ 1.1 ] ====");
c = [30; 40]
A = [4, 2 ; 3, 5 ; 5, 2]
b = [80; 100; 120]
[z_max,x_max,status] = simplex_lp_solver(c,A,b)

disp("==== [ 1.2 ] ====");
c = [30; 40]
A = [4, 2 ; 3, 5 ; 5, 2]
b = [80; 80; 120]
[z_max,x_max,status] = simplex_lp_solver(c,A,b)

disp("==== [ 1.3 ] ====");
c = [30; 40]
A = [4, 2 ; 3, 5 ; 5, 2; 1, 0];
b = [80; 100; 120; 5]
[z_max,x_max,status] = simplex_lp_solver(c,A,b)

disp("===========================================");

disp("==== [ 2.1 ] ====");
c = [400; 600]
A = [-1, -1 ; 200, 100 ; -2, 1];
b = [-8; 2500; 0]
[z_max,x_max,status] = stu_lp_solver(c,A,b)

disp("==== [ 2.2 ] ====");
c = [400; 600]
A = [-1, -1 ; 230, 115 ; -2, 1];
b = [-8; 2500; 0]
[z_max,x_max,status] = stu_lp_solver(c,A,b)

disp("==== [ 2.3 ] ====");
c = [400; 600; 500]
A = [-1, -1, 0 ; 230, 115, 80 ; -2, 1, 0; 0, -2, 1];
b = [-8; 2500; 0; 0]
[z_max,x_max,status] = stu_lp_solver(c,A,b)

disp("================ D O N E ==================");
