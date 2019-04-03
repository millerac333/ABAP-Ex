REPORT Z_ABPTRAIN_ACM_EXER50 MESSAGE-ID ZEX49MSGID.
**************************************************************************************
*Report Name: Z_ABPTRAIN_ACM_EXER50
*Report Title: Calculator OOP and MVC
*User: Aaron Miller
*Date: 4/02/2019

*Illustrates MVC (Model, View, Controller) pattern with use of classes
*User types 2 numbers and chooses 1 of 4 operating options to calculate
*Result of calculation is then displayed

*Copy Ex49
*Change radiobuttons to checkboxes
*Create calculator class --create 4 operation classes inheriting from calculator class

* NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED
* NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED
* NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED
* NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED
* NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED
* NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED
* NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED
* NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED NOT FINISHED
**************************************************************************************
*Data declaration for flag
DATA: gv_flag TYPE c.

*SELECTION SCREEN for user interface will serve as VIEW for MVC.
SELECTION-SCREEN
  BEGIN OF BLOCK b1
    WITH FRAME TITLE text-001.
*Parameters used for user input to select numbers for program
PARAMETERS: p_int1 TYPE i,
            p_int2 TYPE i.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN
  BEGIN OF BLOCK b2
    WITH FRAME TITLE text-002.
*Parameters for rb selection which will allow user to choose which operation
PARAMETERS: rb_sum  AS CHECKBOX,
            rb_diff AS CHECKBOX,
            rb_prod AS CHECKBOX,
            rb_quot AS CHECKBOX.
SELECTION-SCREEN END OF BLOCK b2.

AT SELECTION-SCREEN.
*Validation of operation selection by user
  IF rb_sum IS NOT INITIAL.
    gv_flag = '+'.
  ELSEIF rb_diff IS NOT INITIAL.
    gv_flag = '-'.
  ELSEIF rb_prod IS NOT INITIAL.
    gv_flag = '*'.
  ELSE.
    gv_flag = '/'.
  ENDIF.

*This IF validates that 2nd number is NOT zero and triggers error msg if it is
  IF p_int2 = 0 AND gv_flag = '/'.
    MESSAGE: e000(zex43msgid).
  ENDIF.

CLASS lcl_calculator DEFINITION.
  PUBLIC SECTION.
    DATA: set_flag TYPE c,
          set_int1 TYPE i,
          set_int2 TYPE i,
          set_ans  TYPE i.
    METHODS: m_calculate     IMPORTING get_int1 TYPE i
                                     get_int2 TYPE i
                           CHANGING  get_ans  TYPE i,
             m_get_operation IMPORTING get_flag TYPE c,
             m_display_result.

ENDCLASS.

CLASS lcl_addition DEFINITION INHERITING FROM lcl_calculator.
  PUBLIC SECTION.
    METHODS: m_calculate     REDEFINITION,
             m_get_operation REDEFINITION,
             m_display_result REDEFINITION,
             m_addition      IMPORTING add_int1 TYPE i
                                     add_int2 TYPE i
                           CHANGING  add_ans  TYPE i.
ENDCLASS.

  CLASS lcl_subtraction DEFINITION INHERITING FROM lcl_calculator.
  PUBLIC SECTION.
    METHODS: m_calculate     REDEFINITION,
             m_get_operation REDEFINITION,
             m_display_result REDEFINITION,
             m_subtraction   IMPORTING sub_int1 TYPE i
                                     sub_int2 TYPE i
                           CHANGING  sub_ans  TYPE i.
ENDCLASS.

CLASS lcl_multiplication DEFINITION INHERITING FROM lcl_calculator.
  PUBLIC SECTION.
    METHODS: m_calculate      REDEFINITION,
             m_get_operation  REDEFINITION,
             m_display_result REDEFINITION,
             m_multiplication IMPORTING prod_int1 TYPE i
                                      prod_int2 TYPE i
                            CHANGING  prod_ans  TYPE i.
ENDCLASS.

CLASS lcl_division DEFINITION INHERITING FROM lcl_calculator.
  PUBLIC SECTION.
    METHODS: m_calculate     REDEFINITION,
             m_get_operation REDEFINITION,
             m_display_result REDEFINITION,
             m_division      IMPORTING quot_int1 TYPE i
                                     quot_int2 TYPE i
                           CHANGING  quot_ans  TYPE i.
ENDCLASS.

