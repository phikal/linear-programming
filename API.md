---
layout: page
title: API Documentation
meta-description: The API Documentation for the linear-programming Common Lisp library.
---


<br>
### <a name="package-common-lisp-user:linear-programming"></a>**PACKAGE** - LINEAR-PROGRAMMING   
The overall package for the linear programming library.
                   It contains only the reexported symbols of
                   [LINEAR-PROGRAMMING/PROBLEM](#package-linear-programming/problem),
                   [LINEAR-PROGRAMMING/SOLVER](#package-linear-programming/solver), and
                   [LINEAR-PROGRAMMING/CONDITIONS](#package-linear-programming/conditions).

<br>
### <a name="package-common-lisp-user:linear-programming/problem"></a>**PACKAGE** - LINEAR-PROGRAMMING/PROBLEM   
Handles the representation of linear programming problems.

<a name="generic-linear-programming/problem:objective-variable"></a>**GENERIC** - OBJECTIVE-VARIABLE (OBJECT)  
The name of the objective function.

<a name="function-linear-programming/problem:parse-linear-problem"></a>**FUNCTION** - PARSE-LINEAR-PROBLEM (OBJECTIVE-EXP CONSTRAINTS)  
Parses the expressions into a linear programming problem

<a name="generic-linear-programming/problem:integer-vars"></a>**GENERIC** - INTEGER-VARS (OBJECT)  
A list of variables with integer constraints.

<a name="generic-linear-programming/problem:signed-vars"></a>**GENERIC** - SIGNED-VARS (OBJECT)  
A list of variables without positivity constraints.

<a name="function-linear-programming/problem:make-linear-problem"></a>**FUNCTION** - MAKE-LINEAR-PROBLEM (OBJECTIVE &REST CONSTRAINTS)  
Creates a linear problem from the expressions in the body

<a name="macro-linear-programming/problem:make-linear-problem"></a>**MACRO** - MAKE-LINEAR-PROBLEM (OBJECTIVE &REST CONSTRAINTS)  
Creates a linear problem from the expressions in the body

<a name="condition-linear-programming/conditions:parsing-error"></a>**CONDITION** - PARSING-ERROR   
Indicates an error occured while parsing a linear problem.
                   Includes a textual description of the issue.

<a name="generic-linear-programming/problem:constraints"></a>**GENERIC** - CONSTRAINTS (OBJECT)  
A list of (in)equality constraints.

<a name="generic-linear-programming/problem:objective-function"></a>**GENERIC** - OBJECTIVE-FUNCTION (OBJECT)  
The objective function as a linear expression alist.

<a name="generic-linear-programming/problem:lp-type"></a>**GENERIC** - LP-TYPE (OBJECT)  
Whether the problem is a `min` or `max` problem.

<a name="class-linear-programming/problem:linear-problem"></a>**CLASS** - LINEAR-PROBLEM   
The representation of a linear programming problem.

<a name="generic-linear-programming/problem:variables"></a>**GENERIC** - VARIABLES (OBJECT)  
An array of the variables specified in the problem.

<br>
### <a name="package-common-lisp-user:linear-programming/solver"></a>**PACKAGE** - LINEAR-PROGRAMMING/SOLVER   
The high level linear programming solver interface.  This
                   package abstracts away some of the complexities of the
                   simplex method, including integer constraints.  See
                   [LINEAR-PROGRAMMING/SIMPLEX](#package-linear-programming/simplex)
                   for lower level control of the solver.

<a name="function-linear-programming/solver:solution-shadow-price"></a>**FUNCTION** - SOLUTION-SHADOW-PRICE (SOLUTION VAR)  
Gets the shadow price of the given variable in the solution

<a name="function-linear-programming/solver:solve-problem"></a>**FUNCTION** - SOLVE-PROBLEM (PROBLEM)  
Solves the given linear problem

<a name="function-linear-programming/solver:solution-problem"></a>**FUNCTION** - SOLUTION-PROBLEM (INSTANCE)  
The problem that resulted in this solution.

<a name="struct-linear-programming/solver:solution"></a>**STRUCT** - SOLUTION   
Represents a solution to a linear programming problem.

<a name="function-linear-programming/solver:with-solved-problem"></a>**FUNCTION** - WITH-SOLVED-PROBLEM ((OBJECTIVE-FUNC &REST CONSTRAINTS) &BODY BODY)  
Takes the problem description, and evaluates `body` with the variables of
   the problem bound to their solution values.  Additionally, a macro
   `(shadow-price var)` is bound to get the shadow price of `var`.

<a name="macro-linear-programming/solver:with-solved-problem"></a>**MACRO** - WITH-SOLVED-PROBLEM ((OBJECTIVE-FUNC &REST CONSTRAINTS) &BODY BODY)  
Takes the problem description, and evaluates `body` with the variables of
   the problem bound to their solution values.  Additionally, a macro
   `(shadow-price var)` is bound to get the shadow price of `var`.

<a name="function-linear-programming/solver:solution-objective-value"></a>**FUNCTION** - SOLUTION-OBJECTIVE-VALUE (INSTANCE)  
The value of the objective function.

<a name="function-linear-programming/solver:solution-variable"></a>**FUNCTION** - SOLUTION-VARIABLE (SOLUTION VAR)  
Gets the value of the given variable in the solution

<br>
### <a name="package-common-lisp-user:linear-programming/conditions"></a>**PACKAGE** - LINEAR-PROGRAMMING/CONDITIONS   
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
### <a name="package-common-lisp-user:linear-programming/simplex"></a>**PACKAGE** - LINEAR-PROGRAMMING/SIMPLEX   
The actual simplex solver implementation.

<a name="function-linear-programming/simplex:n-pivot-row"></a>**FUNCTION** - N-PIVOT-ROW (TABLEAU ENTERING-COL CHANGING-ROW)  
Destructively applies a single pivot to the table.

<a name="function-linear-programming/simplex:tableau-p"></a>**FUNCTION** - TABLEAU-P (OBJECT)

<a name="function-linear-programming/simplex:tableau-matrix"></a>**FUNCTION** - TABLEAU-MATRIX (INSTANCE)

<a name="struct-linear-programming/simplex:tableau"></a>**STRUCT** - TABLEAU   
Contains the necessary information for a simplex tableau.

<a name="function-linear-programming/simplex:tableau-var-count"></a>**FUNCTION** - TABLEAU-VAR-COUNT (INSTANCE)

<a name="function-linear-programming/simplex:tableau-objective-value"></a>**FUNCTION** - TABLEAU-OBJECTIVE-VALUE (TABLEAU)  
Gets the objective function value in the tableau

<a name="function-linear-programming/simplex:pivot-row"></a>**FUNCTION** - PIVOT-ROW (TABLEAU ENTERING-COL CHANGING-ROW)  
Non-destructively applies a single pivot to the table.

<a name="function-linear-programming/simplex:n-solve-tableau"></a>**FUNCTION** - N-SOLVE-TABLEAU (TABLEAU)  
A non-consing version of
   [`solve-tableau`](#function-linear-programming/simplex:solve-tableau).

<a name="function-linear-programming/simplex:solve-tableau"></a>**FUNCTION** - SOLVE-TABLEAU (TABLEAU)  
Attempts to solve the tableau using the simplex method.  If a list of two
   tableaus is given, then a two-phase version is used.
   The original tableau is unchanged

<a name="function-linear-programming/simplex:tableau-shadow-price"></a>**FUNCTION** - TABLEAU-SHADOW-PRICE (VAR TABLEAU)  
Gets the shadow price for the given variable from the tableau

<a name="function-linear-programming/simplex:build-tableau"></a>**FUNCTION** - BUILD-TABLEAU (PROBLEM)  
Creates the tableau from the given linear problem.  If the trivial basis is
   not feasible, instead a list is returned containing the two tableaus for a
   two-phase simplex method.

<a name="function-linear-programming/simplex:tableau-basis-columns"></a>**FUNCTION** - TABLEAU-BASIS-COLUMNS (INSTANCE)

<a name="function-linear-programming/simplex:tableau-constraint-count"></a>**FUNCTION** - TABLEAU-CONSTRAINT-COUNT (INSTANCE)

<a name="function-linear-programming/simplex:tableau-problem"></a>**FUNCTION** - TABLEAU-PROBLEM (INSTANCE)

<a name="function-linear-programming/simplex:copy-tableau"></a>**FUNCTION** - COPY-TABLEAU (TABLEAU)  
Copies the given tableau and it's matrix

<a name="function-linear-programming/simplex:with-tableau-variables"></a>**FUNCTION** - WITH-TABLEAU-VARIABLES (VAR-LIST TABLEAU &BODY BODY)  
Evaluates the body with the variables in `var-list` bound to their values in
   the tableau.  If a linear problem is instead passed as `var-list`, all
   of the problem's variables are bound.

<a name="macro-linear-programming/simplex:with-tableau-variables"></a>**MACRO** - WITH-TABLEAU-VARIABLES (VAR-LIST TABLEAU &BODY BODY)  
Evaluates the body with the variables in `var-list` bound to their values in
   the tableau.  If a linear problem is instead passed as `var-list`, all
   of the problem's variables are bound.

<a name="function-linear-programming/simplex:tableau-variable"></a>**FUNCTION** - TABLEAU-VARIABLE (VAR TABLEAU)  
Gets the value of the given variable from the tableau

<br>
### <a name="package-common-lisp-user:linear-programming/expressions"></a>**PACKAGE** - LINEAR-PROGRAMMING/EXPRESSIONS   
Contains functions for processing linear expressions.

<a name="function-linear-programming/expressions:scale-linear-expression"></a>**FUNCTION** - SCALE-LINEAR-EXPRESSION (EXPR SCALAR)  
Multiplies the linear expression by the given scalar

<a name="function-linear-programming/expressions:parse-linear-expression"></a>**FUNCTION** - PARSE-LINEAR-EXPRESSION (EXPR)  
Parses the expression into a alist mapping variables to coefficients.
   Any constant values are mapped to `+constant+`

<a name="function-linear-programming/expressions:sum-linear-expressions"></a>**FUNCTION** - SUM-LINEAR-EXPRESSIONS (&REST EXPRS)  
Takes a list of linear expressions and reduces it into a single expression

