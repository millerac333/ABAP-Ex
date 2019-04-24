REPORT z_abptrain_acm_exer09.

**************************************************************************************
**************************************************************************************
*Report Name: Z_ABPTRAIN_ACM_EXER09
*Report Title: Data Types
*User: Aaron Miller
*Date: UPDATED 4/24/2019

*This program will illustrate a proper usage of data types

**Copy Ex 8 and display the following using variables with the correct data types
**---Employee Number
**---First Name
**---Last Name
**---Birthdate
**---Dream Salary
**---Hobby
**************************************************************************************
**************************************************************************************
*Declare data types
DATA: lv_employee_name   TYPE string,
      lv_employee_#      TYPE string,
      lv_first_name      TYPE string,
      lv_last_name       TYPE string,
      lv_birthdate       TYPE sy-datum,
      lv_dream_salary(7) TYPE p DECIMALS 2,
      lv_hobby           TYPE string.

*Clear values from data declaration
CLEAR: lv_employee_name,
       lv_employee_#,
       lv_first_name,
       lv_last_name,
       lv_birthdate,
       lv_dream_salary,
       lv_hobby.

*Assign Values to Varialbes
lv_first_name = |Bruce|.
lv_last_name = |Wayne|.
CONCATENATE lv_first_name lv_last_name INTO lv_employee_name SEPARATED BY space.
lv_birthdate = '19390723'.
lv_dream_salary = '1000000'.
lv_hobby = |Justice|.

*Write statement to dispaly the user the information
WRITE: |-------Employee-Information-------|,
     / |Full Name: { lv_employee_name }|,
     /  'First Name:', lv_first_name,
     /  'Last Name:', lv_last_name,
     /  'Birthdate:', lv_birthdate,
     /  'Dream Salary:', lv_dream_salary,
     /  'Hobby:', lv_hobby,
     / |----------------------------------|.
