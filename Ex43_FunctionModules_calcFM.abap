FUNCTION zex43fm.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IM_NUM1) TYPE  I
*"     REFERENCE(IM_NUM2) TYPE  I
*"     REFERENCE(IM_TACO) TYPE  CHAR1
*"----------------------------------------------------------------------

  CASE im_taco.
    WHEN '+'.
      DATA(lv_sum) = im_num1 + im_num2.
      WRITE: |SUM of numbers is { lv_sum }|.
    WHEN '-'.
      DATA(lv_diff) = im_num1 - im_num2.
      WRITE |DIFFERENCE of numbers is { lv_diff }|.
    WHEN '*'.
      DATA(lv_prod) = im_num1 * im_num2.
      WRITE |PRODUCT of numbers is { lv_prod }|.
    WHEN '/'.
      DATA(lv_quot) = im_num1 / im_num2.
      WRITE |QUOTIENT of numbers is { lv_quot }|.
    WHEN '%'.
      DATA(lv_mod) = im_num1 MOD im_num2.
      WRITE |REMAINDER of numbers is { lv_mod }|.
    WHEN OTHERS.
      WRITE:|Please select an option|.
  ENDCASE.




ENDFUNCTION.