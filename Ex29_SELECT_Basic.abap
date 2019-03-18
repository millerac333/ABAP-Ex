REPORT z_abptrain_exer29.
************************************************************************
*Report Name: Z_ABPTRAIN_EXER29
*Report Title:
*User:
*Date:
************************************************************************

DATA wa_sflight TYPE sflight.

SELECT * FROM sflight
  INTO wa_sflight.
  WRITE: wa_sflight-mandt.
ENDSELECT.