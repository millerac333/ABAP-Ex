REPORT Z_ABPTRAIN_EXER18.
************************************************************************
*Report Name: Z_ABPTRAIN_EXER18
*Report Title: Data_Calculations
*User:
*Date:
************************************************************************
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

lv_number1 = 333.
lv_number2 = 25.
lv_date1 = sy-datum.
lv_date2 = sy-datum.

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

WRITE:lv_date_diff,
      / lv_sum,
      / lv_number_diff,
      / lv_result,
      / lv_quot,
      / lv_mod.