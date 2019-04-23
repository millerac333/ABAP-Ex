REPORT Z_ABPTRAIN_ACM_EXER54.

**************************************************************************************
**************************************************************************************
*Report Name: Z_ABPTRAIN_ACM_EXER54
*Report Title: OOP - Factory Design Pattern
*User: Aaron Miller
*Date: 4/15/2019

*OVERVIEW: Create a new calcuator program using Factory design pattern that will have an:
*---Input for 2 integers, 5 checkboxes (Addition to Modulo and 2 radio buttons

*---Have 1 factory class where the Constructor:
*______Check if at least 1 checkbox is ticked
*______If not, raise exception, have message at selection screen
*______If DIV or MOD is checked, add exception if dividend is zero
*______Have an error message at selection screeen it is satisfies

*---Returning Value:
*______Internal Table with a list of objects (Addition to modulo operation)
*______Objects must inherit from calculator class

*---Loop at internal table and execute each operation

*---Store each result in an internal table (CLASS-DATA)

*---Output: Create View Class
*______Output using WRITE
*______Output using FM ALV
**************************************************************************************
**************************************************************************************

INITIALIZATION.
*creation of box for user input of two numbers
  SELECTION-SCREEN
    BEGIN OF BLOCK b1
      WITH FRAME TITLE text-001.

*Parameters used for user input to select numbers for program
  PARAMETERS: p_num1 TYPE i,
              p_num2 TYPE i.

  SELECTION-SCREEN END OF BLOCK b1.

*creation of box for operation selection choice
  SELECTION-SCREEN
    BEGIN OF BLOCK b2
      WITH FRAME TITLE text-002.
*Parameters for cb selection which will allow user to choose which operation
  PARAMETERS: cb_sum  AS CHECKBOX USER-COMMAND check1,
              cb_diff AS CHECKBOX USER-COMMAND check2,
              cb_prod AS CHECKBOX USER-COMMAND check3,
              cb_quot AS CHECKBOX USER-COMMAND check4,
              cb_mod  AS CHECKBOX USER-COMMAND check5.

  SELECTION-SCREEN END OF BLOCK b2.

  SELECTION-SCREEN
    BEGIN OF BLOCK b3
      WITH FRAME TITLE text-003.

  PARAMETERS: rb_write RADIOBUTTON GROUP rb1,
              rb_ALV RADIOBUTTON GROUP rb1.

  SELECTION-SCREEN END OF BLOCK b3.

**************************************************************************************
*ABSTRACT CLASS: calculator_factory DEFINITION
************************************************************************************** 
 
CLASS calculator_factory DEFINITION ABSTRACT.
  PUBLIC SECTION.
    CLASS-METHODS: get_operation 
                    IMPORTING lv_operation        TYPE string
                    RETURNING VALUE(ro_operation) TYPE REF TO calculator_factory.
    METHODS: calculate ABSTRACT.
ENDCLASS.

**************************************************************************************
*CLASS: addition DEFINITION AND IMPLEMENTATION 
**************************************************************************************

CLASS addition DEFINITION INHERITING FROM calculator_factory.
  PUBLIC SECTION.
    METHODS: calculate REDEFINITION.
ENDCLASS.

CLASS addition IMPLEMENTATION.
  METHOD calculate.
    ans = p_num1 + p_num2.
  ENDMETHOD.
ENDCLASS. 

**************************************************************************************
*CLASS: subtraction DEFINITION AND IMPLEMENTATION 
**************************************************************************************

CLASS subtraction DEFINITION INHERITING FROM calculator_factory.
  PUBLIC SECTION.
    METHODS: calculate REDEFINITION.
ENDCLASS.

CLASS subtraction IMPLEMENTATION.
  METHOD calculate.
    ans = p_num1 - p_num2.
  ENDMETHOD.
ENDCLASS. 

**************************************************************************************
*CLASS: multiplication DEFINITION AND IMPLEMENTATION 
**************************************************************************************

CLASS multiplication DEFINITION INHERITING FROM calculator_factory.
  PUBLIC SECTION.
    METHODS: calculate REDEFINITION.
ENDCLASS.

CLASS multiplication IMPLEMENTATION.
  METHOD calculate.
    ans = p_num1 * p_num2.
  ENDMETHOD.
ENDCLASS. 

**************************************************************************************
*CLASS: division DEFINITION AND IMPLEMENTATION 
**************************************************************************************

CLASS division DEFINITION INHERITING FROM calculator_factory.
  PUBLIC SECTION.
    METHODS: calculate REDEFINITION.
ENDCLASS.

CLASS division IMPLEMENTATION.
  METHOD calculate.
    ans = p_num1 / p_num2.
  ENDMETHOD.
ENDCLASS. 

**************************************************************************************
*CLASS: modulus DEFINITION AND IMPLEMENTATION 
**************************************************************************************

CLASS modulus DEFINITION INHERITING FROM calculator_factory.
  PUBLIC SECTION.
    METHODS: calculate REDEFINITION.
ENDCLASS.

CLASS modulus IMPLEMENTATION.
  METHOD calculate.
    ans = p_num1 MOD p_num2.
  ENDMETHOD.
ENDCLASS. 

**************************************************************************************
*ABSTRACT CLASS: calculator_factory IMPLEMENTATION
**************************************************************************************

CLASS calculator_factory IMPLEMENTATION.
  METHOD get_operation.
    CASE lv_operation.
    	WHEN '+'.
    	WHEN '-'.
    	WHEN '*'.
    	WHEN '/'.
    	WHEN '%'.
    	WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.

**************************************************************************************
*CLASS lcl_execute_program DEFINITION AND IMPLEMENTATION
**************************************************************************************

CLASS lcl_execute_program DEFINITION.
  PUBLIC SECTION. 
    CLASS-METHODS: execute.
ENDCLASS.

CLASS lcl_excecute_program IMPLEMENTATION.
  METHOD execute.
    DATA: lo_ouput TYPE REF TO calculator_prgoram.
      lo_output = calculator_factory=>get_operation( '+' ).
      lo_output->calculate( ).
  ENDMETHOD.
ENDCLASS.

**************************************************************************************
**************************************************************************************

START-OF-SELECTION.
  lcl_execute_program=>execute( ).