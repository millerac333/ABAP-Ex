REPORT Z_ABPTRAIN_ACM_EXER10.

DATA: lv_employee_name TYPE string,
lv_first_name          TYPE string VALUE 'Bruce',
lv_last_name           TYPE string VALUE 'Wayne',
lv_dream_salary        TYPE string VALUE '1,000,000',
lv_birthdate TYPE string VALUE '01/12/1940'.

CONSTANTS: lc_hobby     TYPE string   VALUE 'Justice'.

CONCATENATE lv_first_name lv_last_name
INTO lv_employee_name
SEPARATED BY space.

CONDENSE: lv_dream_salary.

WRITE: |{ lv_employee_name }|, / |{ lv_first_name }|, / |{ lv_last_name }|, / |{ lv_birthdate }|, / |{ lv_dream_salary }|, / |{ lc_hobby }|.