CLASS lcl_calculator IMPLEMENTATION.
    METHOD m_calculate.
      me->set_ans = 0.
      me->set_int1 = get_int1.
      me->set_int2 = get_int2.

*      WRITE: |Super class variables: { set_int1 } { set_int2 } { set_ans }|.
    ENDMETHOD.

    METHOD m_get_operation.
      me->set_flag = get_flag.
    ENDMETHOD.

    METHOD m_display_result.
    IF set_flag = '+'.
      WRITE: me->m_addition->set_ans.

    ELSEIF set_flag = '-'.
      WRITE: me->m_subtraction->set_ans.

    ELSEIF set_flag = '*'.
      WRITE: me->m_multiplication->set_ans.

    ELSE.
      WRITE: me->m_division->set_ans.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_addition IMPLEMENTATION.
    METHOD m_addition.
      add_ans = add_int1 + add_int2.
    ENDMETHOD.

    METHOD m_calculate.
      super->m_calculate( EXPORTING get_int1 = set_int1
                                  get_int2 = set_int2
                        CHANGING  get_ans = set_ans ).
      super->get_operation( EXPORTING get_flag = set_flag ).
      me->m_addition( EXPORTING add_int1 = get_int1
                              add_int2 = get_int2
                    CHANGING  add_ans = get_ans ).
    ENDMETHOD.
ENDCLASS.

CLASS lcl_subtraction IMPLEMENTATION.
    METHOD m_subtraction.
      sub_ans = sub_int1 - sub_int2.
    ENDMETHOD.

    METHOD m_calculate.
      super->m_calculate( EXPORTING get_int1 = set_int1
                                  get_int2 = set_int2
                        CHANGING  get_ans = set_ans ).
      super->get_operation( EXPORTING get_flag = set_flag ).
      me->m_subtraction( EXPORTING sub_int1 = get_int1
                                 sub_int2 = get_int2
                       CHANGING  sub_ans = get_ans ).
    ENDMETHOD.
ENDCLASS.

CLASS lcl_multiplication IMPLEMENTATION.
    METHOD m_multiplication.
      prod_ans = prod_int1 * prod_int2.
    ENDMETHOD.

    METHOD m_calculate.
      super->m_calculate( EXPORTING get_int1 = set_int1
                                  get_int2 = set_int2
                        CHANGING  get_ans = set_ans ).
      super->get_operation( EXPORTING get_flag = set_flag ).
      me->m_multiplication( EXPORTING prod_int1 = get_int1
                                    prod_int2 = get_int2
                          CHANGING  prod_ans = get_ans ).
    ENDMETHOD.
ENDCLASS.

CLASS lcl_division IMPLEMENTATION.

    METHOD m_division.
      quot_ans = quot_int1 / quot_int2.
    ENDMETHOD.

    METHOD m_calculate.
      super->m_calculate( EXPORTING get_int1 = set_int1
                                  get_int2 = set_int2
                        CHANGING  get_ans = set_ans ).
      super->get_operation( EXPORTING get_flag = set_flag ).
      me->m_division( EXPORTING quot_int1 = get_int1
                              quot_int2 = get_int2
                    CHANGING  quot_ans = get_ans ).
    ENDMETHOD.
ENDCLASS.




START-OF-SELECTION.
*Declare data types for CREATE OBJECT
*which ties "Model" class, "View" class, & "Controller" class together
*takes user input and then manipulates input based on MVC classes above.
DATA: o_calculate      TYPE REF TO lcl_calculate,
      o_addition       TYPE REF TO lcl_addition,
      o_subtraction    TYPE REF TO lcl_subtraction,
      o_multiplication TYPE REF TO lcl_multiplication,
      o_division       TYPE REF TO lcl_division.

  CREATE OBJECT: o_calculate,
                 o_addition,
                 o_subtraction,
                 o_multiplication,
                 o_division.

*Logic that calls and runs the 3 MVC classes
  IF gv_flag = '+'.
    o_addition->m_addition( ).
*    lo_calc_view->display_result( ).

  ELSEIF gv_flag = '-'.
    o_subtraction->m_subtraction( ).
*    lo_calc_view->display_result( ).

  ELSEIF gv_flag = '*'.
    o_multiplication->m_multiplication( ).
*    lo_calc_view->display_result( ).

  ELSE.
    o_division->m_division( ).
*    lo_calc_view->display_result( ).
  ENDIF.
