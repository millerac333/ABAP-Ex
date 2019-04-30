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

**************************************************************************************
*START: CALCULATOR MODEL VIEW
**************************************************************************************

*Define class inherited from system that will later check options are selected
CLASS lcx_no_option_selected DEFINITION
   INHERITING FROM cx_static_check.
ENDCLASS.

*Define class inherited from system that will later check if user input #s are in range
CLASS lcx_out_of_range DEFINITION
  INHERITING FROM cx_static_check.
ENDCLASS.

*Define class inherited from system that will later check if user tries to divide by zero
*or find modulo of zero
CLASS lcx_divide_by_zero DEFINITION
  INHERITING FROM cx_static_check.
ENDCLASS.

**************************************************************************************
*CLASS: super_calculator DEFINITION AND IMPLEMENTATION
**************************************************************************************

*Define super ABSTRACT class with constructor
CLASS lcl_cal_super DEFINITION ABSTRACT.
  PUBLIC SECTION.
*constructor method called upon object creation (confusing bc abstract classes cannot create obj)
    METHODS: constructor IMPORTING im_int1 TYPE i "importing data type
                                   im_int2 TYPE i " "..."
                         RAISING cx_sy_arithmetic_error, "declaring system error
                                 result "declaring result method
                         RETURNING VALUE(rt_result) TYPE i. "returning object

*Declaring Data and methods in protected section (called only in class and subclasses)
  PROTECTED SECTION.
    DATA: lv_int1   TYPE i,
          lv_int2   TYPE i,
          lv_result TYPE i.
    METHODS:
          calculate ABSTRACT.
ENDCLASS.

*Define behavior of methods in super abstract class
CLASS lcl_cal_super IMPLEMENTATION.
  METHOD constructor.
    lv_int1 = im_int1.
    lv_int2 = im_int2.
  ENDMETHOD.

  METHOD result.
    me->calculate( ). "result ties to abstract method m_calculate
    rt_result = me->lv_result. "returning value obj tied to protected super abstract class data
  ENDMETHOD.
ENDCLASS.

**************************************************************************************
**************************************************************************************

  " Internal Table type referencing LCL_CAL
TYPES: BEGIN OF gy_cal,
         operation TYPE REF TO lcl_cal_super,
       END OF gy_cal.
*Declare internal table
TYPES: gy_cal_tab TYPE STANDARD TABLE OF gy_cal.

**************************************************************************************
*CLASS: add DEFINITION AND IMPLEMENTATION
**************************************************************************************

* Addition Operation Inheriting from LCL_CAL_SUPER
CLASS lcl_add DEFINITION
 INHERITING FROM lcl_cal_super.

  PROTECTED SECTION.
    METHODS: calculate REDEFINITION. "passing calcuate method to child from super class

ENDCLASS.

*define class method behavior
CLASS lcl_add IMPLEMENTATION.
*arithmatic logic for add operation
  METHOD calculate.
    lv_result = lv_int1 + lv_int2.
  ENDMETHOD.

ENDCLASS.

**************************************************************************************
*CLASS: subtract DEFINITION AND IMPLEMENTATION
**************************************************************************************

*"Subtraction Operation Inheriting from LCL_CAL_SUPER
CLASS lcl_subtract DEFINITION
 INHERITING FROM lcl_cal_super.

  PROTECTED SECTION.
    METHODS: calculate REDEFINITION. "passing calcuate method to child from super class

ENDCLASS.

*define class method behavior
CLASS lcl_subtract IMPLEMENTATION.
*arithmatic logic for subtraction operation
  METHOD calculate.
    lv_result = lv_int1 - lv_int2.
  ENDMETHOD.

ENDCLASS.

**************************************************************************************
*CLASS: multiply DEFINITION AND IMPLEMENTATION
**************************************************************************************

* Multiplication Operation Inheriting from LCL_CAL_SUPER
CLASS lcl_multiply DEFINITION
 INHERITING FROM lcl_cal_super.

  PROTECTED SECTION.
    METHODS: calculate REDEFINITION. "passing calcuate method to child from super class

