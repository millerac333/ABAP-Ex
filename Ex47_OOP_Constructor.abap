REPORT Z_ABPTRAIN_ACM_EXER47.

*Define/Create/Declare class data and methods
CLASS lcl_calculate DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor IMPORTING num1 TYPE i
                                  num2 TYPE i
                                  num3 TYPE i,
      set_add1and2,
      set_add2and3,
      set_diff1and2,
      set_diff2and3.

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

  METHOD constructor.
     clv_num1 = num1.
     clv_num2 = num2.
     clv_num3 = num3.
*    WRITE: / num1.
  ENDMETHOD.

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

*Validation of user input
START-OF-SELECTION.
  IF ( p_num1 IS NOT INITIAL AND p_num1 > 100 OR p_num1 < 0 ).
     p_num1 = 1.
  ENDIF.

  IF ( p_num2 IS NOT INITIAL AND p_num2 > 100 OR p_num2 < 0 ).
     p_num2 = 1.
  ENDIF.

  IF ( p_num3 IS NOT INITIAL AND p_num3 > 100 OR p_num3 < 0 ).
     p_num3 = 1.
  ENDIF.

  DATA(lo_calculate) = NEW lcl_calculate( num1 = p_num1
                                   num2 = p_num2
                                   num3 = p_num3 ).

  lo_calculate->set_add1and2( ).
  lo_calculate->set_add2and3( ).
  lo_calculate->set_diff1and2( ).
  lo_calculate->set_diff2and3( ).