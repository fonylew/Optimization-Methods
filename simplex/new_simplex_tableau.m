function [Tnew,BVnew,status] = new_simplex_tableau(T,BV)
## Function [Tnew, BVnew, status] = new_simplex_tableau (T, BV) builds 
## a new, hopefully better, simplex tableau [Tnew, BVnew] from the 
## tableau [T, BV], or detects the solution to be unbounded.
## This function is used by the function simplex_lp_solver.

## Variable initializations and short-hand notations.
status = "unknown";               # Paranoia!     
Tnew = T; BVnew = BV;             # New tableau is old tableau (for now).
[m,n] = size(T);                  # Almost the dimensions of A.

## Get the entering BV.
coeff = T(1,2:(n-1));             # Coeffs. of the decisions and slacks.
[tmp,in] = min(coeff);            # Index of the entering coefficient.

## Get the leaving BV, or detect unboundedness and leave the function.
rhs = T(2:m,n);                   # RHS of the constraint rows.
cin = T(2:m,in+1);                # Coeffs. of the entering variables.
ratio = rhs./cin;                 # Pointwise ratios. 

## Set all the "no-limit" ratios to -infinity
for i=1:length(ratio)
  if ( ratio(i)==Inf || ratio(i)<0 )
    ratio(i) = -Inf;
  endif
endfor 

## Check boundedness. Exit if unbounded.
if ( all(ratio<0) )               
  status = "unbounded";
  return;
endif

[tmp,out] = min(abs(ratio));      # Get the winner index.

## Solve T the new BV.
BVnew(out) = in;                  # The new BV.
Tnew = pivot(T,out+1,in+1);       # Solve T for the new BV by pivoting.
endfunction

#########################################################################
## The auxiliary function pivot
#########################################################################

function Ap = pivot(A, r, c)
## Function Ap = pivot (A, r, c) pivots A with row r and column c.  

A(r,:) = A(r,:)/A(r,c);           # Get 1 for the pivot in the pivot row.
for i = 1:rows(A)                 # Remove the pivot from other rows. 
  if (i != r)
    A(i,:) = A(i,:) - A(i,c)*A(r,:);
  endif
endfor
Ap = A;                           # Return the pivoted matrix Ap.
endfunction  
