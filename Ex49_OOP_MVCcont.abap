REPORT Z_ABPTRAIN_ACM_EXER49 MESSAGE-ID ZEX49MSGID.
**************************************************************************************
*Report Name: Z_ABPTRAIN_ACM_EXER49
*Report Title: Calculator OOP and MVC
*User: Aaron Miller
*Date: 4/02/2019

*Illustrates MVC (Model, View, Controller) pattern with use of classes
*User types 2 numbers and chooses 1 of 4 operating options to calculate
*Result of calculation is then displayed

*DID NOT DO--Have a pop-up checkbox in selection-screen--WHAT DOES THIS EVEN MEAN?????
*Extend VIEW class to show result using information message
*Add constructor method to MODEL class; if numbers not betweeen 1-100, then make both values 1.
**************************************************************************************

*Data declaration for flag
DATA: gv_flag TYPE c.

*SELECTION SCREEN for user interface will serve as VIEW for MVC.
SELECTION-SCREEN
  BEGIN OF BLOCK b1
    WITH FRAME TITLE text-001.
*Parameters used for user input to select numbers for program
PARAMETERS: p_num1 TYPE i,
            p_num2 TYPE i.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN
  BEGIN OF BLOCK b2
    WITH FRAME TITLE text-002.
*Parameters for rb selection which will allow user to choose which operation
PARAMETERS: rb_sum  RADIOBUTTON GROUP rbg1,
            rb_diff RADIOBUTTON GROUP rbg1,
            rb_prod RADIOBUTTON GROUP rbg1,
            rb_quot RADIOBUTTON GROUP rbg1.
SELECTION-SCREEN END OF BLOCK b2.

AT SELECTION-SCREEN.
*Validation of operation selection by user
  IF rb_sum      IS NOT INITIAL.
    gv_flag = '+'.
  ELSEIF rb_diff IS NOT INITIAL.
    gv_flag = '-'.
  ELSEIF rb_prod IS NOT INITIAL.
    gv_flag = '*'.
  ELSE.
    gv_flag = '/'.
  ENDIF.

**************************************************************************************
*create class for "model" to hold business logic of program; acts like a template
CLASS lcl_calc_model DEFINITION.

* Public section will allow attributes to be accessed OUTSIDE of class
  PUBLIC SECTION.
*Declaration of data for "model" class based off of "view" data and parameters
    DATA: set_num1 TYPE i,
          set_num2 TYPE i,
          set_flag TYPE c.
*Declaration of data for data "model" behavior
    METHODS: constructor   IMPORTING get_num1 TYPE i
                                     get_num2 TYPE i,
             get_operation IMPORTING get_flag TYPE c.

ENDCLASS.

*implement "model" class (after defining it)
CLASS lcl_calc_model IMPLEMENTATION.

*"me->" = "This()" METHOD for redefining value of data from model
*and equating it to user input parameters
  METHOD constructor.
    me->set_num1 = get_num1.
    me->set_num2 = get_num2.

*logic to validate if user input is between 1-100; if false, number set = 1.
     IF ( p_num1 IS NOT INITIAL AND p_num1 > 100 OR p_num1 < 0 ).
       me->set_num1 = 1.
     ENDIF.

     IF ( p_num2 IS NOT INITIAL AND p_num2 > 100 OR p_num2 < 0 ).
       me->set_num2 = 1.
     ENDIF.
  ENDMETHOD.

*METHOD for redifining flag value from model class
*and equating it to radio button parameter
  METHOD get_operation.
    me->set_flag = get_flag.
  ENDMETHOD.

ENDCLASS.
**************************************************************************************

**************************************************************************************
*Controller class to serve as link between VIEW and MODEL class
*This will use template from model class to complete user specified calculation
CLASS lcl_calc_controller DEFINITION.

* Public section will allow attributes to be accessed OUTSIDE of class
  PUBLIC SECTION.

* Declaration of data types for controller class
    DATA: set_sum        TYPE i,
          set_diff       TYPE i,
          set_prod       TYPE i,
          set_quot       TYPE i,
          set_operator   TYPE c,
          get_calc_model TYPE REF TO lcl_calc_model.

