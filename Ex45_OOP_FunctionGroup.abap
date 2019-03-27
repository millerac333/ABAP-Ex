REPORT Z_ABPTRAIN_ACM_EXER45.

*Program loads and these variables are created
INITIALIZATION.
DATA: lv_add1and2  TYPE i,
      lv_add2and3  TYPE i,
      lv_diff1and2 TYPE i,
      lv_diff2and3 TYPE i.

*values from previous program execution are cleared from data types
CLEAR: lv_add1and2,
       lv_add2and3,
       lv_diff1and2,
       lv_diff2and3.

*create user input selection screen with data types from parameters
SELECTION-SCREEN BEGIN OF BLOCK rad1.
PARAMETERS: p_num1   TYPE i,
            p_num2   TYPE i,
            p_num3   TYPE i.
SELECTION-SCREEN END OF BLOCK rad1.

*user input screen; assign values and input validation
AT SELECTION-SCREEN.
  CALL FUNCTION 'ZEX45FM1'
    EXPORTING
      im_num1 = p_num1
      im_num2 = p_num2
      im_num3 = p_num3.
*User excutes THEN assign exports to local variables
  START-OF-SELECTION.
    CALL FUNCTION 'ZEX45FM2'
      IMPORTING
        em_add1and2 = lv_add1and2
        em_add2and3 = lv_add2and3.
    CALL FUNCTION 'ZEX45FM3'
      IMPORTING
        em_diff1and2 = lv_diff1and2
        em_diff2and3 = lv_diff2and3.

*Write Statement for output after function is executed and processed
  WRITE: / |{ p_num1 } + { p_num2 } = { lv_add1and2 }|,
         / |{ p_num2 } + { p_num3 } = { lv_add2and3 }|,
         / |{ p_num1 } - { p_num2 } = { lv_diff1and2 }|,
         / |{ p_num2 } - { p_num3 } = { lv_diff2and3 }|.