### **PACKAGE** - LINEAR-PROGRAMMING   
The overall package.  Reexports symbols from
             LINEAR-PROGRAMMING/PROBLEM and LINEAR-PROGRAMMING/SIMPLEX.

### **PACKAGE** - LINEAR-PROGRAMMING/SIMPLEX 

**FUNCTION** - TABLEAU-P (OBJECT)

**FUNCTION** - TABLEAU-MATRIX (INSTANCE)

**STRUCT** - TABLEAU 

**FUNCTION** - TABLEAU-VAR-COUNT (INSTANCE)

**FUNCTION** - TABLEAU-OBJECTIVE-VALUE (TABLEAU)  
Gets the objective function value in the tableau

**FUNCTION** - PIVOT-ROW (TABLEAU ENTERING-COL CHANGING-ROW)  
Applies a single pivot to the table.

**FUNCTION** - WITH-TABLEAU-VARIABLES (VAR-LIST TABLEAU &BODY BODY)  
Evaluates the body with the variables in `var-list` bound to their values in
   the tableau.  If a linear problem is instead passed as `var-list`, all
   of the problem's variables are bound.

**MACRO** - WITH-TABLEAU-VARIABLES (VAR-LIST TABLEAU &BODY BODY)  
Evaluates the body with the variables in `var-list` bound to their values in
   the tableau.  If a linear problem is instead passed as `var-list`, all
   of the problem's variables are bound.

**FUNCTION** - SOLVE-TABLEAU (TABLEAU)  
Attempts to solve the tableau using the simplex method.  If a list of two
   tableaus is given, then a two-phase version is used.

**FUNCTION** - GET-TABLEAU-VARIABLE (VAR TABLEAU)  
Gets the value of the given variable from the tableau

**FUNCTION** - BUILD-TABLEAU (PROBLEM)  
Creates the tableau from the given linear problem.  If the trivial basis is
   not feasible, instead a list is returned containing the two tableaus for a
   two-phase simplex method.

**FUNCTION** - TABLEAU-BASIS-COLUMNS (INSTANCE)

**FUNCTION** - TABLEAU-CONSTRAINT-COUNT (INSTANCE)

**FUNCTION** - TABLEAU-PROBLEM (INSTANCE)

**FUNCTION** - GET-SHADOW-PRICE (VAR TABLEAU)  
Gets the shadow price for the given variable from the tableau

**FUNCTION** - COPY-TABLEAU (INSTANCE)

### **PACKAGE** - LINEAR-PROGRAMMING/PROBLEM 

**GENERIC** - OBJECTIVE-VARIABLE (OBJECT)

**FUNCTION** - PARSE-LINEAR-PROBLEM (OBJECTIVE-EXP CONSTRAINTS)  
Parses the expressions into a linear programming problem

**FUNCTION** - MAKE-LINEAR-PROBLEM (OBJECTIVE &REST CONSTRAINTS)  
Creates a linear problem from the expressions in the body

**MACRO** - MAKE-LINEAR-PROBLEM (OBJECTIVE &REST CONSTRAINTS)  
Creates a linear problem from the expressions in the body

**GENERIC** - CONSTRAINTS (OBJECT)

**GENERIC** - OBJECTIVE-FUNCTION (OBJECT)

**GENERIC** - SIGNED-VARS (OBJECT)

**GENERIC** - LP-TYPE (OBJECT)

**CLASS** - LINEAR-PROBLEM 

**GENERIC** - VARIABLES (OBJECT)

### **PACKAGE** - LINEAR-PROGRAMMING/EXPRESSIONS 

**FUNCTION** - SCALE-LINEAR-EXPRESSION (EXPR SCALAR)  
Multiplies the linear expression by the given scalar

**FUNCTION** - PARSE-LINEAR-EXPRESSION (EXPR)  
Parses the expression into a alist mapping variables to coefficients.
   Any constant values are mapped to +constant+

**FUNCTION** - SUM-LINEAR-EXPRESSIONS (EXPRS)  
Takes a list of linear expressions and reduces it into a single expression

