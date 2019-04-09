REPORT z_abptrain_acm_exer50.

**************************************************************************************
**************************************************************************************
*Report Name: Z_ABPTRAIN_ACM_EXER50
*Report Title: Calculator OOP and MVC
*User: Aaron Miller
*Date: 4/09/2019

*Illustrates MVC (Model, View, Controller) pattern with use of classes
*User types 2 numbers and chooses 1 of 4 operating options to calculate
*Result of calculation is then displayed

**Copy Ex49
**Change radiobuttons to checkboxes
*Create calculator class --create 4 operation classes inheriting from calculator class
**************************************************************************************
**************************************************************************************

*create class for "model" to hold business logic of program; acts like a template
CLASS lcl_calc_model DEFINITION.

* Public section will allow attributes to be accessed OUTSIDE of class
  PUBLIC SECTION.
*Declaration of methods with created data for "parent model class" behavior
    METHODS: m_calculate IMPORTING set_num1 TYPE i
                                   set_num2 TYPE i
                         CHANGING  set_ans  TYPE i.

ENDCLASS.

*classes must be implemented after declaration in order to write method logic and later call
CLASS lcl_calc_model IMPLEMENTATION.

*PARENT method to be passed to children
*when passed, excuted with methods of children when children called
  METHOD m_calculate.
    WRITE: |Solution:|.
  ENDMETHOD.

ENDCLASS.

**************************************************************************************
**************************************************************************************

*CHILD class from inheriting from PARENT class
CLASS lcl_addition DEFINITION INHERITING FROM lcl_calc_model.

* Public section will allow attributes to be accessed OUTSIDE of class
  PUBLIC SECTION.
*Declaration of methods with created data for "child model class" behavior
*Redefinition of method passed from parent to this child
    METHODS: m_calculate REDEFINITION,
             m_add       IMPORTING add_num1 TYPE i
                                   add_num2 TYPE i
                         CHANGING  add_ans  TYPE i.

ENDCLASS.

*classes must be implemented after declaration in order to write method logic and later call
CLASS lcl_addition IMPLEMENTATION.

*Method logic; calculation and write statement preformed when method of class called
  METHOD m_add.
    add_ans = add_num1 + add_num2.
    WRITE: |{ add_num1 } + { add_num2 } = { add_ans }|.
  ENDMETHOD.

*m_calculate uses PARENT class via super and adds CHILD class
  METHOD m_calculate.
    super->m_calculate( EXPORTING set_num1 = set_num1
                                  set_num2 = set_num2
                        CHANGING  set_ans = set_ans ).
    me->m_add(          EXPORTING add_num1 = set_num1
                                  add_num2 = set_num2
                        CHANGING  add_ans = set_ans ).
  ENDMETHOD.

ENDCLASS.

**************************************************************************************
**************************************************************************************

*CHILD class from inheriting from PARENT class
CLASS lcl_subtraction DEFINITION INHERITING FROM lcl_calc_model.

* Public section will allow attributes to be accessed OUTSIDE of class
  PUBLIC SECTION.
*Declaration of methods with created data for "child model class" behavior
*Redefinition of method passed from parent to this child
    METHODS: m_calculate REDEFINITION,
             m_subtract  IMPORTING sub_num1 TYPE i
                                   sub_num2 TYPE i
                         CHANGING  sub_ans  TYPE i.

ENDCLASS.

*classes must be implemented after declaration in order to write method logic and later call
CLASS lcl_subtraction IMPLEMENTATION.

*Method logic; calculation and write statement preformed when method of class called
  METHOD m_subtract.
    sub_ans = sub_num1 - sub_num2.
    WRITE: |{ sub_num1 } - { sub_num2 } = { sub_ans }|.
  ENDMETHOD.

*m_calculate uses PARENT class via super and adds CHILD class
  METHOD m_calculate.
    super->m_calculate( EXPORTING set_num1 = set_num1
                                  set_num2 = set_num2
                        CHANGING  set_ans = set_ans ).
    me->m_subtract(     EXPORTING sub_num1 = set_num1
                                  sub_num2 = set_num2
                        CHANGING  sub_ans = set_ans ).
  ENDMETHOD.

ENDCLASS.

**************************************************************************************
**************************************************************************************

*CHILD class from inheriting from PARENT class
CLASS lcl_multiplication DEFINITION INHERITING FROM lcl_calc_model.

* Public section will allow attributes to be accessed OUTSIDE of class
  PUBLIC SECTION.
*Declaration of methods with created data for "child model class" behavior
*Redefinition of method passed from parent to this child
    METHODS: m_calculate REDEFINITION,
             m_multiply  IMPORTING prod_num1 TYPE i
                                   prod_num2 TYPE i
                         CHANGING  prod_ans  TYPE i.
ENDCLASS.

*classes must be implemented after declaration in order to write method logic and later call
CLASS lcl_multiplication IMPLEMENTATION.

