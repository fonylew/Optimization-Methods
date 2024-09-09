function [T,BV] = first_simplex_tableau(c,A,b)
## Function [T, BV] = first_simplex_tableau (c, A, b) builds the first 
## simplex tableau for the function simplex_lp_solver.  T is the tableau,
## BV are the indexes of the basic variables (the slacks in this case).

## n is the number of decision variables, m is the number of constraints.
[m,n] = size(A);

## The simplex tableau without the BV information.
T = [          1  -c'  zeros(1,m)  0; 
      zeros(m,1)    A      eye(m)  b];

## The indexes of the BV's (the slacks in this case).
BV = ( (n+1):(n+m) )';
endfunction
