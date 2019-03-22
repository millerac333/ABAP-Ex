REPORT Z_ABPTRAIN_ACM_EXER10.

DATA(lv_first_name)   = |Bruce|.
DATA(lv_last_name)    = |Wayne|.
DATA(lv_dream_salary) = |1,000,000|.
DATA(lv_birthdate)    = |01/12/1940|.
DATA: lv_employee_name TYPE string.

CONSTANTS: lc_hobby     TYPE string   VALUE 'Justice'.

CONCATENATE lv_first_name lv_last_name
INTO lv_employee_name
SEPARATED BY space.

CONDENSE: lv_dream_salary.

WRITE: |{ lv_employee_name }|, / |{ lv_first_name }|, / |{ lv_last_name }|, / |{ lv_birthdate }|, / |{ lv_dream_salary }|, / |{ lc_hobby }|.