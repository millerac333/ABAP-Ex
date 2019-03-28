REPORT z_abptrain_acm_exer46.

*Define/Create/Declare class data and methods
CLASS lcl_calculate DEFINITION.
  PUBLIC SECTION.
    METHODS: set_add1and2  IMPORTING clv_num1 TYPE i clv_num2 TYPE i,
      set_add2and3  IMPORTING clv_num2 TYPE i clv_num3 TYPE i,
      set_diff1and2 IMPORTING clv_num1 TYPE i clv_num2 TYPE i,
      set_diff2and3 IMPORTING clv_num2 TYPE i clv_num3 TYPE i.

    DATA: clv_num1      TYPE i,
          clv_num2      TYPE i,
          clv_num3      TYPE i,
          clv_add1and2  TYPE i,
          clv_add2and3  TYPE i,
          clv_diff1and2 TYPE i,
          clv_diff2and3 TYPE i.

ENDCLASS.

*logic for methods/functions for the 'behavior' of the class
CLASS lcl_calculate IMPLEMENTATION.

  METHOD set_add1and2.
    clv_add1and2 = clv_num1 + clv_num2.
    WRITE: / |{ clv_num1 } + { clv_num2 } = { clv_add1and2 }|.
  ENDMETHOD.

  METHOD set_add2and3.
    clv_add2and3 = clv_num2 + clv_num3.
    WRITE: / |{ clv_num2 } + { clv_num3 } = { clv_add2and3 }|.
  ENDMETHOD.

  METHOD set_diff1and2.
    clv_diff1and2 = clv_num1 - clv_num2.
    WRITE: / |{ clv_num1 } - { clv_num2 } = { clv_diff1and2 }|.
  ENDMETHOD.

  METHOD set_diff2and3.
    clv_diff2and3 = clv_num2 - clv_num3.
    WRITE: / |{ clv_num2 } - { clv_num3 } = { clv_diff2and3 }|.
  ENDMETHOD.

ENDCLASS.

*Program loads and these parameters are created
INITIALIZATION.

  SELECTION-SCREEN BEGIN OF BLOCK rad1.
  PARAMETERS: p_num1 TYPE i,
              p_num2 TYPE i,
              p_num3 TYPE i.
  SELECTION-SCREEN END OF BLOCK rad1.

*Declare object templated from class
  DATA: lo_calculate TYPE REF TO lcl_calculate.

*Validation of user input
START-OF-SELECTION.
  IF ( p_num1 IS INITIAL )
    OR
     ( p_num2 IS INITIAL )
    OR
     ( p_num3 IS INITIAL ).
    MESSAGE: |Please input a number for all fields| TYPE 'E'.

  ELSEIF
     ( p_num1 IS NOT INITIAL AND p_num1 > 100 OR p_num1 < 0 )
    OR
     ( p_num2 IS NOT INITIAL AND p_num2 > 100 OR p_num2 < 0 )
    OR
     ( p_num3 IS NOT INITIAL AND p_num3 > 100 OR p_num3 < 0 ).
    MESSAGE: |Numbers must be between 0 and 100| TYPE 'E'.

  ENDIF.

*create new object and call necessary methods for new object; object and methods templated from class
  CREATE OBJECT:lo_calculate.
  CALL METHOD lo_calculate->set_add1and2(
    EXPORTING
      clv_num1 = p_num1
      clv_num2 = p_num2 ).
  lo_calculate->set_add2and3(  EXPORTING clv_num2 = p_num2
                                         clv_num3 = p_num3 ).
  lo_calculate->set_diff1and2( EXPORTING clv_num1 = p_num1
                                         clv_num2 = p_num2 ).
  lo_calculate->set_diff2and3( EXPORTING clv_num2 = p_num2
                                         clv_num3 = p_num3 ).