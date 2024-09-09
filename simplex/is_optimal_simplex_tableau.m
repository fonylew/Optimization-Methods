function optimal = is_optimal_simplex_tableau(T,BV)
## Function optimal = is_optimal_simplex_tableau (T,BV) tells (to the
## function simplex_lp_solver) if the simplex tableau [T, BV] is optimal. 

## The tableau [T,BV] is optimal if in the first row all the
## coefficients are non-negative for all Non-Basic Variables (NBV).
NBV = get_NBV(BV,columns(T)-2);  # Get NBV (cf. the function below).
optimal = 0;                     # A priori assume non-optimality.
NBVval = T(1,NBV+1);             # First column is for z, hence NBV+1.
if ( all(NBVval>=0) )            # Check for optimality.
  optimal = 1;
endif
endfunction

#########################################################################
## Auxiliary function to get NBV indexes from BV indexes.
#########################################################################

function NBV = get_NBV(BV,nvar)
vars = ones(nvar,1);            # Set "true" to all indexes.
vars(BV) = 0;                   # Set "false" to BV indexes. 
NBV = find(vars);               # Get the "true" indexes.
endfunction
