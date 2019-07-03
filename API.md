---
layout: page
title: API Documentation
meta-description: The API Documentation for the linear-programming Common Lisp library.
---


### **PACKAGE** - LINEAR-PROGRAMMING NIL  
The overall package.  Reexports symbols from
             LINEAR-PROGRAMMING/PROBLEM, LINEAR-PROGRAMMING/SOLVER and
             LINEAR-PROGRAMMING/CONDITIONS.

### **PACKAGE** - LINEAR-PROGRAMMING/PROBLEM NIL

**GENERIC** - OBJECTIVE-VARIABLE (OBJECT)

**FUNCTION** - PARSE-LINEAR-PROBLEM (OBJECTIVE-EXP CONSTRAINTS)  
Parses the expressions into a linear programming problem

**FUNCTION** - MAKE-LINEAR-PROBLEM (OBJECTIVE &REST CONSTRAINTS)  
Creates a linear problem from the expressions in the body

**MACRO** - MAKE-LINEAR-PROBLEM (OBJECTIVE &REST CONSTRAINTS)  
Creates a linear problem from the expressions in the body

**CONDITION** - PARSING-ERROR NIL  
Indicates an error occured while parsing a linear problem.
                   Includes a textual description of the issue.

**GENERIC** - CONSTRAINTS (OBJECT)

**GENERIC** - OBJECTIVE-FUNCTION (OBJECT)

**GENERIC** - SIGNED-VARS (OBJECT)

**GENERIC** - LP-TYPE (OBJECT)

**CLASS** - LINEAR-PROBLEM NIL

**GENERIC** - VARIABLES (OBJECT)

### **PACKAGE** - LINEAR-PROGRAMMING/SOLVER NIL  
High level linear programming problem solving functions

**FUNCTION** - SOLUTION-SHADOW-PRICE (SOLUTION VAR)  
Gets the shadow price of the given variable in the solution

**FUNCTION** - SOLVE-PROBLEM (PROBLEM)  
Solves the given linear problem

**FUNCTION** - SOLUTION-PROBLEM (INSTANCE)

**STRUCT** - SOLUTION NIL

**FUNCTION** - WITH-SOLVED-PROBLEM ((OBJECTIVE-FUNC &REST CONSTRAINTS) &BODY BODY)  
Takes the problem description, and evaluates `body` with the variables of
   the problem bound to their solution values.  Additionally, a macro
   `(shadow-price var)` is bound to get the shadow price of `var`.

**MACRO** - WITH-SOLVED-PROBLEM ((OBJECTIVE-FUNC &REST CONSTRAINTS) &BODY BODY)  
Takes the problem description, and evaluates `body` with the variables of
   the problem bound to their solution values.  Additionally, a macro
   `(shadow-price var)` is bound to get the shadow price of `var`.

**FUNCTION** - SOLUTION-OBJECTIVE-VALUE (INSTANCE)

**FUNCTION** - SOLUTION-VARIABLE (SOLUTION VAR)  
Gets the value of the given variable in the solution

### **PACKAGE** - LINEAR-PROGRAMMING/CONDITIONS NIL

**CONDITION** - INFEASIBLE-PROBLEM-ERROR NIL  
Indicates the there is no feasible region.

**CONDITION** - SOLVER-ERROR NIL  
The base class for errors that occur with the solving algorithm.

**CONDITION** - UNBOUNDED-PROBLEM-ERROR NIL  
Indicates the feasible region is unbounded such that the
                   optimal objective value is infinite.

**CONDITION** - PARSING-ERROR NIL  
Indicates an error occured while parsing a linear problem.
                   Includes a textual description of the issue.

### **PACKAGE** - LINEAR-PROGRAMMING/SIMPLEX NIL

**FUNCTION** - N-PIVOT-ROW (TABLEAU ENTERING-COL CHANGING-ROW)  
Destructively applies a single pivot to the table.

**FUNCTION** - TABLEAU-P (OBJECT)

**FUNCTION** - TABLEAU-MATRIX (INSTANCE)

**STRUCT** - TABLEAU NIL

**FUNCTION** - TABLEAU-VAR-COUNT (INSTANCE)

**FUNCTION** - TABLEAU-OBJECTIVE-VALUE (TABLEAU)  
Gets the objective function value in the tableau

**FUNCTION** - N-SOLVE-TABLEAU (TABLEAU)  
A non-consing version of `solve-tableau`.

**FUNCTION** - SOLVE-TABLEAU (TABLEAU)  
Attempts to solve the tableau using the simplex method.  If a list of two
   tableaus is given, then a two-phase version is used.
   The original tableau is unchanged

**FUNCTION** - TABLEAU-SHADOW-PRICE (VAR TABLEAU)  
Gets the shadow price for the given variable from the tableau

**FUNCTION** - BUILD-TABLEAU (PROBLEM)  
Creates the tableau from the given linear problem.  If the trivial basis is
   not feasible, instead a list is returned containing the two tableaus for a
   two-phase simplex method.

**FUNCTION** - TABLEAU-BASIS-COLUMNS (INSTANCE)

**FUNCTION** - TABLEAU-CONSTRAINT-COUNT (INSTANCE)

**FUNCTION** - TABLEAU-PROBLEM (INSTANCE)

**FUNCTION** - COPY-TABLEAU (TABLEAU)  
Copies the given tableau and it's matrix

**FUNCTION** - WITH-TABLEAU-VARIABLES (VAR-LIST TABLEAU &BODY BODY)  
Evaluates the body with the variables in `var-list` bound to their values in
   the tableau.  If a linear problem is instead passed as `var-list`, all
   of the problem's variables are bound.

**MACRO** - WITH-TABLEAU-VARIABLES (VAR-LIST TABLEAU &BODY BODY)  
Evaluates the body with the variables in `var-list` bound to their values in
   the tableau.  If a linear problem is instead passed as `var-list`, all
   of the problem's variables are bound.

**FUNCTION** - TABLEAU-VARIABLE (VAR TABLEAU)  
Gets the value of the given variable from the tableau

### **PACKAGE** - LINEAR-PROGRAMMING/EXPRESSIONS NIL

**FUNCTION** - SCALE-LINEAR-EXPRESSION (EXPR SCALAR)  
Multiplies the linear expression by the given scalar

**FUNCTION** - PARSE-LINEAR-EXPRESSION (EXPR)  
Parses the expression into a alist mapping variables to coefficients.
   Any constant values are mapped to +constant+

**FUNCTION** - SUM-LINEAR-EXPRESSIONS (EXPRS)  
Takes a list of linear expressions and reduces it into a single expression

