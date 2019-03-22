REPORT Z_ABPTRAIN_EXER12.
************************************************************************
*Report Name: Z_ABPTRAIN_EXER12
*Report Title:
*User:
*Date:
************************************************************************
TYPES: BEGIN OF ts_profile,
  full_name TYPE string,
  first_name TYPE string,
  last_name TYPE string,
  birthdate TYPE sy-datum,
  dream_salary TYPE string,
  hobby TYPE string,
  END OF ts_profile.

DATA: wa_profile TYPE ts_profile.

 wa_profile-full_name = 'Bruce Wayne'.
 wa_profile-first_name = 'Bruce'.
 wa_profile-last_name = 'Wayne'.
 wa_profile-birthdate = '19390723'.
 wa_profile-dream_salary = '1000000'.
 wa_profile-hobby = 'Justice'.

WRITE: wa_profile-full_name, / wa_profile-first_name, / wa_profile-last_name, / wa_profile-birthdate, / wa_profile-dream_salary, / wa_profile-hobby.
