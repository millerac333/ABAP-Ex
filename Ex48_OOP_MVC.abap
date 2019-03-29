REPORT Z_ABPTRAIN003_EXER48.

DATA: gv_flag_operator TYPE c.

PARAMETERS: p_int1 TYPE i,
            p_int2 TYPE i.

**radio button selection for the user to choose which operation
**they would like completed
SELECTION-SCREEN BEGIN OF BLOCK calculations
                  WITH FRAME TITLE text-001.

PARAMETERS: rb_sum  RADIOBUTTON GROUP calc,
            rb_dif  RADIOBUTTON GROUP calc,
            rb_prod RADIOBUTTON GROUP calc,
            rb_div  RADIOBUTTON GROUP calc.

SELECTION-SCREEN END OF BLOCK calculations.


AT SELECTION-SCREEN.

*this if statment checks which operation the user chose
IF rb_sum IS NOT INITIAL.
  gv_flag_operator = '+'.

ELSEIF rb_dif IS NOT INITIAL.
  gv_flag_operator = '-'.

ELSEIF rb_prod IS NOT INITIAL.
  gv_flag_operator = '*'.

ELSE.
  gv_flag_operator = '/'.

ENDIF.

* Lets the user know that they cannot divide by zero
  IF p_int2 = 0 AND gv_flag_operator = '/'.

    MESSAGE: e003(Z_abptrain003_mess).

  ENDIF.

*local model class that obtains input from the user
CLASS lcl_model DEFINITION.
  PUBLIC SECTION.
    DATA: s_int1           TYPE i,
          s_int2           TYPE i,
          s_flag_operator  TYPE c.

    METHODS: getints      IMPORTING lp_int1 TYPE i lp_int2 TYPE i,
             getoperation IMPORTING lp_flag_operator TYPE c.
ENDCLASS.                    "lcl_model DEFINITION

*local model class implementaion
CLASS lcl_model IMPLEMENTATION.
  METHOD getints.

    me->s_int1 = lp_int1.
    me->s_int2 = lp_int2.

  ENDMETHOD.                    "getints

  METHOD getoperation.

    me->s_flag_operator = lp_flag_operator.

  ENDMETHOD.                    "getoperation
ENDCLASS.                    "lcl_model IMPLEMENTATION


*local controller class obtains input from the model class
*to complete the calculations of the user choice
CLASS lcl_controller DEFINITION.
  PUBLIC SECTION.

    DATA: s_sum  TYPE i,
          s_diff TYPE i,
          s_prod TYPE i,
          s_div  TYPE i,
          s_operator TYPE c,
          s_model TYPE REF TO lcl_model.

    METHODS: constructor IMPORTING smodel TYPE REF TO lcl_model,
             doaddition,
             dosubtraction,
             dodivision,
             domultiplication.
ENDCLASS.                    "lcl_controller DEFINITION


*local controller class implementaion
CLASS lcl_controller IMPLEMENTATION.
*this method gains access to the model class
  METHOD constructor.

    me->s_model = smodel.

  ENDMETHOD.                    "constructor

*  this methods adds the two integers obtained from the
*  model class
  METHOD doaddition.

    s_sum = me->s_model->s_int1 + me->s_model->s_int2.
    s_operator = me->s_model->s_flag_operator.

  ENDMETHOD.                    "doaddition

*  this methods subtracts the two integers obtained from the
*  model class
  METHOD dosubtraction.

    s_diff = me->s_model->s_int1 - me->s_model->s_int2.
    s_operator = me->s_model->s_flag_operator.

  ENDMETHOD.                    "dosubtraction

*  this methods divides the two integers obtained from the
*  model class
  METHOD dodivision.

    s_div = me->s_model->s_int1 / me->s_model->s_int2.
    s_operator = me->s_model->s_flag_operator.

  ENDMETHOD.                    "dodivision

*  this methods multiplies the two integers obtained from the
*  model class
  METHOD domultiplication.

    s_prod = me->s_model->s_int1 * me->s_model->s_int2.
    s_operator = me->s_model->s_flag_operator.

  ENDMETHOD.                    "domultiplication
ENDCLASS.                    "lcl_controller IMPLEMENTATION

*local view class that displays the output to the user
CLASS lcl_view DEFINITION.
  PUBLIC SECTION.

  DATA: s_controller TYPE REF TO lcl_controller.

  METHODS:  writeresult,
            constructor IMPORTING scontroller TYPE REF TO lcl_controller.

ENDCLASS.                    "lcl_view DEFINITION


*local view class implementation
CLASS lcl_view IMPLEMENTATION.
*
  METHOD constructor.

   me->s_controller = scontroller.

  ENDMETHOD.
*
*
  METHOD writeresult.

    if me->s_controller->s_operator = '+'.
      WRITE: me->s_controller->s_sum.

    ELSEIF me->s_controller->s_operator = '-'.
      WRITE: me->s_controller->s_diff.

    ELSEIF me->s_controller->s_operator = '/'.
      WRITE: me->s_controller->s_div.

    ELSE.
      WRITE: me->s_controller->s_prod.
    ENDIF.


  ENDMETHOD.

ENDCLASS.                    "lcl_view IMPLEMENTATION


DATA: lo_model      TYPE REF TO lcl_model,
      lo_controller TYPE REF TO lcl_controller,
      lo_view       TYPE REF TO lcl_view.

*gets the input from the user and manipulates the input
START-OF-SELECTION.

  CREATE OBJECT: lo_model,
                 lo_controller EXPORTING smodel = lo_model,
                 lo_view EXPORTING scontroller = lo_controller.

  lo_model->getints( EXPORTING lp_int1 = p_int1 lp_int2 = p_int2 ).
  lo_model->getoperation( EXPORTING lp_flag_operator = gv_flag_operator ).

  IF gv_flag_operator = '+'.
    lo_controller->doaddition( ).
    lo_view->writeresult( ).

  ELSEIF gv_flag_operator = '-'.
    lo_controller->dosubtraction( ).
    lo_view->writeresult( ).

  ELSEIF gv_flag_operator = '/'.
    lo_controller->dodivision( ).
    lo_view->writeresult( ).

  ELSE.
    lo_controller->domultiplication( ).
    lo_view->writeresult( ).
  ENDIF.