*Method logic; calculation and write statement preformed when method of class called
  METHOD m_multiply.
    prod_ans = prod_num1 + prod_num2.
    WRITE: |{ prod_num1 } * { prod_num2 } = { prod_ans }|.
  ENDMETHOD.

*m_calculate uses PARENT class via super and adds CHILD class
  METHOD m_calculate.
    super->m_calculate( EXPORTING set_num1 = set_num1
                                  set_num2 = set_num2
                        CHANGING  set_ans = set_ans ).
    me->m_multiply(     EXPORTING prod_num1 = set_num1
                                  prod_num2 = set_num2
                        CHANGING  prod_ans = set_ans ).
  ENDMETHOD.

ENDCLASS.

**************************************************************************************
**************************************************************************************
*CHILD class from inheriting from PARENT class
CLASS lcl_division DEFINITION INHERITING FROM lcl_calc_model.

* Public section will allow attributes to be accessed OUTSIDE of class
  PUBLIC SECTION.
*Declaration of methods with created data for "child model class" behavior
*Redefinition of method passed from parent to this child
    METHODS: m_calculate REDEFINITION,
             m_divide    IMPORTING quot_num1 TYPE i
                                   quot_num2 TYPE i
                         CHANGING  quot_ans  TYPE i.
ENDCLASS.

*classes must be implemented after declaration in order to write method logic and later call
CLASS lcl_division IMPLEMENTATION.

*Method logic; calculation and write statement preformed when method of class called
  METHOD m_divide.
    quot_ans = quot_num1 + quot_num2.
    WRITE: |{ quot_num1 } / { quot_num2 } = { quot_ans }|.
  ENDMETHOD.

*m_calculate uses PARENT class via super and adds CHILD class
  METHOD m_calculate.
    super->m_calculate( EXPORTING set_num1 = set_num1
                                  set_num2 = set_num2
                        CHANGING  set_ans = set_ans ).
    me->m_divide(       EXPORTING quot_num1 = set_num1
                                  quot_num2 = set_num2
                        CHANGING  quot_ans = set_ans ).
  ENDMETHOD.

ENDCLASS.

**************************************************************************************
**************************************************************************************

*controller class for addition operation
CLASS lcl_control_add DEFINITION.

* Public section will allow attributes to be accessed OUTSIDE of class
  PUBLIC SECTION.
*Declaration of Data created with reference to class
    DATA: set_addition TYPE REF TO lcl_addition.

*constructor assigns data for declared methods of class and is called upon object creation
*m_execute... will run method logic which will do actual calculation when called
    METHODS: constructor   IMPORTING set_add  TYPE REF TO lcl_addition,
             m_execute_add IMPORTING add_num1 TYPE i
                                     add_num2 TYPE i
                           CHANGING  set_ans  TYPE i.

ENDCLASS.

*classes must be implemented after declaration in order to write method logic and later call
CLASS lcl_control_add IMPLEMENTATION.

*Method Logic (behavior)
  METHOD constructor.
    me->set_addition = set_add.
  ENDMETHOD.

*Method Logic (behavior)
  METHOD m_execute_add.
    me->set_addition->m_calculate( EXPORTING set_num1 = add_num1
                                             set_num2 = add_num2
                                   CHANGING  set_ans = set_ans ).
  ENDMETHOD.

ENDCLASS.

**************************************************************************************
**************************************************************************************

*controller class for subtraction operation
CLASS lcl_control_subtract DEFINITION.

* Public section will allow attributes to be accessed OUTSIDE of class
  PUBLIC SECTION.
*Declaration of Data created with reference to class
    DATA: set_subtraction TYPE REF TO lcl_subtraction.

*constructor assigns data for declared methods of class and is called upon object creation
*m_execute... will run method logic which will do actual calculation when called
    METHODS: constructor        IMPORTING set_subtract TYPE REF TO lcl_subtraction,
             m_execute_subtract IMPORTING sub_num1     TYPE i
                                          sub_num2     TYPE i
                                CHANGING  set_ans      TYPE i.

ENDCLASS.

*classes must be implemented after declaration in order to write method logic and later call
CLASS lcl_control_subtract IMPLEMENTATION.

*Method Logic (behavior)
  METHOD constructor.
    me->set_subtraction = set_subtract.
  ENDMETHOD.

*Method Logic (behavior)
  METHOD m_execute_subtract.
    me->set_subtraction->m_calculate( EXPORTING set_num1 = sub_num1
                                                set_num2 = sub_num2
                                      CHANGING  set_ans = set_ans ).
  ENDMETHOD.

ENDCLASS.

**************************************************************************************
**************************************************************************************

*controller class for multiplication operation
CLASS lcl_control_multiply DEFINITION.

* Public section will allow attributes to be accessed OUTSIDE of class
  PUBLIC SECTION.
*Declaration of Data created with reference to class
    DATA: set_multiplication TYPE REF TO lcl_multiplication.

