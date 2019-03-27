FUNCTION zex45fm2.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  EXPORTING
*"     REFERENCE(EM_ADD1AND2) TYPE  I
*"     REFERENCE(EM_ADD2AND3) TYPE  I
*"----------------------------------------------------------------------

*Function logic for calculating sum of user input
  em_add1and2 = gv_num1 + gv_num2.
  em_add2and3 = gv_num2 + gv_num3.

ENDFUNCTION.