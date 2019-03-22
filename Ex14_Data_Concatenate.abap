REPORT Z_ABPTRAIN_ACM_EXER14.

*TYPES: BEGIN OF me_profile,
*      empnm TYPE n,
*      fname TYPE string,
*      lname TYPE string,
*      bdate TYPE d,
*      dream_salary TYPE n,
*      hobby TYPE string,
*       END OF me_profile.

*DATA full_name TYPE string.

*DATA: ls_account TYPE me_profile.

*ls_account-empnm = '333333'.
*ls_account-fname = 'Bruce'.
*ls_account-lname = 'Wayne'.
*ls_account-bdate = '19390723'.
*ls_account-dream_salary = '1000000'.
*ls_account-hobby = 'Justice'.

*CONCATENATE ls_account-fname ls_account-lname INTO full_name SEPARATED BY space.

*WRITE: full_name.

DATA(n1) = |Bruce|.
DATA(n2) = |Wayne|.
DATA n3(30) TYPE c.

n3 = |{ n1 } { n2 }|.

WRITE / n3.
