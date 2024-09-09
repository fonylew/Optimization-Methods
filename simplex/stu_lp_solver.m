function [z_max, x_max, status] = stu_lp_solver(c, A, b)
## Function [z_max, x_max, status] = stu_lp_solver(c, A, b) solves the LP 
##
##     max  c'*x
##     s.t.  A*x <= b
##             x >= 0, 
##
## by using glpk.
##
## Input:
##
## c, A, b
##      The (column) vector defining the objective function, the 
##       technology matrix, and the (column) vector of the constraints.
##
## Output:
##
## z_max, x_max
##      The maximal value of the objective and an optimal decision.
##
## status
##      A string indicating the status of the solution: 
##	    "bounded"
##           A bounded solution was found. 
##      "unbounded"
##           The solution is known to be unbounded.
##      "infeasible"
##           Solutions are known not to exist.
##      "unknown"
##           The algorithm failed.
##
## See also:  glpk.

## Get m, the number of constraints (excluding the sign constraints), and
## n, is the number of decision variables, from the technology matrix A.
[m,n] = size(A);

## Some input-checking: 
if ( nargin!=3 )
  error("stu_lp_solver: The number of input arguments must be 3.\n");
elseif ( columns(c)>1 )
  error("stu_lp_solver: Objective c must be a column vector.\n"); 
elseif (columns(b)>1 )
  error("stu_lp_solver: Upper bounds b must be a column vector.\n");
elseif (rows(c)!=n || rows(b)!=m )
  error("stu_lp_solver: The dimensions of c, A, and b do not match.\n");
endif 

## Set the parameters for glpk:

## Set the decision-wise lower bounds all to zero, i.e. build a zero
## column vector with n zeros. 
o = zeros(n,1);

## Set the sense of each constraint as an upper bound.
ctype = "";                                 # Start with an empty string. 
for i=1:m                                   # Loop m times.
  ctype = [ctype, "U"];                     # Append "U" to the string.
endfor 

## Set the type of each variable as continuous.
vtype = "";                                 # Start with an empty string. 
for i=1:n                                   # Loop n times.
  vtype = [vtype, "C"];                     # Append "C" to the string.
endfor 

## Solve the system by calling glpk.
[x_max, z_max, STATUS] = glpk(c, A, b, o, [], ctype, vtype, -1);

## Set the STATUS code given by glpk to the appropriate string
status = "unknown";                         # Pessimism by default.
if ( STATUS==180 )                          # Everything went fine.
  status="bounded";
elseif ( STATUS==183 )                      # LP infeasible detected.
  status="infeasible";
elseif ( STATUS==184 )                      # LP unboundedness detected.
  status="unbounded";
endif
endfunction
