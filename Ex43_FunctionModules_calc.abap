REPORT z_abptrain_acm_exer43 MESSAGE-ID zex43msgid.

*Build Screen for Input
SELECTION-SCREEN BEGIN OF BLOCK rad1
  WITH FRAME TITLE text-002.
PARAMETERS: p_num1   TYPE i,
            p_num2   TYPE i,
            rb_sum   RADIOBUTTON GROUP g1,
            rb_ndiff RADIOBUTTON GROUP g1,
            rb_res   RADIOBUTTON GROUP g1,
            rb_quot  RADIOBUTTON GROUP g1,
            rb_mod   RADIOBUTTON GROUP g1.
SELECTION-SCREEN END OF BLOCK rad1.

*Event- error message logic executed when user inputs numbers, selects options, and hits execute
AT SELECTION-SCREEN.
  IF rb_quot IS NOT INITIAL AND p_num2 = 0.
    MESSAGE e000 WITH p_num2.
  ENDIF.
  IF rb_mod IS NOT INITIAL AND p_num2 = 0.
    MESSAGE e001 WITH p_num2.
  ENDIF.

START-OF-SELECTION.

  "CONDITIONALS
  IF rb_sum IS NOT INITIAL.
    DATA(lv_taco) = '+'.
  ELSEIF rb_ndiff IS NOT INITIAL.
    lv_taco = '-'.
  ELSEIF rb_res IS NOT INITIAL.
    lv_taco = '*'.
  ELSEIF rb_quot IS NOT INITIAL.
    lv_taco = '/'.
  ELSEIF rb_mod IS NOT INITIAL.
    lv_taco = '%'.
  ELSE.
    WRITE: 'Please select an option'.
  ENDIF.

*Call funciton module with calculation logic and flag
  CALL FUNCTION 'ZEX43FM'
    EXPORTING
      im_num1 = p_num1
      im_num2 = p_num2
      im_taco = lv_taco.