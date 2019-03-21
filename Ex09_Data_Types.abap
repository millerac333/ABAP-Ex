REPORT Z_ABPTRAIN_EXER9.
************************************************************************
*Report Name: Z_ABPTRAIN_EXER9
*Report Title:
*User:
*Date:
************************************************************************
DATA: lv_EMPLOYEE_NAME TYPE STRING,
lv_FIRST_NAME TYPE STRING,
lv_LAST_NAME TYPE STRING,
lv_BIRTHDATE TYPE D,
lv_DREAM_SALARY TYPE I,
lv_HOBBY TYPE STRING.

lv_FIRST_NAME = |Bruce|.
lv_LAST_NAME = |Wayne|.
CONCATENATE lv_FIRST_NAME lv_LAST_NAME INTO lv_EMPLOYEE_NAME SEPARATED BY space.
lv_BIRTHDATE = 19390723.
lv_DREAM_SALARY = 1000000.
lv_HOBBY = |Justice|.

WRITE: |{ lv_EMPLOYEE_NAME }|, / |{ lv_FIRST_NAME }|, / |{ lv_LAST_NAME }|, /  lv_BIRTHDATE , / lv_DREAM_SALARY, / |{ lv_HOBBY }|.
