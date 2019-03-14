REPORT Z_ABPTRAIN_EXER24 MESSAGE-ID ZEX24MSGID.
************************************************************************
*Report Name: Z_ABPTRAIN_EXER24
*Report Title:
*User:
*Date:
************************************************************************
*Declare Data Types
DATA: lv_number1 TYPE p LENGTH 14,
      lv_number2 TYPE p LENGTH 14,
      lv_date1 TYPE sy-datum,
      lv_date2 TYPE sy-datum,
      lv_sum TYPE p,
      lv_date_diff TYPE p,
      lv_number_diff TYPE p,
      lv_result TYPE p,
      lv_quot TYPE p DECIMALS 14 LENGTH 14,
      lv_mod TYPE p,
      lv_taco TYPE c.

*Build Screen for Input
SELECTION-SCREEN BEGIN OF BLOCK rad1
  WITH FRAME TITLE text-002.
PARAMETERS: p_num1 TYPE i,
            p_num2 TYPE i,
            rb_sum RADIOBUTTON GROUP g1,
            rb_ndiff RADIOBUTTON GROUP g1,
            rb_res RADIOBUTTON GROUP g1,
            rb_quot RADIOBUTTON GROUP g1,
            rb_mod RADIOBUTTON GROUP g1.
SELECTION-SCREEN END OF BLOCK rad1.

*Intializing with CLEAR will remove all data in type
INITIALIZATION.
  CLEAR: lv_number1,
         lv_number2,
         lv_date1,
         lv_date2,
         lv_sum,
         lv_date_diff,
         lv_number_diff,
         lv_result,
         lv_quot,
         lv_mod,
         lv_taco.

*Message Condtionals
AT SELECTION-SCREEN.
  IF rb_quot IS NOT INITIAL AND p_num2 = 0.
    MESSAGE e002 WITH p_num2.
  ENDIF.
  IF rb_mod IS NOT INITIAL AND p_num2 = 0.
    MESSAGE e003 WITH p_num2.
  ENDIF.
START-OF-SELECTION.

*Set Values
lv_number1 = p_num1.
lv_number2 = p_num2.
lv_date1 = sy-datum.
lv_date2 = sy-datum.

*REPORTS (FUNCTIONS)
*Set date 2 to first day of current month
lv_date2+6(2) = '01'.

*Set date 2 to last day to previous month
lv_date2 = lv_date2 - 1.

*Calculate difference in days
lv_date_diff = lv_date1 - lv_date2.

*Calculate sum of two numbers
lv_sum = lv_number1 + lv_number2.

*Calculate difference in two numbers
lv_number_diff = lv_number1 - lv_number2.

*Calculate product of two numbers
lv_result = lv_number1 * lv_number2.

*Calculate quotient of two numbers
lv_quot = lv_number1 / lv_number2.

*Modulo
lv_mod = lv_number1 MOD lv_number2.

"CONDITIONALS
IF rb_sum IS NOT INITIAL.
  lv_taco = '+'.
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

"CASE STATMENTS
CASE lv_taco.
  WHEN '+'.
    WRITE: 'Sum ', lv_sum.
  WHEN '-'.
    WRITE: 'Subtract ', lv_number_diff.
  WHEN '*'.
    WRITE: 'Multiply ', lv_result.
  WHEN '/'.
    WRITE: 'Divide', lv_quot.
  WHEN '%'.
    WRITE: 'Modulus ', lv_mod.
  WHEN OTHERS.
    WRITE:'Please select an option'.
ENDCASE.