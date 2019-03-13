REPORT z_abptrain_exer10.
************************************************************************
*Report Name: Z_ABPTRAIN_EXER10
*Report Title:
*User:
*Date:
************************************************************************
DATA: lv_employee_name TYPE string,
lv_first_name TYPE string,
lv_last_name TYPE string,
lv_dream_salary TYPE string VALUE '1000000'.

CONSTANTS: lc_birthdate TYPE sy-datum VALUE '19390723',
lc_hobby TYPE string VALUE 'Justice'.

lv_first_name = 'Bruce'.
lv_last_name = 'Wayne'.
CONCATENATE lv_first_name lv_last_name INTO lv_employee_name SEPARATED BY space.

CONDENSE: lv_dream_salary.
WRITE: lv_employee_name, / lv_first_name, / lv_last_name, / lc_birthdate, / lv_dream_salary, / lc_hobby.