*constructor assigns data for declared methods of class and is called upon object creation
*m_execute... will run method logic which will do actual calculation when called
    METHODS: constructor        IMPORTING set_multiply TYPE REF TO lcl_multiplication,
             m_execute_multiply IMPORTING prod_num1    TYPE i
                                          prod_num2    TYPE i
                                CHANGING  set_ans      TYPE i.

ENDCLASS.

*classes must be implemented after declaration in order to write method logic and later call
CLASS lcl_control_multiply IMPLEMENTATION.

*Method Logic (behavior)
  METHOD constructor.
    me->set_multiplication = set_multiply.
  ENDMETHOD.

*Method Logic (behavior)
  METHOD m_execute_multiply.
    me->set_multiplication->m_calculate( EXPORTING set_num1 = prod_num1
                                                   set_num2 = prod_num2
                                         CHANGING  set_ans = set_ans ).
  ENDMETHOD.

ENDCLASS.

**************************************************************************************
**************************************************************************************

*controller class for division operation
CLASS lcl_control_divide DEFINITION.

* Public section will allow attributes to be accessed OUTSIDE of class
  PUBLIC SECTION.
*Declaration of Data created with reference to class
    DATA: set_division TYPE REF TO lcl_division.

*constructor assigns data for declared methods of class and is called upon object creation
*m_execute... will run method logic which will do actual calculation when called
    METHODS: constructor      IMPORTING set_divide TYPE REF TO lcl_division,
             m_execute_divide IMPORTING quot_num1  TYPE i
                                        quot_num2  TYPE i
                              CHANGING  set_ans    TYPE i.

ENDCLASS.

*classes must be implemented after declaration in order to write method logic and later call
CLASS lcl_control_divide IMPLEMENTATION.

*Method Logic (behavior)
  METHOD constructor.
    me->set_division = set_divide.
  ENDMETHOD.

*Method Logic (behavior)
  METHOD m_execute_divide.
    me->set_division->m_calculate( EXPORTING set_num1 = quot_num1
                                             set_num2 = quot_num2
                                   CHANGING  set_ans = set_ans ).
  ENDMETHOD.

ENDCLASS.

**************************************************************************************
**************************************************************************************

INITIALIZATION.
*Data declaration for flag and result of calcualtion
  DATA: lv_flag TYPE c,
        lv_ans  TYPE i.

*clear values of this data
  CLEAR: lv_flag,
         lv_ans.

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
  PARAMETERS: cb_sum  AS CHECKBOX,
              cb_diff AS CHECKBOX,
              cb_prod AS CHECKBOX,
              cb_quot AS CHECKBOX.

  SELECTION-SCREEN END OF BLOCK b2.

START-OF-SELECTION.
*Program execution logic
*user selection of addition operation
  IF cb_sum IS NOT INITIAL.
    lv_flag = '+'.
*object creation referencing PARENT calcualte class, CHILD addition class, and addition controller
    DATA(lo_addition) =    NEW lcl_addition( ).
    DATA(lo_control_add) = NEW lcl_control_add( set_add = lo_addition ).
*object logic tying values to created methods of classes
    lo_control_add->m_execute_add( EXPORTING add_num1 = p_num1
                                             add_num2 = p_num2
                                   CHANGING  set_ans = lv_ans ).
*user selection of subtraction operation
  ELSEIF cb_diff IS NOT INITIAL.
    lv_flag = '-'.
*object creation referencing PARENT calcualte class, CHILD subtraction class, and subtraction controller
    DATA(lo_subtraction) =      NEW lcl_subtraction( ).
    DATA(lo_control_subtract) = NEW lcl_control_subtract( set_subtract = lo_subtraction ).
*object logic tying values to created methods of classes
    lo_control_subtract->m_execute_subtract( EXPORTING sub_num1 = p_num1
                                                       sub_num2 = p_num2
                                             CHANGING  set_ans = lv_ans ).
*user selection of multiplication operation
  ELSEIF cb_prod IS NOT INITIAL.
    lv_flag = '*'.
*object creation referencing PARENT calcualte class, CHILD multiplication class, and multiplication controller
    DATA(lo_multiplication) =   NEW lcl_multiplication( ).
    DATA(lo_control_multiply) = NEW lcl_control_multiply( set_multiply = lo_multiplication ).
*object logic tying values to created methods of classes
    lo_control_multiply->m_execute_multiply( EXPORTING prod_num1 = p_num1
                                                       prod_num2 = p_num2
                                             CHANGING  set_ans = lv_ans ).
*user selection of division operation
  ELSEIF cb_quot IS NOT INITIAL.
    lv_flag = '/'.
*object creation referencing PARENT calcualte class, CHILD division class, and division controller
    DATA(lo_division) =       NEW lcl_division( ).
    DATA(lo_control_divide) = NEW lcl_control_divide( set_divide = lo_division ).
*object logic tying values to created methods of classes
    lo_control_divide->m_execute_divide( EXPORTING quot_num1 = p_num1
                                                   quot_num2 = p_num2
                                         CHANGING  set_ans = lv_ans ).
  ELSE.
    WRITE: 'Please select a button'.
  ENDIF.
