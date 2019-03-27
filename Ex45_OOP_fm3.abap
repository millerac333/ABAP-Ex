FUNCTION zex45fm3.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     REFERENCE(EM_DIFF1AND2) TYPE  I
*"     REFERENCE(EM_DIFF2AND3) TYPE  I
*"----------------------------------------------------------------------

*Function logic for calculating difference of user input
  em_diff1and2 = gv_num1 - gv_num2.
  em_diff2and3 = gv_num2 - gv_num3.

ENDFUNCTION.