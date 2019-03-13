REPORT z_abptrain_exer19.
************************************************************************
*Report Name: Z_ABPTRAIN_EXER19
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
      lv_mod TYPE p.

*Build Screen for Input
SELECTION-SCREEN BEGIN OF BLOCK rad1 WITH FRAME TITLE text-001.
PARAMETERS: p_num1 TYPE i,
            p_num2 TYPE i,
            cb_sum AS CHECKBOX,
            cb_ndiff AS CHECKBOX,
            cb_res AS CHECKBOX,
            cb_quot AS CHECKBOX,
            cb_mod AS CHECKBOX.
SELECTION-SCREEN END OF BLOCK rad1.

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
IF cb_sum = abap_true.
  WRITE: 'Sum ', lv_sum.
ELSEIF cb_ndiff = abap_true.
  WRITE: 'Subtract ', lv_number_diff.
ELSEIF cb_res = abap_true.
  WRITE: 'Multiply ', lv_result.
ELSEIF cb_quot = abap_true.
  WRITE: 'Divide', lv_quot.
ELSEIF cb_mod = abap_true.
  WRITE: 'Modulus ', lv_mod.
ELSE.
  WRITE:'Please select a checkbox'.
ENDIF.