ENDCLASS.

*define class method behavior
CLASS lcl_multiply IMPLEMENTATION.
*arithmatic logic for multiply operation
  METHOD calculate.
    lv_result = lv_int1 * lv_int2.
  ENDMETHOD.

ENDCLASS.

**************************************************************************************
*CLASS: divide DEFINITION AND IMPLEMENTATION
**************************************************************************************

* Division Operation Inheriting from LCL_CAL_SUPER
CLASS lcl_divide DEFINITION
 INHERITING FROM lcl_cal_super.

  PROTECTED SECTION.
    METHODS: calculate REDEFINITION. "passing calcuate method to child from super class
ENDCLASS.

*define class method behavior
CLASS lcl_divide IMPLEMENTATION.
*arithmatic logic for divide operation
  METHOD calculate.
    lv_result = lv_int1 / lv_int2.
  ENDMETHOD.

ENDCLASS.

**************************************************************************************
*CLASS: modulo DEFINITION AND IMPLEMENTATION
**************************************************************************************

*" Modulation Operation Inheriting from LCL_CAL_SUPER
CLASS lcl_modulo DEFINITION
 INHERITING FROM lcl_cal_super.

  PROTECTED SECTION.
    METHODS: calculate REDEFINITION. "passing calcuate method to child from super class

ENDCLASS.
*define class method behavior
CLASS lcl_modulo IMPLEMENTATION.
*arithmatic logic for modulo operation
  METHOD calculate.
    lv_result = lv_int1 MOD lv_int2.
  ENDMETHOD.

ENDCLASS.

**************************************************************************************
*START: calculator model class
**************************************************************************************

* Define Model Class returning Classes; class will handle input from user
CLASS lcl_cal_model DEFINITION.

  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          im_int1     TYPE i
          im_int2     TYPE i
          im_add      TYPE c
          im_subtract TYPE c
          im_multiple TYPE c
          im_divide   TYPE c
          im_mod      TYPE c
*Declare error classes
        RAISING   lcx_no_option_selected
                  lcx_out_of_range
                  lcx_divide_by_zero.
*Static methods
    CLASS-METHODS
      performcalculation
        EXPORTING rt_cal  TYPE gy_cal_tab
*predefined system exception specific to class
        RAISING   cx_sy_arithmetic_error.

  PRIVATE SECTION.
    CLASS-DATA:
      lv_int1     TYPE i,
      lv_int2     TYPE i,
      lv_add      TYPE c,
      lv_subtract TYPE c,
      lv_multiple TYPE c,
      lv_divide   TYPE c,
      lv_mod      TYPE c.
ENDCLASS.


CLASS lcl_cal_model IMPLEMENTATION.

  METHOD constructor.
*Absolute value of user input is greather than 100, THEN ->
    IF abs( im_int1 ) > 100
    OR abs( im_int2 ) > 100.
*-> system exception is raised
      RAISE EXCEPTION TYPE lcx_out_of_range.
*logic for checking operations are marked, then->
    ELSEIF im_add = abap_false
    AND im_subtract = abap_false
    AND im_multiple = abap_false
    AND im_divide = abap_false
    AND im_mod = abap_false.
*->if not rasise system exception
      RAISE EXCEPTION TYPE lcx_no_option_selected.
*logic for checking if 2 number of user input is 0 when divide or modulus operation selected ->
    ELSEIF ( im_divide = abap_true OR im_mod = abap_true )
    AND im_int2 = 0.
*->then call/raise system exception
      RAISE EXCEPTION TYPE lcx_divide_by_zero.
    ENDIF.

*assign value constructor data to priviate class data
    lv_int1 = im_int1.
    lv_int2 = im_int2.
    lv_add = im_add.
    lv_subtract = im_subtract.
    lv_multiple = im_multiple.
    lv_divide = im_divide.
    lv_mod = im_mod.
  ENDMETHOD.

  METHOD performcalculation.
