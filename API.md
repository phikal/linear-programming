---
layout: page
title: API Documentation
meta-description: The API Documentation for the linear-programming Common Lisp library.
---


<br>
### <a name="package-linear-programming"></a>**PACKAGE** - LINEAR-PROGRAMMING   
The overall package for the linear programming library.
                   It contains only the reexported symbols of
                   [LINEAR-PROGRAMMING/PROBLEM](#package-linear-programming/problem),
                   [LINEAR-PROGRAMMING/SOLVER](#package-linear-programming/solver), and
                   [LINEAR-PROGRAMMING/CONDITIONS](#package-linear-programming/conditions).

<br>
### <a name="package-linear-programming/problem"></a>**PACKAGE** - LINEAR-PROGRAMMING/PROBLEM   
Handles the representation of linear programming problems.

<a name="nil-linear-programming/problem:problem-type"></a>**NIL** - PROBLEM-TYPE (INSTANCE)  
Whether the problem is a `min` or `max` problem.

<a name="nil-linear-programming/problem:problem-objective-func"></a>**NIL** - PROBLEM-OBJECTIVE-FUNC (INSTANCE)  
The objective function as a linear expression alist.

<a name="nil-linear-programming/problem:problem-objective-var"></a>**NIL** - PROBLEM-OBJECTIVE-VAR (INSTANCE)  
The name of the objective function.

<a name="nil-linear-programming/problem:problem-vars"></a>**NIL** - PROBLEM-VARS (INSTANCE)  
An array of the variables specified in the problem.

<a name="nil-linear-programming/problem:parse-linear-problem"></a>**NIL** - PARSE-LINEAR-PROBLEM (OBJECTIVE-EXP CONSTRAINTS)  
Parses the expressions into a linear programming problem

<a name="nil-linear-programming/problem:problem-constraints"></a>**NIL** - PROBLEM-CONSTRAINTS (INSTANCE)  
A list of (in)equality constraints.

<a name="macro-linear-programming/problem:make-linear-problem"></a>**MACRO** - MAKE-LINEAR-PROBLEM (OBJECTIVE &REST CONSTRAINTS)  
Creates a linear problem from the expressions in the body

<a name="nil-linear-programming/problem:problem-integer-vars"></a>**NIL** - PROBLEM-INTEGER-VARS (INSTANCE)  
A list of variables with integer constraints.

<a name="struct-linear-programming/problem:problem"></a>**STRUCT** - PROBLEM   
The representation of a linear programming problem.

<a name="nil-linear-programming/problem:problem-signed-vars"></a>**NIL** - PROBLEM-SIGNED-VARS (INSTANCE)  
A list of variables without positivity constraints.

<br>
### <a name="package-linear-programming/solver"></a>**PACKAGE** - LINEAR-PROGRAMMING/SOLVER   
The high level linear programming solver interface.  This
                   package abstracts away some of the complexities of the
                   simplex method, including integer constraints.  See
                   [LINEAR-PROGRAMMING/SIMPLEX](#package-linear-programming/simplex)
                   for lower level control of the solver.

<a name="nil-linear-programming/solver:solution-shadow-price"></a>**NIL** - SOLUTION-SHADOW-PRICE (SOLUTION VAR)  
Gets the shadow price of the given variable in the solution

<a name="nil-linear-programming/solver:solve-problem"></a>**NIL** - SOLVE-PROBLEM (PROBLEM)  
Solves the given linear problem

<a name="nil-linear-programming/solver:solution-problem"></a>**NIL** - SOLUTION-PROBLEM (INSTANCE)  
The problem that resulted in this solution.

<a name="struct-linear-programming/solver:solution"></a>**STRUCT** - SOLUTION   
Represents a solution to a linear programming problem.

<a name="macro-linear-programming/solver:with-solution-variables"></a>**MACRO** - WITH-SOLUTION-VARIABLES (VAR-LIST SOLUTION &BODY BODY)  
Evaluates the body with the variables in `var-list` bound to their values in
   the solution.  If a linear problem is instead passed as `var-list`, all
   of the problem's variables are bound.

<a name="nil-linear-programming/solver:solution-variable"></a>**NIL** - SOLUTION-VARIABLE (SOLUTION VAR)  
Gets the value of the given variable in the solution

<a name="macro-linear-programming/solver:with-solved-problem"></a>**MACRO** - WITH-SOLVED-PROBLEM ((OBJECTIVE-FUNC &REST CONSTRAINTS) &BODY BODY)  
Takes the problem description, and evaluates `body` with the variables of
   the problem bound to their solution values.  Additionally, a macro
   `(shadow-price var)` is bound to get the shadow price of `var`.

<a name="nil-linear-programming/solver:solution-objective-value"></a>**NIL** - SOLUTION-OBJECTIVE-VALUE (INSTANCE)  
The value of the objective function.

<br>
### <a name="package-linear-programming/conditions"></a>**PACKAGE** - LINEAR-PROGRAMMING/CONDITIONS   
Contains the various conditions used by this library.

<a name="condition-linear-programming/conditions:nonlinear-error"></a>**CONDITION** - NONLINEAR-ERROR   
Indicates a form was not a linear expression.  This includes
                   the use of nonlinear functions and taking the product of
                   multiple variables

<a name="condition-linear-programming/conditions:infeasible-problem-error"></a>**CONDITION** - INFEASIBLE-PROBLEM-ERROR   
Indicates the there is no feasible region.

<a name="condition-linear-programming/conditions:solver-error"></a>**CONDITION** - SOLVER-ERROR   
The base class for errors that occur with the solving algorithm.

<a name="condition-linear-programming/conditions:infeasible-integer-constraints-error"></a>**CONDITION** - INFEASIBLE-INTEGER-CONSTRAINTS-ERROR   
Indicates that there is no feasible region due to the integer
                   constraints.

<a name="condition-linear-programming/conditions:unbounded-problem-error"></a>**CONDITION** - UNBOUNDED-PROBLEM-ERROR   
Indicates the feasible region is unbounded such that the
                   optimal objective value is infinite.

<a name="condition-linear-programming/conditions:parsing-error"></a>**CONDITION** - PARSING-ERROR   
Indicates an error occured while parsing a linear problem.
                   Includes a textual description of the issue.

<br>
### <a name="package-linear-programming/simplex"></a>**PACKAGE** - LINEAR-PROGRAMMING/SIMPLEX   
The actual simplex solver implementation.

<a name="nil-linear-programming/simplex:n-pivot-row"></a>**NIL** - N-PIVOT-ROW (TABLEAU ENTERING-COL CHANGING-ROW)  
Destructively applies a single pivot to the table.

<a name="nil-linear-programming/simplex:tableau-p"></a>**NIL** - TABLEAU-P (OBJECT)

<a name="nil-linear-programming/simplex:tableau-matrix"></a>**NIL** - TABLEAU-MATRIX (INSTANCE)

<a name="struct-linear-programming/simplex:tableau"></a>**STRUCT** - TABLEAU   
Contains the necessary information for a simplex tableau.

<a name="nil-linear-programming/simplex:tableau-var-count"></a>**NIL** - TABLEAU-VAR-COUNT (INSTANCE)

<a name="nil-linear-programming/simplex:tableau-objective-value"></a>**NIL** - TABLEAU-OBJECTIVE-VALUE (TABLEAU)  
Gets the objective function value in the tableau

<a name="nil-linear-programming/simplex:pivot-row"></a>**NIL** - PIVOT-ROW (TABLEAU ENTERING-COL CHANGING-ROW)  
Non-destructively applies a single pivot to the table.

<a name="nil-linear-programming/simplex:n-solve-tableau"></a>**NIL** - N-SOLVE-TABLEAU (TABLEAU)  
A non-consing version of
   [`solve-tableau`](#function-linear-programming/simplex:solve-tableau).

<a name="nil-linear-programming/simplex:solve-tableau"></a>**NIL** - SOLVE-TABLEAU (TABLEAU)  
Attempts to solve the tableau using the simplex method.  If a list of two
   tableaus is given, then a two-phase version is used.
   The original tableau is unchanged

<a name="nil-linear-programming/simplex:tableau-shadow-price"></a>**NIL** - TABLEAU-SHADOW-PRICE (TABLEAU VAR)  
Gets the shadow price for the given variable from the tableau

<a name="nil-linear-programming/simplex:build-tableau"></a>**NIL** - BUILD-TABLEAU (PROBLEM)  
Creates the tableau from the given linear problem.  If the trivial basis is
   not feasible, instead a list is returned containing the two tableaus for a
   two-phase simplex method.

<a name="nil-linear-programming/simplex:tableau-basis-columns"></a>**NIL** - TABLEAU-BASIS-COLUMNS (INSTANCE)

<a name="nil-linear-programming/simplex:tableau-constraint-count"></a>**NIL** - TABLEAU-CONSTRAINT-COUNT (INSTANCE)

<a name="nil-linear-programming/simplex:tableau-problem"></a>**NIL** - TABLEAU-PROBLEM (INSTANCE)

<a name="nil-linear-programming/simplex:copy-tableau"></a>**NIL** - COPY-TABLEAU (TABLEAU)  
Copies the given tableau and it's matrix

<a name="macro-linear-programming/simplex:with-tableau-variables"></a>**MACRO** - WITH-TABLEAU-VARIABLES (VAR-LIST TABLEAU &BODY BODY)  
Evaluates the body with the variables in `var-list` bound to their values in
   the tableau.  If a linear problem is instead passed as `var-list`, all
   of the problem's variables are bound.

<a name="nil-linear-programming/simplex:tableau-variable"></a>**NIL** - TABLEAU-VARIABLE (TABLEAU VAR)  
Gets the value of the given variable from the tableau

<br>
### <a name="package-linear-programming/expressions"></a>**PACKAGE** - LINEAR-PROGRAMMING/EXPRESSIONS   
Contains functions for processing linear expressions.

<a name="nil-linear-programming/expressions:scale-linear-expression"></a>**NIL** - SCALE-LINEAR-EXPRESSION (EXPR SCALAR)  
Multiplies the linear expression by the given scalar

<a name="nil-linear-programming/expressions:parse-linear-expression"></a>**NIL** - PARSE-LINEAR-EXPRESSION (EXPR)  
Parses the expression into a alist mapping variables to coefficients.
   Any constant values are mapped to `+constant+`

<a name="nil-linear-programming/expressions:sum-linear-expressions"></a>**NIL** - SUM-LINEAR-EXPRESSIONS (&REST EXPRS)  
Takes a list of linear expressions and reduces it into a single expression

