REPORT Z_ABPTRAIN_EXER23.
************************************************************************
*Report Name: Z_ABPTRAIN_EXER23
*Report Title:Loops continued
*User:
*Date:
************************************************************************
SELECTION-SCREEN BEGIN OF BLOCK rad1
  WITH FRAME TITLE text-001.

PARAMETERS: p_loop TYPE i,
           p_thresh TYPE i.

SELECTION-SCREEN END OF BLOCK rad1.

DO p_loop TIMES.
  IF sy-index > p_thresh.
    WRITE: / sy-index.
  ENDIF.
ENDDO.