*Numerous IFS and ENDIFS allow for user to multiselect
    IF lv_add IS NOT INITIAL.
      DATA lo_cal TYPE REF TO lcl_cal_super. "make object type

*  " Add Addition Class
      lo_cal = NEW lcl_add( im_int1 = lv_int1
                            im_int2 = lv_int2 ).

*add created object to nested standard tables gy_cal_tab -> gy_cal -> lcl_cal_super
      APPEND INITIAL LINE TO rt_cal ASSIGNING FIELD-SYMBOL(<fs>).

      <fs>-operation = lo_cal.

      UNASSIGN <fs>.
*clear object which is reused in program
      CLEAR: lo_cal.
    ENDIF.

    IF lv_subtract IS NOT INITIAL.
*  " Add Subtraction Class
      lo_cal = NEW lcl_subtract( im_int1 = lv_int1
                                 im_int2 = lv_int2 ).

*add created object to nested standard tables gy_cal_tab -> gy_cal -> lcl_cal_super
      APPEND INITIAL LINE TO rt_cal ASSIGNING <fs>.

      <fs>-operation = lo_cal.

      UNASSIGN <fs>.
*clear object which is reused in program
      CLEAR: lo_cal.
    ENDIF.

    IF lv_multiple IS NOT INITIAL.
*  " Add Subtraction Class
      lo_cal = NEW lcl_multiply( im_int1 = lv_int1
                                 im_int2 = lv_int2 ).

*add created object to nested standard tables gy_cal_tab -> gy_cal -> lcl_cal_super
      APPEND INITIAL LINE TO rt_cal ASSIGNING <fs>.

      <fs>-operation = lo_cal.

      UNASSIGN <fs>.
*clear object which is reused in program
      CLEAR: lo_cal.
    ENDIF.

    IF lv_divide IS NOT INITIAL.
*  " Add Subtraction Class
      lo_cal = NEW lcl_divide( im_int1 = lv_int1
                               im_int2 = lv_int2 ).

*add created object to nested standard tables gy_cal_tab -> gy_cal -> lcl_cal_super
      APPEND INITIAL LINE TO rt_cal ASSIGNING <fs>.

      <fs>-operation = lo_cal.

      UNASSIGN <fs>.
*clear object which is reused in program
      CLEAR: lo_cal.
    ENDIF.

    IF lv_mod IS NOT INITIAL.
*  " Add Subtraction Class
      lo_cal = NEW lcl_modulo( im_int1 = lv_int1
                               im_int2 = lv_int2 ).

*add created object to nested standard tables gy_cal_tab -> gy_cal -> lcl_cal_super
      APPEND INITIAL LINE TO rt_cal ASSIGNING <fs>.

      <fs>-operation = lo_cal.

      UNASSIGN <fs>.
*clear object which is reused in program
      CLEAR: lo_cal.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

**************************************************************************************
*START: calculator VIEW class
**************************************************************************************

*class for WRITE view OR ALV view
CLASS lcl_cal_view DEFINITION.

  PUBLIC SECTION.
    METHODS:
      constructor
      "import/pass in two boolean based on user input
        IMPORTING
          im_write    TYPE abap_bool
          im_alv      TYPE abap_bool.
    CLASS-METHODS
      displayresult
      "import/pass in nested standard tables gy_cal_tab -> gy_cal -> lcl_cal_super
        IMPORTING im_cal  TYPE gy_cal_tab.

  PRIVATE SECTION.
    CLASS-DATA:
      lv_write    TYPE abap_bool, "local bool
      lv_alv      TYPE abap_bool. "local bool
ENDCLASS.

CLASS lcl_cal_view IMPLEMENTATION.

  METHOD constructor.
    lv_write = im_write.
    lv_alv = im_alv.
  ENDMETHOD.

  METHOD displayresult.
*    " Internal Table type referencing LCL_CAL
    TYPES: BEGIN OF ty_cal,
             result TYPE i,
           END OF ty_cal.

    TYPES: ty_cal_tab TYPE STANDARD TABLE OF ty_cal.
    DATA: ly_cal TYPE ty_cal_tab.

