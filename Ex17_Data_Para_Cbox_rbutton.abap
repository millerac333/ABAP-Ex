REPORT Z_ABPTRAIN_EXER16.
************************************************************************
*Report Name: Z_ABPTRAIN_EXER16&17
*Report Title:Parameters, Checkbox, Radiobuttons
*User:
*Date:
************************************************************************
SELECTION-SCREEN BEGIN OF BLOCK rad1
  WITH FRAME TITLE text-001.
  PARAMETERS: p_emp# TYPE i,
              p_fname TYPE string,
              p_lname TYPE string,
              p_bdate TYPE d,
              p_salary TYPE n LENGTH 8,
              p_hobby TYPE string,
              rb_male RADIOBUTTON GROUP g1,
              rb_fmale RADIOBUTTON GROUP g1,
              cb_drive AS CHECKBOX.
  SELECTION-SCREEN END OF BLOCK rad1.