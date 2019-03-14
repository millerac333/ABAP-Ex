REPORT z_abptrain_exer22.
************************************************************************
*Report Name: Z_ABPTRAIN_EXER22
*Report Title:
*User:
*Date:
************************************************************************
DATA: lv_value1 TYPE i VALUE 10,
      lv_value2 TYPE i VALUE 5,
      lv_value3 TYPE i VALUE 44.

DO lv_value1  TIMES.
  WRITE: / 'Count ', lv_value1,
         / 'Sy-index ', sy-index.
ENDDO.