*loop at imported value and append to local table
    LOOP AT im_cal
      "*Field Symbol points to type im_cal in super (parent) class
      ASSIGNING FIELD-SYMBOL(<fs_cal>).
*append to table
      APPEND INITIAL LINE TO ly_cal ASSIGNING FIELD-SYMBOL(<fs_cal_tab>).
*work area result equals parent FS result method; ly_cal holds result
      <fs_cal_tab>-result = <fs_cal>-operation->result( ).
    ENDLOOP.

    IF lv_write = ABAP_TRUE.
      "loop and WRITE results
        LOOP AT ly_cal ASSIGNING FIELD-SYMBOL(<fs>).
            WRITE: / <fs>-result.
        ENDLOOP.
*make field catalog for ALV display
    ELSEIF lv_alv = ABAP_TRUE.
        DATA: li_fieldcat TYPE slis_t_fieldcat_alv.
        "define column name/field descritption
        li_fieldcat = VALUE #( ( fieldname = 'Result' ) ).

        call function 'REUSE_ALV_GRID_DISPLAY'
          EXPORTING

            it_fieldcat                 =  li_fieldcat   " Field catalog with field descriptions

          TABLES
            t_outtab                    =  ly_cal.    " Table with data to be displayed
        IF sy-subrc <> 0.
          "system description of error/s
         MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                    WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
        ENDIF.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

**************************************************************************************
*END: CALCULATOR MODEL VIEW
**************************************************************************************

" Input VIEW
SELECTION-SCREEN BEGIN OF BLOCK ss01 WITH FRAME TITLE text-001.
PARAMETERS: p_int1 TYPE i,
            p_int2 TYPE i.
SELECTION-SCREEN END OF BLOCK ss01.

SELECTION-SCREEN BEGIN OF BLOCK ss02 WITH FRAME TITLE text-002.
PARAMETERS: p_add   AS CHECKBOX,
            p_minus AS CHECKBOX,
            p_multi AS CHECKBOX,
            p_quot  AS CHECKBOX,
            p_mode  AS CHECKBOX.
SELECTION-SCREEN END OF BLOCK ss02.

SELECTION-SCREEN BEGIN OF BLOCK ss03 WITH FRAME TITLE text-003.
PARAMETERS: p_writ RADIOBUTTON GROUP rg01,
            p_alv  RADIOBUTTON GROUP rg01.

SELECTION-SCREEN END OF BLOCK ss03.


START-OF-SELECTION.


  " Model Class
  TRY.
      DATA(go_model) = NEW lcl_cal_model(
          im_int1     = p_int1
          im_int2     = p_int2
          im_add      = p_add
          im_subtract = p_minus
          im_multiple = p_multi
          im_divide   = p_quot
          im_mod      = p_mode
      ).
    CATCH lcx_no_option_selected.  "
      MESSAGE 'Select an operator to continue' TYPE 'I' DISPLAY LIKE 'E'.
      LEAVE LIST-PROCESSING.
    CATCH lcx_out_of_range.  "
      MESSAGE 'Please enter number between 0 and 100' TYPE 'I' DISPLAY LIKE 'E'.
      LEAVE LIST-PROCESSING.
    CATCH lcx_divide_by_zero.  "
      MESSAGE 'Error: Division by zero' TYPE 'I' DISPLAY LIKE 'E'.
      LEAVE LIST-PROCESSING.
  ENDTRY.
  TRY.
*call method
      go_model->performcalculation(
        IMPORTING
          rt_cal                 = DATA(lv_cal)
      ).
*if method causes THIS exception, output system message for error
    CATCH cx_sy_arithmetic_error.    " .
      LEAVE LIST-PROCESSING.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                    WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDTRY.
*clear object
  CLEAR go_model.

*create view object and load constructor
  DATA(go_view) = NEW lcl_cal_view(
      im_write = p_writ
      im_alv   = p_alv
  ).
*import/pass table and output correct view
  go_view->displayresult( im_cal = lv_cal ).
*clear object
  CLEAR go_view.
