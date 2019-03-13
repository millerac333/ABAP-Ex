REPORT Z_ABPTRAIN_EXER13.
************************************************************************
*Report Name: Z_ABPTRAIN_EXER13
*Report Title:
*User:
*Date:
************************************************************************
TYPES: Begin Of me_profile,
       empnm TYPE n,
       fname TYPE string,
       lname TYPE string,
       bdate TYPE d,
       dream_salary type n,
       hobby TYPE string,
       END OF me_profile.

DATA: ls_account TYPE me_profile.

      ls_account-empnm = '333333'.
      ls_account-fname = 'Bruce'.
      ls_account-lname = 'Wayne'.
      ls_account-bdate = '19390723'.
      ls_account-dream_salary = '1000000'.
      ls_account-hobby = 'Justice'.


" first number: character position; second number: number of characters displayed
WRITE: 'First initial ', ls_account-fname(1),
       / 'Last initial ', ls_account-lname(1),
       / 'Birth Month ' , ls_account-bdate+4(2),
       / 'Birth Day ', ls_account-bdate+6(2),
       / 'Birth Year ', ls_account-bdate(4).