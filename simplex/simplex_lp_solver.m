function [z_max, x_max, status] = simplex_lp_solver(c, A, b, maxiter=100)
## Function [z_max, x_max, status] =
## simplex_lp_solver (c, A, b, maxiter=100) solves the LP
##
##     max  c'*x
##     s.t.  A*x <= b
##             x >= 0,
##
## where b>=0, by using the standard simplex algorithm.
##
## Input:
##
## c, A, b
##      The (column) vector defining the objective function, the
##       technology matrix, and the (column) vector of the constraints.
##
## maxiter
##      The maximum iterations used in finding a solution (default: 100).
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
##           Solutions are known not to exist (not applicable for b>=0).
##      "unknown"
##           The algorithm failed.
##
## simplex_lp_solver uses the functions  first_simplex_tableau,
## new_simplex_tableau, and is_best_simplex_tableau.
##
## See also:  glpk.

## Get the first simplex tableau.
[T,BV] = first_simplex_tableau(c,A,b);
disp("--- first ---");
disp("BV: ");
disp(BV);
disp("T: ");
disp(T);

## Look for better simplex tableaux, but avoid the infinite loop.
status = "unknown";                          # Status still unknown :)
iter = 0;                                    # No iterations yet.
while ( iter<maxiter && ...
        !is_optimal_simplex_tableau(T,BV) && ...
        !strcmp(status,"unbounded") )
  [T,BV,status] = new_simplex_tableau(T,BV); # New [T,BV], unbounded (?).
  iter = iter + 1;                           # We just had an iteration.
  disp("------");
  disp("Iter: ");
  disp(iter);
  disp("BV: ");
  disp(BV);
  disp("T: ");
  disp(T);
endwhile

## Exit (with zeroes), if a solution was not found or found unbounded.
if ( iter>=maxiter || strcmp(status,"unbounded") )
  z_max = 0;
  x_max = zeros(length(c),1);
  return;
endif

## Collect the results from the last simplex tableau.
status = "bounded";                          # We know this now.
z_max = T(1,columns(T));                     # z_max is in the NE corner.
x_max = zeros(length(c)+length(b),1);        # Zeros for now.
x_max(BV) = T(2:(length(b)+1),columns(T));   # Put BV values to x_max.
x_max = x_max(1:length(c));                  # Cut the slacks away.
endfunction