* Declaration of methods for controller class
    METHODS: constructor IMPORTING set_model TYPE REF TO lcl_calc_model,
      get_sum,
      get_diff,
      get_prod,
      get_quot.
ENDCLASS.

*implement "controller" class after defining it
CLASS lcl_calc_controller IMPLEMENTATION.

*constructor will give access to local "model" class
  METHOD constructor.
    me->get_calc_model = set_model.
  ENDMETHOD.

*method to ADD two integers from "model" class
  METHOD get_sum.
    set_sum = me->get_calc_model->set_num1 + me->get_calc_model->set_num2.
    set_operator = me->get_calc_model->set_flag.
  ENDMETHOD.

*method to SUBTRACT two integers from "model" class
  METHOD get_diff.
    set_diff = me->get_calc_model->set_num1 - me->get_calc_model->set_num2.
    set_operator = me->get_calc_model->set_flag.
  ENDMETHOD.

*method to MULTIPLY two integers from model class
  METHOD get_prod.
    set_prod = me->get_calc_model->set_num1 * me->get_calc_model->set_num2.
    set_operator = me->get_calc_model->set_flag.
  ENDMETHOD.

*method to DIVIDE two integers from model class
  METHOD get_quot.
    set_quot = me->get_calc_model->set_num1 / me->get_calc_model->set_num2.
    set_operator = me->get_calc_model->set_flag.
  ENDMETHOD.

ENDCLASS.
**************************************************************************************

**************************************************************************************
*Creation of "View" class to show result of program's calculation to user
CLASS lcl_calc_view DEFINITION.

* Public section will allow attributes to be accessed OUTSIDE of class
  PUBLIC SECTION.

*Data type declaration for "view" class referencing data type from "controller" class
    DATA: get_controller TYPE REF TO lcl_calc_controller.

*Declaration of "View" class methods;
*one is new and other is referencing method from "controller" class
    METHODS: display_result,
      constructor IMPORTING set_controller TYPE REF TO lcl_calc_controller.

ENDCLASS.

*implement "view" class after defining it
CLASS lcl_calc_view IMPLEMENTATION.

*constructor method for class utilizing data from "controller" class
  METHOD constructor.
    me->get_controller = set_controller.
  ENDMETHOD.

*this method ties the class data & methods
*from "model" class to data & methods of "controller" class
*then, based on the user calculation choice (rb),
*computer will output proper message
  METHOD display_result.
    IF me->get_controller->set_operator = '+'.
      MESSAGE i001 WITH me->get_controller->set_sum.

    ELSEIF me->get_controller->set_operator = '-'.
      MESSAGE i002 WITH me->get_controller->set_diff.

    ELSEIF me->get_controller->set_operator = '*'.
      MESSAGE i003 WITH me->get_controller->set_prod.

    ELSE.
      MESSAGE i004 WITH me->get_controller->set_quot.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
**************************************************************************************

*Declare data types for CREATE OBJECT
*which ties "Model" class, "View" class, & "Controller" class together
*takes user input and then manipulates input based on MVC classes above.
DATA: lo_calc_model      TYPE REF TO lcl_calc_model,
      lo_calc_controller TYPE REF TO lcl_calc_controller,
      lo_calc_view       TYPE REF TO lcl_calc_view.

START-OF-SELECTION.
  CREATE OBJECT: lo_calc_model      EXPORTING get_num1 = p_num1
                                              get_num2 = p_num2,
                 lo_calc_controller EXPORTING set_model = lo_calc_model,
                 lo_calc_view       EXPORTING set_controller = lo_calc_controller.

  lo_calc_model->get_operation( EXPORTING get_flag = gv_flag ).

*Logic that calls and runs the 3 MVC classes
  IF gv_flag = '+'.
    lo_calc_controller->get_sum( ).
    lo_calc_view->display_result( ).

  ELSEIF gv_flag = '-'.
    lo_calc_controller->get_diff( ).
    lo_calc_view->display_result( ).

  ELSEIF gv_flag = '*'.
    lo_calc_controller->get_prod( ).
    lo_calc_view->display_result( ).

  ELSE.
    lo_calc_controller->get_quot( ).
    lo_calc_view->display_result( ).
  ENDIF.
